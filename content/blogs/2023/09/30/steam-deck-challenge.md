+++
title = 'Steam Deck Challenge'
date = 2023-09-30T12:00:00-04:00
draft = false
+++

Let's see what the Deck can do for me. I have been using it as a handheld for a while now and my gaming PC for better performance. I was thinking about my setup and thought I could use the Steam Deck docked for my gaming PC needs and turn the tower PC into my server.

The gaming PC is an Intel i7 4790 CPU, AMD RX 580 8GB GPU, 32GB RAM and 1TB SSD. The PC is getting on the older side and it is funny to think that the Steam Deck has the same CPU performance as the i7 4790. Although the RX 580 is a lot more powerful compared to Steam Deck's GPU, it also uses 10x more power just for the video card.

I have been playing Satisfactory with a friend and we have been having a blast and it runs well on my tower PC. I don't have another PC powerful enough to run the dedicated server of Satisfactory and I would like the world to just run all the time so we can collect more resources while we aren't playing. So the idea of turning my tower PC into my main server and run the Satisfactory server, plus my other server software.

I can then make my current server into a backup server for redundancy of my data. It would be great for me to learn how to properly encrypt and ZFS send/receive to other servers. Win/win all around.

I rearanged my area and did some cable management while I was getting the Steam Deck to be my main gaming PC. The other "fun" thing I ran into again was my multiple HDMI switch/splitter setup and getting that to work properly with the Deck, PS3, PS4 and Nintendo Switch. Those four devices go to an HDMI switch that goes into a 2-HDMI splitter to remove HDCP signal. The 2-HDMI splitter goes to my 1080p monitor and a 4-HDMI splitter, which connects to the USB HDMI capture on the Alienware Alpha, the 4k TV in the living room and the 4k TV in the basement.

The Alienware Alpha is strictly a capture/streaming/recording PC and as such, I put Windows 10 back on it. The fact that it has an nVidia 860m makes running Linux/Wayland on it a huge problem and while X11 is decent, I personally want to move on from it.

After messing around with the cabling and such to get all the devices to display on all displays, it seems to be working well. So far, so good for the first day and I plan on Streaming some more on Youtube now that my setup is a little closer to what I want.

Looking forward to the future and when Valve releases either a higher powered Steam Machine console or SteamOS for general PCs, I might reconsider what to do with the Deck as the gaming PC. Until then, I plan to have some fun and play some games.

## A few days later...

**3rd day in**

3rd day in

I haven't done much gaming lately, but so far, so good. The first day, I spend most of the time getting my systems to all display using the HDMI switch and HDMI splitters; the devices seem happy enough to get output from all of them, along with displaying to the monitor and HDMI capture device.

I turned on FSR in SteamOS and set the sharpness to "0". I am leaving the resolution to 720p or 800p for the games, and let FSR do the up-scaling. The image looks OK enough, looks like it would be between PS3 and PS4 graphics. I like when graphics look nice, although I like having higher framerates more than fidelity and most important is that the game is fun.

Played Final Fantasy VII Remake, Final Fantasy XIII and Titanfall 2 on the monitor. I found them to all be enjoyable, even if they didn't look as nice as they would at a native 1080p on my desktop. It is cool that I can just un-dock it and then play on the couch next to my wife when we are watching videos.

Today was a great test. Played several hours of Satisfactory with my friend. The Deck was hosting and it did not crash at all. Although it was a bit hard to look at, as I had to lower all the graphical settings to low and I was still getting 7-10 fps when in the train going from one base to another. Too many things to display. Although I was getting 10-20 fps when working on small segments of the base and I wasn't frustrated with placement. Saving was a slight issue, as it increased saving time from 8 seconds to closer to 13 seconds; even time it autosaved, my friend also had to stop what he was doing as it would not do any item calculations and placements would lock up. Setting up the Satisfactory server should fix this issue, so I am looking into that.

The Deck can get pretty hot. Running Satisfactory for 4 hours, it was hovering around 78C for the GPU and 88C for the CPU. I saw it hit 94C for a second at one point, but it did drop back to 88C pretty quickly. I was thinking of using my Antec thermal paste on my Deck to see if that lowers the temperature at all. Room temp is around 28C for most of the play session.

I decided to try out my thunderbolt 3 enclosure with the RX 580 and my Galago Pro laptop again. I didn't have a great experiance before, but it has been a few years. I won't be gaming on it during the challenge, although I will set it up.

## Pressing forward

**2023-10-07**

2023-10-07

It has been another session of Satisfactory and I must say... don't host Satisfactory on the Deck. It is not taking upwards of 20 seconds to save and it will pause the data processing on the other players during that time. With it also constantly running at less than 15 FPS, I can definitely say, the game is too big for the Deck.

So I will be giving up playing up on playing Satisfactory on the Deck by switching to the Galago Pro with Thunderbolt dock for the next time, while I also get the game running on the server. I don't like making an exception to the challenge, but it is affecting the fun factor of that game.

Now for a game that is even better than it ever was on my PC or PS2/Xbox 360, Final Fantasy XI. To be specific, [HorizonXI](https://horizonxi.com), a level 75 era private server. I was able to get the game running on the Deck and it plays fantastic. This would have been my preferred way to play back in the day, if it would have been a viable choice.

I also reinstalled Discord and also installed OBS on the Deck. When it comes to streaming to discord in game mode, for whatever reason, it will just stop streaming randomly and because I don't have the discord interface up while playing, I don't notice. Very annoying and if someone knows why and how to fix that let me know on discord. While I did install and setup Youtube streaming from OSB, I haven't really tested that just yet. Hopefully it works better than discord.

## I have already learned a lot

**2023-10-10**

2023-10-10

Been playing HorizonXI on the Deck quite a bit, so much so I need to be mindful not to spend all my time and thought on the game. I don't know why I enjoy Final Fantasy XI so much, maybe it is the difficulty, customization and sense of accomplishment, along with a fun battle system.

I tried playing Satisfactory on the Galago Pro (galp2) with the Thunderbolt 3 enclosure using the RX 580. It went very poorly. The game took 5 minutes to load on the 3.5 GHz i7-7500U (2.7 up to 3.5 GHz – 4 MB Cache – 2 Cores – 4 Threads). When the game did load, it was running at 10 FPS at 720p. I give up on Thuderbolt 3 eGPU. I bought in too quickly back in 2017 and I think I am only going to try again once the next handheld I get that has USB4 (or higher) has other people test this stuff out.

I swapped the hardware all back around, so the i7 4790 is back to being the gaming Desktop, the i3 is back to being the server and I will rethink what I want to use the Galago for.

What I have learned, if you are doing something that might affect another person, think about the other person. When it comes to computing, don't take a massive downgrade in performance if you don't have the time, patience or brainpower to deal with the repercussions. I like to tinker and test, so I enjoyed the experience, although it was stressful a few times.

Ultimately, I will be replacing my desktop with another full desktop. I like the ability to replace parts and I want at least 60 FPS on my games. Still looking forward to SteamOS for PC. The Deck or future SteamOS handhelds are great for casual or portable gaming, but I would not recommend it as the only device if you can help it. I like the idea of having a mid-range laptop for work/capture/edit machine.

I will continue to play what I can on the Deck when I can, but it is back to the desktop for the most part. I don't really see the point of continuing the challenge, as I have learned what I was looking for. Thanks for reading.
