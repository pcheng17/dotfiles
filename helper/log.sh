#!/usr/bin/env bash

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
