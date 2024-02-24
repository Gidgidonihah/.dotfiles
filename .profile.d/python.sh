export PYTHONDONTWRITEBYTECODE=1

# Pylint should use my config by default
alias pylint="pylint --rcfile=/Users/jason/pyproject.toml"

# Unit testing
alias cover="coverage run --branch -m --omit='*test*' --source=. pytest -s; coverage report; coverage html &"
alias pytest="PYTHONPATH=. pytest"
function wunittest(){
    # TODO: add param for no network
    # TODO: add param for coverage
    # TODO: allow pytest params (i.e. specific file, negating watchtest)
    find **/*.py | entr -cs "PYTHONPATH=. sandbox-exec -f ~/no-network.sandbox coverage run --branch -m --omit='*test*' --source=. pytest -s && coverage html"
}
alias ,wunittest=wunittest
function watchtest() {
    # TODO: add param for no network
    # TODO: add param for disable-warnings
    # TODO: add param for coverage
    # TODO: allow pytest params
    ls **/*.py | entr -cs "PYTHONPATH=. pytest -s --disable-warnings $*"
}
alias ,watchtest=watchtest
