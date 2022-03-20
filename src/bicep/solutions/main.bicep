param timestamp string = utcNow()
param guid string = newGuid()
param tags object = {
  'tagA': 'tagB'
}
param location string = 'usgovvirginia'

targetScope = 'subscription'

resource rgp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rgp'
  location: location
}

module logA '../resource-modules/logAnalytics/main.bicep' = {
  name: 'logA-${timestamp}'
  scope: resourceGroup(rgp.name)
  params: {
    name: 'logA'
    tags: tags
    location: location
    logSku: 'PerGB2018'
  }
}

module azFwPolicy '../resource-modules/firewall/policy/main.bicep' = {
  name: 'azFw-${timestamp}'
  scope: resourceGroup(rgp.name)
  params: {
    logAnalyticsId: logA.outputs.logAWorkSpaceId
    name: 'azFwPolicy'
    location: location
    tags: tags
    fwSku: 'Premium'
  }
}

module acrRegistry '../resource-modules/registry/main.bicep' = {
  scope: resourceGroup(rgp.name)
  name: 'acr-${timestamp}'
  params: {
    location: location
  }
}
