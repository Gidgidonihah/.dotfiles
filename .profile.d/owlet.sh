# Helpful aliases
alias tree="tree -I \"*pyc|__pycache__\""
alias cdo='scd owlet'

# CRA defaults browser to chrome. Change that.
export BROWSER=safari

# Unit testing
alias cover="coverage run --branch -m --omit='*test*' --source=. pytest -s; coverage report; coverage html &"
alias pytest="PYTHONPATH=. pytest"
alias ut=pytest
function wunittest(){
    # TODO: add param for no network
    # TODO: add param for coverage
    # TODO: allow pytest params (i.e. specific file, negating watchtest)
    find **/*.py | entr -cs "PYTHONPATH=. sandbox-exec -f ~/no-network.sandbox coverage run --branch -m --omit='*test*' --source=. pytest -s && coverage html"
}
function watchtest() {
    # TODO: add param for no network
    # TODO: add param for coverage
    # TODO: allow pytest params
    ls **/*.py | entr -cs "PYTHONPATH=. pytest -s $*"
}

export OWLET_CONFIGURATION=/Users/jweir/Sites/owlet/ci-kit/bin/python/configuration
export OWLET_PYPROJECT_FILE=${OWLET_CONFIGURATION}/pyproject.toml
export OWLET_COVERAGERC_FILE=${OWLET_CONFIGURATION}/.coveragerc

# Linting
alias lint="black --config $OWLET_PYPROJECT_FILE . && isort --settings-path $OWLET_PYPROJECT_FILE --src . ."

alias owlet_pylint_global="pylint --rcfile=${OWLET_CONFIGURATION}/pylint_global.toml"
alias owlet_pylint_global_oas="pylint --rcfile=${OWLET_CONFIGURATION}/pylint_global.toml --ignore=app/models"
alias owlet_pylint_models="pylint --rcfile=${OWLET_CONFIGURATION}/pylint_generated_models.toml"
alias owlet_pylint_tests="pylint --rcfile=${OWLET_CONFIGURATION}/pylint_tests.toml"
alias plg='owlet_pylint_global $(find . -iname "*.py" | grep -v "^./tests\|^./app/models")'
alias plm='owlet_pylint_global_oas $(find app/ -iname "*.py" | grep -v "^./app/models")'
alias plt='owlet_pylint_tests tests/'
alias owlet_pylint="plg; plm; plt"
alias pylint_owlet="owlet_pylint"

# Multi repo search
alias ggo="~/.sh/multi-repo-search.sh -b ~/Sites/owlet"
