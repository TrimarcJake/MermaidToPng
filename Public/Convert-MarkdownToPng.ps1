function Convert-MermaidToPng {
    <#
    .SYNOPSIS
    Converts a Markdown file to a PNG image containing the rendered Mermaid diagrams.
 
    .DESCRIPTION
    This script takes a Markdown file as input, extracts the Mermaid code blocks from it, and converts them into a PNG image using the Microsoft Edge browser in headless mode. The resulting PNG image is saved in the same directory as the input file.
 
    .PARAMETER FilePath
    The path to the Markdown file to be converted. The file must exist and be a valid Markdown file.
 
    .EXAMPLE
    Convert-MermaidToPng -FilePath "C:\path\to\input.md"
    Converts the Markdown file located at "C:\path\to\input.md" to a PNG image.
 
    .NOTES
    - This script requires Microsoft Edge browser to be installed on the system.
    - The script uses the Mermaid library for rendering the diagrams.
    - The script currently only supports basic Mermaid code blocks and does not handle indented code fences or code fences with language identifiers.
    #>
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript({ Test-Path $_ -PathType 'Leaf' })]
        [string]$FilePath,
        [ValidateSet('XS','S','M','L','XL')]
        [string]$Size = 'M'
    )
 
    $ParentPath = Split-Path -Path $FilePath -Parent
    $FileName = Split-Path -Path $FilePath -Leaf
    $FileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
 
    # Set an image size
    switch($Size) {
        'XS' {
            $WindowWidth = 480
            $WindowHeight = 320
        }
        'S' {
            $WindowWidth = 640
            $WindowHeight = 480
        }
        'M' {
            $WindowWidth = 960
            $WindowHeight = 720
        }
        'L' {
            $WindowWidth = 1024
            $WindowHeight = 768
        }
        'XL' {
            $WindowWidth = 1280
            $WindowHeight = 960
        }
    }
 
    # Read the Markdown file content and trim the code fences
    # TODO - This is a very basic implementation. It expects a properly Mermaid-fformatted Markdown file with no additional content outside the code fences.
    $MarkdownContent = Get-Content $FilePath | Select-Object -Skip 1 | Select-Object -SkipLast 1 | Out-String
 
    # Create a temporary HTML file with the Mermaid code
    $TempHtmlFile = [System.IO.Path]::GetTempFileName() + '.html'
    $HtmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
</head>
<body>
    <pre class="mermaid">
$MarkdownContent
    </pre>
</body>
</html>
"@
    $HtmlContent | Out-File -FilePath $TempHtmlFile -Encoding UTF8
 
    $renderLoop = $true
    while ($renderLoop) {
        # Use PowerShell's built-in `msedge` command to convert the HTML to PNG via screenshot
        $TempPngFileName = "$($FileNameWithoutExtension)-$($WindowWidth)x$($WindowHeight).png"
        $TempPngFilePath = Join-Path -Path $ParentPath -ChildPath $TempPngFileName
        Start-Process -FilePath msedge -ArgumentList "--headless --disable-gpu --window-size=$WindowWidth,$WindowHeight --screenshot=$TempPngFilePath", $TempHtmlFile -Wait

        if (Test-IfRightScrollbarExists -ImagePath $TempPngFilePath) {
            Write-Host "Right Scrollbar detected, adding 5 px to height."
            $WindowHeight += 5
            Write-Host "New window height: $WindowHeight"
        }
 
        if (Test-IfBottomScrollbarExists -ImagePath $TempPngFilePath) {
            Write-Host "Bottom Scrollbar Detected, adding 5 px to width."
            $WindowWidth += 5
            Write-Host "New window width: $WindowWidth"
        }
 
        if ( ( (Test-IfBottomScrollbarExists -ImagePath $TempPngFilePath) -eq $false) -and ( (Test-IfRightScrollbarExists -ImagePath $TempPngFilePath) -eq $false) ) {
            $FinalOutputFilePath = Join-Path -Path $ParentPath -ChildPath "$($FileNameWithoutExtension).png"
            Copy-Item -Path $TempPngFilePath -Destination $FinalOutputFilePath -Force
            $renderLoop = $false
        }
    }
 
    Write-Output "Conversion complete. PNG file saved as: $FinalOutputFilePath"
 
    # Clean up temporary files
    $TempPngs = Get-ChildItem $ParentPath "$($FileNameWithoutExtension)-*x*.png"
    Remove-Item -Path $TempHtmlFile -Force
    $TempPngs | Remove-Item -Force
}