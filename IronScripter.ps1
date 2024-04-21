# Iron Scripter Powershell

# Getting Computer Info
$computerinfo = Get-ComputerInfo

# Name of the computer :
$name = $computerinfo.CsName
# OS
$os = $computerinfo.WindowsProductName
# Processor
$processor = $computerinfo.CsProcessors.name | Select-Object -first 1
# OS Architecture
$architecture = $computerinfo.OsArchitecture
# Time Zone
$timezone = $computerinfo.TimeZone

Write-Output "Computer Name: $name"
Write-Output "Operational System: $os"
Write-Output "Architecture: $architecture"
Write-Output "Processor: $processor"
Write-Output "Time-Zone: $timezone"

# When was a server last shutdown?
$normalshutdown = (Get-WinEvent -FilterHashtable @{ LogName = 'system'; id = 1074 }).TimeCreated[0]
$errorshutdown = (Get-WinEvent -FilterHashtable @{ LogName = 'system'; id = 6008 }).TimeCreated[0]
$criticalshutdown = (Get-WinEvent -FilterHashtable @{ LogName = 'system'; id = 41 }).TimeCreated[0]

$lastshutdown = ($normalshutdown, $errorshutdown, $criticalshutdown|Sort-Object)[-1]
# When did the server start up again?
$startup = (gcim Win32_OperatingSystem).LastBootUpTime
# Local Date Time
$datetime = (gcim Win32_OperatingSystem).LocalDateTime
# Downtime
$downtime=$startup.Subtract($lastshutdown)
# Current Uptime 
$uptime = $datetime.Subtract($startup)

Write-Output "Last Shutdown Time: $lastshutdown"
Write-Output "Last StartUp Time: $startup"
Write-Output "Last Down Time: $downtime"
Write-Output "Current Up Time: $uptime"

