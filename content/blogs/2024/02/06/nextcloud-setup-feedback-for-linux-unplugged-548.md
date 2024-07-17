+++
title = 'Nextcloud setup: Feedback for Linux Unplugged 548'
date = 2024-02-06T12:00:00-04:00
draft = false
+++

This is how I currently run my Nextcloud software, so I can backup data from my phones and PCs. If you don't know what Nextcloud is, then check it out [here](https://nextcloud.com). I recommend listening to [LUP 548](https://www.jupiterbroadcasting.com/show/linux-unplugged/548) for some context about this post.

## TrueNAS SCALE

**My preferred Network Attached Storage OS**

I have used FreeNAS in the past and I thought it was decent enough for just storing files, but since it was FreeBSD-based I had issues running extra software on it. I ran it on a Intel Atom for a few years back around 2012 just to give some background. I was playing around with learning docker on the side and didn't understand how it all worked until I watched this [YouTube video by Traversy Media](https://www.youtube.com/watch?v=Kyx2PsuwomE). Also enter FreeNAS Corral around the same time. It finally all clicked together, but FreeNAS Corral failed. Thankfully I learned what I needed to learn from using it.

Back in 2021 I switched to running Fedora for my desktops and my servers, using BtrFS and all was good for a time. I could spin up extra software via podman on the server. Then one day my server rebooted and one of my drives couldn't be mounted any longer. Something had happened to BtrFS that put it in a state that it couldn't be mounted any longer, at least by normal ways. I was able to mount it via read-only recovery and copied all the data off the drive. With that scare, I went back to wanting to use ZFS.

It was time to start using [TrueNAS SCALE](https://www.truenas.com/truenas-scale) in my home and it has been rock solid for my data. Getting apps running on it took me some doing. I had no clue about kubernetes or helm, but I was willing to learn. I found out that Nextcloud was provided via TrueNAS charts by default, so I tried that out first. While I did get it running and it was fairly trivial to setup that version, the whole setup was very limiting. I wanted to host even more things on my TrueNAS, which meant I needed a reverse proxy up and running.

## TrueCharts

**A lot more software for TrueNAS**

I found out that I could setup [TrueCharts](https://truecharts.org) to run [Traefik](https://doc.traefik.io/traefik) as a reverse proxy for all my TrueCharts apps, it would handle all [TLS](https://www.cloudflare.com/learning/ssl/transport-layer-security-tls) Certificate and [DNS](https://www.cloudflare.com/learning/dns/what-is-dns) name responses. To get the DNS names to point to my TrueNAS server, I added some DNS overrides in [OPNsense](https://opnsense.org), the router OS I am running on a [ZimaBoard](https://www.zimaboard.com) [model 832](https://www.amazon.com/ZimaBoard-Computer-Personal-Network-Attached/dp/B0BKL7YPBQ).

![Unbound DNS](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/unbound-DNS.png "Unbound DNS")

The TrueNAS web interface needs to be rebound to different ports, so it doesn't conflict with running Traefik. It can be configured at https://*truenas-ip*:*port*/ui/system/general of the web interface. If you want to use the same certificate as Traefik, set up the certs first and also have DNS resolve to the TrueNAS server's IP addresses.

![TrueNAS GUI settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/TrueNAS-GUI-settings.png "TrueNAS GUI settings")

Adding Certificates was important for me, so I configured it to use my [Cloudflare DNS](https://www.cloudflare.com) for [Let's Encrypt](https://letsencrypt.org). Those can be configured at https://*truenas-ip*:*port*/ui/credentials/certificates. The **Certificate Signing Requests** has to be done first, then **Certificates** can be added.

![Certificates](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Certificates.png "Certificates")

Add TrueCharts to the system via https://*truenas-ip*:*port*/ui/apps/available/catalogs.

![Catalogs](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Catalogs.png "Catalogs")

A few apps need to be installed before Nextcloud or Traefik, they include cert-manager, cloudnative-pg, clusterissuer, prometheus-operator. Most of them don't require configuration, but clusterissuer does.

![Cluster Certificate Issuer](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Clusterissuer.png "Cluster Certificate Issuer")

After those are installed, Traefik is next. We have to expose ports 80 and 443 on the TrueNAS network interface, ClusterIP is only accessible via the cluster's network. Traefik will reverse proxy those connections. If you ingest Traefik into itself, you can access the service web page via the reverse proxy.

![Traefik Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Traefik-1.png "Traefik Settings")

![Traefik Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Traefik-2.png "Traefik Settings")

Lastly, install Nextcloud. **Default Phone Region** had to be entered manually and **Access IP** is TrueNAS's IP address. I highly recommend using a **Host Path** for the **User Data Storage** and make sure it is a directory that will only be used by Nextcloud. This way, if the app fails, you can still copy out the unencrypted data. PVCs are nice for settings and such that can be recreated. Enable the Ingress to be the DNS name that is going to be resolved, enable the cert setting and install.

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-1.png "Nextcloud Settings")

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-2.png "Nextcloud Settings")

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-3.png "Nextcloud Settings")

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-4.png "Nextcloud Settings")

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-5.png "Nextcloud Settings")

![Nextcloud Settings](/images/blogs/nextcloud-setup-feedback-for-linux-unplugged-548/Nextcloud-6.png "Nextcloud Settings")

This isn't a completely detailed guide, but I hope it helps for people who need to fill in the gaps. It took me a lot of web searches to figure out all the settings I needed to get this all up and running. If I get any feedback or questions, I will try to update this with more information.
