@{
    AliasesToExport      = @()
    Author               = 'Jake Hildreth'
    CmdletsToExport      = @()
    CompanyName          = 'CompanyName'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2024 - 2024 Jake Hildreth. All rights reserved.'
    Description          = 'Simple project MermaidToPng'
    FunctionsToExport    = 'Convert-MermaidToPng'
    GUID                 = '7dcbf923-6543-4c54-b309-690be4a3b018'
    ModuleVersion        = '2024.2.8'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags = @('Mermaid', 'Png', 'Markdown', 'Documentation', 'Image', 'Convert')
        }
    }
    RequiredModules      = @(@{
            Guid          = 'eefcb906-b326-4e99-9f54-8b4bb6ef3c6d'
            ModuleName    = 'Microsoft.PowerShell.Management'
            ModuleVersion = '7.0.0.0'
        }, @{
            Guid          = '1da87e53-152b-403e-98dc-74d7b4d63d59'
            ModuleName    = 'Microsoft.PowerShell.Utility'
            ModuleVersion = '7.0.0.0'
        })
    RootModule           = 'MermaidToPng.psm1'
}