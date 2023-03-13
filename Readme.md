This repossitory stores the infrastructure code to provision the stack to deploy Rolax Resort application

Terraform Statefile - storing it locally
Region : UK South : uksouth (region name)
Resource group
Vnet
Private Subnet
Azure Container Registry
Log Analytics Workspace
Azure Container Apps Environment
Container Apps
Load balancer/Application Gateway
Azure Monitor



Parked Items:

    Iam Policy 
    -  create user for authentication
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/44dacde6-8608-413c-a507-73a91aa45940"

    Azure Contaienr apps not connecting to application gateway backend, hence using Azure container instance
    
    Azure Container Apps Environment
    Container Apps
