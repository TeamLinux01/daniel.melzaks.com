+++
title = 'Tech can be unwieldy'
date = 2023-02-14T12:00:00-04:00
draft = false
+++

![Photo by Andrea Piacquadio](/images/blogs/pexels-olly-3777572.jpg "Photo by Andrea Piacquadio: https://www.pexels.com/photo/man-showing-distress-3777572/")

Be careful what you edit. Especially when it involves [Systemd](https://en.m.wikipedia.org/wiki/Systemd) services.

In planning to add the ability to email using Ghost blog, I had to recreate my [Podman](https://podman.io) container for it. In doing so, even though my Systemd service unit was calling the same name of the container "ghost", it had changed the PIDFile. Since I had it restart on-failure, it would restart the container because it could not communicate with the original container's PID.

Lesson learned, if you generate a new container, update the PIDFile used in the Systemd unit.

`podman generate systemd --name --no-header` *container-name*

Read the output of the `PIDFile=` and copy it over to the `.service` file.

Update 2024-05-04: I have moved over to Hugo, so I can just serve static files via Caddy. This is much simpler for me to understand and backup.
