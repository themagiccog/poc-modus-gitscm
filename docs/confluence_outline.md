# Flask App Deployment - Confluence Documentation

## Build Process
Details GitHub Actions steps: install, test, build Docker image.

## Version Management
Auto-increment via Bash script, stored in version.txt, changelog.md.

## CI/CD
Runs on main and tags. Push to ACR, deploys via Azure Web App.

## Infrastructure
Provisioned with Terraform: RG, ACR, App Plan, Web App.

## Artifacts
Docker image with tag (vX.Y.Z), stored in ACR.

## Rollback
Re-deploy older tag in Web App or via GitHub UI.

## Security
Secrets managed in GitHub. ACR auth via Azure login.

## Local Dev
Run with venv and flask run.

## Monitoring
Enable Azure Monitor or App Insights in App Service configuration.
