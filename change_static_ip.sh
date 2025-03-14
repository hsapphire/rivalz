#!/bin/bash

# 配置静态 IP 地址
STATIC_IP="192.168.239.128"  # 修改为你的静态 IP
GATEWAY="192.168.239.1"      # 修改为你的网关
DNS="8.8.8.8,8.8.4.4"      # Google DNS，可根据需要更改
INTERFACE="ens33"          # 你的网络接口，使用 `ip a` 检查

# 备份原配置
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak

# 写入新的 Netplan 配置
echo "network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      addresses:
        - $STATIC_IP/24
      gateway4: $GATEWAY
      nameservers:
        addresses: [$DNS]
      dhcp4: no" | sudo tee /etc/netplan/50-cloud-init.yaml

# 应用网络配置
sudo netplan apply

echo "静态 IP 设置完成，当前 IP 配置如下："
ip a show $INTERFACE
