@description('Name of the resource group')
param name string
@description('Name of the location')
param location string
@description('Parameter Based Tags')
param tags object
@description('Route Table Block to populate')
param routes object

resource routeTable 'Microsoft.Network/routeTables@2019-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    routes: [for route in items(routes): {
        name: route.value.name
        properties: {
          addressPrefix: route.value.addressPrefix
          nextHopType: route.value.nextHopType
          nextHopIpAddress: route.value.NextHopIpAddress
        }
      }]
    disableBgpRoutePropagation: true
  }
}

