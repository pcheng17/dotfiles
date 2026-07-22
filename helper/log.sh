#!/usr/bin/env bash

clear_line() {
    printf "\r\033[K"
}

clear_lines() {
    clear_line
    for _ in $(seq 2 "$1"); do
        tput cuu1
        clear_line
    done
}

log_running_inline() {
    printf "\033[35m[Running]\033[0m %s" "$1"
}

log_running() {
    log_running_inline "$1"
    printf "\n"
}

log_ok() {
    printf "\033[32m[OK]\033[0m   %s\n" "$1"
}

log_info() {
    printf "\033[34m[INFO]\033[0m %s\n" "$1"
}

log_warn() {
    printf "\033[33m[WARN]\033[0m %s\n" "$1"
}

log_error() {
    printf "\033[31m[ERROR]\033[0m %s\n" "$1"
}
