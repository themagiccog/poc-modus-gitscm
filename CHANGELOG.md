## [1.3.1](https://github.com/themagiccog/poc-modus-gitscm/compare/v1.3.0...v1.3.1) (2025-07-02)

### Bug Fixes

* add managed identity client ID to site configuration for Azure Linux web app ([099598e](https://github.com/themagiccog/poc-modus-gitscm/commit/099598ed43041f44402165362d48b8fdd5612660))
* add output for user assigned identity in Terraform configuration ([0504728](https://github.com/themagiccog/poc-modus-gitscm/commit/0504728e615226372f261310f3757d392a879d48))
* update docker image name and registry URL for Azure Linux web app ([0abcff1](https://github.com/themagiccog/poc-modus-gitscm/commit/0abcff1defa9bf342a77d8bb4cc0867737e7b511))
* update Docker image version to 1.3.0 for Azure Linux web app ([2f5335a](https://github.com/themagiccog/poc-modus-gitscm/commit/2f5335a24e037aade257e01c13e359488bb6b2d7))

## [1.3.0](https://github.com/themagiccog/poc-modus-gitscm/compare/v1.2.4...v1.3.0) (2025-07-02)

### Features

* add output for image URL in Terraform configuration ([7f60c6a](https://github.com/themagiccog/poc-modus-gitscm/commit/7f60c6ac299a6f375d1d4f341d8ad70e5c003930))
* add user assigned identity to Azure Linux web app configuration ([5fa8f35](https://github.com/themagiccog/poc-modus-gitscm/commit/5fa8f359226ab243a485c77dddcea00cb7e40c08))

### Bug Fixes

* enable managed identity for container registry in Azure Linux web app configuration ([e36f8a0](https://github.com/themagiccog/poc-modus-gitscm/commit/e36f8a076c2c0fefd227105aac38d4fea6fec58e))
* update Docker image version to use 'latest' tag for Azure Linux web app ([42dc66a](https://github.com/themagiccog/poc-modus-gitscm/commit/42dc66a42ecd7f0a5fd3d0fda74c4e5993981cfc))

## [1.2.4](https://github.com/themagiccog/poc-modus-gitscm/compare/v1.2.3...v1.2.4) (2025-07-02)

### Bug Fixes

* update Azure credentials reference in workflow ([33dd031](https://github.com/themagiccog/poc-modus-gitscm/commit/33dd03189d9a2baba91fb1a29ce228d0b023ecc3))

## [1.2.3](https://github.com/themagiccog/poc-modus-gitscm/compare/v1.2.2...v1.2.3) (2025-07-02)

### Bug Fixes

* comment out lifecycle block in azurerm_linux_web_app resource ([d6cccc7](https://github.com/themagiccog/poc-modus-gitscm/commit/d6cccc7b711eeba9e2d9b7d828213c2a3e8b5d8f))
* comment out linux_fx_version in web app configuration ([42d8642](https://github.com/themagiccog/poc-modus-gitscm/commit/42d86426daf0267add78e42341f2c2bd0e1084c0))
* correct reference to container registry data source in output configuration ([d3d3448](https://github.com/themagiccog/poc-modus-gitscm/commit/d3d3448fbfd75d7be8585a51a69c143d1687693b))
* remove provider reference from azurerm_container_registry data source ([9161354](https://github.com/themagiccog/poc-modus-gitscm/commit/9161354605a8bba8a81504b4a0d78c6741815778))
* update container registry name and location in Terraform configuration ([45643ee](https://github.com/themagiccog/poc-modus-gitscm/commit/45643ee614e9313c1c255b038e05d2f7ce134764))
* update container registry name to include full URL in data source configuration ([c8e89ae](https://github.com/themagiccog/poc-modus-gitscm/commit/c8e89aed109ccb8bbdcfdc822d9b4305b008edd9))
* update container registry reference in azurerm_linux_web_app configuration ([e3e110e](https://github.com/themagiccog/poc-modus-gitscm/commit/e3e110e05bb476226423b57ad2650e0e11ec4124))
* update dependency reference for azurerm_linux_web_app resource ([52651e0](https://github.com/themagiccog/poc-modus-gitscm/commit/52651e092d8b9db3b981403d3c745992bb43ee10))
* update docker image version in azurerm_linux_web_app configuration ([7d953b1](https://github.com/themagiccog/poc-modus-gitscm/commit/7d953b195d7e5299afb2c30182d6872594b5f18e))
* update provider reference for azurerm_container_registry data source ([c669bac](https://github.com/themagiccog/poc-modus-gitscm/commit/c669bac716a762fdf3ec3984121807ee83457bd0))
