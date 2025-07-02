# Modus Create POC - Flask Todo Application

A simple yet robust Flask-based todo list application designed as a proof of concept, featuring containerization with Docker and cloud deployment capabilities using Azure services.

## 📋 Overview

This project demonstrates a complete web application stack with:

- **Flask** web framework for the backend
- **HTML/CSS** for the frontend with responsive design
- **Docker** containerization for consistent deployment
- **Azure App Service** deployment via Terraform
- **Comprehensive testing** with pytest
- **CI/CD ready** infrastructure

## 🚀 Features

- ✅ Add new todo items
- ❌ Delete existing todos
- 🎨 Modern, responsive UI design
- 📱 Mobile-friendly interface
- 🔧 Environment-based configuration
- 📊 Structured logging
- 🧪 Full test coverage
- 🐳 Docker containerization
- ☁️ Azure cloud deployment ready

## 🛠️ Technology Stack

- **Backend**: Flask 2.3.3, Gunicorn 21.2.0
- **Frontend**: HTML5, CSS3 (responsive design)
- **Testing**: pytest 8.2.1
- **Containerization**: Docker
- **Infrastructure**: Terraform (Azure)
- **Runtime**: Python 3.13

## 📁 Project Structure

```text
modus-create-poc/
├── app/                    # Main application code
│   ├── app.py             # Flask application
│   ├── requirements.txt   # Python dependencies
│   ├── test_app.py       # Unit tests
│   ├── static/           # Static assets
│   │   └── images/       # Image files
│   └── templates/        # HTML templates
│       └── index.html    # Main page template
├── deploy/               # Deployment configurations
│   └── terraform/        # Infrastructure as Code
│       ├── main.tf       # Main Terraform configuration
│       ├── variables.tf  # Variable definitions
│       ├── provider.tf   # Provider configuration
│       ├── backend.tf    # State backend configuration
│       └── output.tf     # Output definitions
├── scripts/              # Utility scripts
│   └── tag_release.sh    # Release tagging script
├── docs/                 # Documentation
├── Dockerfile           # Container configuration
├── version.txt          # Application version
└── README.md           # This file
```

## 🏗️ CI/CD Pipeline

The project includes a complete GitHub Actions workflow setup for automated testing, building, and deployment:

### Workflow Files

```text
.github/workflows/
├── pr-test.yml         # Pull request testing
├── deploy-infra.yml    # Infrastructure deployment
└── deploy-app.yml      # Application build and deployment
```

### GitHub Actions Workflows

#### 🔍 PR Test Workflow (`pr-test.yml`)

- **Trigger**: Pull requests to `main` branch
- **Purpose**: Automated testing for code quality assurance
- **Steps**:
  - Checkout code
  - Set up Python 3.13
  - Install dependencies
  - Run pytest test suite

#### 🛠️ Infrastructure Management (`deploy-infra.yml`)

- **Trigger**: Manual workflow dispatch
- **Purpose**: Deploy/destroy Azure infrastructure using Terraform
- **Features**:
  - Optional infrastructure destruction
  - Terraform 1.6.6 with Azure provider
  - Environment-based secrets management
  - Azure Resource Group, App Service Plan, and Web App creation

#### 🚀 Build & Deploy Workflow (`deploy-app.yml`)

- **Trigger**: Push to `main` branch (app changes) or manual dispatch
- **Purpose**: Complete CI/CD pipeline with semantic versioning
- **Pipeline Stages**:

  **1. Release Stage**
  - Semantic versioning with conventional commits
  - Automatic changelog generation
  - GitHub release creation

  **2. Build Stage**
  - Python environment setup and testing
  - Docker image building
  - Azure Container Registry (ACR) push
  - Image tagging with semantic version

  **3. Deploy Stage**
  - Azure Web App environment configuration
  - Container deployment to Azure App Service

### Required Secrets and Variables

#### GitHub Secrets

- `AZURE_CREDENTIALS`: Azure service principal for app deployment
- `AZURE_CREDS_CORE`: Azure credentials for ACR access
- `MY_GITHUB_TOKEN`: GitHub token for semantic release
- `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`: Azure service principal for Terraform
- `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`: Azure subscription details
- `STATE_CLIENT_ID`, `STATE_CLIENT_SECRET`: Terraform state management
- `STATE_SUBSCRIPTION_ID`, `STATE_TENANT_ID`: Terraform state Azure details

#### GitHub Variables

- `RESOURCE_GROUP`: Azure resource group name
- `AZURE_LOCATION`: Azure deployment region
- `ACR_NAME`: Azure Container Registry name
- `AZURE_WEBAPP_NAME`: Azure Web App name

### Semantic Versioning

The project uses semantic-release for automated versioning:

- **feat**: New features (minor version bump)
- **fix**: Bug fixes (patch version bump)
- **BREAKING CHANGE**: Breaking changes (major version bump)
- Automatic changelog and GitHub release generation

## 🏃‍♂️ Quick Start

### Prerequisites

- Python 3.13+
- Docker (optional, for containerization)
- Azure CLI (for cloud deployment)

### Local Development

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd modus-create-poc
   ```

2. **Set up Python environment**

   ```bash
   cd app
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Run the application**

   ```bash
   python app.py
   ```

4. **Access the application**

   Open your browser and navigate to `http://localhost:5000`

### Environment Variables

The application supports the following environment variables:

- `CUSTOM_MESSAGE`: Custom message displayed on the main page
- `DEPLOY_ENV`: Deployment environment identifier
- `BUILD_VERSION`: Application build version
- `FLASK_APP`: Flask application module (default: `app`)

### Running Tests

```bash
cd app
pytest test_app.py -v
```

## 🐳 Docker Usage

### Build the Docker image

```bash
docker build -t modus-create-poc .
```

### Run the container

```bash
docker run -p 8000:8000 \
  -e CUSTOM_MESSAGE="Hello from Docker!" \
  -e DEPLOY_ENV="docker" \
  -e BUILD_VERSION="1.0.0" \
  modus-create-poc
```

The application will be available at `http://localhost:8000`

## ☁️ Azure Deployment

This project includes Terraform configurations for deploying to Azure App Service.

### Azure Deployment Prerequisites

- Azure subscription
- Terraform installed
- Azure CLI configured

### Deployment Steps

1. **Navigate to Terraform directory**

   ```bash
   cd deploy/terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Plan the deployment**

   ```bash
   terraform plan
   ```

4. **Apply the configuration**

   ```bash
   terraform apply
   ```

### Infrastructure Components

The Terraform configuration creates:

- Azure Resource Group
- Azure App Service Plan (F1 SKU)
- Azure Linux Web App
- Integration with existing Azure Container Registry
- User-assigned managed identity integration

## 🏗️ Infrastructure as Code (Terraform)

The project uses Terraform for Infrastructure as Code (IaC) to provision and manage Azure resources. The Terraform configuration is organized into multiple files for maintainability and follows Azure best practices.

### Terraform File Structure

```text
deploy/terraform/
├── backend.tf          # Remote state configuration
├── provider.tf         # Azure provider configuration
├── variables.tf        # Input variable definitions
├── main.tf            # Core resource definitions
├── output.tf          # Output value definitions
└── steps              # Setup instructions
```

### File Breakdown

#### 🔧 `backend.tf` - State Management

```hcl
terraform {
  required_version = ">= 1.3.0"
  
  backend "azurerm" {
    resource_group_name  = "core-rg"
    storage_account_name = "tfstatestorage13543"
    container_name       = "tfstate"
    key                  = "modus-create-infra.tfstate"
  }
}
```

**Purpose**: Configures remote state storage in Azure Storage Account

- **State File**: `modus-create-infra.tfstate` stored in Azure Blob Storage
- **Benefits**: Team collaboration, state locking, and disaster recovery
- **Minimum Terraform Version**: 1.3.0+

#### 🔐 `provider.tf` - Provider Configuration

```hcl
provider "azurerm" {
  alias           = "infra"
  subscription_id = var.infra_subscription_id
  client_id       = var.infra_client_id
  client_secret   = var.infra_client_secret
  tenant_id       = var.infra_tenant_id
  features {}
}

provider "azurerm" {
  alias = "state"
  features {}
}
```

**Purpose**: Defines Azure Resource Manager providers

- **`infra` Provider**: For deploying application infrastructure with explicit credentials
- **`state` Provider**: For accessing existing shared resources (uses environment variables)
- **Dual Provider Setup**: Enables cross-subscription resource access

#### 📋 `variables.tf` - Input Variables

```hcl
variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "prefix" {
  type = string
}

variable "webapp_name" {
  type = string
}

variable "acr_name" {
  type = string
}

# Service Principal Variables
variable "infra_subscription_id" {
  type        = string
  description = "Subscription ID for infrastructure deployment"
}

variable "infra_client_id" {
  type        = string
  description = "Client ID for the infra SP"
}

variable "infra_client_secret" {
  type        = string
  description = "Client Secret for the infra SP"
  sensitive   = true
}

variable "infra_tenant_id" {
  type        = string
  description = "Tenant ID for the infra SP"
}
```

**Purpose**: Defines configurable parameters for infrastructure deployment

- **Resource Naming**: `resource_group_name`, `prefix`, `webapp_name`, `acr_name`
- **Location**: Azure region (defaults to East US)
- **Authentication**: Service principal credentials for deployment
- **Security**: Sensitive variables marked appropriately

#### 🏢 `main.tf` - Core Infrastructure

```hcl
# Resource Group
resource "azurerm_resource_group" "rg" {
  provider = azurerm.infra
  name     = var.resource_group_name
  location = var.location
}

# Data Sources - Existing Resources
data "azurerm_container_registry" "acr" {
  provider            = azurerm.state
  name                = "az4africa"
  resource_group_name = "core-rg"
}

data "azurerm_user_assigned_identity" "identity" {
  provider            = azurerm.state
  name                = "core-resources-umi"
  resource_group_name = "core-rg"
}

# App Service Plan
resource "azurerm_service_plan" "plan" {
  provider            = azurerm.infra
  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  os_type  = "Linux"
  sku_name = "F1"  # Free tier
}

# Linux Web App
resource "azurerm_linux_web_app" "app" {
  provider            = azurerm.infra
  name                = var.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  
  # User-Assigned Managed Identity
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  }
  
  site_config {
    # Container Registry Authentication
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = data.azurerm_user_assigned_identity.identity.client_id
    
    always_on = false  # Required for F1 tier
    
    # Docker Configuration
    application_stack {
      docker_image_name   = "flask-app:0.0.1"
      docker_registry_url = "https://${data.azurerm_container_registry.acr.login_server}"
    }
  }
  
  # Application Settings
  app_settings = {
    WEBSITES_PORT  = "8000"
    CUSTOM_MESSAGE = "Hello from Terraform"
    DEPLOY_ENV     = "terraform"
  }
}
```

**Key Components**:

- **Resource Group**: Container for all application resources
- **App Service Plan**: Compute resources (F1 Free tier for cost optimization)
- **Linux Web App**: Containerized Flask application hosting
- **Managed Identity**: Secure authentication to Azure Container Registry
- **Data Sources**: References to existing shared infrastructure

#### 📤 `output.tf` - Output Values

```hcl
output "acr_login_server" {
  value = data.azurerm_container_registry.acr.login_server
}

output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "image_url" {
  value = "${data.azurerm_container_registry.acr.login_server}/flask-app:latest"
}

output "umi_identity" {
  value = data.azurerm_user_assigned_identity.identity.id
}
```

**Purpose**: Exports important values for use by other systems

- **ACR Login Server**: Container registry endpoint
- **Web App URL**: Application access point
- **Image URL**: Full container image path
- **Managed Identity ID**: For role assignments and permissions

### Infrastructure Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                    Azure Subscription                       │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │   core-rg       │    │   modus-create-rg               │ │
│  │                 │    │                                 │ │
│  │ ┌─────────────┐ │    │ ┌─────────────────────────────┐ │ │
│  │ │     ACR     │ │    │ │      App Service Plan       │ │ │
│  │ │ az4africa   │ │────┤ │      (F1 Free)              │ │ │
│  │ └─────────────┘ │    │ └─────────────────────────────┘ │ │
│  │                 │    │                                 │ │
│  │ ┌─────────────┐ │    │ ┌─────────────────────────────┐ │ │
│  │ │    UMI      │ │────┤ │      Linux Web App          │ │ │
│  │ │core-res-umi │ │    │ │   (Flask Container)         │ │ │
│  │ └─────────────┘ │    │ └─────────────────────────────┘ │ │
│  │                 │    │                                 │ │
│  │ ┌─────────────┐ │    │                                 │ │
│  │ │ TF State    │ │    │                                 │ │
│  │ │ Storage     │ │    │                                 │ │
│  │ └─────────────┘ │    │                                 │ │
│  └─────────────────┘    └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Security & Best Practices

#### 🔐 Identity and Access Management

- **User-Assigned Managed Identity**: Eliminates need for stored credentials
- **ACR Integration**: Secure container image pulling without passwords
- **Service Principal**: Least-privilege access for Terraform operations

#### 🏗️ Resource Organization

- **Resource Groups**: Logical separation of shared vs application-specific resources
- **Naming Conventions**: Consistent resource naming with prefixes
- **Provider Aliases**: Clean separation of concerns across subscriptions

#### 💰 Cost Optimization

- **F1 Free Tier**: Cost-effective for development/testing environments
- **Shared Resources**: ACR and Managed Identity shared across multiple applications
- **Resource Lifecycle**: Infrastructure can be easily destroyed and recreated

#### 🔄 State Management

- **Remote State**: Azure Blob Storage for team collaboration
- **State Locking**: Prevents concurrent modifications
- **Versioning**: State file versioning for rollback capabilities

### Deployment Prerequisites

Before running Terraform, ensure you have:

1. **Service Principal** with appropriate permissions:

   ```bash
   az ad sp create-for-rbac \
     --name "my-github-sp" \
     --role Contributor \
     --scopes /subscriptions/<your-subscription-id> \
     --sdk-auth
   ```

2. **Existing Shared Resources**:
   - Container Registry (`az4africa`)
   - User-Assigned Managed Identity (`core-resources-umi`)
   - Storage Account for Terraform state (`tfstatestorage13543`)

3. **Required Permissions**:
   - Contributor role on target subscription
   - Access to shared resource group (`core-rg`)
   - Storage Blob Data Contributor on state storage account

## 🧪 Testing

The project includes comprehensive unit tests covering:

- ✅ GET requests to the main page
- ✅ POST requests for adding todos
- ✅ Todo deletion functionality
- ✅ Edge cases (empty todos, invalid indices)
- ✅ Test isolation and cleanup

Run tests with:

```bash
cd app
pytest test_app.py -v --tb=short
```

## 📝 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Display todo list and form |
| POST | `/` | Add a new todo item |
| GET | `/delete/<int:idx>` | Delete todo at specified index |

## 🔧 Configuration

### Application Settings

The Flask application uses the following configuration:

- Host: `0.0.0.0` (accessible from all interfaces)
- Port: `5000` (development), `8000` (Docker)
- Debug: Disabled in production
- Logging: INFO level with timestamp formatting

### Docker Configuration

- Base image: `python:3.13-slim`
- Security: Runs as non-root user (`appuser`)
- Virtual environment: Isolated Python dependencies
- Exposed port: `8000`
- WSGI server: Gunicorn

## 📊 Monitoring and Logging

The application includes structured logging with:

- Request/response logging
- Todo operations tracking
- Error and warning messages
- Environment variable status

## 🔒 Security Features

- Non-root user execution in Docker
- Environment-based configuration
- Input validation for todo items
- Secure default settings

## 🚀 Version Information

Current version: **1.0.0** (see `version.txt`)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is created as a proof of concept for Modus Create.

## 📞 Support

For questions or support, please contact the development team or create an issue in the repository.

---

Built with ❤️ for Modus Create