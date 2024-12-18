# Changelog

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
