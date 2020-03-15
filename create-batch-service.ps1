Login-AzAccount

Get-AzSubscription

Set-AzContext -SubscriptionName "IaaS for Devs"

$location = "westus"
$rgName = "batch-ps-rg"
$acctName = "storageacctps99999"
$batchAcctName = "batchacctps201999"

New-AzResourceGroup -Name $rgName -Location $location 

$storageAcct = New-AzStorageAccount -ResourceGroupName $rgName `
    -Name $acctName `
    -Location $location `
    -SkuName Standard_LRS `
    -Kind StorageV2

New-AzBatchAccount -ResourceGroupName $rgName `
    -Name $batchAcctName `
    -Location $location `
    -AutoStorageAccountId $storageAcct.Id