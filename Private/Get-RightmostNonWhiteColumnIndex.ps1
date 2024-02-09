function Get-RightmostNonWhiteColumnIndex {
    <#
    .SYNOPSIS
        Get the index of the rightmost non-white column in an image.

    .DESCRIPTION
        This function takes an image file path as input and returns the index of the rightmost non-white column in the image.
        It iterates through each column from right to left and checks if the pixel is not pure white.
        If a non-white pixel is found, the function returns the zero-based index of that column.
        If all pixels are white, the function returns -1.

    .PARAMETER ImagePath
        Specifies the path of the image file.

    .OUTPUTS
        System.Int32
        The index of the rightmost non-white column in the image. If all pixels are white, -1 is returned.

    .EXAMPLE
        Get-RightmostNonWhiteColumn -ImagePath "C:\Images\image.jpg"
        Returns: 123

    #>

    param(
        [string]$ImagePath
    )

    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
    $bitmap = New-Object System.Drawing.Bitmap $image

    # Iterate through each column from right to left
    for ($x = $bitmap.Width - 1; $x -ge 0; $x--) {
        for ($y = 0; $y -lt $bitmap.Height; $y++) {
            $pixel = $bitmap.GetPixel($x, $y)

            # Check if the pixel is not pure white
            if ($pixel.R -ne 255 -or $pixel.G -ne 255 -or $pixel.B -ne 255) {
                # Return the zero-based index of the rightmost non-white column
                $bitmap.Dispose()
                return $x
            }
        }
    }

    $bitmap.Dispose()
    # If all pixels are white, return -1 or an appropriate value
    return -1
}