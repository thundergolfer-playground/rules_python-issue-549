#!/usr/bin/env bash

main() {
    local version
    local dest
    local op_sys
    local archictecture
    version="v1.7.4"
    dest="/usr/local/bin/bazel"

    op_sys="$(uname)"
    architecture=""
    case $(uname -m) in
        i386)   architecture="386" ;;
        i686)   architecture="386" ;;
        x86_64) architecture="amd64" ;;
        arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
    esac

    # NOTE: 'sudo' is required in Github Codespaces
    if [[ "${op_sys}" == "Darwin" && "${architecture}" == "amd64" ]]; then
        sudo wget "https://github.com/bazelbuild/bazelisk/releases/download/${version}/bazelisk-darwin-amd64" -O "${dest}"
    elif [[ "${op_sys}" == "Linux" && "${architecture}" == "amd64" ]]; then
        sudo wget "https://github.com/bazelbuild/bazelisk/releases/download/${version}/bazelisk-linux-amd64" -O "${dest}"
    else
        echo "Install script does not support OS '${op_sys}' and Architecture '${architecture}'."
        exit 1
    fi

    sudo chmod +x /usr/local/bin/bazel

    echo "Bazelisk installed as the 'bazel' binary to '${dest}'"
}

main
