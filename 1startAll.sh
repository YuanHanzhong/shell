#!/bin/bash
Hadoop.sh start 
ZooKeeper.sh start && Kafka.sh start 
Flume_102_103.sh start 
Flume_104.sh start 
Flume_104_kafka_to_hdfs_db.sh start 
Maxwell.delay.sh start 
Hive.sh start
