+++
title = 'Nobara SteamDeck Edition'
date = 2023-07-16T12:00:00-04:00
draft = false
+++

I have been playing around with the Nobara SteamDeck Edition on both my gaming PC and Steam Deck. If you want to check out Nobara yourself, download from [this link](https://nobaraproject.org/download-nobara); please read the [changelog](https://nobaraproject.org/category/changelog) and [troubleshooting](https://nobaraproject.org/docs/upgrade-troubleshooting). I personally use [Ventoy](https://github.com/ventoy/Ventoy/releases) to setup a USB drive to boot the ISO install discs.

When it comes to gaming on a PC, I like the simplicity of a console interface and Steam's newer Big Picture Mode is where it is at for me. Nobara SteamDeck Edition boots directly into this interface, just like SteamOS, along with being able to switch to a full desktop environment using [KDE's Plasma](https://kde.org/plasma-desktop). Nobara is created by [heavily modifying Fedora](https://nobaraproject.org/docs/modification-details/details-on-the-listed-modifications) and adding a lot of useful things. This makes Nobara a great choice for running on general PCs in general and with the extra changes to the SteamDeck Edition, a great choice for people who don't want to wait for SteamOS for general PCs. It is not the easiest thing to use compared to SteamOS when it comes to updates and such, but if you are accustomed to Linux desktops as I am, it isn't a big deal.

## Running on a PC

**Intel i7 4790, AMD RX 580 8GB, 32GB RAM, 1TB SSD and 6TB HDD**

Since my PC has a newish AMD video card, I have not experienced any issue with Big Picture Mode when booting into what Nobara calls the "Steam Deck Mode" desktop session. If you do have an nVidia video card, please read [this information](https://nobaraproject.org/docs/nvidia-troubleshooting). A lot of people have issues with nVidia systems because nVidia does not provide open source drivers to be included in the system, along with the way the drivers are built to interact with some of [the technologies use to render the desktop](https://www.howtogeek.com/900698/what-is-wayland-on-linux-and-how-is-it-different-from-x). I personally want to stick with AMD for my GPUs and I am seriously considering them for my CPUs going forward as well.

To be more "compatible" with the Steam Deck configuration, I decided to install the system with a user name of "deck". If you want to encrypt the file-system at install, it works just as well as another Linux system using LUKS, as long as you have a physical keyboard to be able to type that password in on boot. The other setting to act like the Steam Deck is to set the swap to use "file" instead of using a partition. Back to user settings, I would leave the "autologin" setting when creating the user; if auto-login is not set, it will bring up the sddm login screen to select the session and user, asking for the user password. The sddm theme will break and fallback to the basic looking login screen after the first upgrade of packages. Autologin is a big recommendation from me.

After the system is installed, before messing with any Steam settings, switch to desktop. Applying updates, installing extra software and other maintenance helps a lot. After installing updates and installing codecs, I like to install Kdenlive, OBS Studio and Discord. I have also discovered that installing the "XONE" drivers is required for my [8bitdo Pro 2](https://www.8bitdo.com/pro2) controllers to function properly in Xinput mode. I skip building the firmware, since the control does not require it. Running Proton-GE, installing the latest Proton version from GloriousEggroll and setting it as the default compatibility for games is what I like to do next.

>⚠️ There is a bug in Plasma on Fedora/Nobara. The folder `~/.cache/thumbnails` is not created, which causes dolphin file browser to open then close. Just create the folder with the command `mkdir ~/.cache/thumbnails` to fix the crashing issue.

Running [CryoByte33's steam-deck-utilities](https://github.com/CryoByte33/steam-deck-utilities) runs into one issue. It does not know what the swap size is and does not set swappiness. Changing the swappiness can be done by adding the line `vm.swappiness=1` or whatever number you want to the file `/etc/sysctl.d/99-sysctl.conf`. The other settings will apply normally.

I did not run into any problems installing [EmuDeck](https://www.emudeck.com/#download). I did change my mount point of the 6TB to use the same path as putting an SD card into a Steam Deck, so it is mounted at `/run/media/mmcblk0p1`. It works exactly like it does on SteamOS.

>⚠️ Duckstation fails to use the vulkan render in Steam Deck Mode. This is the same issue on SteamOS. Switch the renderer to OpenGL mode.

I highly recommend installing [Ludusavi](https://flathub.org/apps/com.github.mtkennerly.ludusavi) from the Flatpaks section of the Nobara Package Manager. It is great for preventing the loss of game saves. Not only does it do a good job at finding game saves from Steam, Heroic Games Launcher, etc... I have setup custom games for backing up my PS1 and PS2 memory cards.

While I am in the desktop session, I also have to set the proper audio output. I have a monitor plugged into HDMI and another into DisplayPort. The system likes to use the DisplayPort for both the primary display and audio. I set the HDMI monitor to be the primary display, change the orientation to 90° Counterclockwise for the DisplayPort monitor and audio to the HDMI (HDMI 4).

Finally, I set Steam to use the Library on the 6TB HDD as default, as it is where I store all my Steam games. I thought Steam would put the compatdata folder in the user's home folder when `-steamdeck` is used to launch Steam, but I am unsure if that is correct. Sometimes the game would still put it on the HDD when the game is installed, so I have made symbolic links from the home folder to the HDD using the command `ln -s /home/deck/.local/share/Steam/steamapps/compatdata /run/media/mmcblk0p1/SteamLibrary/steamapps/compatdata`.

**UPDATE 2023-07-18:** I am also trying the same thing with the shadercache folder as the compatdata. The command is `ln -s /home/deck/.local/share/Steam/steamapps/shadercache /run/media/mmcblk0p1/SteamLibrary/steamapps/shadercache`.

----

Back into Steam Deck Mode, I double check the audio settings, test my controller inputs and apply steam updates. At this point, it is just like it would be on SteamOS.

>🔄 In order to apply updates to the OS and software, switching to desktop is required. It is best to switch to desktop and check for updates using the "Update System" shortcut in the menu every few days.

## Running on the Steam Deck

**512GB NVMe version**

>⚠️ I would only recommend doing this if you are a tinkerer and know a lot about Linux. SteamOS is easier to use and maintain on the Steam Deck. If you want to install Nobara SteamDeck Edition on a Steam Deck, you will need a physical keyboard. The Steam virtual keyboard requires to be logged into Steam, which you will not be in the installer and Maliit virtual keyboard for the Plasma desktop does not pop-up in the installer.

The reason I choose to install it on the Deck was that I like using the same OS for devices that do the same tasks. If Valve would have released SteamOS 3.X for general PCs, I would have tried that on my PC instead. I have dabbled with HoloISO and ChimeraOS on the PC, but the former had issues with updates and the latter uses Gnome for the Desktop Environment along with being designed to be strictly being a console OS. I still like using the PC for desktop functions.

>🛠️ The brightness control in Steam Deck Mode does not work. The default audio is also set to "echo-cancel-sink". Switch to desktop and set the brightness and change the volume. If you set the audio device to "speaker" in Steam Deck Mode, the volume controls will work as normal.
>
>**UPDATE 2023-07-18:** The brightness control in Steam Deck Mode works now as of [this update](https://nobaraproject.org/2023/07/17/july-17-2023).

After getting things setup and updated, there is not too big a difference between Nobara SteamDeck Edition and SteamOS when it comes to games. The big differences would be what you can do on the system. Nobara has a lot more customizing options as it is not an immutable OS, so installing software is a little easier with the package manager. It is also great for running software in desktop mode, since it is just a normal Linux installation. If you want to stream video to a discord channel, just boot into desktop mode, launch discord, launch the game and start streaming.

>🛠️ The power button defaults to "Shutdown" in Steam Deck Mode, when pressed. If you want to sleep, press the physical "Steam" button, go down to "Power" in the pop-up menu, then select "Sleep". This behavior could be a deal breaker for most people.
>
>**UPDATE 2023-07-22:** The power button now works as it should on the Deck in Steam Deck Mode. Tapping it sleeps the device and long press brings up the power menu. On other PCs, pressing the power button now does nothing in Steam Deck Mode.

GloriousEggroll has applied upstream patches to gamescope to fix the Remote Play crash when streaming from Steam Deck Mode on Nobara. Before the patch, a race condition would happen with the vulkan encoding and crash the host computer. I ran into the same issue when running ChimeraOS. I personally love Remote Play as the Deck does not have the storage space for all the games I would like to play, plus my PC can render at a higher framerate/resolution. Thank you GE for looking into this issue and getting that fixed.

----

I changed some file-system settings on both devices based on some information I found in [this project](https://gitlab.com/popsulfr/steamos-btrfs). I added the `discard=async` to be extra sure it is using trim on the SSD/NVMe drives.

`/etc/fstab` file contents:

```
UUID=####-#### /boot/efi vfat defaults,noatime,discard 0 2

UUID=########-####-####-####-############ /boot ext4 defaults,noatime,discard 0 2

UUID=########-####-####-####-############ / btrfs subvol=/@,compress=zstd:6,noatime,lazytime,space_cache=v2,autodefrag,ssd_spread,discard=async,x-systemd.device-timeout=0 0 0

UUID=########-####-####-####-############ /home btrfs subvol=/@home,compress=zstd:6,noatime,lazytime,space_cache=v2,autodefrag,ssd_spread,discard=async,x-systemd.device-timeout=0 0 0

UUID=########-####-####-####-############ /swap btrfs subvol=/@swap,defaults,noatime,discard=async 0 0

UUID=########-####-####-####-############ /run/media/mmcblk0p1 ext4 defaults,noatime,lazytime 0 0

/swap/swapfile swap swap defaults 0 0

tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
```

After the drives have been remounted, run the commands `btrfs filesystem defragment /` and `btrfs filesystem defragment /home` to re-compress all the files.

----

So far, this is my favorite gaming OS. Been enjoying it immensely and I hope it continues to get better. Check out the Nobara Discord via [this invite](https://discord.com/invite/6y3BdzC) to talk about the system.

I am not sure if I will even bother trying to use SteamOS for general PCs at this point, Nobara covers what I need. I would like to see more people try it out for their home theater and gaming PCs. Thank you for reading.
