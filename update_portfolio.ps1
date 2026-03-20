$htmlPath = ".\index.html"
$html = Get-Content $htmlPath -Raw

$galeriaPath = ".\IMAGENES PAGINA WEB\Galeria"
$tiendaPath = ".\IMAGENES PAGINA WEB\Tienda"

# Filters
$gf = '<button class="filter-btn active" data-filter="all" data-i18n="filter_all">Todas</button>' + "`n"
$gg = ""
$tsEs = @()
$tsEn = @()

$i = 1
foreach ($expo in (Get-ChildItem -Path $galeriaPath -Directory)) {
    $name = if ($expo.Name -match "^(\d+)_?(.*)") { $matches[2].Trim() } else { $expo.Name }
    $fclass = "expo$i"
    $gf += '                <button class="filter-btn" data-filter="' + $fclass + '" data-i18n="filter_' + $fclass + '">' + $name + '</button>' + "`n"
    $tsEs += '        filter_' + $fclass + ': "' + $name + '",'
    $tsEn += '        filter_' + $fclass + ': "' + $name + ' Exposición",'
    
    foreach ($img in (Get-ChildItem -Path $expo.FullName -File)) {
        $src = "IMAGENES PAGINA WEB/Galeria/" + $expo.Name + "/" + $img.Name
        # UTF-8 URL encoding correctly handles spaces while keeping things web-safe
        $src = [uri]::EscapeUriString($src)
        $gg += '                <div class="gallery-item ' + $fclass + '">
                    <img src="' + $src + '" alt="' + $name + '" loading="lazy">
                </div>
'
    }
    $i++
}

$sg = ""
$j = 1
foreach ($tienda in (Get-ChildItem -Path $tiendaPath -Directory)) {
    $price = if ($tienda.Name -match "^(\d+)_?(.*)") { $matches[1] } else { "0" }
    # Fix the missing match mapping error when Tienda doesn't have number prefix
    $name = if ($tienda.Name -match "^(\d+)_?(.*)") { $matches[2].Trim() } else { $tienda.Name }
    
    $itemKey = "shop_item_$j"
    $tsEs += '        ' + $itemKey + ': "' + $name + '",'
    $tsEn += '        ' + $itemKey + ': "' + $name + '",'

    $ih = ""
    foreach ($img in (Get-ChildItem -Path $tienda.FullName -File)) {
        $src = "IMAGENES PAGINA WEB/Tienda/" + $tienda.Name + "/" + $img.Name
        $src = [uri]::EscapeUriString($src)
        $ih += '                        <img src="' + $src + '" alt="' + $name + '" loading="lazy">' + "`n"
    }

    $sg += '                <div class="shop-item">
                    <div class="shop-images-scroll">
' + $ih + '                    </div>
                    <div class="shop-info">
                        <h3 data-name="' + $name + '" data-i18n="' + $itemKey + '">' + $name + '</h3>
                        <p class="price">&euro;' + $price + '</p>
                        <button class="btn-interest" data-i18n="btn_interest">Me interesa</button>
                    </div>
                </div>
'
    $j++
}

# Use flexible regex without special character assumptions
$html = $html -replace "(?s)(<div class=`"gallery-filters`">).*?(<!-- INSTRUCCIONES: para a.adir fotos)", "`$1`n            $gf`n`n            `$2"

$html = $html -replace "(?s)(<div class=`"gallery-grid`">).*?</section>\s*(<!-- SECCI.N: TIENDA -->)", "`$1`n$gg            </div>`n        </section>`n`n        `$2"

$html = $html -replace "(?s)(<div class=`"shop-grid`">).*?</section>\s*(<!-- SECCI.N: CONTACTO -->)", "`$1`n$sg            </div>`n        </section>`n`n        `$2"

# Write out with proper encoding (UTF8)
$html | Set-Content ".\index.html" -Encoding UTF8

$jsPath = ".\script.js"
$js = Get-Content $jsPath -Raw
$esVals = $tsEs -join "`n"
$enVals = $tsEn -join "`n"

$js = $js -replace "(?s)(es: \{)", "`$1`n$esVals"
$js = $js -replace "(?s)(en: \{)", "`$1`n$enVals"

$js | Set-Content ".\script.js" -Encoding UTF8

Write-Host "Success"
