+++
title = 'uCore and Butane'
date = 2024-05-14T14:00:00-04:00
draft = false
+++

# uCore with a custom partition scheme

Since I had issues find this information clearly, I thought I would share it here.

If you need to create a butane file to create an igntion file to use with uCore which has a swap partition here is an example snippit to do such a thing.

`ucore-autorebase.butane`:
```yaml
...
storage:
  disks:
    - device: /dev/disk/by-id/coreos-boot-disk
      wipe_table: true
      partitions:
        - number: 1
          label: BIOS-BOOT
          size_mib: 1
          type_guid: 21686148-6449-6E6F-744E-656564454649
        - number: 2
          label: EFI-SYSTEM
          size_mib: 127
          type_guid: c12a7328-f81f-11d2-ba4b-00a0c93ec93b
        - number: 3
          label: boot
          size_mib: 384
        - number: 4
          label: swap
          size_mib: 8192
          type_guid: 0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
        - number: 5
          label: root
          size_mib: 0
          resize: true
  filesystems:
    - device: /dev/disk/by-partlabel/BIOS-BOOT
      format: none
      wipe_filesystem: true
      label: BIOS-BOOT
    - device: /dev/disk/by-partlabel/EFI-SYSTEM
      format: vfat
      wipe_filesystem: true
      label: EFI-SYSTEM
    - device: /dev/disk/by-partlabel/boot
      format: ext4
      wipe_filesystem: true
      label: boot
    - device: /dev/disk/by-partlabel/swap
      format: swap
      wipe_filesystem: true
      with_mount_unit: true
      label: swap
    - device: /dev/disk/by-partlabel/root
      format: btrfs
      wipe_filesystem: true
      label: root
...
```

This will allow a 8GB swap on the same installation drive and the root will use the rest of the space.

A command to run to build the ignition file would look something like this:

```bash
podman run -ti --rm --security-opt label=disable -v ./:/pwd --workdir /pwd quay.io/coreos/butane:release --pretty --strict ucore-autorebase.butane > ucore.ign
```

I hope this helps anyone that is trying to do the same.