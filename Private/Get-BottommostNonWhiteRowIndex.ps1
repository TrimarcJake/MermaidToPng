function Get-BottommostNonWhiteRowIndex {
    <#
    .SYNOPSIS
        Get the index of the bottommost row that includes non-white pixels in an image.

    .DESCRIPTION
        This function takes an image file path as input and returns the index of the bottommost row that includes non-white pixels in the image.
        It iterates through each row from bottom to top and checks if any pixel in that row is not pure white.
        If a non-white pixel is found, the function returns the zero-based index of that row.
        If all pixels are white, the function returns -1.

    .PARAMETER ImagePath
        Specifies the path of the image file.

    .OUTPUTS
        System.Int32
        The index of the bottommost row that includes non-white pixels in the image. If all pixels are white, -1 is returned.

    .EXAMPLE
        Get-BottommostNonWhiteRowIndex -ImagePath "C:\Images\image.jpg"
        Returns: 456

    #>

    param(
        [string]$ImagePath
    )

    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
    $bitmap = New-Object System.Drawing.Bitmap $image
    $image.Dispose()

    # Iterate through each row from bottom to top
    for ($y = $bitmap.Height - 1; $y -ge 0; $y--) {
        for ($x = 0; $x -lt $bitmap.Width; $x++) {
            $pixel = $bitmap.GetPixel($x, $y)

            # Check if the pixel is not pure white
            if ($pixel.R -ne 255 -or $pixel.G -ne 255 -or $pixel.B -ne 255) {
                # Return the zero-based index of the bottommost row that includes non-white pixels
                $bitmap.Dispose()
                return $y
            }
        }
    }

    $bitmap.Dispose()
    # If all pixels are white, return -1 or an appropriate value
    return -1
}