# ===================================================
# update_prices.ps1
# Recorre la carpeta Tienda y escanea los precios
# en los nombres de las carpetas (ej. "350_CUADRO") 
# para actualizar el precio de venta en el index.html
# ===================================================
$htmlPath = ".\index.html"
$html = [IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

$updatedCount = 0
$folders = Get-ChildItem -Path ".\IMAGENES PAGINA WEB\Tienda" -Directory
foreach ($f in $folders) {
    if ($f.Name -match "^(\d+)_?(.*)") {
        $price = $matches[1]
        $rawName = $matches[2].Trim().ToLower()
        $escapedH3 = [regex]::Escape($rawName)
        
        # Regex busca el h3 específico, los espacios intermedios y reemplaza la cifra en el precio
        $pattern = "(?s)(<h3 data-name=`"$escapedH3`"[^>]*>.*?</h3>\s*<p class=`"price`">€)(\d+)(</p>)"
        if ($html -match "(?s)<h3 data-name=`"$escapedH3`"") {
            $html = [regex]::Replace($html, $pattern, {
                param($m)
                return $m.Groups[1].Value + $price + $m.Groups[3].Value
            })
            $updatedCount++
        }
    }
}

[IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "`n✅ Precios escaneados y actualizados dinamicamente: $updatedCount obras comprobadas."
