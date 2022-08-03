Write-Host "Hi"
$Table = @()
$Record = @{
   "Role Name" = ""
   "Owner" = ""
   "Group Name" = ""
}
$Record."Group Name"="1"
$Record."Owner"="2"
$Record."Role Name"="3"
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
$Record."Group Name"="4"
$Record."Owner"="5"
$Record."Role Name"="6"
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

git checkout $branch
git pull


git add .
# git config --global user.email "Any email id"
# git config --global user.name "Any user name"
git commit -am "commit message [ci skip]"
git push --set-upstream origin $branch
