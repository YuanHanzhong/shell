#!/bin/bash
Hadoop.sh start && 
ZooKeeper.sh start &&
Kafka.sh start &&
Flume_102_103.sh start &&
Flume_104.sh start &&
Maxwell.sh start
