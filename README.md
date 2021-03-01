# Yu-Gi-Oh Sealed Draft Simulator for Tabletop Simulator

This Tabletop Simulator (TTS) mod creates randomized Yu-Gi-Oh Booster and Booster Boxes for sealed draft play.
It is still an early prototype so don't expect it to be in any way perfect or complete.

Card lists are downloaded from [YGOPRODECK](https://db.ygoprodeck.com/api-guide/).

This repository contains code which can be imported in interactable objects inside of TTS.

## Developer Setup

TTS scripting is done with the text editor [Atom](https://atom.io/) and the official [plugin](https://atom.io/packages/tabletopsimulator-lua) from the TTS developers. An introduction for TTS scripting and the API documentation can be found [here](https://api.tabletopsimulator.com/).

Open a game in TTS with button-like elements and connect Atom with it with "Get LUA Scripts". Clone this repository into the directory for your TTS Lua scripts (Default: "~/Documents/Tabletop Simulator", can be changed in the setting of the Atom plugin, more info is [here](https://blog.onelivesleft.com/2017/08/atom-tabletop-simulator-package.html)).

## Acknowledgements

Many thanks go to

* YGOPRODECK for their API
* [rxi](https://github.com/rxi) for providing a great [JSON library for Lua](https://github.com/rxi/json.lua) (which outperforms the native JSON decoding of TTS by a factor of 20)
