+++
title = 'Automatic updates on Fedora'
date = 2023-03-02T12:00:00-04:00
draft = false
+++

![Photo by seppe machielsen](/images/blogs/pexels-semac-14011035.jpg "Photo by seppe machielsen: https://www.pexels.com/photo/glow-in-the-dark-keyboard-14011035/")

I really like [Fedora](https://spins.fedoraproject.org/kde) as an Operating System, especially the [Plasma Desktop Environment](https://kde.org/plasma-desktop) version. I also like to set and forget things; one of those things is updates.

When I started using Fedora again in 2022, I noticed that there was a way to set "Update software: Automatically" through System Settings under System Administration > Software Update. I was enjoying [Pop!_OS](https://pop.system76.com)'s automatic software updates, so I wanted it on Fedora as well. Turns out this setting does nothing for me.

I moved on to the next way to do automatic updates that I knew would work, dnf-automatic. I use it on my servers, so why not on the desktop as well.

Install dnf automatic with the following command:

`sudo dnf install dnf-automatic`

----

Modify the dnf automatic config file with the following command:

`sudo nano /etc/dnf/automatic.conf`

Change these lines under `[commands]` in the file:

```
download_updates = true
apply_updates = true
```

add this line under `[commands]` in the file:

```
reboot = never
```

----

Setup the systemd unit to download, install and report updates with the following command:

`sudo systemctl enable --now dnf-automatic.timer`

Check the enablement of the unit with the following command:

`sudo systemctl status dnf-automatic.timer`

After I set this up on my laptop and desktop, when Discover Software Center displayed some updates, I waited a couple hours instead of updating. I refreshed the updates later and it showed that there was none to apply, so mission accomplished.

Thanks for reading and if this helps any, I am glad. God bless.
