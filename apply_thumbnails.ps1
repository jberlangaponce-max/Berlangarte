# ===================================================
# apply_thumbnails.ps1
# Modifica el index.html para que:
# - src de galería apunte al thumbnail (_thumb.jpg)
# - data-full-src guarde la imagen original
# El JS del modal leerá data-full-src para mostrar full res.
# ===================================================
$htmlPath = ".\index.html"
$html = [IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

$base = "IMAGENES%20PAGINA%20WEB/Galeria/01_Mira%20el%20pajarito/"

# Regex: captura el src completo de cualquier img dentro de .gallery-item
# Reemplaza src con thumbnail y añade data-full-src con el original
$html = [regex]::Replace(
    $html,
    '(<div class="gallery-item[^>]+>)<img\s+src="(' + [regex]::Escape($base) + '([^"]+))"(\s+loading="lazy")\s+alt="Obra">',
    {
        param($m)
        $prefix  = $m.Groups[1].Value
        $fullSrc = $m.Groups[2].Value
        $file    = $m.Groups[3].Value   # e.g. ABEJARUCO.JPG

        # Build thumb filename: strip original extension, append _thumb.jpg
        $name    = [System.IO.Path]::GetFileNameWithoutExtension([uri]::UnescapeDataString($file))
        $thumbSrc = $base + [uri]::EscapeDataString($name + "_thumb.jpg")

        return $prefix + '<img src="' + $thumbSrc + '" data-full-src="' + $fullSrc + '" loading="lazy" alt="Obra">'
    }
)

[IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "index.html actualizado con thumbnails."
