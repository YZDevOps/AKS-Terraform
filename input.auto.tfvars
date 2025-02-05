aks_vnet_name = "aksvnet"

sshkvsecret = "akssshpubkey"

clientidkvsecret = "my-app-spn-client-id"

spnkvsecret = "my-app-spn-secret"

vnetcidr = ["10.0.0.0/24"]

subnetcidr = ["10.0.0.0/25"]

keyvault_rg = "aksdemo-rg"

keyvault_name = "aksdemocluster-keyvault"

azure_region = "West Europe"

resource_group = "aksdemocluster-rg"

cluster_name = "aksdemocluster"

acrname= "clusterregister1976"

dns_name = "aksdemocluster"

admin_username = "aksuser"

kubernetes_version = "1.21.7"

agent_pools = {
      name            = "pool1"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_disk_size_gb = "30"
      type                = "VirtualMachineScaleSets"
      availability_zones  = [1, 2, 3]
      
    }
