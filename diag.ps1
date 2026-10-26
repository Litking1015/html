$fp  = "c:\Users\Aswat Driouch\Documents\GitHub\html\index.html"
$jsf = "c:\Users\Aswat Driouch\Documents\GitHub\html\pricing_slider.js"
$c   = [System.IO.File]::ReadAllText($fp,  [System.Text.Encoding]::UTF8)
$js  = [System.IO.File]::ReadAllText($jsf, [System.Text.Encoding]::UTF8)

# Run the JS logic in .NET – we can't exec Node, so we implement the replacements
# in pure PowerShell, keeping all Arabic in the source JS file and referencing line numbers.

$lines = $c -split "`r`n"

# ─── diagnostic ───
Write-Host "Total lines: $($lines.Length)"
Write-Host "Looking for packagesView..."
$pvLine = ($lines | Select-String 'class="pricing-view active pricing-grid" id="packagesView"').LineNumber
Write-Host "packagesView at line: $pvLine"
$closeMarkerLine = ($lines | Select-String '<!-- العرض 2').LineNumber
Write-Host "Close marker line: $closeMarkerLine"
$injectCSSLine = ($lines | Select-String 'تنسيقات مركز الاستثمار').LineNumber | Select-Object -First 1
Write-Host "CSS inject after line: $injectCSSLine"
$mobileGridLine = ($lines | Select-String '=== الأسعار').LineNumber
Write-Host "Mobile grid line: $mobileGridLine"
$activeGridLine = ($lines | Select-String '.pricing-view.active.pricing-grid \{').LineNumber
Write-Host "Active grid line: $activeGridLine"
