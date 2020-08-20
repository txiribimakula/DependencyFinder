$projectFilePath = Read-Host 'Full path'

[xml]$projectXml = Get-Content $projectFilePath

$ns = new-object Xml.XmlNamespaceManager $projectXml.NameTable
$ns.AddNamespace("msb", "http://schemas.microsoft.com/developer/msbuild/2003")

$projectReferenceNodes = $projectXml.SelectNodes('//msb:ProjectReference', $ns)

foreach ($projectReference in $projectReferenceNodes) {
    Write-Host $projectReference.Include
}