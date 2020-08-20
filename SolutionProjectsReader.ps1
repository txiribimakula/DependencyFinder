$solutionFilePath = Read-Host 'Full path'

Get-Content $solutionFilePath |
Select-String 'Project\(' |
ForEach-Object {
    $projectParts = $_ -Split '[,=]'
    $projectName = $projectParts[1].Trim('[ "{}]')
    Write-Host $projectName
}