# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```markdown
## [Unreleased] - YYYY-MM-DD
### Added
### Changed
### Deprecated
### Fixed
### Security
```

## [Unreleased] - YYYY-MM-DD
### Added
- Added `workflow_dispatch` to the github workflow.
### Changed
### Deprecated
### Fixed
### Security


## [0.2.0] - 2024-05-01

### Added
- Added a `githooks.mk` include file that always creates a pre-push hook locally
  preventing direct pushes to main.
- Added a `help` target that parses the commands to produce a help message.
- Created tests for the `bash-build-tools`.
- Created tests for the `common-targets`.
- Created tests for the `install-tools`.
### Changed
- Slight changes to the verbosity of the recipes: added start messages, finish messages,
  and removed the printing of empty lines.
### Fixed
- Fixed a bug in the `boxerbird::build-bash-executable` call.

## [0.1.0] - 2024-01-08

### Added
- Shared file installation recipes
- Shared git repo recipes
- Shared bash script recipes
- Shared common targets
