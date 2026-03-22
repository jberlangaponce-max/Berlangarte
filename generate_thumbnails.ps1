# ================================================
# generate_thumbnails.ps1
# Genera miniaturas (máx. 600px de ancho) de todas
# las imagenes de la Galería para carga rápida.
# La imagen original se conserva intacta.
# ================================================
Add-Type -AssemblyName System.Drawing

$galleriaPath = ".\IMAGENES PAGINA WEB\Galeria"
$thumbSuffix   = "_thumb"
$maxWidth      = 600   # px máximos del lado largo
$quality       = 80    # calidad JPEG (0-100)

$extensions = @("*.jpg","*.jpeg","*.JPG","*.JPEG","*.png","*.PNG")

$imageCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
    Where-Object { $_.MimeType -eq "image/jpeg" }

$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
    [System.Drawing.Imaging.Encoder]::Quality, [long]$quality)

$count = 0
foreach ($ext in $extensions) {
    Get-ChildItem -Path $galleriaPath -Filter $ext -File -Recurse | ForEach-Object {
        $file = $_
        # Evitar procesar los que ya son thumbs
        if ($file.BaseName -like "*$thumbSuffix") { return }

        $thumbName = $file.BaseName + $thumbSuffix + ".jpg"
        $thumbPath = Join-Path $file.DirectoryName $thumbName

        # Si el thumb ya existe, saltar
        if (Test-Path $thumbPath) { return }

        try {
            $img = [System.Drawing.Image]::FromFile($file.FullName)
            
            $w = $img.Width
            $h = $img.Height

            if ($w -gt $maxWidth) {
                $ratio  = $maxWidth / $w
                $newW   = [int]($w * $ratio)
                $newH   = [int]($h * $ratio)
            } else {
                $newW = $w
                $newH = $h
            }

            $thumb = New-Object System.Drawing.Bitmap($newW, $newH)
            $g = [System.Drawing.Graphics]::FromImage($thumb)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.DrawImage($img, 0, 0, $newW, $newH)
            $g.Dispose()

            $thumb.Save($thumbPath, $imageCodec, $encoderParams)
            $thumb.Dispose()
            $img.Dispose()

            $count++
            Write-Host "OK: $thumbName"
        } catch {
            Write-Host "ERROR procesando $($file.Name): $_"
        }
    }
}

Write-Host "`n✅ Proceso completado: $count miniaturas generadas."
