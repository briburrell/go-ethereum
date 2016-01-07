#!/bin/bash

dir=`dirname $0`
source $dir/../../cmd/swarm/test.sh

long=/tmp/10M
randomfile 10000 > $long
ls -l $long

swarm init 2
sleep $wait
swarm up 00 $long |tail -n1 > key &
sleep $wait
swarm attach 01 -exec "'bzz.blockNetworkRead(true)'"
sleep $wait
swarm attach 01 -exec "'bzz.blockNetworkRead(false)'"
sleep $wait
swarm attach 01 -exec "'bzz.blockNetworkRead(true)'"
sleep $wait
swarm stop 01

swarm start 01
swarm needs 01 key $long

swarm stop all