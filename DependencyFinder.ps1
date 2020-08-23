param ([string]$ns='')

Import-Module -Name ".\DependencyFinder.psm1"

$filePath,$isSLN,$isCSPROJ = AskForFilePath

$criteria = Read-Host 'Criteria'

if ($isSLN) {
    SolutionDependencies $filePath $criteria $ns
}
elseif ($isCSPROJ) {
    ProjectDependencies $filePath $criteria $ns
}