Import-Module PSWriteOffice -Force

$servers = @(
    'vmware.local'
)

$data = [System.Collections.ArrayList]@()

$file_path = "vms.xlsx"

N

#$worksheet = New-OfficeExcelWorkSheet -ExcelDocument $excel -WorksheetName 'VMs'

$user = Read-Host -Prompt "Please enter your username"
$password_sec = Read-Host -Prompt "Please enter your password" -AsSecureString
$password = ConvertFrom-SecureString -SecureString $password_sec -AsPlainTex

foreach ($i in $servers) {
    Connect-VIServer -Server $i -User $user -Password $password
}


Get-VM 
    | Select-Object -Property Name, @{Label = "IPAddress";Expression ={$_.Guest.IPAddress}}, @{Label = "OSFullName";Expression ={$_.Guest.OSFullName}}
    | Export-OfficeExcel -FilePath $file_path -WorksheetName "VMs"