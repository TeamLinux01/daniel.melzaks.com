+++
title = 'nushell and starship'
date = 2025-02-08T18:12:00-05:00
draft = false
+++

## I think I found the default shell and terminal prompt for me

A friend of mine, [Steven Bass](https://github.com/MacGyverBass), recommended that I look into [nushell](https://www.nushell.sh/). I have to say, I like it a lot. The idea that you can pipe objects instead of text streams for passing data from one application to another really intrigues me.

I installed it on [Bluefin](https://projectbluefin.io/) via [Brew](https://brew.sh/). Then I followed the instructions to setup [Starship](https://www.nushell.sh/book/3rdpartyprompts.html#starship). I was a little confused on how to configure Starship, but that is only because I didn't go to the Starship website. It turns out you should [follow these instructions to create the starship.toml file](https://starship.rs/config/).

Once I created the starship.toml file, I was able to add time, battery status and change some colors. May configuration on my laptop looks like this:

`starship.toml`
```toml
# Get editor completions based on the config schema
"$schema" = 'https://starship.rs/config-schema.json'

# Inserts a blank line between shell prompts
add_newline = true

# Replace the '❯' symbol in the prompt with '➜'
[character] # The name of the module we are configuring is 'character'
success_symbol = '[➜](bold green)' # The 'success_symbol' segment is being set to '➜' with the color 'bold green'

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true

[battery]
disabled = false
full_symbol = '🔋'
charging_symbol = '⚡️'
discharging_symbol = '💀'

[[battery.display]]
threshold = 99

[directory]
style = 'bold purple'

[time]
disabled = false
format = '🕙[\[$time\]]($style) '
time_format = "%T"
utc_time_offset = "-5"
```

As I keep customizing my shells, VS Code configurations and other apps, I am starting to regret not learning out to safely and securely storage my dot-configs in Git. I think that will be my next adventure.

I am looking forward to when I can build my own OS image using bootc, make all the changes I want in the git repo and be ready to go on a UEFI SecureBoot x64 system.