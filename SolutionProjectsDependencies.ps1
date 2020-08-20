$solutionFilePath = Read-Host 'Full path'

Get-Content $solutionFilePath |
Select-String 'Project\(' |
ForEach-Object {
    $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
    New-Object PSObject -Property @{
        Name = $projectParts[1];
        Path = $projectParts[2];
    }
}