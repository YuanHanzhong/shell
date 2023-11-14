#!/bin/bash

#即使处于安全模式也不会导致脚本执行失败
hdfs dfsadmin -safemode wait 


beeline -u jdbc:hive2://hadoop102:10000 -n atguigu --hiveconf hive.exec.mode.local.auto=true
