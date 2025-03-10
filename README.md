# Cloudflare Terraform Organization Management

This repository contains Terraform configurations for managing multiple Cloudflare accounts and domains. The configurations reference modules from [github.com/MateusClepf/cf-Terraform-Org-management-modules](https://github.com/MateusClepf/cf-Terraform-Org-management-modules).

## Repository Structure

```
└── accounts
    ├── account-1
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── tf-01.whereismypacket.net
    │   │   ├── bot-management.tf
    │   │   ├── cache.tf
    │   │   ├── provider.tf
    │   │   ├── terraform.tfstate.enc  # Encrypted state file
    │   │   ├── variable.tf
    │   │   ├── waf-managed-rules.tf
    │   │   └── zone-settings.tf
    │   └── variable.tf
    └── account-2
        ├── main.tf
        ├── provider.tf
        ├── tf1.requestlab.net
        │   ├── bot-management.tf
        │   ├── cache.tf
        │   ├── provider.tf
        │   ├── terraform.tfstate.enc  # Encrypted state file
        │   ├── variable.tf
        │   ├── waf-managed-rules.tf
        │   └── zone-settings.tf
        └── variable.tf
```

## Encrypted State Files

This repository contains encrypted Terraform state files using Mozilla SOPS and age encryption.

**Public key:** `age1d4gw55krnp4axj742jq5ry80tzlvw3aqgd8c6tqrcgg60z3u2u6qffp2e9`

To work with these encrypted state files, you'll need:
1. The SOPS utility installed (https://github.com/mozilla/sops)
2. The age encryption utility installed (https://github.com/FiloSottile/age)
3. Access to the private key (securely share this with team members)

## Working with Encrypted State Files

### Option 1: Work on a specific project directory

When working on a specific project (e.g., tf-01.whereismypacket.net):

```bash
# Before Terraform operations
./encrypt-state.sh decrypt-file "accounts/account-1/tf-01.whereismypacket.net/terraform.tfstate.enc"

# Run your Terraform commands
cd accounts/account-1/tf-01.whereismypacket.net
terraform plan
terraform apply

# After Terraform operations
cd ../../../
./encrypt-state.sh encrypt-file "accounts/account-1/tf-01.whereismypacket.net/terraform.tfstate"
```

### Option 2: Work on all files in an account

When working on all projects in an account:

```bash
# Before Terraform operations
./encrypt-state.sh decrypt "accounts/account-1"

# After Terraform operations
./encrypt-state.sh encrypt "accounts/account-1"
```

## Getting Started

1. Clone this repository
2. Obtain the private key for state file decryption
3. Save the private key as `key.txt` in the root directory
4. Follow the workflow options above to decrypt state files before making changes

## Module References

The Terraform configurations in this repository reference modules from:
- [github.com/MateusClepf/cf-Terraform-Org-management-modules](https://github.com/MateusClepf/cf-Terraform-Org-management-modules)

These modules provide standardized configurations for:
- WAF Managed Rules
- Bot Management
- Zone Settings
- Cache Configurations

## Security Notes

- Never commit unencrypted state files to the repository
- Keep the private key secure and never commit it to the repository
- The `.gitignore` file is configured to ignore unencrypted state files
- Only encrypted state files (*.tfstate.enc) should be committed

## How to Add a New Domain

1. Create a new directory for the domain under the appropriate account
2. Copy the template files from an existing domain
3. Modify the configurations as needed
4. Run Terraform init, plan, and apply
5. Encrypt the state file before committing