@description('Name of the resource group')
param name string
@description('Name of the location')
param location string
@description('Parameter Based Tags')
param tags object

targetScope = 'subscription'

resource rgp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  tags: tags
}
