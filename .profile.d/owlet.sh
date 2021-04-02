# Helpful aliases
alias tree="tree -I \"*pyc|__pycache__\""
alias ggo="export BASE='/Users/jweir/Sites/owlet'; ~/.sh/multi-repo-search.sh"
alias ggom="export BASE='/Users/jweir/Sites/owlet/mobile'; ~/.sh/multi-repo-search.sh"
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

# Linting
export OWLET_PYPROJECT_FILE=/Users/jweir/Sites/owlet/ci-kit/bin/python/configuration/pyproject.toml
alias lint="isort --apply --settings-path $OWLET_PYPROJECT_FILE && black --config $OWLET_PYPROJECT_FILE ."

function genApiKey(){
  APIKEY=$(python -c 'import secrets; print(secrets.token_urlsafe(32))')
  echo $APIKEY
  echo $APIKEY | pbcopy
}

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
