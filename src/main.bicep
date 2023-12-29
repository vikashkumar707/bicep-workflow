@description('Specifies the location for resources.')
param location string = 'eastus'
var vnetName = 'VK_vnet'
var vmName = 'VK_VM1'
var vmNicName = 'VK_VmNic'


// Link variables from variables.outputs.bicep
module variables 'variables.bicep' = {
  name: 'VK_VAR'
  params: {
    adminUsername: 'VikashKumar'
    adminPassword: 'Vikash123'
    location: location
    
  }
}


resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [variables.outputs.addressPrefix]
    }
    subnets: [
      {
        name: variables.outputs.subnetName
        properties: {
          addressPrefix: variables.outputs.subnetAddressPrefix
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: variables.outputs.vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: variables.outputs.osDiskStorageAccountType
        }
      }
      imageReference: {
        publisher: variables.outputs.publisher
        offer: variables.outputs.offer
        sku: variables.outputs.sku
        version: variables.outputs.osVersion
      }
    }
    osProfile: {
      computerName: variables.outputs.computerName
      adminUsername: variables.outputs.adminUsername
      adminPassword: variables.outputs.adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNic.id
        }
      ]
    }
  }
}

resource vmNic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: vmNicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: variables.outputs.privateIPAllocationMethod
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output vmNicId string = vmNic.id
