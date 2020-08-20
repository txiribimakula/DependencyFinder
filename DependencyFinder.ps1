Import-Module -Name ".\DependencyFinder.psm1"

$filePath,$isSLN,$isCSPROJ = AskForFilePath

$criteria = Read-Host 'Criteria'

if ($isSLN) {
    SolutionDependencies $filePath $criteria
}
elseif ($isCSPROJ) {
    ProjectDependencies $filePath $criteria
}