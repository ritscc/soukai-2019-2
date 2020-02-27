#!/bin/bash
# - written by @aonrjp

MODULES=('constitution' 'tex-commands')
GITLAB_HOST='git@gitlab.com:'

# CI実行の場合はCI_JOB_TOKENを利用して取ってくる
if [ "${CI_JOB_TOKEN}" ]; then
    GITLAB_HOST="https://gitlab-ci-token:${CI_JOB_TOKEN}@gitlab.com/"
fi

for module in ${MODULES[@]}
do
    git clone ${GITLAB_HOST}ritscc/soukai/${module}.git
done

