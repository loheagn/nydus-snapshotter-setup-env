#! /bin/bash

instance_name=nydus-dev

limactl start --name ${instance_name} vm.yaml

limactl shell ${instance_name} sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
limactl shell ${instance_name} sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
limactl shell ${instance_name} sudo bash -c 'apt-get update -y && apt-get install -y libbtrfs-dev libseccomp-dev sudo psmisc jq lsof net-tools vim neofetch git make wget build-essential'

limactl shell ${instance_name} git config --global user.email "loheagn@icloud.com"
limactl shell ${instance_name} git config --global user.name "Nan Li"
limactl shell ${instance_name} git config --global core.editor vim
limactl shell ${instance_name} git config --global pull.rebase true

limactl shell ${instance_name} mkdir -p /tmp/bin
limactl copy setup-nydus.sh ${instance_name}:/tmp/bin/setup-nydus.sh
limactl copy setup-go.sh ${instance_name}:/tmp/bin/setup-go.sh
limactl shell ${instance_name} sudo bash -c 'chmod +x /tmp/bin/* && cp /tmp/bin/* /usr/local/bin/'
limactl shell ${instance_name} sudo bash --login /usr/local/bin/setup-go.sh
limactl shell ${instance_name} sudo bash --login /usr/local/bin/setup-nydus.sh
