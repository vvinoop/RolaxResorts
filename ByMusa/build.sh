# Docker Build COmmands

set -e

export ACR_HOSTNAME="acrappreg.acr.io"

az login
az acr login

cd app
docker build -t static-web-app:latest .

docker tag static-web-app:latest $ACR_HOSTNAME/static-web-app:latest
docker push $ACR_HOSTNAME/static-web-app:latest


# Terraform Commands
terraform init
terraform validate
terraform plan -out tfpan -var-file dev.tfvars
terraform apply tfplan -var-file dev.rfvars

# Note: Terraform will use az cli to authenticate against azure. No need to add ClientId / ClientSecret / TenantId