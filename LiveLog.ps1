<#
    continuously reads a file until the timeout is reached
    prints any new lines added to the file that match the input regex query
    will not exit if new lines are not added to the file, but impact should be negligible on a file not in use
#>

param(

    [Parameter(Position=0,mandatory=$true)]
    [string]$regexString,
    [Parameter(Position=1)]
    [string]$path = "c:\temp\somelog.txt",
    [Parameter(Position=2)]
    [DateTime]$end = (Get-Date).AddHours(1)

)

#tail 1 to skip current log contents & only try to match new content added

Get-Content $path -Tail 1 -Wait | ForEach-Object {

    if($_ -match $regexString){Write-Host $_}
    if((Get-Date) -gt $end){break}

}