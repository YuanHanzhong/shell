#!/bin/bash
Hive.sh stop 
Flume_104_kafka_to_hdfs_db.sh stop 
Flume_102_103.sh stop 
Kafka.sh stop && ZooKeeper.sh stop 
Hadoop.sh stop 
Flume_104.sh stop 
Maxwell.delay.sh stop
