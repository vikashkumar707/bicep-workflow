// param adminUsername string
// // param location string = resourceGroup().location
// @secure()
// param adminPassword string


// // var vnetName = 'VK_vnet'
// var subnetName = 'VK_Subnet'
// // var vmName = 'VK_VM1'
// // var vmNicName = 'VK_VmNic'
// var addressPrefix = '10.0.0.0/16'
// var subnetAddressPrefix = '10.0.1.0/24'
// var vmSize = 'Standard_B1s'
// var osDiskStorageAccountType = 'Standard_LRS'
// var publisher = 'MicrosoftWindowsServer'
// var offer = 'WindowsServer'
// var sku = '2019-Datacenter'
// var osVersion = 'latest'
// var computerName = 'myVM01'
// var privateIPAllocationMethod = 'Dynamic'


// output adminUsername string = adminUsername
// #disable-next-line outputs-should-not-contain-secrets
// output adminPassword string = adminPassword
// // output vmName string = vmName
// output  addressPrefix string =  addressPrefix
// // output vmNicName string = vmNicName
// // output vnetName string = vnetName
// // output location string = location
// output subnetName string = subnetName
// output subnetAddressPrefix string = subnetAddressPrefix
// output vmSize string = vmSize
// output osDiskStorageAccountType string = osDiskStorageAccountType
// output publisher string = publisher
// output offer string = offer
// output sku string = sku
// output osVersion string = osVersion
// output computerName string = computerName
// output privateIPAllocationMethod string = privateIPAllocationMethod


param adminUsername string
// param location string = resourceGroup().location
@secure()
param adminPassword string


// var vnetName = 'VK_vnet'
// var subnetName = 'VK_Subnet'
// param vmName string
// var vmNicName = 'VK_VmNic'
var addressPrefix = '10.0.0.0/16'
var subnetAddressPrefix = '10.0.1.0/24'
var vmSize = 'Standard_D2_v3'
var osDiskStorageAccountType = 'Standard_LRS'
var publisher = 'MicrosoftWindowsServer'
var offer = 'WindowsServer'
var sku = '2019-Datacenter'
var osVersion = 'latest'
// var computerName = 'myVM01'
var privateIPAllocationMethod = 'Dynamic'


output adminUsername string = adminUsername
#disable-next-line outputs-should-not-contain-secrets
output adminPassword string = adminPassword
// output vmName string = vmName
output  addressPrefix string =  addressPrefix
// output vmNicName string = vmNicName
// output vnetName string = vnetName
// output location string = location
// output subnetName string = subnetName
output subnetAddressPrefix string = subnetAddressPrefix
output vmSize string = vmSize
output osDiskStorageAccountType string = osDiskStorageAccountType
output publisher string = publisher
output offer string = offer
output sku string = sku
output osVersion string = osVersion
// output computerName string = computerName
output privateIPAllocationMethod string = privateIPAllocationMethod
