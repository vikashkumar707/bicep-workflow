// @description('Specifies the location for resources.')
// param location string = resourceGroup().location
// var vnetName = 'VK_vnet'
// var vmName = 'VK_VM1'
// var vmNicName = 'VK_VmNic'


// // Link variables from variables.outputs.bicep
// module variables 'variables.bicep' = {
//   name: 'VK_VAR'
//   params: {
//     adminUsername: 'VikashKumar'
//     adminPassword: 'Vikash123'
   
    
//   }
// }


// resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
//   name: vnetName
//   location: location
//   properties: {
//     addressSpace: {
//       addressPrefixes: [variables.outputs.addressPrefix]
//     }
//     subnets: [
//       {
//         name: variables.outputs.subnetName
//         properties: {
//           addressPrefix: variables.outputs.subnetAddressPrefix
//         }
//       }
//     ]
//   }
// }

// resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
//   name: vmName
//   location: location
//   properties: {
//     hardwareProfile: {
//       vmSize: variables.outputs.vmSize
//     }
//     storageProfile: {
//       osDisk: {
//         createOption: 'FromImage'
//         managedDisk: {
//           storageAccountType: variables.outputs.osDiskStorageAccountType
//         }
//       }
//       imageReference: {
//         publisher: variables.outputs.publisher
//         offer: variables.outputs.offer
//         sku: variables.outputs.sku
//         version: variables.outputs.osVersion
//       }
//     }
//     osProfile: {
//       computerName: variables.outputs.computerName
//       adminUsername: variables.outputs.adminUsername
//       adminPassword: variables.outputs.adminPassword
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: vmNic.id
//         }
//       ]
//     }
//   }
// }

// resource vmNic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
//   name: vmNicName
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: 'ipconfig'
//         properties: {
//           subnet: {
//             id: vnet.properties.subnets[0].id
//           }
//           privateIPAllocationMethod: variables.outputs.privateIPAllocationMethod
//         }
//       }
//     ]
//   }
// }

// output vnetId string = vnet.id
// output vmNicId string = vmNic.id



@description('Specifies the location for resources.')
param location string = resourceGroup().location
@description('VM name Prefix')
param vmName string = 'az104-04-vm'
@description('Number of VMs')
param vmCount int = 2
param nic_VK string = 'VK_VmNic'
@description('Virtual network name')
param vnetName string = 'VK_vnet'
var subnetName = 'subnet'
var subnet0Name = 'subnet0'
var subnet1Name = 'subnet1'
// var subnet2Name = 'subnet2'
// var subnet3Name = 'subnet3'
// param subnetNames array = ['subnet0', 'subnet1', 'subnet2']

// Link variables from variables.outputs.bicep
module variables 'variables.bicep' = {
  name: 'VK_VAR'
  params: {
    
    adminUsername: 'VikashKumar'
    adminPassword: 'Vikash123'
    
    
    
  }
}


resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' =  {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.40.0.0/22']
    }
    subnets: [

      
        // for subnetName in subnetNames: {
        //   name: subnetName
        //   properties: {
        //     addressPrefix: '10.0.' + string(subnetNames.indexOf(subnetName)) + '.0/24'
        //   }
        // }
      
  
      {
        name: subnet0Name
        properties: {
          addressPrefix: '10.40.0.0/24'
        }
      }
      {
        name: subnet1Name
        properties: {
          addressPrefix: '10.40.1.0/24'
        }
      }
      // {
      //   name: subnet2Name
      //   properties: {
      //     addressPrefix: '10.40.2.0/24'
      //   }
      // }
      // {
      //   name: subnet3Name
      //   properties: {
      //     addressPrefix: '10.40.3.0/24'
      //   }
      // }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = [for i in range(0, vmCount): {
  name: '${vmName}${i}'
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
      computerName: '${vmName}${i}'
      adminUsername: variables.outputs.adminUsername
      adminPassword: variables.outputs.adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: resourceId('Microsoft.Network/networkInterfaces', '${nic_VK}${i}')
        }
      ]
    }
  }
  dependsOn:[
    vnet
  ]
}]

resource vmNic 'Microsoft.Network/networkInterfaces@2021-02-01' =  [for i in range(0, vmCount):{
  name: '${nic_VK}${i}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, '${subnetName}${i}')
          }
          privateIPAllocationMethod: variables.outputs.privateIPAllocationMethod
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}]

output vnetId string = vnet.id

