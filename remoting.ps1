param ($u, $p, $machineName)
$User = $u
$PWord = ConvertTo-SecureString -String $p -AsPlainText -Force
$machine = $machineName
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Invoke-Command -ComputerName $machine -Authentication Negotiate -Credential $creds -ScriptBlock {Import-Module -Name C:\Jenkins\workspace\sil_test\onmyremote.ps1;onmyremote}

#Invoke-Command -ComputerName $machine -Authentication Negotiate -Credential $creds -ScriptBlock {powershell -Command "& { . C:\Jenkins\workspace\sil_test\onmyremote.ps1;onmyremote }" }
