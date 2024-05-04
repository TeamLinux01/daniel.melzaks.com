+++
title = 'Horizon on Deck'
date = 2023-10-07T12:00:00-04:00
draft = false
+++

# Horizon on Deck

First off, thank you HorizonXI team for setting all of this up so people can relive some of the best days of Final Fantasy XI. It is also great with how easy it is to get started. Appreciate the hard work.

## Working on a new way to install

[It's a script on Github](https://github.com/TeamLinux01/HorizonXI-on-Deck)

> 🛑 The more "official" way to install HorizonXI would be to use this script, so please use the link to setup the game.
>
>https://github.com/trentondyck/horizon_scripts
>
>This was recommend via the Discord Steam Deck Thread for HorizonXI.
>
>Please check out this guide as well.
>
>https://github.com/MattyGWS/HorizonXI-Linux-Installation
>
>Consider the following my own personal setup and learning.

## Create the account

When you are ready to begin, go ahead and register an account on HorizonXI. They will E-Mail you an activation link and when you are finished verifying the account, you can create your character or characters on the website. On the account page, click the create character button and fill out the character's name, race, etc... you can make up to 3 characters.

This game is all about playing with others, so no dual boxing or botting and the server has been designed to remove a lot of Quality of Life things that were introduced later in FFXI lifetime, such as Home Point teleporting, easy experience point gaining or level syncing.

[![](https://markdown-videos-api.jorgenkh.no/youtube/uM0T9fIVgEc)](https://youtu.be/uM0T9fIVgEc)

## Download the launcher

Things have changed a little bit since I wrote this guide and the `.nupkg` is not directly downloadable any longer. So now it requires to extract the `.nupkg` from the `.exe` and then extract all the files from it.

I started a script that creates the folders, downloads the `.exe`, extracts all the files to where they need to be and then removes the extra unneeded files.

Save the file [horizon-setup.sh](https://github.com/TeamLinux01/HorizonXI-on-Deck/raw/main/horizonxi-setup.sh) to the machine and execute it. If you don't run it in the terminal, you won't see any progress but it should still be doing each line in the script.

Take a look at the script before launching, just to make sure it isn't doing anything it isn't suppose to be doing or if you want to learn how it works. The Github view of the file is at https://github.com/TeamLinux01/HorizonXI-on-Deck/blob/main/horizonxi-setup.sh

By the end of the execution of the script, there should be a new folder at `~/Games` with `Launcher` and `Prefix` inside of it. The Launcher folder has the launcher exe that Steam will run and the `Prefix` folder will be where the Windows files and the game will be stored.

If you do not have `GE-Proton7-42` go ahead and get [ProtonUp-Qt](https://flathub.org/apps/net.davidotek.pupgui2) from the Discover store, close Steam and launch `ProtonUp-Qt`. Search for `GE-Proton7-42` and install it. After it is all done, launching Steam again will allow this version of Proton to be use for games.

In the Steam interface, click the `Add non-steam game` button, find `/home/deck/Games/HorizonXI/Launcher/HorizonXI-Launcher`.exe or the path you extracted it and add it to Steam. Now change the properties of `HorizonXI-Launcher.exe` Steam game link, I renamed it to just `HorizonXI`, set the **LAUNCH OPTIONS** to

`STEAM_COMPAT_DATA_PATH=/home/deck/Games/HorizonXI/Prefix/ %command%`

>🛑 If installing on another Linux OS and username, change /home/deck/ to /home/*username*/, such as /home/daniel/.

This will tell steam to use this folder instead of the numbered folder in the compdata and set the proton version to `GE-Proton7-42`. I originally tried `GE-Proton8-16`, but it would not pass the login information from the launcher to the ashita-cli.exe program and other issues.

>💡 It seems newer versions of GE Proton have started to work with the game, starting with `GE-Proton8-25` and `Proton-9.0`. If the you have issues with the latest version, stick with `GE-Proton7-42`. Although I have heard that there is a memory leak in versions other that `GE-Proton7-42`, which will cause the game to crash after a while.

To update the launcher, run the setup script again, although the version number has to be updated in the script before launching or it will get the same version. I will try to keep the version as up to date as possible.

>⚠️ If for any reason the download gets interrupted or corrupt, the launcher might try to install and fail after about two seconds. I recommend deleting the download folder and trying again.
>
>It should be located at `/home/deck/Games/HorizonXI/Prefix/pfx/drive_c/Program Files (x86)/HorizonXI/Downloads/`. You might have to close the launcher and start again.
>
>If that doesn't work, close the launcher and try deleting the files in `/home/deck/Games/HorizonXI/Prefix/`, just don't remove the `Prefix` folder itself. Steam should automatically recreate the prefix just like it does on the first time you launched the app.

## Time to launch

It is time to hit the `Play` button on Steam. The launcher should come up and play its music. I recommend turning the launcher music all the way down to 0, as I had an issue of it continuing to play its music after launching the game.

>🛑 I recently installed launcher 1.2.4 on the OLED Steam Deck with SteamOS 3.5.5. I had an issue with the virtual Steam keyboard popping up under the launcher in desktop mode, so I had to set the resolution settings and login information via Game mode.

Go ahead and change what plugins and add-ons you want to use, go to the `Gear icon`, General to set the Window Resolution to `1280x800` and set Window Mode to `Fullscreen` or `Windowed Fullscreen`. Under `Graphics`, have the Menu Resolution set to `1280x800`. I also turn on `Graphics Stabilization`, `Bump Mapping`, `Maintain Aspect Ratio` and turn off `Map Compression` and `3D LCD Mode`. `Environment` = `Smooth`, `Textures` = `High`, `Fonts` = `High` and `Mip Mapping` = `High`.

>🛑 Definitely make sure the Window Resolution and Menu Resolution at set to `1280x800`, if they are set to `1920x1080` for both or either, the game may silently crash to a black screen when launched or the menus will not fit correctly on screen.

 Time to go back to home in the launcher and hit the `Install` button. When it asks where it should should install the game, I choose `C:\Program Files (x86)\` although others suggest using `C:\Program Files\`. It will take a while to download all the required files and then install the game.

One last thing to take care of before playing the game, setting up the controller. Go to the `Gear icon` in the launcher, under `General` there will be an `Open Gamepad Config` button, click it. The settings I recommend are:

```
[X] Enable Gamepad
[X] Enable force feedback
[X] Enable XInput
[ ] Enable gamepad when game is inactive
Click the XInput (F) button under Predefined Setups
```
At this point, you can close the launcher and log back into Game mode.

## Playing in Game mode

The last thing you want to do is set Steam Input for the controller. I found a nice layout called "HorizonXI" by Casuallynoted and added mouse clicking via clicking on the right touch-pad. If you want my modified layout, it is "HorizonXI" by TeamLinux01.

Enter your login information in the launcher that you created when you made the account and hit the `Play HorizonXI` button once to begin your adventures.

>🛑 I have had some problems with launching to a black screen/silent crashing on first install. After making sure the settings are correct, I tried launching the game from Steam in the desktop mode. It usually launches in that, so I will exit and go back to Game mode. I don't have issues in Game mode after that.

The launcher seems to be made in electron and does not have protection against multiple clicking of the `Play HorizonXI` button, so it will launch the game multiple times if you click it multiple times. It can also be resized to be smaller in Game mode, which can make it so you can't see the buttons any longer; just close the launcher and restart it. This is just a heads up.

## Backing up the settings using Ludusavi

To backup settings for the game, I recommend using [Ludusavi](https://github.com/mtkennerly/ludusavi), which can be installed via the Discover store. It requires adding `CUSTOM GAMES` to be able to backup, so click on that top button in the app and then `Add game`. Put `HorizonXI` as the name and add these 3 Paths:

```
/home/deck/Games/HorizonXI/Prefix/pfx/drive_c/Program Files (x86)/HorizonXI/Game/config

/home/deck/Games/HorizonXI/Prefix/pfx/drive_c/Program Files (x86)/HorizonXI/Game/scripts

/home/deck/Games/HorizonXI/Prefix/pfx/drive_c/Program Files (x86)/HorizonXI/Game/SquareEnix/FINAL FANTASY XI/USER
```

>🛑 Don't forget to change deck to *username* if you are not on the Steam Deck and `Program Files (x86)` to the location that you selected during install if you chose another path.

Click `BACKUP MODE` and click the `Preview` button. It should list all Steam games, along with `HorizonXI`. Clicking the `Back up` button will backup all games displayed in the preview and the folder it will backup to is `~/ludusavi-backup` unless you change it. Restoring is easy as clicking `RESTORE MODE` and clicking `Preview`, when `HorizonXI` is displayed in the list, click the 3 dot button that is in line with the game and click on Restore from that menu.

>⚠️ If `HorizonXI` does not show up in `BACKUP MODE`, make sure the paths are correct first. It could be that the flatpak version of `ludusavi` needs extra permissions to access `~/Games/`. To change these settings, search for `Flatpak Permission Settings` under Application Launcher (the menu that pops up when clicking the SteamOS icon in the bottom-left in Desktop Mode). Find `ludusavi` under Flatpak Applications and click on it. Click `+ Add New` under Filesystem Access and add `~/Games/` in Enter filesystem path... and change the drop-down from `read-only` to `read/write`. Click OK, then Apply and close the settings.

## dgVoodoo2 is possible

Right now, I know that it requires using `GE-Proton7-42` and `dgVoodoo2.81.3`. I have had black screens and crashes with `GE-Proton8-XX` and `dgVoodoo2.82.X`.

http://dege.freeweb.hu/dgVoodoo2/bin/dgVoodoo2_81_3.zip

Extract the files in the `MS/x86` folder of the zip into `~/Games/HorizonXI/Prefix/pfx/drive_c/Program Files (x86)/HorizonXI/Game/bootloader/` along with this [dgVoodoo.conf](https://raw.githubusercontent.com/TeamLinux01/HorizonXI-dgVoodoo2/main/dgVoodoo.conf).

The Steam Launch Options are `STEAM_COMPAT_DATA_PATH=/home/deck/Games/HorizonXI/Prefix/ WINEDLLOVERRIDES="d3d8.dll,d3d9.dll,d3dimm.dll,ddraw.dll=n,b" %command%`

## See you there

My character name is Paugue and I like playing White Mage the most, but I think I will also level Thief. I had the same character officially back in the day and I leveled all jobs to level 99 on him. I do not want to do that grind, so I think my goal will be to focus on 75WHM and 75THF, with the important sub-jobs to 37.

If you have any suggestions or feedback, let me know via discord. Thanks for reading.