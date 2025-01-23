# Changelog

## [2.5.1](https://github.com/cds-snc/cds-superset/compare/v2.5.0...v2.5.1) (2025-01-23)


### Bug Fixes

* allow API requests for large dashboards ([#285](https://github.com/cds-snc/cds-superset/issues/285)) ([98fabe3](https://github.com/cds-snc/cds-superset/commit/98fabe3f520d9e9f430c7a24b123127b4daef73a))


### Miscellaneous Chores

* add Platform / Support database export ([#283](https://github.com/cds-snc/cds-superset/issues/283)) ([390ea2a](https://github.com/cds-snc/cds-superset/commit/390ea2ae29a964ced296be1ae1183c95348bfa28))

## [2.5.0](https://github.com/cds-snc/cds-superset/compare/v2.4.2...v2.5.0) (2025-01-23)


### Features

* grant Staging access to Freshdesk dataset ([#279](https://github.com/cds-snc/cds-superset/issues/279)) ([e5d0a08](https://github.com/cds-snc/cds-superset/commit/e5d0a08c677f827fb5f4733cbe9cf2ba29ea3637))
* onboard Freshdesk dataset to prod ([#281](https://github.com/cds-snc/cds-superset/issues/281)) ([3f51f24](https://github.com/cds-snc/cds-superset/commit/3f51f24d02111c7c69c9d0e4cdde575b5352314f))


### Miscellaneous Chores

* follow Terragrunt naming convention ([#282](https://github.com/cds-snc/cds-superset/issues/282)) ([000a1fa](https://github.com/cds-snc/cds-superset/commit/000a1fa1252486f16939b30cb9ab942dd98152d6))

## [2.4.2](https://github.com/cds-snc/cds-superset/compare/v2.4.1...v2.4.2) (2025-01-20)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#278](https://github.com/cds-snc/cds-superset/issues/278)) ([f274d87](https://github.com/cds-snc/cds-superset/commit/f274d877c9d6b8c0c0355bf21358819bc26eddeb))
* **deps:** update github/codeql-action action to v3.28.1 ([#276](https://github.com/cds-snc/cds-superset/issues/276)) ([c202dce](https://github.com/cds-snc/cds-superset/commit/c202dce0114943e7ce26e0e11e0848f6ed5a998e))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.2.2 ([#277](https://github.com/cds-snc/cds-superset/issues/277)) ([41532e8](https://github.com/cds-snc/cds-superset/commit/41532e8187d67c06586b3c8a4b23aa7d08d85f2d))
* Enable bilingual feature ([#274](https://github.com/cds-snc/cds-superset/issues/274)) ([2da58cd](https://github.com/cds-snc/cds-superset/commit/2da58cd56a39fc9873ac69a63459e6ebf8720eb5))

## [2.4.1](https://github.com/cds-snc/cds-superset/compare/v2.4.0...v2.4.1) (2025-01-13)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#273](https://github.com/cds-snc/cds-superset/issues/273)) ([3fb787b](https://github.com/cds-snc/cds-superset/commit/3fb787bdf3127f86f38cc56046a92965311da6d1))
* suppress AccessDenied DB errors ([#270](https://github.com/cds-snc/cds-superset/issues/270)) ([e5131b6](https://github.com/cds-snc/cds-superset/commit/e5131b6269ec08829354bd27d2fca277e0d7a116))
* suppress user generated error ([#272](https://github.com/cds-snc/cds-superset/issues/272)) ([e2ef8ca](https://github.com/cds-snc/cds-superset/commit/e2ef8cad2a38ce9b1ddd1308e69ea936f96ea63b))

## [2.4.0](https://github.com/cds-snc/cds-superset/compare/v2.3.0...v2.4.0) (2025-01-09)


### Features

* Superset IAM role that can read all databases ([#269](https://github.com/cds-snc/cds-superset/issues/269)) ([0bdba47](https://github.com/cds-snc/cds-superset/commit/0bdba47a0553f033775a051dba6518d490b33c66))


### Bug Fixes

* remove suppress of generic DB errors ([#268](https://github.com/cds-snc/cds-superset/issues/268)) ([0646e07](https://github.com/cds-snc/cds-superset/commit/0646e070e19b03e84c094b6fd3bd22344ff23290))


### Miscellaneous Chores

* synced file(s) with cds-snc/site-reliability-engineering ([#265](https://github.com/cds-snc/cds-superset/issues/265)) ([1b922fb](https://github.com/cds-snc/cds-superset/commit/1b922fb115612f5bb0344b2519dc1ac3c3d3ddbf))
* update Operations / AWS DB export ([#267](https://github.com/cds-snc/cds-superset/issues/267)) ([5971342](https://github.com/cds-snc/cds-superset/commit/5971342fc34ab0f40e3fd3662f3fe61f9ef9cc0d))

## [2.3.0](https://github.com/cds-snc/cds-superset/compare/v2.2.2...v2.3.0) (2025-01-08)


### Features

* create IAM role per Glue database ([#262](https://github.com/cds-snc/cds-superset/issues/262)) ([5e6f610](https://github.com/cds-snc/cds-superset/commit/5e6f61012d98089d790f2e7d5849180d4eb5b549))


### Bug Fixes

* non-alpha characters in IAM policy sid ([#264](https://github.com/cds-snc/cds-superset/issues/264)) ([d78a10e](https://github.com/cds-snc/cds-superset/commit/d78a10e152b0a7b48516c89d91cbf038cc2e2d91))

## [2.2.2](https://github.com/cds-snc/cds-superset/compare/v2.2.1...v2.2.2) (2025-01-07)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#258](https://github.com/cds-snc/cds-superset/issues/258)) ([cf9d1d9](https://github.com/cds-snc/cds-superset/commit/cf9d1d93002fec5db34baf681fdef264b2c5e01b))
* **deps:** update all minor dependencies ([#261](https://github.com/cds-snc/cds-superset/issues/261)) ([50fb0c6](https://github.com/cds-snc/cds-superset/commit/50fb0c6866b1bbd51508293ae6a107b6b70af505))
* **deps:** update all non-major github action dependencies ([#260](https://github.com/cds-snc/cds-superset/issues/260)) ([f6c7952](https://github.com/cds-snc/cds-superset/commit/f6c7952904bf60ddcccb768cbe8c28b643385271))
* **deps:** update dependency redis to v5 ([#248](https://github.com/cds-snc/cds-superset/issues/248)) ([beb977c](https://github.com/cds-snc/cds-superset/commit/beb977cdd545829518b9e985ab16dd43c3baef20))
* **deps:** update github/codeql-action action to v3.27.9 ([#256](https://github.com/cds-snc/cds-superset/issues/256)) ([45e3bcd](https://github.com/cds-snc/cds-superset/commit/45e3bcd9d3fb16fb37b81a4f1ff1ff0b39478f90))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.2.1 ([#257](https://github.com/cds-snc/cds-superset/issues/257)) ([1c5f80b](https://github.com/cds-snc/cds-superset/commit/1c5f80bc8a2a6957068606326282b71d6e443ed0))

## [2.2.1](https://github.com/cds-snc/cds-superset/compare/v2.2.0...v2.2.1) (2024-12-20)


### Bug Fixes

* stop WAF from blocking dashboard saves ([#253](https://github.com/cds-snc/cds-superset/issues/253)) ([8f3ea74](https://github.com/cds-snc/cds-superset/commit/8f3ea743c11ade8bfc2e8ebed70b4246ff39ec8f))

## [2.2.0](https://github.com/cds-snc/cds-superset/compare/v2.1.0...v2.2.0) (2024-12-20)


### Features

* enable Jinja templating in queries ([#252](https://github.com/cds-snc/cds-superset/issues/252)) ([45c9fe3](https://github.com/cds-snc/cds-superset/commit/45c9fe3c14eefd29b41beef602697e28431cd9ab))

## [2.1.0](https://github.com/cds-snc/cds-superset/compare/v2.0.2...v2.1.0) (2024-12-19)


### Features

* staging access to GC Forms form test data ([#249](https://github.com/cds-snc/cds-superset/issues/249)) ([4991896](https://github.com/cds-snc/cds-superset/commit/4991896ddd5479ba036050466e2e4e12af9f535d))


### Miscellaneous Chores

* suppress user query CloudWatch alarms ([#251](https://github.com/cds-snc/cds-superset/issues/251)) ([2a132e4](https://github.com/cds-snc/cds-superset/commit/2a132e45a4dbd38b2ea4579ac0c923262ee9b6f0))

## [2.0.2](https://github.com/cds-snc/cds-superset/compare/v2.0.1...v2.0.2) (2024-12-18)


### Bug Fixes

* remove SBOM generate for prod release ([#245](https://github.com/cds-snc/cds-superset/issues/245)) ([f060b1b](https://github.com/cds-snc/cds-superset/commit/f060b1b2989aae29f389910c11ada354271de8be))


### Miscellaneous Chores

* suppress DML not allowed CloudWatch errors ([#244](https://github.com/cds-snc/cds-superset/issues/244)) ([c84ccda](https://github.com/cds-snc/cds-superset/commit/c84ccda705d6e279404fce3e0b2c83702a906654))
* update to latest Terraform and use lockfile ([#247](https://github.com/cds-snc/cds-superset/issues/247)) ([387bf47](https://github.com/cds-snc/cds-superset/commit/387bf4720ca19de1cd0e3af2d427ce187910d54a))

## [2.0.1](https://github.com/cds-snc/cds-superset/compare/v2.0.0...v2.0.1) (2024-12-16)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#242](https://github.com/cds-snc/cds-superset/issues/242)) ([30ee982](https://github.com/cds-snc/cds-superset/commit/30ee982e8df08d6250daf9882644cf8bcb5d80d1))
* **deps:** update all non-major github action dependencies ([#241](https://github.com/cds-snc/cds-superset/issues/241)) ([bc349fc](https://github.com/cds-snc/cds-superset/commit/bc349fcb05ab537d454a3b156736908e0408039c))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to f485b76 ([#240](https://github.com/cds-snc/cds-superset/issues/240)) ([517bf38](https://github.com/cds-snc/cds-superset/commit/517bf38628758fe15c010cdaae9b859cc142eebf))

## [2.0.0](https://github.com/cds-snc/cds-superset/compare/v1.1.1...v2.0.0) (2024-12-11)


### ⚠ BREAKING CHANGES

* switch to Aurora Serverless database ([#238](https://github.com/cds-snc/cds-superset/issues/238))

### Features

* switch to Aurora Serverless database ([#238](https://github.com/cds-snc/cds-superset/issues/238)) ([3c18c59](https://github.com/cds-snc/cds-superset/commit/3c18c5995b5e5d9ab8d3a8c1a0b9536563ceec44))

## [1.1.1](https://github.com/cds-snc/cds-superset/compare/v1.1.0...v1.1.1) (2024-12-11)


### Bug Fixes

* release please to trigger release for chore commits ([#236](https://github.com/cds-snc/cds-superset/issues/236)) ([0e0b16e](https://github.com/cds-snc/cds-superset/commit/0e0b16e5fbe0710f65ef97467e76078349fa9cec))


### Miscellaneous Chores

* **deps:** update dependency pyathena to v3 ([#235](https://github.com/cds-snc/cds-superset/issues/235)) ([35f546f](https://github.com/cds-snc/cds-superset/commit/35f546ff2fbf89c2e7c08e562ddfa54c556348f2))

## [1.1.0](https://github.com/cds-snc/cds-superset/compare/v1.0.1...v1.1.0) (2024-12-11)


### Features

* add an OIDC role that can perform prod releases ([#233](https://github.com/cds-snc/cds-superset/issues/233)) ([6f9e74c](https://github.com/cds-snc/cds-superset/commit/6f9e74c6bd2f1e2e2d7c9f2b2f12084b5ff0cccd))
* split Staging and Prod deploy workflows ([#232](https://github.com/cds-snc/cds-superset/issues/232)) ([722486a](https://github.com/cds-snc/cds-superset/commit/722486a407782deac6982fb108bb9668a76046d1))

## [1.0.1](https://github.com/cds-snc/cds-superset/compare/v1.0.0...v1.0.1) (2024-12-10)


### Bug Fixes

* switch prod URL to superset.cds-snc.ca ([#228](https://github.com/cds-snc/cds-superset/issues/228)) ([1d3b1cd](https://github.com/cds-snc/cds-superset/commit/1d3b1cd461a1d94eae32fb2a7300ef2e9e18cdc8))
