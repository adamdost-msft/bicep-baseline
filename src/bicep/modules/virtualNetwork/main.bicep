@description('Name of the resource group')
param name string
@description('Name of the location')
param location string
@description('Parameter Based Tags')
param tags object
@description('Virtual Network Address Prefixes')
param addressPrefixes array
@description('Subnet Array Configuration Block')
param subnets array


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: subnets
  }
}
