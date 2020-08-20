


$solutionFilePath = Read-Host 'Full path'

$solutionFolderPath = Split-Path $solutionFilePath

Get-Content $solutionFilePath |
Select-String 'Project\(' |
ForEach-Object {
    $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
    Write-Host $projectParts[1]

    $projectFilePath = $solutionFolderPath + '\' + $projectParts[2]
    [xml]$projectXml = Get-Content $projectFilePath

    $ns = new-object Xml.XmlNamespaceManager $projectXml.NameTable
    $ns.AddNamespace("msb", "http://schemas.microsoft.com/developer/msbuild/2003")

    $projectReferenceNodes = $projectXml.SelectNodes('//msb:ProjectReference', $ns)

    foreach ($projectReference in $projectReferenceNodes) {
        Write-Host $projectReference.Include
    }
}