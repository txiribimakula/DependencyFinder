$projectFilePath = Read-Host 'Full path'

[xml]$projectXml = Get-Content $projectFilePath

foreach($projectReference in $projectXml.Project.ItemGroup.ProjectReference) {
    Write-Host $projectReference.Include
}