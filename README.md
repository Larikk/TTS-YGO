# Yu-Gi-Oh TTS Edition

A Steam Workshop for Yu-Gi-Oh! inside of Tabletop Simulator.

## Main Features

* Spawn Booster Packs
* Spawn Starter and Structure Decks
* Import Cards via their ID or name
* Import Decks via YDK file
* Play mat and hidden zones for drafting included

Steam links:

2-player version: https://steamcommunity.com/sharedfiles/filedetails/?id=2586256855

8-player version: https://steamcommunity.com/sharedfiles/filedetails/?id=2205827151

Card lists are downloaded from [YGOPRODECK](https://db.ygoprodeck.com/api-guide/).

This repository contains code which can be imported in interactable objects inside of TTS.

## Developer Setup

TTS scripting is done with the text editor [Atom](https://atom.io/) and the official [plugin](https://atom.io/packages/tabletopsimulator-lua) from the TTS developers. An introduction for TTS scripting and the API documentation can be found [here](https://api.tabletopsimulator.com/).

Open a game in TTS with button-like elements and connect Atom with it with "Get LUA Scripts". Clone this repository into the directory for your TTS Lua scripts (Default: "~/Documents/Tabletop Simulator", can be changed in the setting of the Atom plugin, more info is [here](https://blog.onelivesleft.com/2017/08/atom-tabletop-simulator-package.html)).

## Acknowledgements

Many thanks go to

* YGOPRODECK for their API
