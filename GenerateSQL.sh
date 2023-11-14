#!/bin/bash
for i in hadoop102 hadoop103
do
  if [ $1 ]
  then
    echo "========== Creating log for $i =========="
    ssh $i "sed -i '/mock.date/d' /opt/module/applog/application.yml ; echo 'mock.date: \"$1\"' >> /opt/module/applog/application.yml"  # 分号很有必要，不能是空格
  fi
  ssh $i "cd /opt/module/applog; nohup java -jar gmall2020-mock-log-2021-10-10.jar 1>/dev/null 2>&1 &"
done



