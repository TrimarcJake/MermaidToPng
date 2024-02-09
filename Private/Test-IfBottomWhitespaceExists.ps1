function Test-IfBottomWhitespaceExists {
    <#
    .SYNOPSIS
        Tests if whitespace exists at the bottom of an image.

    .DESCRIPTION
        This function takes an image file path as input and determines if whitespace exists at the bottom of the image.
        It does this by analyzing the bottommost 15 pixels of the image and calculating the average color.
        If the average color is not pure white (ffffffff), it indicates the presence of non-whitespace at the bottom.

    .PARAMETER ImagePath
        Specifies the path of the image file to be tested.

    .EXAMPLE
        Test-IfBottomWhitespaceExists -ImagePath "C:\Images\image.png"
        This example tests if whitespace exists at the bottom of the image located at "C:\Images\image.png".

    .OUTPUTS
        System.Boolean
        Returns $true if whitespace exists at the bottom, otherwise returns $false.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$ImagePath
    )
 
    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
 
    # Get the bottommost 15 pixels
    $bottommostPixels = $image.Clone([System.Drawing.Rectangle]::FromLTRB(0, $image.Height - 15, $image.Width - 15, $image.Height), $image.PixelFormat)
    $image.Dispose()
    
    # Calculate the average color
    $totalRed = 0
    $totalGreen = 0
    $totalBlue = 0
 
    for ($x = 0; $x -lt $bottommostPixels.Width; $x++) {
        for ($y = 0; $y -lt $bottommostPixels.Height; $y++) {
            $pixel = $bottommostPixels.GetPixel($x, $y)
            $totalRed += $pixel.R
            $totalGreen += $pixel.G
            $totalBlue += $pixel.B
        }
    }
 
    $totalPixels = $bottommostPixels.Width * $bottommostPixels.Height
    $averageRed = [math]::Round($totalRed / $totalPixels)
    $averageGreen = [math]::Round($totalGreen / $totalPixels)
    $averageBlue = [math]::Round($totalBlue / $totalPixels)
 
    # Get the average color and test if it matches pure white (ffffffff)
    $averageColor = [System.Drawing.Color]::FromArgb($averageRed, $averageGreen, $averageBlue)
    ($averageColor.Name -eq 'ffffffff')
}