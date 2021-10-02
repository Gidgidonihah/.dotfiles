# Helpful aliases
alias tree="tree -I \"*pyc|__pycache__\""
alias cdo='scd owlet'

# Unit testing
alias cover="coverage run --branch -m --omit='*test*' --source=. pytest -s; coverage report; coverage html &"
alias pytest="PYTHONPATH=. pytest"
alias ut=pytest
function wunittest(){
    # TODO: add param for no network
    # TODO: add param for coverage
    # TODO: allow pytest params
    find **/*.py | entr -cs "PYTHONPATH=. sandbox-exec -f ~/no-network.sandbox coverage run --branch -m --omit='*test*' --source=. pytest -s && coverage html"
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

# NOTES:
# # number of nodes in cluster
# $ kubectl get nodes -oname | wc -l
# 12
#
# # number of nodes with vital-data pods
# $ kubectl get pods -lapp=vital-data -ojson | jq -r '.items[].spec.nodeName' | sort | uniq -c | wc -l
# 10
#
# # distribution of vital-data pods on nodes
# $ kubectl get pods -lapp=vital-data -ojson | jq -r '.items[].spec.nodeName' | sort | uniq -c
#       2 gke-platform-green-terraform-20180824-43127f14-5v3f
#       6 gke-platform-green-terraform-20180824-43127f14-hm1m
#       2 gke-platform-green-terraform-20180824-43127f14-kr2l
#       5 gke-platform-green-terraform-20180824-5f8be5a1-0wxr
#       2 gke-platform-green-terraform-20180824-5f8be5a1-1xg9
#       3 gke-platform-green-terraform-20180824-5f8be5a1-cl04
#       4 gke-platform-green-terraform-20180824-c34a5c88-2hn2
#       1 gke-platform-green-terraform-20180824-c34a5c88-5j5l
#       3 gke-platform-green-terraform-20180824-c34a5c88-lc88
#       2 gke-platform-green-terraform-20180824-c34a5c88-vs0w
