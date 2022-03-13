@description('Name of the resource group')
param name string
@description('Name of the location')
param location string
@description('Parameter Based Tags')
param tags object

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    securityRules: [
    ]
  }
}
