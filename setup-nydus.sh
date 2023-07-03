#!/bin/bash

cd /tmp && git clone https://github.com/containerd/nydus-snapshotter.git
cd nydus-snapshotter && make && mv bin/containerd-nydus-grpc /usr/bin/containerd-nydus-grpc
cd /tmp
rm -rf nydus-snapshotter
NYDUS_VER=v$(curl -s "https://api.github.com/repos/dragonflyoss/image-service/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
wget https://github.com/dragonflyoss/image-service/releases/download/$NYDUS_VER/nydus-static-$NYDUS_VER-linux-amd64.tgz
tar xzvf nydus-static-$NYDUS_VER-linux-amd64.tgz
mv nydus-static/nydus-image nydus-static/nydusd nydus-static/nydusify /usr/bin/
rm -rf nydus-static nydus-static-$NYDUS_VER-linux-amd64.tgz

tee -a /etc/containerd/config.toml > /dev/null <<EOT
[proxy_plugins.nydus]
address = "/run/containerd-nydus/containerd-nydus-grpc.sock"
type = "snapshot"
EOT

systemctl restart containerd
