# Changelog

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
