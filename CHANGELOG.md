# Changelog

## [3.5.4](https://github.com/cds-snc/cds-superset/compare/v3.5.3...v3.5.4) (2025-09-23)


### Bug Fixes

* add workflow security fixes ([#555](https://github.com/cds-snc/cds-superset/issues/555)) ([8cc6899](https://github.com/cds-snc/cds-superset/commit/8cc68995b62a25c824ebc28c548ad44da23db8cd))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#558](https://github.com/cds-snc/cds-superset/issues/558)) ([5df86b9](https://github.com/cds-snc/cds-superset/commit/5df86b967d4991dda25ef2efee2bb47323f665c8))
* **deps:** update all non-major github action dependencies ([#556](https://github.com/cds-snc/cds-superset/issues/556)) ([a99c672](https://github.com/cds-snc/cds-superset/commit/a99c672e6009e4526700dec5218633148b4a34e9))
* **deps:** update dependency authlib to v1.6.4 [security] ([#561](https://github.com/cds-snc/cds-superset/issues/561)) ([0d701b2](https://github.com/cds-snc/cds-superset/commit/0d701b2a0001dd143a9f759a12daa2a795ce9099))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.7.1 ([#557](https://github.com/cds-snc/cds-superset/issues/557)) ([fce09d1](https://github.com/cds-snc/cds-superset/commit/fce09d13bf5a244e1876175ddf7b6ac24bb0c339))

## [3.5.3](https://github.com/cds-snc/cds-superset/compare/v3.5.2...v3.5.3) (2025-09-15)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#553](https://github.com/cds-snc/cds-superset/issues/553)) ([f2d13ea](https://github.com/cds-snc/cds-superset/commit/f2d13ea8f5f5486eba77b99a0b5d5feacc001c28))
* **deps:** update all non-major github action dependencies ([#551](https://github.com/cds-snc/cds-superset/issues/551)) ([ae98d8b](https://github.com/cds-snc/cds-superset/commit/ae98d8bc388b6d9667874a7ae870210b40021482))
* **deps:** update apache/superset:5.0.0 docker digest to 09735ad ([#550](https://github.com/cds-snc/cds-superset/issues/550)) ([ed4140f](https://github.com/cds-snc/cds-superset/commit/ed4140f71ee3b159667dee06c96502ef6e9c8127))
* **deps:** update dependency pyathena to v3.18.0 ([#552](https://github.com/cds-snc/cds-superset/issues/552)) ([84a9569](https://github.com/cds-snc/cds-superset/commit/84a9569a8b9bc42b00a807f741e8220efdf53c7e))

## [3.5.2](https://github.com/cds-snc/cds-superset/compare/v3.5.1...v3.5.2) (2025-09-11)


### Bug Fixes

* upgrade VPC to add SSH/RDP NACL block ([#548](https://github.com/cds-snc/cds-superset/issues/548)) ([609de00](https://github.com/cds-snc/cds-superset/commit/609de0004ec9ff4f9f111d4da6c17ed71c1a3016))

## [3.5.1](https://github.com/cds-snc/cds-superset/compare/v3.5.0...v3.5.1) (2025-09-10)


### Bug Fixes

* increase CloudWatch log retention to 365 days ([#547](https://github.com/cds-snc/cds-superset/issues/547)) ([a2bcd65](https://github.com/cds-snc/cds-superset/commit/a2bcd65ff05877813a682e61aa2c28ff2bf75401))
* set permanent session lifetime ([#545](https://github.com/cds-snc/cds-superset/issues/545)) ([01b6e43](https://github.com/cds-snc/cds-superset/commit/01b6e4356cb7ebe17ff162478e03284eaf0e74d1))

## [3.5.0](https://github.com/cds-snc/cds-superset/compare/v3.4.0...v3.5.0) (2025-09-08)


### Features

* add Terraform static analysis and drift check workflows ([#537](https://github.com/cds-snc/cds-superset/issues/537)) ([4ddd315](https://github.com/cds-snc/cds-superset/commit/4ddd315819079c3de18d200180681e9f9a718e72))


### Bug Fixes

* apply cache changes immediately ([#539](https://github.com/cds-snc/cds-superset/issues/539)) ([4fa75e6](https://github.com/cds-snc/cds-superset/commit/4fa75e69854f253049e6c7f2454b2aed7ff08dbf))
* set encryption mode of cache ([#540](https://github.com/cds-snc/cds-superset/issues/540)) ([3a673af](https://github.com/cds-snc/cds-superset/commit/3a673af80956511b60c855f0a414a7b176890840))


### Miscellaneous Chores

* **deps:** update actions/dependency-review-action action to v4.7.3 ([#542](https://github.com/cds-snc/cds-superset/issues/542)) ([cc9f704](https://github.com/cds-snc/cds-superset/commit/cc9f704c28e3f053f16371064bece3ef118f6820))
* **deps:** update dependency authlib to v1.6.3 ([#543](https://github.com/cds-snc/cds-superset/issues/543)) ([ad1345c](https://github.com/cds-snc/cds-superset/commit/ad1345cf2ddb84baf611067a9519a86431da1870))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to b387f79 ([#541](https://github.com/cds-snc/cds-superset/issues/541)) ([b33f8c7](https://github.com/cds-snc/cds-superset/commit/b33f8c74b6de634567435ffcd1a62fae49ca4e88))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.7.0 ([#544](https://github.com/cds-snc/cds-superset/issues/544)) ([382cfa6](https://github.com/cds-snc/cds-superset/commit/382cfa6e807db0a8c769d4e984982aaf5201cc11))

## [3.4.0](https://github.com/cds-snc/cds-superset/compare/v3.3.1...v3.4.0) (2025-09-04)


### Features

* add system use notification ([#536](https://github.com/cds-snc/cds-superset/issues/536)) ([07bd3ae](https://github.com/cds-snc/cds-superset/commit/07bd3ae36efbe8ef1a8ad9b012dc9a7ba03435f8))
* set the Superset log format and level ([#534](https://github.com/cds-snc/cds-superset/issues/534)) ([f2d7af0](https://github.com/cds-snc/cds-superset/commit/f2d7af04ce34d1701a5ab7114e36107e4e2ae605))

## [3.3.1](https://github.com/cds-snc/cds-superset/compare/v3.3.0...v3.3.1) (2025-09-02)


### Miscellaneous Chores

* suppress invalid SQL query error ([#531](https://github.com/cds-snc/cds-superset/issues/531)) ([509cbbe](https://github.com/cds-snc/cds-superset/commit/509cbbe1306f3584798f384fca07b769afb75f3c))

## [3.3.0](https://github.com/cds-snc/cds-superset/compare/v3.2.0...v3.3.0) (2025-09-02)


### Features

* add security headers ([#527](https://github.com/cds-snc/cds-superset/issues/527)) ([74cef48](https://github.com/cds-snc/cds-superset/commit/74cef482183c7839b456e4fb48aa98e4d2045f03))
* improve session authenticity protection ([#525](https://github.com/cds-snc/cds-superset/issues/525)) ([a2d601f](https://github.com/cds-snc/cds-superset/commit/a2d601f4e782a5ff9b2551eb77f47fdded544a3c))


### Miscellaneous Chores

* **deps:** update actions/checkout action to v5 ([#530](https://github.com/cds-snc/cds-superset/issues/530)) ([ebbee33](https://github.com/cds-snc/cds-superset/commit/ebbee33f4704d4135eb515e4601e59dec8b8a3f2))
* **deps:** update all non-major github action dependencies ([#528](https://github.com/cds-snc/cds-superset/issues/528)) ([6efeb5d](https://github.com/cds-snc/cds-superset/commit/6efeb5dce1e03878688ea46b9af6de713c321e45))
* **deps:** update dependency authlib to v1.6.2 ([#529](https://github.com/cds-snc/cds-superset/issues/529)) ([0c6adea](https://github.com/cds-snc/cds-superset/commit/0c6adea8d4fabd8fba3b546161e97dfd678ea171))

## [3.2.0](https://github.com/cds-snc/cds-superset/compare/v3.1.5...v3.2.0) (2025-08-28)


### Features

* add GCDS tables ([#523](https://github.com/cds-snc/cds-superset/issues/523)) ([a7a2b60](https://github.com/cds-snc/cds-superset/commit/a7a2b60b04f0d5e3049c2cc77667a28f39573b8a))

## [3.1.5](https://github.com/cds-snc/cds-superset/compare/v3.1.4...v3.1.5) (2025-08-27)


### Bug Fixes

* suppress thumbnail cache alarms ([#521](https://github.com/cds-snc/cds-superset/issues/521)) ([7f6bd32](https://github.com/cds-snc/cds-superset/commit/7f6bd32dd4ce433b49c22d3244d40135bda82571))

## [3.1.4](https://github.com/cds-snc/cds-superset/compare/v3.1.3...v3.1.4) (2025-08-25)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#515](https://github.com/cds-snc/cds-superset/issues/515)) ([4c14666](https://github.com/cds-snc/cds-superset/commit/4c14666ab6588dccfba4088d92499ba00e74d78e))
* **deps:** lock file maintenance ([#520](https://github.com/cds-snc/cds-superset/issues/520)) ([7fd6247](https://github.com/cds-snc/cds-superset/commit/7fd6247164febab84e7cca3f5202dcefbf6f435c))
* **deps:** update all non-major github action dependencies ([#513](https://github.com/cds-snc/cds-superset/issues/513)) ([055e560](https://github.com/cds-snc/cds-superset/commit/055e5601eacdd512835d3acc6d3b425270aa422a))
* **deps:** update all non-major github action dependencies ([#518](https://github.com/cds-snc/cds-superset/issues/518)) ([75797c2](https://github.com/cds-snc/cds-superset/commit/75797c272096ef9e622eb82af0507477dd66b4df))
* **deps:** update apache/superset:5.0.0 docker digest to ac98e93 ([#517](https://github.com/cds-snc/cds-superset/issues/517)) ([9cec3fb](https://github.com/cds-snc/cds-superset/commit/9cec3fbb80c64d8b11ae1625899ba18e8a9bcd6e))
* **deps:** update dependency pyathena to v3.17.0 ([#514](https://github.com/cds-snc/cds-superset/issues/514)) ([b5275e0](https://github.com/cds-snc/cds-superset/commit/b5275e0817e411ed0cdf815ebff267a12dcc19e5))
* **deps:** update dependency pyathena to v3.17.1 ([#519](https://github.com/cds-snc/cds-superset/issues/519)) ([3fe0e6a](https://github.com/cds-snc/cds-superset/commit/3fe0e6a74db5dc9d196b7b92a0868caacba6c68f))

## [3.1.3](https://github.com/cds-snc/cds-superset/compare/v3.1.2...v3.1.3) (2025-08-11)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#511](https://github.com/cds-snc/cds-superset/issues/511)) ([09489d1](https://github.com/cds-snc/cds-superset/commit/09489d10ac3e84080a1dc6ff4b64c44237a934d1))
* **deps:** update dependency pyathena to v3.16.0 ([#510](https://github.com/cds-snc/cds-superset/issues/510)) ([584a7ff](https://github.com/cds-snc/cds-superset/commit/584a7ffc907f2ec275514b0334b48f8d7d8292b9))
* **deps:** update github/codeql-action action to v3.29.7 ([#509](https://github.com/cds-snc/cds-superset/issues/509)) ([92ad7f6](https://github.com/cds-snc/cds-superset/commit/92ad7f6d140d2b0f986221894adc8b0518db2dce))

## [3.1.2](https://github.com/cds-snc/cds-superset/compare/v3.1.1...v3.1.2) (2025-08-08)


### Bug Fixes

* increase app and celery memory ([#507](https://github.com/cds-snc/cds-superset/issues/507)) ([9d93fe6](https://github.com/cds-snc/cds-superset/commit/9d93fe637765d01f841933adf4990d46d4457fd5))

## [3.1.1](https://github.com/cds-snc/cds-superset/compare/v3.1.0...v3.1.1) (2025-08-08)


### Bug Fixes

* add SES complain/bounce alarms ([#505](https://github.com/cds-snc/cds-superset/issues/505)) ([1a7c749](https://github.com/cds-snc/cds-superset/commit/1a7c7498df0e4363de6f02a9c21610b7dc855033))

## [3.1.0](https://github.com/cds-snc/cds-superset/compare/v3.0.0...v3.1.0) (2025-08-07)


### Features

* add SMTP config for email reports ([#502](https://github.com/cds-snc/cds-superset/issues/502)) ([239da41](https://github.com/cds-snc/cds-superset/commit/239da4125c75d5e85d4f29c16ded13f5d2082187))


### Bug Fixes

* SMTP config and allow port 465 ([#504](https://github.com/cds-snc/cds-superset/issues/504)) ([365ef92](https://github.com/cds-snc/cds-superset/commit/365ef921738b31d568610eda22dc4506758a1c78))

## [3.0.0](https://github.com/cds-snc/cds-superset/compare/v2.22.5...v3.0.0) (2025-08-05)


### ⚠ BREAKING CHANGES

* upgrade to Superset v5 ([#487](https://github.com/cds-snc/cds-superset/issues/487))

### Features

* add SES for SMTP server ([#497](https://github.com/cds-snc/cds-superset/issues/497)) ([40c8eb4](https://github.com/cds-snc/cds-superset/commit/40c8eb4ba316646f09c0f907b4cad24155b8e929))
* enable alerts and thumbnails ([#493](https://github.com/cds-snc/cds-superset/issues/493)) ([726680f](https://github.com/cds-snc/cds-superset/commit/726680f61ccee547005a2f7b4efd22aa5e514d03))
* upgrade to Superset v5 ([#487](https://github.com/cds-snc/cds-superset/issues/487)) ([6f532ae](https://github.com/cds-snc/cds-superset/commit/6f532ae989791361a615f5408d9f15392344b2d1))


### Bug Fixes

* add missing translations files ([#492](https://github.com/cds-snc/cds-superset/issues/492)) ([3753585](https://github.com/cds-snc/cds-superset/commit/3753585e4583852c1c412c4ae2223a2eec31947a))
* database upgrade task CPU architecture ([#489](https://github.com/cds-snc/cds-superset/issues/489)) ([94e143e](https://github.com/cds-snc/cds-superset/commit/94e143e0e703d00190486bbdb75370931487deaa))
* import database integration tests only for app config ([#490](https://github.com/cds-snc/cds-superset/issues/490)) ([84c8945](https://github.com/cds-snc/cds-superset/commit/84c894503a807bf8a3d79868277c9510756fc78c))
* move common variables into main vars file ([#498](https://github.com/cds-snc/cds-superset/issues/498)) ([d26dd2c](https://github.com/cds-snc/cds-superset/commit/d26dd2c2442ec1ba5a7273757f05b085ceeb1bd0))
* suppress thumbnail generate time out ([#501](https://github.com/cds-snc/cds-superset/issues/501)) ([c016920](https://github.com/cds-snc/cds-superset/commit/c016920a8cd67f03af9cee196ef3dd0d0fe6364c))
* thumbnail generation and increase screenshot resolution ([#494](https://github.com/cds-snc/cds-superset/issues/494)) ([bfb64f7](https://github.com/cds-snc/cds-superset/commit/bfb64f749e4a139e3e08aa46e0f130618d362216))
* wait for database upgrade to complete ([#491](https://github.com/cds-snc/cds-superset/issues/491)) ([5eedf3e](https://github.com/cds-snc/cds-superset/commit/5eedf3ef8523a9a9c8f1e9f53b23017e802c6a70))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#500](https://github.com/cds-snc/cds-superset/issues/500)) ([45b9d43](https://github.com/cds-snc/cds-superset/commit/45b9d43152e2c704aec1b689241328c035fe698c))
* **deps:** update all non-major github action dependencies ([#495](https://github.com/cds-snc/cds-superset/issues/495)) ([36edbf2](https://github.com/cds-snc/cds-superset/commit/36edbf244b4220f94b28230fafcaf1964ea5db83))
* **deps:** update dependency redis to v5.3.1 ([#496](https://github.com/cds-snc/cds-superset/issues/496)) ([7a22d3f](https://github.com/cds-snc/cds-superset/commit/7a22d3f31efa5987ef50b9f6e8e0410263d8fad9))
* suppress thumbnail retrieval error ([#499](https://github.com/cds-snc/cds-superset/issues/499)) ([8505064](https://github.com/cds-snc/cds-superset/commit/850506429f8d6a29204f4da1a3c30061392cfdf6))

## [2.22.5](https://github.com/cds-snc/cds-superset/compare/v2.22.4...v2.22.5) (2025-07-30)


### Bug Fixes

* remove the dashboard cache warmup scheduled task ([#484](https://github.com/cds-snc/cds-superset/issues/484)) ([e705aaf](https://github.com/cds-snc/cds-superset/commit/e705aaff3833b297feb622e18d666a0d08f08775))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#486](https://github.com/cds-snc/cds-superset/issues/486)) ([a9a33da](https://github.com/cds-snc/cds-superset/commit/a9a33dab79b7dedd8aabc5115b1414aa590cedbf))

## [2.22.4](https://github.com/cds-snc/cds-superset/compare/v2.22.3...v2.22.4) (2025-07-28)


### Miscellaneous Chores

* **deps:** update dependency authlib to v1.6.1 ([#482](https://github.com/cds-snc/cds-superset/issues/482)) ([e7f31fd](https://github.com/cds-snc/cds-superset/commit/e7f31fdf99821bb4734bee35d19aea98adbe2e82))
* **deps:** update dependency pyathena to v3.15.0 ([#481](https://github.com/cds-snc/cds-superset/issues/481)) ([a286b3d](https://github.com/cds-snc/cds-superset/commit/a286b3dd3d5ce27acc1921ac14f3b15a441db6a2))

## [2.22.3](https://github.com/cds-snc/cds-superset/compare/v2.22.2...v2.22.3) (2025-07-21)


### Miscellaneous Chores

* **deps:** update apache/superset docker tag to v4.1.3 ([#479](https://github.com/cds-snc/cds-superset/issues/479)) ([12b48d6](https://github.com/cds-snc/cds-superset/commit/12b48d61956e10f0e4c55627e8ee14345016c6b2))
* **deps:** update github/codeql-action action to v3.29.2 ([#478](https://github.com/cds-snc/cds-superset/issues/478)) ([a6e79ea](https://github.com/cds-snc/cds-superset/commit/a6e79ea7142496c948dd2b8f944c7653ea6c26ab))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to 5d19b08 ([#477](https://github.com/cds-snc/cds-superset/issues/477)) ([2be166e](https://github.com/cds-snc/cds-superset/commit/2be166ee86c31c37770bc17134082ff2c5ab070b))

## [2.22.2](https://github.com/cds-snc/cds-superset/compare/v2.22.1...v2.22.2) (2025-07-10)


### Bug Fixes

* upgrade to latest version of gunicorn ([#475](https://github.com/cds-snc/cds-superset/issues/475)) ([7f90e4a](https://github.com/cds-snc/cds-superset/commit/7f90e4a4bc8fe94aa03ab35bd2a18db8efc7c7f8))

## [2.22.1](https://github.com/cds-snc/cds-superset/compare/v2.22.0...v2.22.1) (2025-07-10)


### Bug Fixes

* add `ecpg` to validate SQL syntax ([#474](https://github.com/cds-snc/cds-superset/issues/474)) ([ee56237](https://github.com/cds-snc/cds-superset/commit/ee562378ee014c8e05759a8f34cfc2bec8b47641))
* remove dev dependencies from base image ([#472](https://github.com/cds-snc/cds-superset/issues/472)) ([07107e2](https://github.com/cds-snc/cds-superset/commit/07107e2fccff55f103175cd68bb20c7889c54719))

## [2.22.0](https://github.com/cds-snc/cds-superset/compare/v2.21.2...v2.22.0) (2025-07-09)


### Features

* enable Anti DDoS WAF ACL rule ([#469](https://github.com/cds-snc/cds-superset/issues/469)) ([b59c77b](https://github.com/cds-snc/cds-superset/commit/b59c77be0d8e094ee9c055791cb067e930ba3a14))


### Bug Fixes

* WAF anti-DDoS manage rule config ([#471](https://github.com/cds-snc/cds-superset/issues/471)) ([ee9fac4](https://github.com/cds-snc/cds-superset/commit/ee9fac429a3c98ea63d752d85a0b1ec2bec8fcce))

## [2.21.2](https://github.com/cds-snc/cds-superset/compare/v2.21.1...v2.21.2) (2025-07-07)


### Miscellaneous Chores

* **deps:** update all minor dependencies ([#466](https://github.com/cds-snc/cds-superset/issues/466)) ([830aca4](https://github.com/cds-snc/cds-superset/commit/830aca41d009f329d9aee7c4f7912bf65e07176e))
* **deps:** update all non-major github action dependencies ([#464](https://github.com/cds-snc/cds-superset/issues/464)) ([708eb83](https://github.com/cds-snc/cds-superset/commit/708eb832e7bd9a7cef306bb39dbf5561e5eeea62))
* **deps:** update all non-major github action dependencies ([#468](https://github.com/cds-snc/cds-superset/issues/468)) ([c9548fb](https://github.com/cds-snc/cds-superset/commit/c9548fb42738363761381fc1810ada6631eefe62))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.6.2 ([#465](https://github.com/cds-snc/cds-superset/issues/465)) ([52d799a](https://github.com/cds-snc/cds-superset/commit/52d799a63ce8d62eb90b9d76f36ab01990e57359))

## [2.21.1](https://github.com/cds-snc/cds-superset/compare/v2.21.0...v2.21.1) (2025-06-25)


### Bug Fixes

* switch to Sentinel forwarder to capture role grants ([#462](https://github.com/cds-snc/cds-superset/issues/462)) ([3efd88b](https://github.com/cds-snc/cds-superset/commit/3efd88bec77aae3a87b341835d705f0810197fa6))

## [2.21.0](https://github.com/cds-snc/cds-superset/compare/v2.20.0...v2.21.0) (2025-06-23)


### Features

* add alarm for privileged role grants ([#460](https://github.com/cds-snc/cds-superset/issues/460)) ([a79498e](https://github.com/cds-snc/cds-superset/commit/a79498ec770a55d353775b85b40e25926413a6c2))


### Bug Fixes

* pin GitHub actions to commit SHAs ([#453](https://github.com/cds-snc/cds-superset/issues/453)) ([f936a34](https://github.com/cds-snc/cds-superset/commit/f936a34d9eba01ad1e9aace2efca74b200cbfb10))
* privileged role grant regular expression ([#461](https://github.com/cds-snc/cds-superset/issues/461)) ([d0394d0](https://github.com/cds-snc/cds-superset/commit/d0394d0a940848c97d1a405b855c373e61c5d079))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#458](https://github.com/cds-snc/cds-superset/issues/458)) ([c8060b2](https://github.com/cds-snc/cds-superset/commit/c8060b292c6d26f3866efdab467bf75900a7712c))
* **deps:** update all non-major github action dependencies ([#456](https://github.com/cds-snc/cds-superset/issues/456)) ([3e7f33a](https://github.com/cds-snc/cds-superset/commit/3e7f33aba7e3e6f2ce1e237742f5f321d956b7ab))
* **deps:** update terraform aws to v6 ([#459](https://github.com/cds-snc/cds-superset/issues/459)) ([5911aa0](https://github.com/cds-snc/cds-superset/commit/5911aa0d9431676b6cc34af5295c7c8f43e63ccf))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.5.1 ([#457](https://github.com/cds-snc/cds-superset/issues/457)) ([9c7b31f](https://github.com/cds-snc/cds-superset/commit/9c7b31fb206b0691ef15abb6d7475282d8824993))
* synced local '.github/workflows/backstage-catalog-helper.yml' with remote 'tools/sre_file_sync/backstage-catalog-helper.yml' ([#455](https://github.com/cds-snc/cds-superset/issues/455)) ([f90ebfe](https://github.com/cds-snc/cds-superset/commit/f90ebfe397ee6d3179d800dca7fdc7a2dd87ece3))

## [2.20.0](https://github.com/cds-snc/cds-superset/compare/v2.19.0...v2.20.0) (2025-06-17)


### Features

* add Slack notification for Security PRs ([#448](https://github.com/cds-snc/cds-superset/issues/448)) ([b7dc4d4](https://github.com/cds-snc/cds-superset/commit/b7dc4d43136b0e3e6ca1271ec401f2e9c7324ad9))
* enable AWS Shield Advanced ([#451](https://github.com/cds-snc/cds-superset/issues/451)) ([bbd2e0a](https://github.com/cds-snc/cds-superset/commit/bbd2e0afd8494d488ad0b00f2b666e51f473984b))


### Bug Fixes

* add automatic block rule for Shield Advanced ([#452](https://github.com/cds-snc/cds-superset/issues/452)) ([aeafa49](https://github.com/cds-snc/cds-superset/commit/aeafa491ba8f9ad7e83d53df7478489e0152a1ac))
* update CODEOWNERS for our team ([#446](https://github.com/cds-snc/cds-superset/issues/446)) ([b0e0da2](https://github.com/cds-snc/cds-superset/commit/b0e0da2a469a6e00beff38d160542c68743fb2d4))


### Miscellaneous Chores

* **deps:** update github/codeql-action action to v3.28.19 ([#449](https://github.com/cds-snc/cds-superset/issues/449)) ([ec86906](https://github.com/cds-snc/cds-superset/commit/ec86906c1a48651ff665aa35b393c2d9243a8b66))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.5.0 ([#450](https://github.com/cds-snc/cds-superset/issues/450)) ([9b2b3ad](https://github.com/cds-snc/cds-superset/commit/9b2b3adb10d628ccffa1e85dd62e4e5a34829922))

## [2.19.0](https://github.com/cds-snc/cds-superset/compare/v2.18.3...v2.19.0) (2025-06-10)


### Features

* create Notify Prod data IAM role ([#445](https://github.com/cds-snc/cds-superset/issues/445)) ([c8025c7](https://github.com/cds-snc/cds-superset/commit/c8025c72a6281768e3c8c73eb7e4b9a30978b1c7))


### Bug Fixes

* architecture diagram account label ([#443](https://github.com/cds-snc/cds-superset/issues/443)) ([6da9920](https://github.com/cds-snc/cds-superset/commit/6da9920376d9506188435b0df5b35914c89e3ab5))

## [2.18.3](https://github.com/cds-snc/cds-superset/compare/v2.18.2...v2.18.3) (2025-06-09)


### Documentation

* add architectural diagram ([#442](https://github.com/cds-snc/cds-superset/issues/442)) ([5f8a79e](https://github.com/cds-snc/cds-superset/commit/5f8a79efd6b8ae03956568474707cdbe251aff40))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#439](https://github.com/cds-snc/cds-superset/issues/439)) ([06e66d2](https://github.com/cds-snc/cds-superset/commit/06e66d2f6855f0b3763fa82130174cb79caf9ce1))
* **deps:** update all patch dependencies ([#437](https://github.com/cds-snc/cds-superset/issues/437)) ([62ab349](https://github.com/cds-snc/cds-superset/commit/62ab349c3af6948f8d8cb13d20d2212b6aeda27a))
* **deps:** update aws-actions/amazon-ecs-render-task-definition action to v1.7.3 ([#438](https://github.com/cds-snc/cds-superset/issues/438)) ([84f38de](https://github.com/cds-snc/cds-superset/commit/84f38de3c933d244be4394e6d605bd2b75b6519e))
* lower min capacity scaling of database ([#441](https://github.com/cds-snc/cds-superset/issues/441)) ([0ecc81e](https://github.com/cds-snc/cds-superset/commit/0ecc81e5e25f58c9bd525187583edb9e7f619019))

## [2.18.2](https://github.com/cds-snc/cds-superset/compare/v2.18.1...v2.18.2) (2025-06-02)


### Bug Fixes

* drop support for TLS 1.2 connections ([#432](https://github.com/cds-snc/cds-superset/issues/432)) ([f84ead9](https://github.com/cds-snc/cds-superset/commit/f84ead9a24fa335e7c35777a44674b8d2fa3d31f))


### Miscellaneous Chores

* **deps:** update dependency authlib to v1.6.0 ([#435](https://github.com/cds-snc/cds-superset/issues/435)) ([04443be](https://github.com/cds-snc/cds-superset/commit/04443be497ffb797a6d826a8c2c824cd6456c2f9))
* **deps:** update dependency pyathena to v3.14.1 ([#436](https://github.com/cds-snc/cds-superset/issues/436)) ([e75a3e8](https://github.com/cds-snc/cds-superset/commit/e75a3e8e16cf3d827ed18169dcbf24c859e1f529))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to c283798 ([#434](https://github.com/cds-snc/cds-superset/issues/434)) ([60be36a](https://github.com/cds-snc/cds-superset/commit/60be36a5ec47d4b3265373612c5ab55dffed09d6))

## [2.18.1](https://github.com/cds-snc/cds-superset/compare/v2.18.0...v2.18.1) (2025-05-30)


### Bug Fixes

* remove port 80 load balancer listener ([#430](https://github.com/cds-snc/cds-superset/issues/430)) ([73d87c7](https://github.com/cds-snc/cds-superset/commit/73d87c76aa3a06b9ee81b89bd24f5c5beecfdaab))

## [2.18.0](https://github.com/cds-snc/cds-superset/compare/v2.17.0...v2.18.0) (2025-05-29)


### Features

* enable pgAudit query logging ([#422](https://github.com/cds-snc/cds-superset/issues/422)) ([0e74b2c](https://github.com/cds-snc/cds-superset/commit/0e74b2c43ab7339e238ff4ff9fc7affb98b5bd18))


### Miscellaneous Chores

* remove the old Redis cache ([#428](https://github.com/cds-snc/cds-superset/issues/428)) ([a2c9cdf](https://github.com/cds-snc/cds-superset/commit/a2c9cdf5fe16f580487cd4fda249c9497fa020cd))

## [2.17.0](https://github.com/cds-snc/cds-superset/compare/v2.16.0...v2.17.0) (2025-05-29)


### Features

* switch to the fully operational Valkey cluster ([#426](https://github.com/cds-snc/cds-superset/issues/426)) ([236f729](https://github.com/cds-snc/cds-superset/commit/236f72993f8bfa82f4f1cb46cab4d12c13da621e))

## [2.16.0](https://github.com/cds-snc/cds-superset/compare/v2.15.0...v2.16.0) (2025-05-29)


### Features

* switch to Valkey caching engine ([#423](https://github.com/cds-snc/cds-superset/issues/423)) ([7a7537d](https://github.com/cds-snc/cds-superset/commit/7a7537d98e1cfb83a7753633ab02901b0c661a64))


### Bug Fixes

* creation of the Valkey memcache cluster ([#425](https://github.com/cds-snc/cds-superset/issues/425)) ([6e92391](https://github.com/cds-snc/cds-superset/commit/6e92391b26d3f1b43cc6f3cb5e47d00a02075ee4))

## [2.15.0](https://github.com/cds-snc/cds-superset/compare/v2.14.11...v2.15.0) (2025-05-28)


### Features

* require SSL for database connection ([#420](https://github.com/cds-snc/cds-superset/issues/420)) ([4d0ffd4](https://github.com/cds-snc/cds-superset/commit/4d0ffd444539b091ad2b3b165dea9e159fb95ce8))

## [2.14.11](https://github.com/cds-snc/cds-superset/compare/v2.14.10...v2.14.11) (2025-05-26)


### Bug Fixes

* race condition to retrieve commit SHA ([#419](https://github.com/cds-snc/cds-superset/issues/419)) ([c289834](https://github.com/cds-snc/cds-superset/commit/c289834f666e2a57111b6d6f3830fde7207fa903))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#417](https://github.com/cds-snc/cds-superset/issues/417)) ([ec3c4c4](https://github.com/cds-snc/cds-superset/commit/ec3c4c44476f00f8a6664865a1df73ce3c4e23a6))
* **deps:** update all non-major github action dependencies ([#414](https://github.com/cds-snc/cds-superset/issues/414)) ([0f306d8](https://github.com/cds-snc/cds-superset/commit/0f306d83f0e1409f6c2bb0a420b2531f340f7ceb))
* **deps:** update dependency pyathena to v3.14.0 ([#416](https://github.com/cds-snc/cds-superset/issues/416)) ([d4a09af](https://github.com/cds-snc/cds-superset/commit/d4a09afa30d2bd37eb57d3f0e13999c957481733))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.4.6 ([#415](https://github.com/cds-snc/cds-superset/issues/415)) ([0e046a8](https://github.com/cds-snc/cds-superset/commit/0e046a8beff03974c83161a275aebe9a3584e844))

## [2.14.10](https://github.com/cds-snc/cds-superset/compare/v2.14.9...v2.14.10) (2025-05-23)


### Bug Fixes

* do not consider no tables as an error ([#411](https://github.com/cds-snc/cds-superset/issues/411)) ([cc8d4de](https://github.com/cds-snc/cds-superset/commit/cc8d4de2a1933ce776f36d726a15c863b558a737))
* force translation of top level menu items ([#413](https://github.com/cds-snc/cds-superset/issues/413)) ([7ee10a2](https://github.com/cds-snc/cds-superset/commit/7ee10a25adff07881a133b4d51859cde6ddef843))

## [2.14.9](https://github.com/cds-snc/cds-superset/compare/v2.14.8...v2.14.9) (2025-05-20)


### Miscellaneous Chores

* **deps:** update all non-major github action dependencies ([#409](https://github.com/cds-snc/cds-superset/issues/409)) ([86b0561](https://github.com/cds-snc/cds-superset/commit/86b05617a044ec5abd9da86964b77f2e2d8a5b9e))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.4.5 ([#408](https://github.com/cds-snc/cds-superset/issues/408)) ([4ff244d](https://github.com/cds-snc/cds-superset/commit/4ff244dcc26142bbd720c7ea5bbd97b6464b38f8))

## [2.14.8](https://github.com/cds-snc/cds-superset/compare/v2.14.7...v2.14.8) (2025-05-15)


### Bug Fixes

* route failed workflow notifications to correct channel ([#406](https://github.com/cds-snc/cds-superset/issues/406)) ([7cbeee0](https://github.com/cds-snc/cds-superset/commit/7cbeee002bbb1da61e8d0c909c83c196d350c96c))

## [2.14.7](https://github.com/cds-snc/cds-superset/compare/v2.14.6...v2.14.7) (2025-05-15)


### Bug Fixes

* add Staging Data Lake IAM roles ([#402](https://github.com/cds-snc/cds-superset/issues/402)) ([889afd1](https://github.com/cds-snc/cds-superset/commit/889afd1d1b0b722d0f175341bd2b4129d55c8119))
* revert the description change for the data catalog ([#405](https://github.com/cds-snc/cds-superset/issues/405)) ([621c668](https://github.com/cds-snc/cds-superset/commit/621c668aa42a6f263b7fea610c0fd974bf9f9ed8))
* Superset IAM roles used to access the Data Lake ([#404](https://github.com/cds-snc/cds-superset/issues/404)) ([a4bc8e4](https://github.com/cds-snc/cds-superset/commit/a4bc8e4c0170fa3eb27b25cbd700a6caf2f871ce))

## [2.14.6](https://github.com/cds-snc/cds-superset/compare/v2.14.5...v2.14.6) (2025-05-13)


### Bug Fixes

* add more missing permissions to our custom roles ([#400](https://github.com/cds-snc/cds-superset/issues/400)) ([9efddb8](https://github.com/cds-snc/cds-superset/commit/9efddb8aa2e936c52c10cf3b416c71acdebe9277))

## [2.14.5](https://github.com/cds-snc/cds-superset/compare/v2.14.4...v2.14.5) (2025-05-13)


### Bug Fixes

* add prophet dependency for predictive analytics ([#399](https://github.com/cds-snc/cds-superset/issues/399)) ([5acd40f](https://github.com/cds-snc/cds-superset/commit/5acd40f4389004c4f77c36d0c5c428132bf95857))


### Miscellaneous Chores

* cleanup unused folder ([#396](https://github.com/cds-snc/cds-superset/issues/396)) ([9a4cfbc](https://github.com/cds-snc/cds-superset/commit/9a4cfbc1633f5b7649ac73ed8e11e2c36d230c88))
* **deps:** update all non-major github action dependencies ([#394](https://github.com/cds-snc/cds-superset/issues/394)) ([8be5b54](https://github.com/cds-snc/cds-superset/commit/8be5b5498ff438cd344ef217ac9b283b564f1869))
* **deps:** update dependency redis to v5.3.0 ([#395](https://github.com/cds-snc/cds-superset/issues/395)) ([1d60450](https://github.com/cds-snc/cds-superset/commit/1d60450ced5c37b1f13fd5485e1583a98d647fae))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to 76a2d99 ([#393](https://github.com/cds-snc/cds-superset/issues/393)) ([e63e007](https://github.com/cds-snc/cds-superset/commit/e63e00733b3a2f4de9c1c2f374c4cf09a1878bd6))
* suppress generic PostgresSQL errors ([#398](https://github.com/cds-snc/cds-superset/issues/398)) ([489fb8f](https://github.com/cds-snc/cds-superset/commit/489fb8f2842302f3f0b5ff044b1020c6d365f2e9))

## [2.14.4](https://github.com/cds-snc/cds-superset/compare/v2.14.3...v2.14.4) (2025-05-06)


### Bug Fixes

* permissions for `WriteData` role ([#391](https://github.com/cds-snc/cds-superset/issues/391)) ([eaea7ba](https://github.com/cds-snc/cds-superset/commit/eaea7ba73fc8fedb92ccc0ccc35ec3cabe3d23e4))

## [2.14.3](https://github.com/cds-snc/cds-superset/compare/v2.14.2...v2.14.3) (2025-05-05)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#389](https://github.com/cds-snc/cds-superset/issues/389)) ([f572803](https://github.com/cds-snc/cds-superset/commit/f572803f6e81791b4eeec005a964aa63f9a2202b))
* **deps:** update all non-major github action dependencies ([#386](https://github.com/cds-snc/cds-superset/issues/386)) ([968af9b](https://github.com/cds-snc/cds-superset/commit/968af9b5571e889530cc8b8ba53f0dece6d87e50))
* **deps:** update dependency pyathena to v3.13.0 ([#388](https://github.com/cds-snc/cds-superset/issues/388)) ([c20342e](https://github.com/cds-snc/cds-superset/commit/c20342ee29541d9873d40489242209112f21860a))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.4.2 ([#387](https://github.com/cds-snc/cds-superset/issues/387)) ([8f14dab](https://github.com/cds-snc/cds-superset/commit/8f14dabec7e51744e4f56ed29f5d37cb893b91e3))

## [2.14.2](https://github.com/cds-snc/cds-superset/compare/v2.14.1...v2.14.2) (2025-04-29)


### Miscellaneous Chores

* switch to CDS Release Bot ([#384](https://github.com/cds-snc/cds-superset/issues/384)) ([953f6d7](https://github.com/cds-snc/cds-superset/commit/953f6d71a27c5a3f9dec58818c4ba671d4628acd))

## [2.14.1](https://github.com/cds-snc/cds-superset/compare/v2.14.0...v2.14.1) (2025-04-28)


### Bug Fixes

* allow CacheWarmer access to all data ([#382](https://github.com/cds-snc/cds-superset/issues/382)) ([7c8005a](https://github.com/cds-snc/cds-superset/commit/7c8005a9879b6a8d8508a3775116b2225a6637ed))

## [2.14.0](https://github.com/cds-snc/cds-superset/compare/v2.13.0...v2.14.0) (2025-04-28)


### Features

* allow some 4XX responses through the IP blocklist ([#380](https://github.com/cds-snc/cds-superset/issues/380)) ([89ecedb](https://github.com/cds-snc/cds-superset/commit/89ecedb80a0e4f73162551f75516cbfe9e56fe36))


### Miscellaneous Chores

* **deps:** update cds-snc/terraform-plan action to v3.4.2 ([#379](https://github.com/cds-snc/cds-superset/issues/379)) ([1e4c9fb](https://github.com/cds-snc/cds-superset/commit/1e4c9fbf6a504de9344723c2fd9f973d94101333))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v7.4.3 ([#381](https://github.com/cds-snc/cds-superset/issues/381)) ([359b330](https://github.com/cds-snc/cds-superset/commit/359b330e75f99fbf8f6204704793d7b746a4ea92))
* synced local '.github/workflows/backstage-catalog-helper.yml' with remote 'tools/sre_file_sync/backstage-catalog-helper.yml' ([#377](https://github.com/cds-snc/cds-superset/issues/377)) ([dae32a4](https://github.com/cds-snc/cds-superset/commit/dae32a4dfad4fa149130f2591a1a40cfda6f2f7e))

## [2.13.0](https://github.com/cds-snc/cds-superset/compare/v2.12.2...v2.13.0) (2025-04-22)


### Features

* add `PlatformUser` role ([#375](https://github.com/cds-snc/cds-superset/issues/375)) ([19c85bc](https://github.com/cds-snc/cds-superset/commit/19c85bcfe83c0cfcfd794af76b035faa17bd88b3))

## [2.12.2](https://github.com/cds-snc/cds-superset/compare/v2.12.1...v2.12.2) (2025-04-22)


### Bug Fixes

* add missing API time range permission ([#373](https://github.com/cds-snc/cds-superset/issues/373)) ([d427c38](https://github.com/cds-snc/cds-superset/commit/d427c38cc0869fc412a0dd6fa923c3d68a30d994))

## [2.12.1](https://github.com/cds-snc/cds-superset/compare/v2.12.0...v2.12.1) (2025-04-22)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#370](https://github.com/cds-snc/cds-superset/issues/370)) ([66085e9](https://github.com/cds-snc/cds-superset/commit/66085e9a39c6acded7260f95add78191684fa926))
* **deps:** update all non-major github action dependencies ([#369](https://github.com/cds-snc/cds-superset/issues/369)) ([0863e78](https://github.com/cds-snc/cds-superset/commit/0863e788307bfe6239f1ec34ac00cf4103d60b93))

## [2.12.0](https://github.com/cds-snc/cds-superset/compare/v2.11.0...v2.12.0) (2025-04-21)


### Features

* create GC Forms data IAM role ([#368](https://github.com/cds-snc/cds-superset/issues/368)) ([388aa26](https://github.com/cds-snc/cds-superset/commit/388aa2621ed691cff9b936adb7a4c3a1285ce005))

## [2.11.0](https://github.com/cds-snc/cds-superset/compare/v2.10.4...v2.11.0) (2025-04-14)


### Features

* create the Notify Staging IAM role ([#367](https://github.com/cds-snc/cds-superset/issues/367)) ([5f3c3b7](https://github.com/cds-snc/cds-superset/commit/5f3c3b7f1bbff3ad2914ae41ea2482082594b473))


### Miscellaneous Chores

* **deps:** update dependency authlib to v1.5.2 ([#366](https://github.com/cds-snc/cds-superset/issues/366)) ([24026d8](https://github.com/cds-snc/cds-superset/commit/24026d8ec007317ad847d033e34fe78ad7e38501))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to d67d4d2 ([#365](https://github.com/cds-snc/cds-superset/issues/365)) ([ff87e0b](https://github.com/cds-snc/cds-superset/commit/ff87e0bdf589932a72c4ac17524cad2ba853a354))
* suppress user generated alarms ([#363](https://github.com/cds-snc/cds-superset/issues/363)) ([27198e7](https://github.com/cds-snc/cds-superset/commit/27198e7eb20ac3e08722e4c0a1ad1f5d14d958fe))

## [2.10.4](https://github.com/cds-snc/cds-superset/compare/v2.10.3...v2.10.4) (2025-04-10)


### Bug Fixes

* Superset ReadOnly and WriteData roles ([#361](https://github.com/cds-snc/cds-superset/issues/361)) ([6f6d45d](https://github.com/cds-snc/cds-superset/commit/6f6d45d9bb207d2a71f88048db32ca9142de0de5))

## [2.10.3](https://github.com/cds-snc/cds-superset/compare/v2.10.2...v2.10.3) (2025-04-07)


### Bug Fixes

* skip integration test for the meta database ([#360](https://github.com/cds-snc/cds-superset/issues/360)) ([f48d694](https://github.com/cds-snc/cds-superset/commit/f48d694b164808b8c2ebdfe38eeb1b597d278d47))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#358](https://github.com/cds-snc/cds-superset/issues/358)) ([f48f742](https://github.com/cds-snc/cds-superset/commit/f48f742b2e4052a162056274f9eb52aa884d3099))
* **deps:** update actions/create-github-app-token action to v2 ([#354](https://github.com/cds-snc/cds-superset/issues/354)) ([b38030b](https://github.com/cds-snc/cds-superset/commit/b38030b2866ccac5fde1d25905dbe0d38024971a))
* **deps:** update all minor dependencies ([#357](https://github.com/cds-snc/cds-superset/issues/357)) ([c932a0d](https://github.com/cds-snc/cds-superset/commit/c932a0d5f28c9746798b35decdf006091b8878d5))
* **deps:** update all non-major github action dependencies ([#356](https://github.com/cds-snc/cds-superset/issues/356)) ([0256824](https://github.com/cds-snc/cds-superset/commit/02568249baaa3a8467c67adff46e6ab54ac3beab))
* **deps:** update apache/superset docker tag to v4.1.2 ([#355](https://github.com/cds-snc/cds-superset/issues/355)) ([a659101](https://github.com/cds-snc/cds-superset/commit/a6591010a721648bdfd360b9cd61da110ef518c7))

## [2.10.2](https://github.com/cds-snc/cds-superset/compare/v2.10.1...v2.10.2) (2025-04-01)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#352](https://github.com/cds-snc/cds-superset/issues/352)) ([7bd0cfa](https://github.com/cds-snc/cds-superset/commit/7bd0cfa3d8bfbcb631a0aa5bbd750268caff0f42))
* **deps:** update all non-major github action dependencies ([#351](https://github.com/cds-snc/cds-superset/issues/351)) ([ac03e52](https://github.com/cds-snc/cds-superset/commit/ac03e52522ecd0ac6aaa90c2359533a75ed62ab2))

## [2.10.1](https://github.com/cds-snc/cds-superset/compare/v2.10.0...v2.10.1) (2025-03-25)


### Bug Fixes

* adjust load balancer response time alarm ([#350](https://github.com/cds-snc/cds-superset/issues/350)) ([b5f31ca](https://github.com/cds-snc/cds-superset/commit/b5f31ca57c397726d89c052e0083c1c71eb98e3c))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#348](https://github.com/cds-snc/cds-superset/issues/348)) ([da986f0](https://github.com/cds-snc/cds-superset/commit/da986f0324377a332841a916ff78c56ac04a8778))
* **deps:** update mcr.microsoft.com/devcontainers/base:bullseye docker digest to 0b3c5ff ([#346](https://github.com/cds-snc/cds-superset/issues/346)) ([8efdf69](https://github.com/cds-snc/cds-superset/commit/8efdf69290097d67893a65f6574f9b33eb3e8c63))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.3.2 ([#347](https://github.com/cds-snc/cds-superset/issues/347)) ([c51b15d](https://github.com/cds-snc/cds-superset/commit/c51b15dabf3f43d00bf8e6d48a451bbaf3e24e6a))

## [2.10.0](https://github.com/cds-snc/cds-superset/compare/v2.9.3...v2.10.0) (2025-03-17)


### Features

* add Superset meta database configuration and enable feature flag ([#336](https://github.com/cds-snc/cds-superset/issues/336)) ([e8aef2d](https://github.com/cds-snc/cds-superset/commit/e8aef2d6be38f4141cf0750ec1e7e133e8fd03bb))
* setup superset meta db limit to 10000 ([#339](https://github.com/cds-snc/cds-superset/issues/339)) ([27bba35](https://github.com/cds-snc/cds-superset/commit/27bba35f890aef3a889bfbde85280e8d52ecdbcb))
* switch to ARM64 Docker images ([#343](https://github.com/cds-snc/cds-superset/issues/343)) ([ad13ac0](https://github.com/cds-snc/cds-superset/commit/ad13ac0034ad1b8666661eb851893b75d6fe0a08))


### Bug Fixes

* allow Celery works to perform async queries ([#337](https://github.com/cds-snc/cds-superset/issues/337)) ([4dc2055](https://github.com/cds-snc/cds-superset/commit/4dc2055a4171d3a706ff722aa9cb0c48d74acfbd))
* docker SBOM architecture ([#345](https://github.com/cds-snc/cds-superset/issues/345)) ([8ee6773](https://github.com/cds-snc/cds-superset/commit/8ee67735312dea1a0261377f190c78333d22040e))
* increase Superset meta db row limit to 100k ([#340](https://github.com/cds-snc/cds-superset/issues/340)) ([0d315c6](https://github.com/cds-snc/cds-superset/commit/0d315c687b8e303d7ed6006f3ed02e98bc29d926))
* propagate tags on new deployments ([#333](https://github.com/cds-snc/cds-superset/issues/333)) ([2309cb5](https://github.com/cds-snc/cds-superset/commit/2309cb5e35897eead96c96bb63fde001c31ca74b))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#344](https://github.com/cds-snc/cds-superset/issues/344)) ([39b1719](https://github.com/cds-snc/cds-superset/commit/39b1719625b354ed1b3c168e851738bf971237f9))
* **deps:** update all non-major github action dependencies ([#342](https://github.com/cds-snc/cds-superset/issues/342)) ([8ac71ce](https://github.com/cds-snc/cds-superset/commit/8ac71ce76376e6d685fd868bad829cc830a58972))
* remove the SupersetAthenaReal-all role ([#338](https://github.com/cds-snc/cds-superset/issues/338)) ([79488e9](https://github.com/cds-snc/cds-superset/commit/79488e96eef859b3b1c3a84fb7879b23af5bf14d))

## [2.9.3](https://github.com/cds-snc/cds-superset/compare/v2.9.2...v2.9.3) (2025-03-11)


### Bug Fixes

* add warning CloudWatch alarm ([#331](https://github.com/cds-snc/cds-superset/issues/331)) ([8eaccd6](https://github.com/cds-snc/cds-superset/commit/8eaccd693f8941f7937411fb7f1c101a665cf38e))


### Miscellaneous Chores

* synced local '.github/workflows/ossf-scorecard.yml' with remote 'tools/sre_file_sync/ossf-scorecard.yml' ([#330](https://github.com/cds-snc/cds-superset/issues/330)) ([dcb6714](https://github.com/cds-snc/cds-superset/commit/dcb6714c37c322d9ea558b943ad6776b9c03b813))

## [2.9.2](https://github.com/cds-snc/cds-superset/compare/v2.9.1...v2.9.2) (2025-03-10)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#328](https://github.com/cds-snc/cds-superset/issues/328)) ([a1c0c69](https://github.com/cds-snc/cds-superset/commit/a1c0c692ad9121604b00eeeb447679900bb7903c))
* **deps:** update all non-major github action dependencies ([#325](https://github.com/cds-snc/cds-superset/issues/325)) ([f7a4b0d](https://github.com/cds-snc/cds-superset/commit/f7a4b0dc3b003c0b755b1ace4adc4f3692be1433))
* **deps:** update dependency authlib to v1.5.1 ([#327](https://github.com/cds-snc/cds-superset/issues/327)) ([f1de414](https://github.com/cds-snc/cds-superset/commit/f1de414dce15b76546e46561849c39283be58ee3))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.3.1 ([#326](https://github.com/cds-snc/cds-superset/issues/326)) ([0a29649](https://github.com/cds-snc/cds-superset/commit/0a29649d5e0f844685cafa4246fe7585c1563708))

## [2.9.1](https://github.com/cds-snc/cds-superset/compare/v2.9.0...v2.9.1) (2025-03-06)


### Bug Fixes

* update CA geo restriction with Upptime header ([#323](https://github.com/cds-snc/cds-superset/issues/323)) ([26247a2](https://github.com/cds-snc/cds-superset/commit/26247a2055b928f238c17295d4d21653dac062c2))

## [2.9.0](https://github.com/cds-snc/cds-superset/compare/v2.8.1...v2.9.0) (2025-03-05)


### Features

* add a WAF rule to only allow Canadian IP addresses ([#321](https://github.com/cds-snc/cds-superset/issues/321)) ([30cb4e8](https://github.com/cds-snc/cds-superset/commit/30cb4e864608c6b14e209a72deeef341bda879ea))

## [2.8.1](https://github.com/cds-snc/cds-superset/compare/v2.8.0...v2.8.1) (2025-03-03)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#319](https://github.com/cds-snc/cds-superset/issues/319)) ([9d6f045](https://github.com/cds-snc/cds-superset/commit/9d6f04554efc37f9f0936ed6c918c3ff3438536d))
* **deps:** update all non-major github action dependencies ([#318](https://github.com/cds-snc/cds-superset/issues/318)) ([0eec38d](https://github.com/cds-snc/cds-superset/commit/0eec38de14e53ea135d403c8d3374db3be82bbea))

## [2.8.0](https://github.com/cds-snc/cds-superset/compare/v2.7.1...v2.8.0) (2025-02-26)


### Features

* add SNS alarm topics in us-east-1 ([#315](https://github.com/cds-snc/cds-superset/issues/315)) ([1546356](https://github.com/cds-snc/cds-superset/commit/154635646994bad98305462247d577307c7c15dc))


### Bug Fixes

* always use latest ECS task definition ([#317](https://github.com/cds-snc/cds-superset/issues/317)) ([4b98be2](https://github.com/cds-snc/cds-superset/commit/4b98be27d5e9d5a45c42795a16f988c281d633d3))


### Miscellaneous Chores

* synced file(s) with cds-snc/site-reliability-engineering ([#314](https://github.com/cds-snc/cds-superset/issues/314)) ([418f481](https://github.com/cds-snc/cds-superset/commit/418f481ccda551d181f26c375b495f80e1af03d5))

## [2.7.1](https://github.com/cds-snc/cds-superset/compare/v2.7.0...v2.7.1) (2025-02-24)


### Miscellaneous Chores

* **deps:** lock file maintenance ([#312](https://github.com/cds-snc/cds-superset/issues/312)) ([0972759](https://github.com/cds-snc/cds-superset/commit/09727596cfefb9feca8e7c90a03a4cc968383d13))
* **deps:** update actions/create-github-app-token action to v1.11.5 ([#309](https://github.com/cds-snc/cds-superset/issues/309)) ([d00aaca](https://github.com/cds-snc/cds-superset/commit/d00aaca9fe668d0e3c7a229fd2c5538e13bffc25))
* **deps:** update dependency flake8 to v7.1.2 ([#311](https://github.com/cds-snc/cds-superset/issues/311)) ([b2c654c](https://github.com/cds-snc/cds-superset/commit/b2c654c6b22293da00347b5bd3a3f5da315e3dca))
* **deps:** update terraform github.com/cds-snc/terraform-modules to v10.3.0 ([#310](https://github.com/cds-snc/cds-superset/issues/310)) ([6e24a83](https://github.com/cds-snc/cds-superset/commit/6e24a839970a8f52dc61d5f7ca8bbc5119d994f0))

## [2.7.0](https://github.com/cds-snc/cds-superset/compare/v2.6.0...v2.7.0) (2025-02-18)


### Features

* add salesforces transformed db ([#304](https://github.com/cds-snc/cds-superset/issues/304)) ([d64a66d](https://github.com/cds-snc/cds-superset/commit/d64a66d852d5d9babe7acd1b8900a56b70dfdd24))


### Miscellaneous Chores

* **deps:** update all non-major github action dependencies ([#308](https://github.com/cds-snc/cds-superset/issues/308)) ([28b2f14](https://github.com/cds-snc/cds-superset/commit/28b2f14f9aaaf06e9e5c038f40f66f5157a61f8e))
* suppress user query error ([#306](https://github.com/cds-snc/cds-superset/issues/306)) ([7f48055](https://github.com/cds-snc/cds-superset/commit/7f4805542405e86739f7f0bafca640ff5d3f8cb3))
* suppress user query errors ([#307](https://github.com/cds-snc/cds-superset/issues/307)) ([579ef9e](https://github.com/cds-snc/cds-superset/commit/579ef9efcfa924d13c49b64b4420da6ad98a90d8))

## [2.6.0](https://github.com/cds-snc/cds-superset/compare/v2.5.4...v2.6.0) (2025-02-11)


### Features

* add startup database integration tests ([#296](https://github.com/cds-snc/cds-superset/issues/296)) ([d5c61ea](https://github.com/cds-snc/cds-superset/commit/d5c61ea0daee2a133ec07cb3c0b66d2004c13bbd))
* update branding to use CDS logo ([#303](https://github.com/cds-snc/cds-superset/issues/303)) ([7e26445](https://github.com/cds-snc/cds-superset/commit/7e26445fca72fa56b980135a291892e32a9e7bad))


### Bug Fixes

* integration tests for impersonation databases ([#297](https://github.com/cds-snc/cds-superset/issues/297)) ([e8b1408](https://github.com/cds-snc/cds-superset/commit/e8b1408f31bf74b1052d14dffda5181258f9852f))


### Miscellaneous Chores

* **deps:** lock file maintenance ([#302](https://github.com/cds-snc/cds-superset/issues/302)) ([88eacb0](https://github.com/cds-snc/cds-superset/commit/88eacb04711282e3e9ce1db7e6d9884a8dcf7eca))
* **deps:** update all non-major github action dependencies ([#299](https://github.com/cds-snc/cds-superset/issues/299)) ([8eb27b5](https://github.com/cds-snc/cds-superset/commit/8eb27b55afe7f5c2886afba8586a7340dad18309))
* **deps:** update dependency authlib to v1.4.1 ([#300](https://github.com/cds-snc/cds-superset/issues/300)) ([8644f56](https://github.com/cds-snc/cds-superset/commit/8644f568c4db1dfe238e7ad333d72a0092a2f37a))
* **deps:** update dependency black to v25 ([#298](https://github.com/cds-snc/cds-superset/issues/298)) ([fb335b1](https://github.com/cds-snc/cds-superset/commit/fb335b154a0adb952f9beff9496bdf98de1e10a1))
* **deps:** update github/codeql-action action to v3.28.5 ([#294](https://github.com/cds-snc/cds-superset/issues/294)) ([10539be](https://github.com/cds-snc/cds-superset/commit/10539bed5afebcf4d1db1edf978abbb432825dbf))
* synced file(s) with cds-snc/site-reliability-engineering ([#301](https://github.com/cds-snc/cds-superset/issues/301)) ([39969de](https://github.com/cds-snc/cds-superset/commit/39969de9bb686d6a8e6229640d07bbf8236f7820))

## [2.5.4](https://github.com/cds-snc/cds-superset/compare/v2.5.3...v2.5.4) (2025-01-27)


### Bug Fixes

* add missing `explore` permissions to ReadOnly role ([#293](https://github.com/cds-snc/cds-superset/issues/293)) ([c7785c0](https://github.com/cds-snc/cds-superset/commit/c7785c02e28fc69eea23e45a7191b6315b66ce9f))
* switch language translation flags ([#290](https://github.com/cds-snc/cds-superset/issues/290)) ([8e5b891](https://github.com/cds-snc/cds-superset/commit/8e5b8916ac8a42acd0ee1e821369a06223f14d25))


### Miscellaneous Chores

* **deps:** update aws-actions/amazon-ecs-render-task-definition action to v1.6.2 ([#291](https://github.com/cds-snc/cds-superset/issues/291)) ([ad5fa98](https://github.com/cds-snc/cds-superset/commit/ad5fa986112022757b251dd34cf25837e3872496))

## [2.5.3](https://github.com/cds-snc/cds-superset/compare/v2.5.2...v2.5.3) (2025-01-24)


### Bug Fixes

* combine `Gamma` permissions with `ReadOnly` ([#288](https://github.com/cds-snc/cds-superset/issues/288)) ([2072d59](https://github.com/cds-snc/cds-superset/commit/2072d59f7fa60d015a56b856bbb573b10246535b))

## [2.5.2](https://github.com/cds-snc/cds-superset/compare/v2.5.1...v2.5.2) (2025-01-24)


### Bug Fixes

* increase rate limit and block IP set ([#286](https://github.com/cds-snc/cds-superset/issues/286)) ([d02b5e1](https://github.com/cds-snc/cds-superset/commit/d02b5e198d2ab0f1d709c8087808c5cd176366b0))

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
