terraform {
  required_providers {
    qumulo = {
      source  = "qumulo-terraform-registry.s3.us-east-1.amazonaws.com/qumulo/qumulo"
      version = "~> 1.0"
    }
  }
}

provider "qumulo" {
  azure {
    subscription_id = "18854c3b-da18-4bd5-8449-587ebb392144"
  }
}

resource "qumulo_filesystem_azure" "spoke2" {
  name                = "azurespoke16"
  resource_group_name = "spoke-azure-27"
  location            = "westus2"

  subnet_id = "/subscriptions/18854c3b-da18-4bd5-8449-587ebb392144/resourceGroups/engineering-cnq-vnet/providers/Microsoft.Network/virtualNetworks/engineering-cnq-vnet/subnets/engineering-cnq-subnet"

  node_count           = 3
  vm_type              = "Standard_L8s_v3"
  admin_password       = "Admin123!"
  cluster_product_type = "HOT"
}

output "cluster_name" {
  value = qumulo_filesystem_azure.spoke2.name
}

output "endpoint_ips" {
  value = qumulo_filesystem_azure.spoke2.endpoint_ips
}
