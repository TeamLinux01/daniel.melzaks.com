+++
title = 'uCore Server Setup'
date = 2024-07-21T17:00:05-04:00
draft = false
+++

# My uCore home server setup

So I don't forget how to do this in the future, I am putting it in this guide. I do want to switch to quadlets instead of podman-compose systemd.

## My [butane](https://coreos.github.io/butane/) setup for uCore

`ucore-autorebase.butane` #Redacted password hash for security
```file
variant: fcos
version: 1.5.0
passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWZwOOpn6R4YUVemenq+HMrFHYKgwmJr5aLyUviyCwk
      password_hash: **redacted**
boot_device:
  mirror:
    devices:
      - /dev/sda
      - /dev/sdb
storage:
  disks:
    - device: /dev/sda
      partitions:
        - label: root-1
          size_mib: 10240
        - label: var-1
    - device: /dev/sdb
      partitions:
        - label: root-2
          size_mib: 10240
        - label: var-2
  raid:
    - name: md-var
      level: raid1
      devices:
        - /dev/disk/by-partlabel/var-1
        - /dev/disk/by-partlabel/var-2
  filesystems:
    - device: /dev/md/md-var
      path: /var
      format: btrfs
      wipe_filesystem: true
      with_mount_unit: true
  directories:
    - path: /etc/ucore-autorebase
      mode: 0754
    - path: /var/home/core/.config/systemd/user/sockets.target.wants
      user:
        name: core
      group:
        name: core
  links:
    - path: /var/home/core/.config/systemd/user/sockets.target.wants/podman.socket
      user:
        name: core
      group:
        name: core
      target: /usr/lib/systemd/user/podman.socket
  files:
    - path: /etc/sysctl.d/net.conf
      contents:
        inline: net.ipv4.ip_unprivileged_port_start=80
    - path: /etc/systemd/user/podman-compose@.service
      contents:
        source: http://workstation/podman-compose@.service
        verification:
          hash: sha256-f9d86c2f64c71315728640e7721c62fb3457ad685177e140912f293f13899c88
    - path: /etc/modules-load.d/zfs.conf
      contents:
        inline: zfs
systemd:
  units:
    - name: ucore-unsigned-autorebase.service
      enabled: true
      contents: |
        [Unit]
        Description=uCore autorebase to unsigned OCI and reboot
        ConditionPathExists=!/etc/ucore-autorebase/unverified
        ConditionPathExists=!/etc/ucore-autorebase/signed
        After=network-online.target
        Wants=network-online.target
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        ExecStart=/usr/bin/rpm-ostree rebase --bypass-driver ostree-unverified-registry:ghcr.io/ublue-os/ucore-hci:stable-zfs
        ExecStart=/usr/bin/touch /etc/ucore-autorebase/unverified
        ExecStart=/usr/bin/systemctl disable ucore-unsigned-autorebase.service
        ExecStart=/usr/bin/systemctl reboot
        [Install]
        WantedBy=multi-user.target
    - name: ucore-signed-autorebase.service
      enabled: true
      contents: |
        [Unit]
        Description=uCore autorebase to signed OCI and reboot
        ConditionPathExists=/etc/ucore-autorebase/unverified
        ConditionPathExists=!/etc/ucore-autorebase/verified
        After=network-online.target
        Wants=network-online.target
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        ExecStart=/usr/bin/rpm-ostree rebase --bypass-driver ostree-image-signed:docker://ghcr.io/ublue-os/ucore-hci:stable-zfs
        ExecStart=/usr/bin/touch /etc/ucore-autorebase/signed
        ExecStart=/usr/bin/systemctl disable ucore-signed-autorebase.service
        ExecStart=/usr/bin/systemctl reboot
        [Install]
        WantedBy=multi-user.target
    - name: post-setup.service
      enabled: true
      contents: |
        [Unit]
        Description=uCore install software to overlay and reboot
        ConditionPathExists=/etc/ucore-autorebase/unverified
        ConditionPathExists=/etc/ucore-autorebase/signed
        ConditionPathExists=!/etc/ucore-autorebase/setup
        After=network-online.target
        Wants=network-online.target
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        ExecStart=/usr/bin/chown core:core -R /var/home/core
        ExecStart=/usr/bin/loginctl enable-linger core
        ExecStart=/usr/bin/firewall-cmd --permanent --add-service=http --add-service=https --add-service=http3
        ExecStart=/usr/bin/rpm-ostree install buildah
        ExecStart=/usr/bin/systemctl enable cockpit.service podman.service podman.socket
        ExecStart=/usr/bin/touch /etc/ucore-autorebase/setup
        ExecStart=/usr/bin/systemctl disable post-setup.service
        ExecStart=/usr/bin/systemctl reboot
        [Install]
        WantedBy=multi-user.target
```

```podman-compose@.service```
```file
# /etc/systemd/user/podman-compose@.service

[Unit]
Description=%i rootless pod (podman-compose)

[Service]
Type=simple
EnvironmentFile=%h/.config/containers/compose/projects/%i.env
ExecStartPre=-/usr/bin/podman-compose --in-pod pod_%i up --no-start
ExecStartPre=/usr/bin/podman pod start pod_%i
ExecStart=/usr/bin/podman-compose wait
ExecStop=/usr/bin/podman pod stop pod_%i
ExecStopPost=/usr/bin/podman pod rm pod_%i

[Install]
WantedBy=default.target

```

## Install brew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
brew install bat borgbackup bottom dua-cli dysk fastfetch fd fish fzf ncdu neovim smartmontools tldr tree
```

## Automatic updates

```bash
sudo nvim /etc/rpm-ostreed.conf
```

`/etc/rpm-ostreed.conf` #Change to this
```file
# By default, this system has its OS updates managed by
# `zincati.service`.  Changes made to this file may
# conflict with the configuation of `zincati.service`.
# See https://github.com/coreos/zincati for additional
# information.

# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# For option meanings, see rpm-ostreed.conf(5).

[Daemon]
AutomaticUpdatePolicy=apply
#IdleExitTimeout=60
#LockLayering=false
```

```bash
sudo cp /usr/lib/systemd/system/rpm-ostreed-automitic.timer /etc/systemd/system/rpm-ostreed-automatic.timer
sudo nvim /etc/systemd/system/rpm-ostreed-automatic.timer
```

`/etc/ssh/sshd_config` #Change to this
```file
[Unit]
Description=rpm-ostree Automatic Update Trigger
Documentation=man:rpm-ostree(1) man:rpm-ostreed.conf(5)
ConditionPathExists=/run/ostree-booted

[Timer]
# OnBootSec=1h
# OnUnitInactiveSec=1d
OnCalendar=Sun *-*-* 04:00:00

[Install]
WantedBy=timers.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now rpm-ostreed-automatic.timer
```

## Configure sshd

```bash
sudo nvim /etc/ssh/sshd_config
```

`/etc/ssh/sshd_config` #Change these lines
```file
PubkeyAuthentication yes

PasswordAuthentication no
PermitEmptyPasswords no

PermitUserEnvironment yes
```

## ZFS Setup

### Initialize the disks:

> ⚠️ If a disk needs to be reset use `sudo wipefs -a --no-act /dev/sdX`, which will preform a dry-run. Remove `--no-act` to execute the command.

```bash
sudo gdisk /dev/sdc
gdisk>o #Create a new GPT partition table on the disk
gdisk>w #Write new data to the disk and close gdisk

sudo gdisk /dev/sdd
gdisk>o
gdisk>w
```

### To create my 16TB mirror:

```bash
sudo zpool create -oashift=12 -Oxattr=sa -Ocompression=zstd -Oatime=off -Orecordsize=64K -m/var/lina lina mirror /dev/sdc /dev/sdd #ahisft=12 (4k sectors), xattr=sa (Sets Linux eXtended ATTRibutes directly in the inodes), atime=off (I don't care when things are opened), recordsize=64K (Default to smaller recordsize for the base dataset in case of VMs)
```

Using some of the suggestions from [ZFS tuning cheat sheet](https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/)

### To create my library dataset:

```bash
sudo zfs create -orecordsize=1M lina/library #1M record size for larger files
```

### Snapshot the old library:

```bash
sudo zfs snapshot library/shows@migrate
```

### Send and Receive the dataset to dataset:

```bash
sudo sh -c 'zfs send -vR library/shows@migrate | zfs recv -d lina/library' #Send the snapshot of library/shows@migrate and create a new dataset of lina/library/shows with all the previous snapshots up to and including @migrate
```

## Backups from other machines

### Setting up ssh

Copy the ssh public key for the backup user into `~/.ssh/authorized_keys`.

#### Create an ssh enviroment file to use brew:

```bash
echo 'PATH=/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/var/home/core/.local/bin:/var/home/core/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin' > ~/.ssh/environment
chmod 600 ~/.ssh/environment
```

## TMUX setup on server

`~/.tmux.conf`
```file
set-option -g default-shell "/home/linuxbrew/.linuxbrew/bin/fish"
set -g mouse on

setw -g mode-keys vi
```
