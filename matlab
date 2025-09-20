#!/bin/bash
# MATLAB wrapper script

# 修复 ~/.MathWorks 权限
mkdir -p "$HOME/.MathWorks"
chown "$USER":"$USER" "$HOME/.MathWorks"

# 禁止 GTK 加载 canberra 模块
export GTK_MODULES=""

# 如果有参数（文件路径），用 -r 命令在启动时打开
if [ $# -gt 0 ]; then
    files=""
    for f in "$@"; do
        # 转义单引号并加到 open 命令
        files="$files open('$f');"
    done
    LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/MATLAB/R2024a/bin/matlab -desktop -r "$files"
else
    LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/MATLAB/R2024a/bin/matlab -desktop
fi

