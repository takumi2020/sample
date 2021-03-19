#!/bin/bash

#スクリーンセーバーを動作させるためのコード
open_screen_saver () {
    open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/

}

#Thunderboltが接続されているか確認する(Thunderboltなら全て反応してしまう)
get_status () {
    if [ `system_profiler SPThunderboltDataType | grep "Macintosh:"` ]; then
        status="connected"
    else
        status="disconnected"
    fi
    echo $status
}

#Target Display Modeを開始する。
#command + F2を押す動作をosascriptにより実現
start_target_display_mode (){
    echo "Start target display mode..."
    osascript -e 'tell application "System Events" to key code 144 using command down'
}

#init
echo "Start auto Target Display Mode..."
open_screen_saver;

#working
#Thunderboltが接続されているかステータスを確認する
while :
do
    preStatus=$status
    echo $preStatus
    status=`get_status`
    if [ "$preStatus" != "connected" ] && [ "$status" = "connected" ]; then
        start_target_display_mode;
    elif [ "$preStatus" = "connected" ] && [ "$status" = "disconnected" ]; then
        open_screen_saver;
    fi
    sleep 1
done
