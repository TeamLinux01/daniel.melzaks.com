+++
title = 'Intel X550-T2 2.5Gbps'
date = 2026-08-29T21:47:00-04:00
draft = false
+++

# How to advertise 2.5Gbps and 5Gbps on Linux for the Intel X550-T2 PCEi dual 10Gbps NIC

I have found that when I purchased and started using two X550-T2 NICs that we wired together and connected to the same 2.5Gbps switch, the had no problem linking at 10Gbps with each other, but would only negotiate at 1Gbps to the switch.

I discovered that they only advertise 1Gbps and 10Gbps links by default on Linux, so you have to run a command each time the system is started to get it to advertise 2.5Gbps and 5Gbps links as well.

The command is the following, where enpXs0fX is replaced with the network interface name you want to change:
```bash
ethtool -s enpXs0fX advertise 0x1800000001028
```
You would want to run the command for f0 and f1 if you need to change both interfaces.

## TrueNAS

If you go to `System` > `Advanced Settings` > `Init/Shutdown Scripts` and click the `Add` button, just select `Type` as `Command` and type the command in the `Command` textbox.
I chose `Pre Init` for `When` and it seems to load the change without issues.

## Systemd Unit

I created two files to fix the problem on Bazzite.

### intel_ethtool_fix.sh

Copy this file to `/usr/local/bin/` with the name `intel_ethtool_fix.sh`.

> Use whatever the interface name is for your computer, mine was enp9s0f0

```bash
#!/bin/bash
#This fixes the 2.5Gbps and 5Gbps advertisement for the Intel X550-T2 NIC
ethtool -s enp9s0f0 advertise 0x1800000001028
```

### intel_ethtool_fix.service

Copy this file to `/etc/systemd/system/` with the name `intel_ethtool_fix.service`

```bash
[Unit]
Desciption=Fix X550-T2 NIC
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/intel_ethtool_fix.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Then refresh the systemd daemon and enable the systemd unit with the command:
```bash
sudo systemctl daemon-reload && sudo systemctl enable --now intel_ethtool_fix.service
```
