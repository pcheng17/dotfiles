#!/bin/sh

. ./helper/cmd.sh

git_set_global() {
    name="Set $1 to $2"
    eval_cmd "$name" "git config --global $1 $2"
}
