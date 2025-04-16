#!/bin/sh

. ./helper/cmd.sh
. ./helper/print.sh

create_missing_dirs() {
    if [ ! -e "$1" ]; then
        mkdir -p "$(dirname "$1")"
    fi
}

symlink() {
    local target_file=$1
    local link_file=$2

    if [ ! -f "$target_file" ] && [ ! -d "$target_file" ]; then
        echo "Neither a file nor a directory: $target_file"
        exit 1
    fi

    # If link_file doesn't exist, create all of the directories in the path
    create_missing_dirs "$link_file"

    if [ -L "$link_file" ]; then
        unlink "$link_file"
    fi

    name="Symlink $link_file -> $target_file"
    eval_cmd "$name" "ln -sf $target_file $link_file"
}

sudo_symlink() {
    local target_file=$1
    local link_file=$2

    if [ ! -f "$target_file" ] && [ ! -d "$target_file" ]; then
        print_error "Neither a file nor a directory" "$target_file"
        exit 1
    fi

    # If link_file doesn't exist, create all of the directories in the path
    create_missing_dirs "$link_file"

    if [ -L "$link_file" ]; then
        unlink "$link_file"
    fi

    name="Symlink $link_file -> $target_file"
    eval_cmd "$name" "sudo ln -sf $target_file $link_file"
}
