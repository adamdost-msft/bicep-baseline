param virtualNetwork string
param peeringName string
param remoteVnetId string
param allowGatewayTransit bool
param useRemoteGateways bool
param allowVirtualNetworkAccess bool
param allowForwardedTraffic bool


resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: '${virtualNetwork}/${peeringName}'
  properties: {
    allowVirtualNetworkAccess: allowVirtualNetworkAccess
    allowForwardedTraffic: allowForwardedTraffic
    allowGatewayTransit: allowGatewayTransit
    useRemoteGateways: useRemoteGateways
    remoteVirtualNetwork: {
      id: remoteVnetId
    }
  }
}
