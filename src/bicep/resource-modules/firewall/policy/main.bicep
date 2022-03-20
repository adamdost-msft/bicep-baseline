@description('Name of the resource group')
param name string
@description('Name of the location')
param location string = resourceGroup().location
@description('Parameter Based Tags')
param tags object
@description('Log Analytics Resource ID')
param logAnalyticsId string
@allowed([
  'Standard'
  'Premium'
  'Basic'
])
param fwSku string = 'Premium'

resource azFwPolicy 'Microsoft.Network/firewallPolicies@2021-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    insights: {
      isEnabled: true
      logAnalyticsResources: {
        defaultWorkspaceId: {
          id: logAnalyticsId
        }
      }
      retentionDays: 365
    }
    intrusionDetection: {
      mode: 'Deny'
    }
    sku: {
      tier: fwSku
    }
    threatIntelMode: 'Deny'
  }
}

output azFwPolicyName string = azFwPolicy.name
