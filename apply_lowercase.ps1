$htmlPath = ".\index.html"
$html = [IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

# 1. Update Shop H3 Titles to lowercase
$html = [regex]::Replace($html, '(?s)(<h3[^>]*>)([^<]+)(</h3>)', {
    param($match)
    return $match.Groups[1].Value + $match.Groups[2].Value.ToLower() + $match.Groups[3].Value
})

# 2. Update Shop data-name attributes to lowercase
$html = [regex]::Replace($html, '(?s)data-name="([^"]+)"', {
    param($match)
    return 'data-name="' + $match.Groups[1].Value.ToLower() + '"'
})

# 3. Add gallery-title to Gallery grid items
$html = [regex]::Replace($html, '(?s)(<div class="gallery-item[^>]+>.*?<img[^>]*src="[^"]+/([^"/\.]+)\.[^"]+"[^>]*>)\s*(</div>)', {
    param($match)
    # Decode %20 and similar uri parts so the name is human readable
    $name = [uri]::UnescapeDataString($match.Groups[2].Value).ToLower()
    # avoid double inserting if ran twice
    if ($match.Groups[1].Value -match 'gallery-title') {
        return $match.Groups[1].Value + $match.Groups[3].Value
    }
    return $match.Groups[1].Value + "`n<p class=`"gallery-title`">" + $name + "</p>`n" + $match.Groups[3].Value
})

# Save HTML
[IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)

$jsPath = ".\script.js"
$js = [IO.File]::ReadAllText($jsPath, [System.Text.Encoding]::UTF8)

# 4. Update script.js Shop translations and Gallery names to lowercase match
$js = [regex]::Replace($js, '(?s)(shop_item_\d+:\s*")([^"]+)(")', {
    param($match)
    return $match.Groups[1].Value + $match.Groups[2].Value.ToLower() + $match.Groups[3].Value
})

# Save JS
[IO.File]::WriteAllText($jsPath, $js, [System.Text.Encoding]::UTF8)

Write-Host "Success"
