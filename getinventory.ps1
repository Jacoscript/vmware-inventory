Import-Module PSWriteOffice -Force

$servers = @(
    'vmware.local'
)

$data = [System.Collections.ArrayList]@()

$file_path = "vms.xlsx"


#$worksheet = New-OfficeExcelWorkSheet -ExcelDocument $excel -WorksheetName 'VMs'

$user = Read-Host -Prompt "Please enter your username"
$password_sec = Read-Host -Prompt "Please enter your password" -AsSecureString
$password = ConvertFrom-SecureString -SecureString $password_sec -AsPlainText

foreach ($i in $servers) {
    Connect-VIServer -Server $i -User $user -Password $password
}


Get-VM 
    | Select-Object -Property Name, @{Label = "IPAddress";Expression ={$_.Guest.IPAddress | Where {$_ -NotLike "*:*"}}}, @{Label = "OSFullName";Expression ={$_.Guest.OSFullName}}
    | Export-Csv -Path vms.csv