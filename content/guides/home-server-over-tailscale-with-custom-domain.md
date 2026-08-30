+++
title = 'Setting up a home server so that you can access it over tailscale network using a domain you own'
date = 2026-08-30T14:57:00-04:00
draft = false
+++

# Setting up a home server so that you can access it over tailscale network using a domain you own

> If you would like to leave feedback, please use the [Github discussions for this blog post](https://github.com/TeamLinux01/daniel.melzaks.com/discussions/3).

This is how I setup my server so I can access things such as [Audiobookshelf](https://audiobookshelf.org), [Jellyfin](https://jellyfin.org), [makemkv](https://github.com/jlesage/docker-makemkv) and more over the Internet.

Doing this also allows you to allow others of your choice to be able to access whatever apps you want them to, as well.

Through [NPM](https://nginxproxymanager.com/guide/) and [Tailscale Access controls](https://console.tailscale.com/admin/acls/visual/general-access-rules), you can even control the ability for a user to be able to even attempt to access a service or port on the machine you share with them.

## Requirements

You will need the following:

* A [Tailscale account](https://login.tailscale.com/start), which is free to sign up and use.
* Your own domain name you can manage `A` and `AAAA` records. I bought mine through [Cloudflare](https://www.cloudflare.com/products/registrar/).
* A computer to run tailscale and [OCI Containers](https://opencontainers.org), such as [Docker](https://www.docker.com) or [Podman](https://podman.io).
    * [TrueNAS Community Edition](https://www.truenas.com/truenas-community-edition/) can run Tailscale under their "Apps" section.
    > I recommend choosing "Host Network" for the Network Configuration so it isn't behind another layer of networking.
    > It is also recommended to bring the administrative interface to another port, so http `80/tcp` and https `443/tcp and 443/udp` are available for your apps.
    > I also had to make nginx-proxy-manager a custom app and having it use `network_mode: host` for it to be able to access the container networks.
    * [Proxmox](https://proxmox.com/en/downloads/proxmox-virtual-environment) can now [run OCI images](https://raymii.org/s/tutorials/Finally_run_Docker_containers_natively_in_Proxmox_9.1.html) apparently.
    * [uCore](https://github.com/ublue-os/ucore) which I have ran in the past.
    * Really any computer if you go looking how to set things up.

### Tailscale setup

#### Register your server

Once you have your account and have access to the dashboard, you will want to add your server to the Tailnet. I recommend creating a a [tag](https://tailscale.com/docs/features/tags) and `Disable key expiry` during adding your server or shortly afterward. You don't want to have to log into the server to renew the keys and it is much easier to manage [ACLs](https://console.tailscale.com/admin/acls/visual/general-access-rules) based on tags.

#### Setup Tailscale DNS

> [DuckDNS](https://www.duckdns.org) is supported for NPM's Let's Encrypt, so you might want to try it out.

You will want to keep a subdomain in mind for your server to use for your custom domain, as you will want to use `Split DNS` for just that subdomain. Even though it will be a publicly resolvable domain, since it will point to [CGNAT IPv4 and ULA IPv6 addresses](https://tailscale.com/docs/concepts/ip-and-dns-addresses), routers such as [OpenSense](https://opnsense.org) will refuse to provide the records to clients due to [DNS Rebind Protection](https://en.wikipedia.org/wiki/DNS_rebinding).

To get around this problem, enable the following:

1. Under [DNS](https://console.tailscale.com/admin/dns) settings, click `Add nameserver`.
1. Click the 3-dot button next to whatever nameserver you added and click `Edit...`.
1. Turn on `Restrict to domain Split DNS` and enter the subdomain in the text field. Mine is `server.melzaks.com`.
1. Click `Save`
1. Still under DNS settings, click `Add search domain...`.
1. Enter the subdomain in the text field. Again mine is `server.melzaks.com`
1. Click `Add search domain`

Setting up the search domain will allow your clients reach out to the provided name server to get the Tailnet device IP. An example would be for my domain, `http://jellyfin` would get me to the same device and then I can have NPM redirect to `https://jellyfin.server.melzaks.com`

> Do not add the same SSL certificates to the redirection hosts. If you do, you will get an SSL warning, as the certificate does not match the domain.

> Just know that if you type something like `https://jellyfin`, it won't load anything, as no certificate is applied to the redirect. Only the `http://jellyfin` would have the response to redirect to the [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name).

#### Setup Access Control Policies

Add `tcp:80`, `tcp:443` and `upd:443` in your [Tailscale Access control policy](https://console.tailscale.com/admin/acls/visual/general-access-rules) to allow devices to access your apps. I have mine setup as **Sources:** `All users and devices` **can access destinations:** `tag:apps` **on port and protocol** `tcp:80, tcp:443, udp:80, udp:443`.

In order to access the NPM web GUI, you should have another rule that allows only your account as a Source, your tag or server device group as the destination and `tcp:81` for the port. This will allow you to access it over the Tailnet, making it easy and secure to setup.

#### Share your server with your friends and family

You can share your just the server with anyone you want after you get things up and running.

## Domain setup

Log into your DNS registrar and get to the part where you can edit your `A` and `AAAA` records. [Guide to create records for Cloudflare DNS](https://developers.cloudflare.com/dns/manage-dns-records/how-to/create-dns-records/)

> It should not offer the ability to Proxy the connection, but if it does, make sure it is turned off.
* You will want to create four new records, two `A` and two `AAAA`.
    1. One `A` record will be for the server name. For me, it was `server.melzaks.com`. Use the IPv4 address of the Tailnet for your server.
    1. The other `A` record will be for the wildcard subdomains for the server. For me, it was `*.server.melzaks.com`. Use the same IPv4 address of the Tailnet for your server.
    1. Repeat for both of the `AAAA` records, instead use the IPv6 address of the server.

This should all that is needed for setting up your custom domain.

> Repeat the process if you want other Tailnet devices to be resolvable with your DNS.

> Also, make sure to update the records if your devices ever have their IPs change.

### Container setups

Time to setup the container images and start serving content!

> I had to use firewall-cmd to unblock http, https and other ports on Fedora server even if the container binds to a Tailnet IP, so keep local firewalls in mind.


#### NPM

> I changed the TrueNAS administration web port to be 8080 and 8443. It is under `General Settings`, then `GUI Settings` button. Remember to put that HTTPS port into the server URL going forward to get back to the TrueNAS web GUI.

I am currently running nginx-proxy-manager as a custom app on TrueNAS. The Custom Config looks like this:

```docker
services:
  nginx-proxy-manager:
    container_name: nginx-proxy-manager
    image: jc21/nginx-proxy-manager:latest
    network_mode: host
    restart: unless-stopped
    volumes:
      - npm_data:/data
      - npm_letsencrypt:/etc/letsencrypt
version: '3.9'
volumes:
  npm_data: Null
  npm_letsencrypt: Null
```

1. Log into the web interface using your domain name for the server and port 81. The my URL would be `http://server.melzaks.com:81` or `http://server:81` lettings the search domain do the work.
    * If you have MagicDNS turned on, you can also use the Tailnet name of the server, too.

1. Setup your username and password for NPM. You will want to save these somewhere.

1. Click on `Certificates` on the web interface.
    * This is where things get complicated. You can get certificates all sorts of ways from different providers. Just keep in mind that the server will not be accessible on the public Internet, so `Let's Encrypt via HTTP` won't work.
    * Since I registered my domain with Cloudflare, I ended up using a [Cloudflare API token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) for this next part. If you create a token, you will want to securely save that somewhere to be able to reference later.
    1. Enter both the wildcard subdomain and the domain of the server in the `Domain Names` text field. Mine was `*.server.melzaks.com` and `server.melzaks.com`.
    1. Leave `ECDSA 256` as the `Key Type`.
    1. Under `DNS Provider`, choose whichever DNS you signed up with and are using. I have `Cloudflare`, so I replaced the string after `=` to be the API token I generated for this purpose.
    1. Click `Save` button.

1. Click on Access Lists`. Having this list setup can deny access to apps that are not on the allow list.
    1. On the details tab:
        1. Name the Access list using the `Name` text field. Mine is `Secure Tailnet Systems`.
    1. On the rules tab:
        1. Click `Add` button.
            1. Create an `Allow` for the IPv4 or IPv6 address of the Tailnet device you want to allow.
            1. Leave `Deny` as `all`
            1. Click `Save` button.
        1. Repeat for each IPv4 and IPv6 address of all the Tailnet devices you want to allow.

1. Click on `Hosts` and then `Proxy Hosts`.
1. Click `Add Proxy Host`.
    1. On the details tab:
        1. Enter the apps domain name in `Domain Names` text field. Example would be `jellyfin.server.melzaks.com`.
        1. `Scheme` is `http`, `Forward Hostname / IP` is the IP address of the docker container for the app, `Forward Port` is the internal port of the app. Example would be `http`, `172.16.2.2`, `8096`.
            * You will have to use `docker container inspect` or some other method to determine the internal IP address of the app. A lot of chicken and egg going on here.
            * You will also have to look up what the internal port of the service should be, looking at other docker-compose setups, how the image is built or even the default ports for the app when it isn't in a container can help you figure out what the correct port for the web interface should be.
            * If you can, try to manually assign the internal IP address of the container. You will have to get back into NPM to change it if the container pulls a different IP.
            * You can turn off Port Bind mode when setting up apps in TrueNAS, as you won't be accessing them directly.
        1. `Access List` should be `Publicly Accessible` if you want anyone that has shared access to the device to be able to access it, otherwise select the correct Access List.
        1. Turn on `Websockets Support`. It might be needed, depending on the app.
    1. On the SSL tab:
        1. `SSL Certificate` select the certificate you setup earlier. Mine says `*.server.melzaks.com, server.melzaks.com`.
        1. Turn on `Force SSL`
        1. Turn on `HTTP/2 Support`, some apps might work better with it on.
        1. Feel free to turn on or keep off the rest of the settings
    1. Click `Save` button.
1. Repeat for each app you want to host.

###### Optional redirects

1. Click on `Hosts` and then `Redirection Hosts`.
1. Click `Add Redirection Host`.
    1. Start enter apps short domain name in `Domain Names` text field. Example would be `jellyfin`.
    1. Leave `Scheme` as `Auto`. Enter FDQN for the app in `Forward Domain`. Example would be `jellyfin.server.melzaks.com`.
    1. Leave `HTTP Code` as `301 Moved permanently`
    1. Click `Save` button.
        * Do not set SSL, as it will not match properly and you will get an error on page load of the short domain.

> WARNING! If you have to make a change to the SSL Certificate by removing one, make sure it is removed from every host before deleting it. If you do not, the container will break and you will have to manually edit the files in the /data volume to remove traces of trying to load the now deleted SSL folder. This bug should probably be brought up to the NPM container maintainers at some point.

Also, NPM can do a Proxy redirect of it's own container port, just use `localhost` and port `81`. Just don't block port 81 in case things go bad.

#### Jellyfin

I am not going to mention much here except make sure to have the `Published Server URL` be the same as what you have in the NPM Proxy setting. Mine is `https://jellyfin.server.melzaks.com`

Follow this [official Jellyfin container documentation](https://jellyfin.org/docs/general/installation/container/) to help you get started with that. You shouldn't need to use the `ports` section, though.

## Wrap up

I wrote this to help me look up how to do this again, as it is not easy and also to share with other interested people.

As for sharing the connection with your friends and family, just have then sign up for Tailscale account and then send the share with a link they can click or via email.

All they would need is to install Tailscale app on their ChromeCast, AndroidTV, computer or phone and type in the URL you want them to access. Don't forget to get them any additional usernames and passwords for Jellyfin and such.

Feel free to let me know if I should expand on a thing, have a question or comment using the [Github discussions for this blog post](https://github.com/TeamLinux01/daniel.melzaks.com/discussions/3).