#!/bin/bash

echo "================================"
echo "  Sengoku AWS Setup Script"
echo "================================"
echo ""

echo ">>> Step 1: Downloading Terraform..."
wget -q https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
echo ">>> Unzipping..."
unzip -q terraform_1.7.5_linux_amd64.zip
mkdir -p ~/bin
mv terraform ~/bin/
export PATH=$PATH:~/bin
echo "✓ Terraform installed: $(terraform --version | head -1)"
echo ""

echo ">>> Step 2: Checking Git..."
if command -v git &>/dev/null; then
    echo "✓ Git already installed: $(git --version)"
else
    echo "Git not found, installing..."
    dnf install -y git
    echo "✓ Git installed: $(git --version)"
fi
echo ""

echo ">>> Step 3: Cloning GitHub repo..."
git clone https://github.com/Edin2753/ISO_Sengoku_PR2
echo "✓ Repo cloned!"
echo ""

echo ">>> Step 4: Initializing Terraform..."
cd ISO_Sengoku_PR2/terraform-sengoku
terraform init
echo ""

echo "================================"
echo "  Setup complete!"
echo "  Run: terraform apply"
echo "================================"