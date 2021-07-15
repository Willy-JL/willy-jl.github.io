---
title: Projects
icon: fas fa-briefcase
order: 5
---

Here you can find a list of the major projects that I have taken on.

<br>

# Actual Projects

<br>

![Soundy icon](https://raw.githubusercontent.com/Willy-JL/Soundy/main/resources/icons/icon.png){: style="width: 33%; max-width: 200px;" .left}
## [**Soundy**](https://github.com/Willy-JL/Soundy)
Soundy is a minimal media controller and visualizer. It shows the currently playing track along with it's author and the album art, which also influences the colors of the rest of the interface. It features your usual play/pause, skip, repeat, shuffle and time scrubber controls, along with Discord rich presence support. It hooks into Windows' internal API and because of this nearly all media players (including most browsers) are supported.

<br>

![A.L.T.I.E.R.A. icon](https://cdn.discordapp.com/avatars/822824094680481792/74ddf49a7dabc1b6b4cc06ad1b0ac580.webp?size=2048){: style="width: 33%; max-width: 200px;" .right}
## [**A.L.T.I.E.R.A.**](https://github.com/Willy-JL/ALTIERA-Bot)
A.L.T.I.E.R.A., also known as Alt bot, is a custom bot I wrote for the Cyberpunk 2077 modding Discord servers. The main feature is the user experience system that tracks level (any kind of message), cred (messages by modders in modding channels) and assistance (messages in help channels). That however is not the only feature: it also allows you to give reputation to other users, receive a daily reward, custom server join and user level-up notification messages and a few other commands. Also the bot is custom themed for the futuristic and cyberpunky atmosphere in the servers.

<br>

![AnimateMyEmojis icon](https://cdn.discordapp.com/avatars/812756332905365504/e13ce7095ffb2e1cf0609f3476131bf3.webp?size=2048){: style="width: 33%; max-width: 200px; border-radius: 50%;" .left}
## [**AnimateMyEmojis**](https://github.com/Willy-JL/Animate-My-Emojis)
AnimateMyEmojis is a Discord bot that allows non nitro users to use animated emojis in servers. How it works is that when a message is sent it checks for emoji names that are not actually being displayed as emojis, and if it finds some it will delete the message and resend it 1:1 though a webhook (created automatically) with the same user's name and profile picture but with the emojis converted and animated. This bot also features "yoinking" emojis, which allows you to add other server's emojis to your own server.

<br>

![Lifeless icon](https://cdn.discordapp.com/attachments/741226265100681229/782016206810775582/unknown.png){: style="width: 33%; max-width: 200px; border-radius: 50%;"" .right}
## **Lifeless SelfBot**
Lifeless is a selfbot for the Discord platform. It's purpose is to enhance your chatting experience with a wide range of cool and useful commands. The aim is a very stable and reliable program with exclusive features and that is easy to setup and use. For the time being this is a work in progress, with no ETA. This will be closed source and paid (lifetime, no subscriptions, likely 5€ or 10€).

<br>

![Omega icon](https://cdn.discordapp.com/attachments/741226265100681229/864969847657201745/omega.png){: style="width: 33%; max-width: 200px; border-radius: 50%;"" .left}
## [**Omega**](https://github.com/Willy-JL/Omega-Theme)
Omega is my very own custom theme for the BetterDiscord client. I decided to create it because I simply couldn't quite find the theme I wanted and so I started making my own. Omega keeps Discord's original feeling, but makes the whole interface slightly darker and features a consistent color scheme with stunning gradients, which by default are blue to purple. It takes some design inspiration from Nocturnal, but was written by myself for the most part.

<br>

![InstaDownloader icon](https://cdn.discordapp.com/attachments/741226265100681229/864962351480569866/118063983_325062525308988_6769172755963192430_n.png){: style="width: 33%; max-width: 200px; border-radius: 50%;"" .right}
## [**InstaDownloader**](https://github.com/Willy-JL/InstaDownloader)
InstaDownloader is an Instagram bot that replies to direct mesages (aka DMs) with direct links to the media you sent. This way it is possible to easily download images and videos from Instagram. Unfortunately, just like all other project similar in concept, this is largely subject to rate limits and shadow bans due to its design. As of right now I am not actively maintaining the code base and the bot itself is not active (my instance is not running, I don't know if there are mirrors). If I come back to the project I will implement a websocket system to circumvent rate limits and better mimick the web client.

<br>

![F95Checker icon](https://cdn.discordapp.com/attachments/741226265100681229/864987647628541952/f95checker.png){: style="width: 33%; max-width: 200px; border-radius: 50%;"" .left}
## [**F95Checker**](hhttps://github.com/Willy-JL/F95Checker)
F95Checker is an update checker and manager tool for NSFW games on the F95Zone platform. Unlike other similar tools, it aims to be the easy to setup and use, without bloating the user interface with complex features and unwanted behavior. For each game you can see the banner image, description, changelog, current version, development status and you have a button to launch it if you have it installed. It also features an alert and inbox checker, to keep you up to speed on what has been happening on the forum, and a background mode, which will notify you of game updates and alerts every 15 minutes.

<br>

<br>

# Cyberpunk 2077 Mods

<br>

## [**Better Minimap**](https://www.nexusmods.com/cyberpunk2077/mods/634)
Better Minimap was the first mod to address the lingering issue of GPS zoom, causing you to not see upcoming turns. The mod features 4 zoom settings for vehicles and 4 for on foot navigation, along with some aesthetic options. You can either use the presets or install using the installer, which gives you more customization options.

Source: [Willy-JL/BetterMinimap-Installer](https://github.com/Willy-JL/BetterMinimap-Installer)

<br>

## [**Str8up Menu**](https://www.nexusmods.com/cyberpunk2077/mods/779)
Str8up was the first cheat menu to come to Cyberpunk 2077. Thanks to Cyber Engine Tweaks (mod framework and console addon) including ImGUI it was finally a viable option to make a user interface within the game and Str8up menu was one of the first to make use of this and it brought a much needed GTA-style mod menu to Cyberpunk 2077.

Source: [Willy-JL/Str8up-Menu](https://github.com/Willy-JL/Str8up-Menu)

<br>

## [**CP77 Discord RPC**](https://www.nexusmods.com/cyberpunk2077/mods/986)
When Cyberpunk 2077 first released I was personally quite shocked to find out that such a massive game didn't include any kind of rich presence support for Discord, and because of this I felt the need to incorporate it myself. The first attempt was quite bumpy as it required a parallel Python process to update the presence info, but later rewriting the mod in C++ and integrating it as an ASI mod made it much more stable and gave it a nearly native feel.

Source: [Willy-JL/CP77-Discord-RPC](https://github.com/Willy-JL/CP77-Discord-RPC)

<br>

## [**Annoy Me No More**](https://www.nexusmods.com/cyberpunk2077/mods/1512)
In Cyberpunk 2077 there are many annoying and simply stupid limitations and behaviors that you cannot change in any way, and when with the release of Redscript it was finally possible to easily edit the game's core scripts I rushed to make some of what I considered to be the most needed fixes and improvements.

Source: [Files tab on Nexus](https://www.nexusmods.com/cyberpunk2077/mods/1512?tab=files)

<br>

## [**Mod Mover**](https://www.nexusmods.com/cyberpunk2077/mods/2325)
With many different creators making awesome mods it was bound to happen that someone would make a great mod but package it incorrectly, and while to most users this is not a big deal, in some cases it can be, like for example installing mods with Vortex mod manager will simply not load the mod because it will end up in the wrong folder. Mod Mover aims to fix that by moving (aka renaming, takes no time at all) the incorrectly installed mods to their appropriate location when the game is started, and to optionally move them back when the game is closed.

Source: [Willy-JL/ModMover](https://github.com/Willy-JL/ModMover)
