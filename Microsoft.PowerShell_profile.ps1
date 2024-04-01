Set-PSReadLineKeyHandler -Chord "Tab" -Function AcceptLine
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -Colors @{ "Command" = '#1b80a7' }

function NpmInstallStart { npm install && npm start }  
Set-Alias nis NpmInstallStart
function NpmStart { npm start }  
Set-Alias dev NpmStart
function GitPull { git pull }  
Set-Alias pull GitPull
function GitPush { git push }
Set-Alias push GitPush
function GitFetch { git fetch -p }  
Set-Alias fetch GitFetch
function GitCheckoutMaster { git checkout master && git pull }
Set-Alias master GitCheckoutMaster
function GitCheckout([string]$branchId) { git checkout ${branchId} }  
Set-Alias checkout GitCheckout
function CommitBranch([string]$branchId) { git checkout master && git pull origin && git checkout -b $branchId }  
Set-Alias branch CommitBranch
function SaveCurrentWork([string]$branchId, [string]$branchMessage) { git add . && git stash -m ${branchId} && git checkout master && git pull && git checkout -b ${branchId} && git stash apply 0 && git add . && git commit -m "#${branchId} - ${branchMessage}" && git push origin ${branchId} && git checkout master }  
Set-Alias firstSave SaveCurrentWork
function CommitWork([string]$branchId, [string]$branchMessage) { git add . && git commit -m "#${branchId} - ${branchMessage}" && git push origin ${branchId} }  
Set-Alias save CommitWork
function CommitDateNow { git add . && git commit -m "$(Get-Date)" && git push }  
Set-Alias savedb CommitDateNow
function Publish { npm run patch && npm run build && npm run publish }
Set-Alias libpub Publish
function InstallPublish { npm i @forlogic/qex@latest }
Set-Alias libinst InstallPublish