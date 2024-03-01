# [WIP] HRAlit

This repository has the code, input data, and draft results for HRAlit construction. Final versions of the HRAlit atlas are published to <https://lod.humanatlas.io/graph/hra-lit>.

## Construction Algorithm

### Requirements

To run the construction algorithm, you will need the following installed:

1. A unix-like environment (Linux, WSL2 / Ubuntu For Windows, or Mac (untested))
2. Node.js v18+
3. psql (`postgresql-client` in Ubuntu's package manager)
4. Java 11 (for blazegraph-runner)
5. Docker (optional)

### Setup

1. Install node dependencies via `npm ci`, which also installs [blazegraph-runner](https://github.com/balhoff/blazegraph-runner/) into `node_modules/.bin` for querying and reports.
2. Install `psql`. In Ubuntu, you can run `sudo apt install postgresql-client`.

### Input

Each HRAlit version is defined in a subdirectory of the input-data directory by version. A [config.sh](input-data/v0.6/config.sh) file is used to configure the sources and settings for the HRAlit construction workflow.

### Running

To start a workflow run, check the constants.sh to ensure it's including the right config.sh for your version. Then run [./logged-run.sh](./logged-run.sh) which will run the whole workflow and place a log.txt file in the correct subdirectory of output-data.

### Construction Workflow

| Script | Description |
| :-- | :-- |
| 00-setup-environment.sh | Additional environment setup (installs `blazegraph-runner`) |
| ... | ... |

### Output

Data is compiled to output-data/$VERSION.
