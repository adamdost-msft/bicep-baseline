@description('Name of the resource group')
param name string
@description('Object that contains  the Azure firewall parent policy')
param parentAzFwPolicyObj object
@description('Priority of the Parent Rule Collection Group')
param ruleCollectionParentPriority int
@description('Priority of the Sub Rule Collection Group')
param ruleCollectionPriority int
@description('Name of the rule collection')
param ruleCollectionName string
@allowed([
  'Allow'
  'Deny'
])
@description('Define whether or not the rule collection will allow or deny')
param actionType string = 'Allow'
@description('Azure Firewall Parameters')
param policy object

resource azFwParent 'Microsoft.Network/firewallPolicies@2021-05-01' existing = {
  name: parentAzFwPolicyObj.name
}

resource azFwRuleCollection 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2021-05-01' = {
  name: name
  parent: azFwParent
  properties: {
    priority: ruleCollectionParentPriority
    ruleCollections: [
      {
        name: ruleCollectionName
        priority: ruleCollectionPriority
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        action: {
          type: actionType
        }
        rules: [
          {
            ruleType: policy.ruleType
            name: policy.name
            description: policy.description
            protocols: [
              {
                protocolType: 'Http'
                port: 80
              }
              {
                protocolType: 'Https'
                port: 443
              }
            ]
            sourceAddresses: policy.sourceIpSpace
            fqdnTags: empty(policy.fqdnTags) ? null : policy.fqdnTags
            targetFqdns: empty(policy.targetFqdns) ? null : policy.targetFqdns
            destinationAddresses: empty(policy.targetFqdns) ? null : policy.targetFqdns
          }
        ]
      }
    ]
  }
}
