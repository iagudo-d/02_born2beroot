#!/bin/bash

arch=$(uname -a)
pcpu=$(nproc --all)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
memT=$(cat /proc/meminfo | awk 'NR==1{print $2/1000}')
memF=$(cat /proc/meminfo | awk 'NR==2{print $2/1000}')
memU=$(awk "BEGIN {print $memT / $memF}")
dskT=$(df -h | grep /dev/mapper/iagudo-home | awk '{print $2}')
dskA=$(df -h | grep /dev/mapper/iagudo-home | awk '{print $4}')
dskU=$(df -h | grep /dev/mapper/iagudo-home | awk '{print $5}')
cpuU=$(top -bn |grep load | awk '{print $10}')
lstB=$(who | cut -d " " -f 1 | short -u | wc -l)
lvmP=$(lsblk | grep lvm | awk '{if ($1) {print"YES"; exit;} else {print "NO"}}')
tcpC=$(netstat | grep tcp | wc -l)
usrC=$(who | cut -d " " -f 1 | short -u | wc -l)
netI=$(hostname -I)
netH=$(ip -a | grep link/ether | awk '{print $2}')
sudI=$(cat /var/log/sudolog.log | wc -l)

wall -n "
# Architecture: $arch
# CPU Physical: $pcpu
# vCPU: $vcpu
# Memory Usage: $memF/$memT MB ($memU %)
# Disk Usage: $dskA/$dskT ($dskU)
# CPU Load: $cpuU
# Last Boot: $lstB
# LVM Use: $lvmP
# Connexions TPC: $tcpC
# Users Logged: $usrC
# Network IP: $netI  ($netH)
# Sudo: $sudI"


