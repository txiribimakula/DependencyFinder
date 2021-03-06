function ProjectDependencies ($projectFilePath, $criteria, $nsUri) {
    [xml]$projectXml = Get-Content $projectFilePath

    $ns = new-object Xml.XmlNamespaceManager $projectXml.NameTable
    $ns.AddNamespace("msb", $nsUri)
    $projectReferenceNodes = $projectXml.SelectNodes('//msb:ProjectReference', $ns)

    foreach ($projectReference in $projectReferenceNodes) {
        $projectReferenceValue = $projectReference.Include;
        if ($projectReferenceValue -match $criteria) {
            Write-Host $projectReference.Include -ForegroundColor Black -BackgroundColor Yellow
        }
        else {
            Write-Host $projectReference.Include
        }
    }
}

function SolutionDependencies ($solutionFilePath, $criteria, $nsUri){
    $solutionFolderPath = Split-Path $solutionFilePath

    Get-Content $solutionFilePath |
    Select-String 'Project\(' |
    ForEach-Object {
        $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
        Write-Host ''
        Write-Host $projectParts[1] -ForegroundColor Blue
    
        $projectFilePath = $solutionFolderPath + '\' + $projectParts[2]
        
        ProjectDependencies $projectFilePath $criteria $nsUri
    }
    Write-Host ''
}

function AskForFilePath {
    $filePath = $null
    do {
        $filePath = Read-Host 'File path (.sln/.csproj)'
        $fileExtension = [System.IO.Path]::GetExtension($filePath)
        $isSLN = $fileExtension -eq '.sln'
        $isCSPROJ = $fileExtension -eq '.csproj'
        if (-not $isSLN -and -not $isCSPROJ) {
            Write-Host 'Extension is not compatible.' -ForegroundColor Red
        }
    } while (-not $isSLN -and -not $isCSPROJ)

    return $filePath,$isSLN,$isCSPROJ
}