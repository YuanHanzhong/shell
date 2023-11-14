#!/bin/bash

MAXWELL_HOME=/opt/module/maxwell

status_maxwell(){
    ps -ef | grep com.zendesk.maxwell.Maxwell | grep -v grep | wc -l
}


start_maxwell(){
    cnt=$(status_maxwell)
    if [ $cnt -lt 1 ]; then
        echo "启动Maxwell.realtime"
        cd $MAXWELL_HOME
        bin/maxwell --config config.properties.realtime --daemon
    else
        echo "Maxwell正在运行"
    fi
}


stop_maxwell(){
    cnt=$(status_maxwell)
    if [ $cnt -gt 0 ]; then
        echo "停止Maxwell"
        ps -ef | grep com.zendesk.maxwell.Maxwell | grep -v grep | awk '{print $2}' | xargs kill
        sleep 7
    else
        echo "Maxwell未在运行"
    fi
}


case $1 in
    start )
        start_maxwell
    ;;
    stop )
        stop_maxwell
    ;;
    restart )
       stop_maxwell
       start_maxwell
    ;;   
    status )
       status_maxwell
    ;;
esac
