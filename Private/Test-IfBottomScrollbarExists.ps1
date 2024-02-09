function Test-IfBottomScrollbarExists {
    <#
    .SYNOPSIS
        Tests if a bottom scrollbar exists in an image.

    .DESCRIPTION
        This function takes an image file path as input and determines if a bottom scrollbar exists in the image.
        It does this by analyzing the bottommost 5 pixels of the image and calculating the average color.
        If the average color is not pure white (ffffffff), it indicates the presence of a scrollbar.

    .PARAMETER ImagePath
        Specifies the path of the image file to be tested.

    .EXAMPLE
        Test-IfBottomScrollbarExists -ImagePath "C:\Images\image.png"
        This example tests if a bottom scrollbar exists in the image located at "C:\Images\image.png".

    .OUTPUTS
        System.Boolean
        Returns $true if a bottom scrollbar exists, otherwise returns $false.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$ImagePath
    )
 
    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
 
    # Get the bottommost 5 pixels
    $bottommostPixels = $image.Clone([System.Drawing.Rectangle]::FromLTRB(0, $image.Height - 5, $image.Width -5, $image.Height), $image.PixelFormat)
    Clear-Variable image
    
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
    ($averageColor.Name -ne 'ffffffff')
}