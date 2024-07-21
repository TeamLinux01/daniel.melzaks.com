+++
title = 'TMUX FTW'
date = 2024-07-18T12:54:00-04:00
draft = false
+++

I just spend a few minutes watching a video explaining the benefits of using [TMUX, the terminal multiplexer](https://github.com/tmux/tmux/wiki). It was a video from [NetworkChuck](https://www.youtube.com/@NetworkChuck), [you need to learn tmux RIGHT NOW!!!](https://www.youtube.com/watch?v=nTqu6w2wc68)

I was able to set tmux as my default shell on both my desktop and server, then have tmux use [fish](https://fishshell.com/) as its default shell.

My desktop is running [Aurora-DX](https://getaurora.dev/) and the server is running [ucore-hci:stable-zfs](https://github.com/ublue-os/ucore?tab=readme-ov-file#ucore-hci). I setup [Homebrew](https://brew.sh/) on uCore by running the install script, Aurora has it installed out of the box.

To get fish install via brew:
```bash
brew install fish
```

Thankfully tmux is installed on both systems out of the box as well. To get it to play nicely with my desktop's clipboard on Wayland, I installed the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

I created the `~/.tmux.conf` files on my desktop and server.

Desktop:
```file
set-option -g default-shell "/home/linuxbrew/.linuxbrew/bin/fish"

set -s set-clipboard on
set -s copy-command 'wl-copy -- '
set -g mouse on

# Send bind-key to remote session by `C-b b`
bind-key b send-prefix

setw -g mode-keys vi

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

Server:
```file
set-option -g default-shell "/home/linuxbrew/.linuxbrew/bin/fish"
set -g mouse on

setw -g mode-keys vi
```

Lastly I set tmux as my default shell by executing it with `.bashrc`

Add the following line to the end of `~/.bashrc`:
```file
if [[ -z "$TMUX" ]]; then
    if tmux has-session 2>/dev/null; then
        exec tmux attach
    else
        exec tmux
    fi
fi
```

With all that done, I can now enjoy creating new panes, windows and not worry about commands being terminated do to disconnections. Using the `bind-key b send-prefix`, I am able to press `Ctrl+b` then `b` then the command I want to send to my server.

I am really starting to fully enjoy my computers lately. Thank you to all whom are working on the Universal Blue project, Linux kernel and all the other great F/LOSS out there. I really appreciate the opportunity to use it. God Bless you.