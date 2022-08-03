Write-Host "Hi"
$Table = @()
$Record = @{"Role" = ""}
$Record."Role"="3"
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
$Record."Role"="6"
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord

$Table | export-csv "table_AD_Role.csv" -NoTypeInformation

if($env:SYSTEM_PULLREQUEST_SOURCEBRANCH)
{
"This is a PR build"
$branch = ("$env:SYSTEM_PULLREQUEST_SOURCEBRANCH").replace("refs/heads/","")
Write-Host "Branch name is: " $branch
}
elseif($env:BUILD_SOURCEBRANCH)
{
"This is a Non-PR build pipeline run"
$branch = ("$env:BUILD_SOURCEBRANCH").replace("refs/heads/","")
}
Else
{
Exit
}
Write-Host $branch
# git init
Write-Host "1"
ls
git checkout $branch
# git pull
ls
Write-Host "2"

git add .
git config user.email "navya.26.02.00@gmil.com"
git config user.name "Navya"
git commit -am "commit message [ci skip]"
git push --set-upstream origin $branch
