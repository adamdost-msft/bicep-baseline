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

targetScope = 'subscription'

module rgpDepoy 'hubRgpDeploy/hubRgp.bicep' = {
  scope: subscription(subId)
  name: 'deploy-hub-rgps-${timestamp}'
  params: {
    resourcePrefix: resourcePrefix
    subId: subId
  }
}
