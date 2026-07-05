# Dev Tools
- [Dev Tools](#dev-tools)
- [Setup](#setup)
  - [1.1 Option A: Use Submodules (preferred)](#11-option-a-use-submodules-preferred)
  - [1.2 Option B: Clone this repo into your repo](#12-option-b-clone-this-repo-into-your-repo)
  - [2. Configuration](#2-configuration)
- [Tools Available](#tools-available)
  - [`dev_tools` Script](#dev_tools-script)
    - [Usage](#usage)
    - [Modes Avaialble](#modes-avaialble)

# Setup
## 1.1 Option A: Use Submodules (preferred)
Run the following:
```bash
cd <repo>
git submodule add https://github.com/fastrobotics/dev_tools.git dev_tools
```

To update:
```bash
cd <repo>
git submodule update --remote
```

## 1.2 Option B: Clone this repo into your repo

## 2. Configuration
Create a file called `repo_config.sh` in the root of your repo, like the following:
```bash
#!/bin/bash
# REPO Config
## General Config
export REPO_NAME="Your Rep Name"
export BUILD_TOOL="catkin" #cmake, catkin

## Coverage Config
export LINE_COVERAGE_THRESHOLD=50
export BRANCH_COVERAGE_THRESHOLD=0 # Don't care about Branch Coverage.
```

# Tools Available
## `dev_tools` Script
### Usage
```bash
cd <repo>
./dev_tools/scripts/dev_tools.sh <mode>
```

### Modes Avaialble
| Mode | Description | Support |
| --- | --- |
| `code_coverage` | Generates Code Coverage | Supports `cmake` and `catkin` |

