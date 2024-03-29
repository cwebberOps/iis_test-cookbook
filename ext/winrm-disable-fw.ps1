<powershell>
 
#####
#DON'T FORGET TO SET/CHANGE THE USERNAME/PASSWORD BELOW!
#####
 
$start = Get-Date
$user="chef"
$password="chef"

# Disable password complexity requirements
$seccfg = [IO.Path]::GetTempFileName()
secedit /export /cfg $seccfg
(Get-Content $seccfg) | Foreach-Object {$_ -replace "PasswordComplexity\s*=\s*1", "PasswordComplexity=0"} | Set-Content $seccfg
secedit /configure /db $env:windir\security\new.sdb /cfg $seccfg /areas SECURITYPOLICY
del $seccfg
 
# Create a user with her password, add to Admin group
net user /add $user $password;
net localgroup Administrators /add $user;

# These commands are necessary only if the target machine is being
# used as a Chef node and you want to bootstrap it. They do not need
# to appear on a "workstation" machine.
# 
# Get the instance ready for Chef bootstrapper
winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="512"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall set allprofiles state off
</powershell>
