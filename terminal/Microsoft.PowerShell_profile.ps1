function prompt {
  $origLastExitCode = $LastExitCode

  Write-Host "$(Get-Date -f "HH:mm:ss") " -NoNewline -ForegroundColor DarkYellow

  $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
  if ($curPath.ToLower().StartsWith($Home.ToLower())) {
    $curPath = "~" + $curPath.SubString($Home.Length)
  } 

  Write-Host $curPath -NoNewline -ForegroundColor Magenta

  Write-VcsStatus

  $LastExitCode = $origLastExitCode
  "`n$('>' * ($nestedPromptLevel + 1)) "
}

Import-Module posh-git
Import-Module PSColor

$GitPromptSettings.BeforeText = ' on ['
$GitPromptSettings.DefaultPromptPrefix = '`n$(''>'' * ($nestedPromptLevel + 1)) '
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

function which($name) {
  Get-Command $name | Select-Object -ExpandProperty Definition
}

function git-fetch-git-status(){
  git fetch; git status
}
Set-Alias -Name gfgs -Value  git-fetch-git-status

Import-Module posh-git
