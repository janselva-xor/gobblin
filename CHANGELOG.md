# Change Log
All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.1.6] 2017-11-24
### Changed
- PNDA-3304: Remove javadoc generation in all subprojects.
### Fixed
- PNDA-3499: Cleanup CHANGELOG with missing release info.

## [0.1.5] 2017-07-04
### Changed
- PNDA-3103: Accept any JDK1.8 to build

## [0.1.4] 2017-05-23
### Changed
- PNDA-2984: Upgrade JDK to 8u131
### Fixed
- Don't run tests by default
- PNDA-3076: Catch all potential exceptions thrown by avro deserialisation

## [0.1.3] 2017-01-20
### Fixed
- PNDA-2521: Exits on first build error
- PNDA-2659: Update an old MySQL unittest library in order to make the build work

## [0.1.2] 2016-12-12
### Added
- Basic checks on PNDA message after deserialization
### Changed
- Externalized build logic from Jenkins to shell script so it can be reused
- Bumped Cloudera libraries to 5.9.0

## [0.1.1] 2016-09-13
### Changed
- Enhanced CI support

## [0.1.0] 2016-07-04
### Added
* A new converter to convert messages read from Kafka to the PNDA Avro schema (gobblin.pnda.PNDAConverter)
* A new writer writing data with the kitesdk library (gobblin.pnda.PNDAKiteWriterBuilder)
