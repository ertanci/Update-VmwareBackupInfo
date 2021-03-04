param ($u, $p, $machineName)
$User = $u
$PWord = ConvertTo-SecureString -String $p -AsPlainText -Force
$machine = $machineName
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Invoke-Command -ComputerName $machine -Authentication Negotiate -Credential $creds -ScriptBlock {Get-Content c:\windows\temp\ertan.log}

