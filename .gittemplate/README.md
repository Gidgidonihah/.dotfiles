# Git Template
The Git template for cloned Repos

## What is this
This repo provides 4 git pre-commit hooks (and 1 runner hook) that will run before a commit is allowed.

* **Pre-Commit Runner** - Runs the 4 main hooks (and any other approiately named pre-commit hooks)
* **Pylint** - Runs `pylint` against the files being committed
* **Flake8** - Runs `flake8` against the files being committed
* **Branch Checker** - Checks if you are committed to a _protected_ branch. Asks for verification.
* **Tag Checker** - Checks for matches of a specified tag. Asks for verification.

## Setup
The git template may be cloned and used globally for all new cloned repos.
Alternatively you may copy the hooks locally to existing repos as you choose.

### Global setup
1. Clone the git_template repo

    ```bash
    cd ~; # You may change this location, but note the location is referenced in commands below
    git clone <this_repo> .git_template;
    cd ~/.git_template;
    pip install -r requirements.txt
    ```

1. Set up the global template

    ```bash
    git config --global init.templatedir '~/.git_template'
    ```

1. Specify the flake8 hook settings

    ```bash
    git config --global --bool flake8.strict true # Requires clean flake8 output for commit
    ```

1. Specify the tagmatch hook settings

    ```bash
    git config --add --global hooks.tagmatchpattern <enter a git search pattern here>
    # e.g git config --add --global hooks.tagmatchpattern jweir|todo
    ```

1. Clone your repositories. The template will be copied to your new clone.

### Local setup
1. Clone a repo of your choosing
1. Copy the runner (pre-commit) hook into your .git/hooks directory in your repo
1. Copy each additionaly hook you wish to use into the .git/hooks directory in your repo
1. If you choose to use the flake8 hook, install and setup

    ```bash
    git install flake8
    git config --local --bool flake8.strict true # Requires clean flake8 output for commit
    ```

1. If you choose to use the tagmatch hook, specify the tagmatch hook settings

    ```bash
    git config --add --local hooks.tagmatchpattern <enter a git search pattern here>
    # e.g git config --add --local hooks.tagmatchpattern jweir|todo
    ```

1. If you choose to use the pylint hook, you will need to install `pylint` and `git-pylint-commit-hook`

    ```bash
    pip install pylint
    pip install git-pylint-commit-hook
    ```

## Known Issues
Currently there is [a bug (#291)](https://gitlab.com/pycqa/flake8/issues/291) with flake8's hook that will check all
files that are staged for commit, rather than only the python files. In the meantime, you may turn of strict checking
(see setup above) until the bug is fixed.
