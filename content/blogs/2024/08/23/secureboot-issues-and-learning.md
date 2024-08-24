+++
title = 'SecureBoot issues and learning'
date = 2024-08-23T20:50:00-04:00
draft = false
+++

## SecureBoot Advanced Targeting or SBAT for short, new to me thanks to Microsoft Windows update

I have not heard of this technology before this week and it is very important to me going down a SecureBoot rabbit hole.

I like to have SecureBoot enabled and I think it is better to have an extra layer of protection than to not have it. [Ventoy](https://github.com/ventoy/Ventoy/releases/) and [Universal Blue Project](https://universal-blue.org/) OSes, such as [Aurora](https://getaurora.dev/), make enrolling a Machine Owner Key (MOK) a breeze.

Normally I don't have issues after I enroll the MOKs and I tend to only have Linux installed on my machines. This changed when I was having issues with EA app games, such as Star Wars Battlefront II and Titanfall 2, on SteamOS and Bazzite, which utilizes Proton to interpret the Windows code. I could only get the EA app to finish installing and launch when using the flatpak version of Steam on Aurora and even then it could break at any update. If I tried installing either game on SteamOS, the EA app would bring up the installer, configure it and then stop; repeat if I tried to launch the game again.

This leads me to thinking of dual booting Windows 11 and Aurora on my IdeaPad. I read that it is possible and there is a [Bazzite guide](https://universal-blue.discourse.group/t/dual-boot-preliminary-setup-and-post-setup-guide/2743), which is what I used for Aurora. I wiped the partition information before I installed Windows 11. I downloaded the official [Windows 11 ISO](https://www.microsoft.com/software-download/windows11) from Microsoft and put it on a Ventoy USB boot drive.

During the Windows install, I clicked custom install and then the new partition button. I used a calculator to use 2/3rds of the usable drive size. I finished the install and rebooted into Windows.

After boot Windows, applying updates and getting the machine set the way I liked it, I also saw there was a BIOS update for the system. Unfortunately, I can only apply BIOS updates in Windows for this IdeaPad, so I have to either do it in the installed Windows or use [Hiren's BootCD PE](https://www.hirensbootcd.org/). The update went through without issues.

When I tried to boot Aurora again via Ventoy, I was greeted with an [error message about SBAT and "Something has gone seriously wrong."](https://arstechnica.com/security/2024/08/a-patch-microsoft-spent-2-years-preparing-is-making-a-mess-for-some-linux-users/) I thought it had to do with the BIOS update and that it wiped my MOKs, but after doing a lot of testing, it turns out it was just because a Windows update that was applied; the system was not dual booting at the time of the update, so it was applied. I ended up temporary disabled SecureBoot, booted Ventoy and then Aurora installer and began the Linux install.

```
Manual Partitioning Scheme:

mount point: /boot/efi  
format:      EFI system partition
size:        300MB  

mount point: /boot
format:      ext4
size:        1GB

mount point:
format: btrfs
Encryption: checked
Encryption Type: LUKS2
size: [max]

mount point: /
format:      btrfs (subvolume)

mount point: /var
format:      btrfs (subvolume)

mount point: /var/home
format:      btrfs (subvolume)
```

This is the layout that I used, where the `/boot/efi` partition ended up starting as partition number 5.

The install finished and it rebooted into Windows. I checked the EFI boot menu and the new Aurora OS was not listed. Knowing that I can make an entry myself, I booted Ventoy again and this time I started a Linux Live CD.

At the live CD's desktop, I ran the `efibootmgr` command as root. I also used `fdisk -l` to see the partition numbers.

```
/dev/nvme0n1p5 1333604352 1334218751     614400   300M EFI System
```

To add the EFI entry, I used the command:

```
sudo efibootmgr -c -d /dev/nvme0n1 -p 5 -l "\EFI\fedora\shimx64.efi" -L "aurora"
```

Except instead of `shimx64.efi`, I read about efi entries and I had deduced I need to use `grubx64.efi`.

> Only use `shimx64.efi`, as that is what kicks off the signing chain.

I rebooted and GRUB did load Aurora. Since Windows did not show up in the GRUB list I use the command:

```
ujust regenerate-grub
```

At that point, I rebooted into UEFI settings and turned SecureBoot back on. Rebooting and it immediately booted into Windows; again, this happened, because grubx64.efi is not signed properly to boot directly and SecureBoot ignores it.

> I don't know why Aurora did not add the EFI boot entry, because it would have just worked if it had. I did install Windows 10 and Aurora on my System76 Galago Pro (galp2) and it had no issues making the entry.

## Enter mokutil

If you want to do all sorts of SecureBoot key checking, enrolling, deleting and changing verbosity, then `mokutil` is what you want.

```
mokutil --sb-state
```

> Displays if SecureBoot status (enabled/disabled) and can also display if it is in Setup mode

```
mokutil --list-enrolled
```

> Displays currently enrolled MOKs

This is what mine looks like after doing resets to SecureBoot a few times, changing from factory to Setup and back to factory.

> 2bb010e24d fedoraca
> 
> 54f41874f4 grub
> 
> 2be991e3b1 ublue kernel

### What happens normally

When you install Bluefin, Aurora or Bazzite, it will automatically boot `/EFI/fedora/mmx64.efi` on first boot, which is a program called MOK manager. It is a basic text-based interface with a blue background. When it comes up, you can enroll the ublue MOK by clicking the `enroll key` button and use the password `universalblue`.

With the MOK enrolled, SecureBoot can remain enabled and in Standard mode to allow Bluefin, Aurora or Bazzite's grub to boot. I highly recommend enrolling the MOK and keeping SecureBoot enabled.

### What happened because I used grubx64.efi

It did not boot MOK manager. I had also wiped the MOK by doing the SecureBoot factory setting, so no MOKs were enrolled. I tried to manually enroll the key again by using the command

```
ujust enroll-secure-boot-key
```

which should should also bring up MOK manager on reboot, but it didn't. I though it had to do with the BIOS update and I was confused.

I did find out that I could create an EFI boot entry for MOK manager, so I tried that. When the key was pending enrollment, it looked like it would normally; when it finished, the key was still not enrolled and it wasn't listed with `mokutil --list-new` either.

I think enrollment was messed up because I was not booting through the shimx64.efi. The reason I say that is when I finally tried booting Ventoy again, Ventoy's MOK enrollment kicked off. Resetting SecureBoot must have cleared the SBAT policy and allowed Ventoy to boot once more.

Keeping SecureBoot enabled and now being able to boot Ventoy, I choose to boot a local file on the Ventoy boot menu; the file I booted was `/EFI/fedora/shimx64.efi`. Aurora booted back up and then fixed it's EFI boot entry by deleting the old one and creating a new one that pointed to the correct file. I ran the `ujust enroll-secure-boot-key` one more time.

Booted back into MOK manager and tried the enrollment one more time. It finally enrolled ublue's MOK.

The system is now in a state where I can boot Ventoy, Aurora and Windows with SecureBoot enabled.

## Things to take away

* Leave SecureBoot in Standard mode, it shouldn't be required to change to Setup mode to enroll a MOK.
* MOKs can be enrolled with SecureBoot disabled.
* `efibootmgr` is great for listing and modifying EFI entries.
* `mokutil` has the ability to list SecureBoot status, enrolled or pending enrollment MOKs, turn SecureBoot on/off and even change verbosity when booting code with a MOK.
* `mokutil` can also set SBAT policies.

Don't be afraid of SecureBoot. It might have bugs, but it is still really useful. Knowing how UEFI booting works is also a skill in itself. If it hadn't been for the Windows update applying SBAT policies, I wouldn't have learned all these fun new skills.

Take care everyone and thanks for reading.
