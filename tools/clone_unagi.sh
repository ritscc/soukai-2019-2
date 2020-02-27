#!/bin/bash
# - written by @aonrjp

GITLAB_HOST='git@gitlab.com:'

# CI実行の場合はCI_JOB_TOKENを利用して取ってくる
if [ "${CI_JOB_TOKEN}" ]; then
    GITLAB_HOST="https://gitlab-ci-token:${CI_JOB_TOKEN}@gitlab.com/"
fi

git clone ${GITLAB_HOST}ritscc/soukai/unagi.git

# 対象コミットが指定されていれば適応
if [ -v UNAGI_COMMIT ]; then
    cd unagi
    git checkout ${UNAGI_COMMIT} 2> /dev/null
fi

# HEADの短縮ハッシュを取得
git rev-parse --short HEAD
