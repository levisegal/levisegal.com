## Setup
```bash
# npm install
brew install terraform

# Export your AWS credentials
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
```

## Folder Structure
```bash
├── infrastructure # infrastructure
├── scripts # utility scripts e.g. deploy_site.sh
└── site # hugo static site

```

## Terraform Files

```bash
└── base # configure resources common across all environments (IAM & API Gateway)
    └── files # Files to use with Terraform file() helper
└── app # application infrastructure
    ├── production.tfvars # production terraform environment variables
    ├── staging.tfvars # staging terraform environment variables
    └── variables.tf # variables that need to be set in respective .tfvars file
└── modules # terraform resource modules
```

## Hugo Structure
```bash
├── archetypes # a way to define the default metadata for a new type of post.
├── config.toml # site configuration.
├── content # actual site content.
├── data # specify your own custom data that can be accessed via templates or shortcodes.
├── layouts # html templates utilizing Go html/template library
├── public # compiled html files that get deployed to s3
├── static # will be copied directly into the final site when rendered.
└── themes # community themes
```

### Manually deploying

The [`base`](./terraform/base) directory contains resources that are shared *across environments.*
Since base resources are shared, they _do not_ use `terraform env`.

Deploying resources shared across environments:

```bash
cd ./terraform/base
terraform plan
terraform apply
```

The [`app`](./terraform/app) directory contains resources that are environment specific.

Current environments:
* staging
* production

Deploying a specific environment:

```bash
# Package lambdas
npm run build

cd ./terraform/app

# Select the terraform environment to use:
terraform env list

# e.g: terraform env select staging
terraform env select staging
```

