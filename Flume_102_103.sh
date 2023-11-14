#!/bin/bash
FLUME_HOME=/opt/module/flume
APP_HOME=/opt/module/applog
function f1_start(){
  for host in hadoop102 hadoop103
  do
    ssh $host "nohup $FLUME_HOME/bin/flume-ng agent -n a1 -c $FLUME_HOME/conf -f $APP_HOME/file-flume-kafka.conf -Dflume.root.logger=INFO,console 1>/opt/module/flume/f1.log 2>&1 &"
  done
}

function f1_stop(){
  for host in hadoop102 hadoop103
  do
    ssh $host "ps -ef | grep file-flume-kafka | grep -v grep | awk '{print \$2}' | xargs -n1 kill"
  done
}

function f1_status(){
  for host in hadoop102 hadoop103
  do
    echo "==========  $host  ==========="
    ssh $host "[ \$(ps -ef | grep file-flume-kafka | grep -v grep |wc -l) -eq 1 ] && echo ok || echo error"
  done
}

case $1 in
"start")
  f1_start
  ;;
"stop")
  f1_stop
  ;;
"status")
  f1_status
  ;;
"restart")
  f1_stop
  sleep 5
  f1_start
  ;;
*)
  echo "Usage: f1.sh start|stop|status|restart"
  ;;
esac
