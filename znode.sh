#!/bin/bash

# 半闭当前所有的screen会话（除了第一个，假设第一个是会话列表的标题行）
SCREEN_NAME="znoderivalz"
screen -ls | awk 'NR>=2 {print $1}' |grep $SCREEN_NAME | while read session; do
    screen -S "$session" -X quit
    done

 # 启动或重启 znoderivalz screen 会话
screen -dmS $SCREEN_NAME bash -c 'rivalz run; exec bash'
