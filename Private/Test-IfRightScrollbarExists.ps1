function Test-IfRightScrollbarExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ImagePath
    )
 
    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
 
    # Get the rightmost 15 pixels
    $rightmostPixels = $image.Clone([System.Drawing.Rectangle]::FromLTRB($image.Width - 5, 0, $image.Width, $image.Height - 5), $image.PixelFormat)
    Clear-Variable image
   
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
    ($averageColor.Name -ne 'ffffffff')
}