+++
title = 'Time to talk about the Tech stack'
date = 2023-02-15T12:00:00-04:00
draft = false
+++

# My srver's tech stack

![Photo by Kelly](/images/blogs/pexels-kelly-1179532-4269517.jpg "Photo by Kelly: https://www.pexels.com/photo/anonymous-pilots-in-aircraft-cockpit-flying-over-sea-4269517/")

This will most likely be a multi-part entry, where I will explain how I got this all up and running. For now, let's do an overview.

Let me explain that I have been fascinated with how technology has worked since I was a little boy. I once took apart my Father's rotary phone, to see how it worked; although I did not put it back together in the end and he was not happy with what I had did.

![Photo by Ekrulila](/images/blogs/pexels-ekrulila-8232117.jpg "Photo by Ekrulila: https://www.pexels.com/photo/close-up-shot-of-a-person-using-a-classic-rotary-phone-8232117/")

After I was exposed to the world of computers, I did not look back. I took a Computer Networking course in my Junior and Senior years of High School. From there, I learned how computers and networks functioned. I was gifted our home's older computer to work on while I started the course. It was very slow and I could not upgrade it. I remember going to Best Buy with my Mom and asking for EDO RAM (this was in 2002), which the cleric responded with "We don't carry that."

## The gift computer specs (what I remember, at least)

* Pentium 100Mhz (somewhere around there)
* 32MB of EDO RAM (it was originally 16MB, but I was able to get some more from my Grandfather's computer, so it was the same computer)
* Hard drive may have been 10GB
* It had ISA Slots
* CD-Rom Drive

I was able to build my first computer fully towards the end of the first year. I wanted to game at the time and the original computer wasn't going to cut it for "modern" games. One game in particular which caught my interest was "Final Fantasy XI Online." I won't get into much more details about either one of those for now.

## The computer specs of the machine I built in High School

* [AMD Athlon XP 2800+](https://www.techpowerup.com/cpu-specs/athlon-xp-2800.c89) which was later upgraded to a [AMD Athlon XP +3200](https://hothardware.com/reviews/amd-athlon-xp-3200)
* 2GB of RAM (4x 512GB DDR Sticks)
* [PNY nVidia GeForce FX 5600](https://www.techpowerup.com/gpu-specs/geforce-fx-5600.c64) although this was taken from the family PC and it was a warrany from a failed [PNY nVidia GeForce 4 TI 4600](https://www.techpowerup.com/gpu-specs/geforce4-ti-4600.c178)
* 40GB Hard Drive (I think...)
* DVD-Rom Drive
* Installed Windows XP on it

Enough with the history lesson. Time to get down to the current tech!

## This blog's tech stack

### Service's I paid for

* [Linode hosting](https://linode.com/jupiter)
* [Proton E-Mail](https://proton.me/mail)
* [Cloudflare DNS Registrar (just the registered domain name)](https://developers.cloudflare.com/registrar/get-started/register-domain)

### Free to use services' and software

* [Google Mail](https://www.google.com/gmail/about)
* [Fedora Server](https://getfedora.org/en/server/download)
* [Podman](https://podman.io)
* [Systemd](https://systemd.io)
* [Cockpit](https://cockpit-project.org/running)
* [SSH server and client](https://en.wikipedia.org/wiki/Secure_Shell)
* [Let's Encrypt](https://letsencrypt.org)
* [Caddy server](https://caddyserver.com)
* [Ghost](https://ghost.org)
* [MariaDB](https://mariadb.org)

### The quick overview in the order I used this tech

1. Bought `melzaks.com` from Cloudflare DNS Registrar.
1. Paid for Proton E-Mail.
1. Put in my custom domain into Proton E-Mail's settings.
1. Created an account, put in my payment info and used promo code on Linode.
1. Spun up the $5 a month virtual machine on Linode, choosing Fedora Server 37.
1. Created A/AAAA DNS records using the static IPv4 and IPv6 addresses which were assigned to the Linode VM. Made sure to keep the DNS Proxy for each entry. Assigning `*.melzaks.com` and `melzaks.com` to cover the primary domain and subdomains.
1. Locked down the VM. This includes changing SSH server settings to only using keys and not passwords, uploading those keys. Changing the firewall so only ports 80/tcp and 443/tcp+udp are accessible to the public internet; ports 22/tcp and 9090/tcp are only accessible from my home's IPv6 addresses.
1. Downloaded caddy with Cloudflare DNS support for Let's Encrypt SSL certificates. Set up caddy to only listen on the public IPv4 and IPv6 addresses.
1. Created a Systemd unit to start the caddy web server.
1. Spun up podman containers for Ghost and MariaDB, putting them in the same pod and set up Ghost to listen on an extra IPv6 address in the pool I requested from Linode. The address is a GUA ([Globa Unicast Address](https://en.wikipedia.org/wiki/IPv6_address)), although the firewall does not allow any Internet traffic to access it.
1. Created Systemd units to start the ghost blog server stack.

If I missed anything, I will come back and edit this post. I hope this overview is helpful and in the coming days, I will explain in more detail each of these parts and how to piece it all together.

Thank you for reading, may you enjoy your day. Never stop learning and God bless.

Update 2024-05-04: Some things have changed and I will be using just a caddy podman container and a static folder to host this blog, it is much simpler.
