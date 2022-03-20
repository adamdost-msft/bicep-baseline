@description('Name of the location')
param location string = 'usgovvirginia'
@description('Parameter Based Tags')
param tags object = {}
@description('Subscription ID for targeted rgp')
param subId string 
@description('Current Time')
param timestamp string = utcNow()
@description('Resource Prefix')
param resourcePrefix string


@description('Network Resource Group name')
var netRgpName = '${resourcePrefix}-NET-RGP-01'
@description('Core Resource Group name')
var corRgpName = '${resourcePrefix}-COR-RGP-01'
@description('Application Resource Group name')
var appRgpName = '${resourcePrefix}-APP-RGP-01'
@description('Application Resource Group name')
var avdRgpName = '${resourcePrefix}-AVD-RGP-01'

targetScope = 'subscription'

module netRgp '../../resource-modules/resourceGroups/main.bicep' = {
  scope: subscription(subId)
  name: 'deploy-net-rgp-${timestamp}'
  params: {
    location: location
    name: netRgpName 
    tags: tags
  }
}

module corRgp '../../resource-modules/resourceGroups/main.bicep' = {
  scope: subscription(subId)
  name: 'deploy-cor-rgp-${timestamp}'
  params: {
    location: location
    name: corRgpName 
    tags: tags
  }
}

module appRgp '../../resource-modules/resourceGroups/main.bicep' = {
  scope: subscription(subId)
  name: 'deploy-app-rgp-${timestamp}'
  params: {
    location: location
    name: appRgpName 
    tags: tags
  }
}

module avdRgp '../../resource-modules/resourceGroups/main.bicep' = {
  scope: subscription(subId)
  name: 'deploy-avd-rgp-${timestamp}'
  params: {
    location: location
    name: avdRgpName 
    tags: tags
  }
}

output corRgpObj object = corRgp.outputs.rgpObj
output netRgpObj object = netRgp.outputs.rgpObj
output appRgpObj object = appRgp.outputs.rgpObj
output avdRgpObj object = avdRgp.outputs.rgpObj
