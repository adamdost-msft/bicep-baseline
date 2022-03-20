$fwName = "azFwPolicy"
$rgpName = "rgp"
$polName = "policy01"
$priority = 1000

az network firewall policy rule-collection-group create --name $polName `
                                                        --policy-name $fwName `
                                                        --priority $priority `
                                                        --resource-group $rgpName 


az network firewall application-rule create --collection-name $polName  `
--name "allow-google" `
--protocols "http=80" `
--resource-group $rgpName `
--action Allow `
--priority 1000 `
--source-addresses "10.0.0.0/8" `
--fqdn-tags ['WindowsUpdate'] `
--firewall-name $fwName
