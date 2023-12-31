#!/bin/bash

cd /tmp && wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.20.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
echo 'go env -w GO111MODULE=on' >> /etc/profile
echo 'go env -w  GOPROXY=https://goproxy.cn,direct' >> /etc/profile
