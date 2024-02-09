function Test-IfBottomScrollbarExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ImagePath
    )
 
    # Load the image
    $image = [System.Drawing.Image]::FromFile($ImagePath)
 
    # Get the bottommost 15 pixels
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