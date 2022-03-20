@description('Name of the resource group')
param name string
@description('Name of the location')
param location string = resourceGroup().location
@description('Parameter Based Tags')
param tags object
@allowed([
  'CapacityReservation'
  'Free'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Premium'
  'Standalone'
  'Standard'
])
param logSku string = 'Free'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: logSku
    }
  }
}

output logAWorkSpaceId string = logAnalyticsWorkspace.id
