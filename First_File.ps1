Write-Host "Hi"
$Table = @()
$Record = @{"Role" = ""}
$Record."Role"="3"
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
$Record."Role"="6"
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
$primaryAlias = $env:Release_PrimaryArtifactSourceAlias
cd $primaryAlias
cd drop
$current_date = $(get-date -f yyyy-MM-dd)
$filename = "table_AD_$($current_date).csv"
$Table | export-csv $filename -NoTypeInformation

if($env:SYSTEM_PULLREQUEST_SOURCEBRANCH)
{
$branch = ("$env:SYSTEM_PULLREQUEST_SOURCEBRANCH").replace("refs/heads/","")
}
elseif($env:BUILD_SOURCEBRANCH)
{
$branch = ("$env:BUILD_SOURCEBRANCH").replace("refs/heads/","")
}
Else
{
Exit
}
git init

git checkout $branch
# git pull


git add .
git config user.email "navya.26.02.00@gmail.com"
git config user.name "Navya"
git commit -am "Added $($FileName)"
git push --set-upstream origin $branch
