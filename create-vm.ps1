Login-AzAccount

Get-AzSubscription

$subscription = Read-Host -Prompt "Enter subscription name"
$location = Read-Host -Prompt "Enter location"
$rgName = Read-Host -Prompt "Enter resource group name"
$newVMName = Read-Host -Prompt "Enter a new VM name"
$credential = Get-Credential

Set-AzContext -SubscriptionName $subscription

New-AzResourceGroup -Name $rgName -Location $location

New-AzVm `
    -ResourceGroupName $rgName `
    -Name $newVMName `
    -Location $location `
    -VirtualNetworkName ($newVMName + "-vnet") `
    -SubnetName ($newVMName + "-subnet") `
    -SecurityGroupName ($newVMName + "-nsg") `
    -PublicIpAddressName ($newVMName + "-ip") `
    -OpenPorts 80, 3389 `
    -Credential $credential

$ipAddress = Get-AzPublicIpAddress -ResourceGroupName $rgName | Select-Object -ExpandProperty IpAddress

Write-Host "IP Adress of your new VM: " + $ipAddress

#For Windows, you can call command for immediate connection to your VM through RDP:
#mstsc /v:$ipAddress