function Test-IfRightWhitespaceExists {
    <#
    .SYNOPSIS
        Tests if whitespace exists at the right edge of an image.

    .DESCRIPTION
        This function takes an image file path as input and determines if whitespace exists at the right edge of the image.
        It does this by analyzing the rightmost 5 pixels of the image and calculating the average color.
        If the average color is not pure white (ffffffff), it indicates the presence of non-whitespace at the right edge.

    .PARAMETER ImagePath
        Specifies the path of the image file to be tested.

    .EXAMPLE
        Test-IfRightWhitespaceExists -ImagePath "C:\Images\image.png"
        This example tests if whitespace exists at the right edge of the image located at "C:\Images\image.png".

    .OUTPUTS
        System.Boolean
        Returns $true if whitespace exists at the right edge, otherwise returns $false.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$ImagePath
    )
 
    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
 
    # Get the rightmost 15 pixels
    # TODO - This is a very basic implementation. It assumes the scrollbar is always on the right side of the image.
    # TODO - The selection width should be configurable - likely to match the desired padding.
    $rightmostPixels = $image.Clone([System.Drawing.Rectangle]::FromLTRB($image.Width - 15, 0, $image.Width, $image.Height - 15), $image.PixelFormat)
    $image.Dispose()
    
    # Calculate the average color
    $totalRed = 0
    $totalGreen = 0
    $totalBlue = 0
 
    for ($x = 0; $x -lt $rightmostPixels.Width; $x++) {
        for ($y = 0; $y -lt $rightmostPixels.Height; $y++) {
            $pixel = $rightmostPixels.GetPixel($x, $y)
            $totalRed += $pixel.R
            $totalGreen += $pixel.G
            $totalBlue += $pixel.B
        }
    }
 
    $totalPixels = $rightmostPixels.Width * $rightmostPixels.Height
    $averageRed = [math]::Round($totalRed / $totalPixels)
    $averageGreen = [math]::Round($totalGreen / $totalPixels)
    $averageBlue = [math]::Round($totalBlue / $totalPixels)
 
    # Get the average color and test if it matches pure white (ffffffff)
    $averageColor = [System.Drawing.Color]::FromArgb($averageRed, $averageGreen, $averageBlue)
    ($averageColor.Name -eq 'ffffffff')
}