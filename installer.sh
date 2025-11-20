#!/usr/bin/env bash
# Author: wxnacy(wxnacy@gmail.com)
# Description:

basic_needs=(git zsh)
missing=()

for need in "${basic_needs[@]}"; do
    if ! command -v "${need}" >/dev/null 2>&1; then
        missing+=("${need}")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo "缺少以下必要软件: ${missing[*]}"
    system=$(uname -s)
    if [ -f /etc/os-release ]; then
        . /etc/os-release
    fi
    case "${system}" in
        Darwin)
            echo "macOS 安装命令: brew install ${missing[*]}"
            ;;
        Linux)
            case "${ID:-}" in
                ubuntu|debian)
                    echo "Ubuntu/Debian 安装命令: sudo apt update && sudo apt install -y ${missing[*]}"
                    ;;
                centos|rhel)
                    echo "CentOS/RHEL 安装命令: sudo yum install -y ${missing[*]}"
                    ;;
                fedora)
                    echo "Fedora 安装命令: sudo dnf install -y ${missing[*]}"
                    ;;
                arch|manjaro)
                    echo "Arch/Manjaro 安装命令: sudo pacman -S --needed ${missing[*]}"
                    ;;
                opensuse-leap|opensuse-tumbleweed|sles)
                    echo "openSUSE/SLES 安装命令: sudo zypper install -y ${missing[*]}"
                    ;;
                *)
                    echo "通用 Linux 安装命令: 使用发行版的软件包管理器安装 ${missing[*]}"
                    ;;
            esac
            ;;
        *)
            echo "请使用系统的软件包管理器安装: ${missing[*]}"
            ;;
    esac
    exit 1
fi

CUR_DIR=$(pwd)
W_HOME=$HOME/.local/share/wzsh
W_GIT=$W_HOME/wzsh.git
command mkdir -p "$W_HOME" && command chmod g-rwX "$W_HOME"
test -d "$W_GIT" || git clone --recursive --depth=1 https://github.com/wxnacy/wzsh "${W_GIT}"
cd $W_GIT
make install
cd $CUR_DIR

