# Yu-Gi-Oh Sealed Draft Simulator for Tabletop Simulator

This Tabletop Simulator (TTS) mod creates randomized Yu-Gi-Oh Booster and Booster Boxes for sealed draft play.
It is still an early prototype so don't expect it to be in any way perfect or complete.

Card lists are downloaded from [YGOPRODECK](https://db.ygoprodeck.com/api-guide/).

This repository contains code which can be imported in interactable objects inside of TTS.

## Developer Setup

TTS scripting is done with the text editor [Atom](https://atom.io/) and the official [plugin](https://atom.io/packages/tabletopsimulator-lua) from the TTS developers. An introduction for TTS scripting and the API documentation can be found [here](https://api.tabletopsimulator.com/).

Open a game in TTS with button-like elements and connect Atom with it with "Get LUA Scripts". Clone this repository into the directory for your TTS Lua scripts (Default: "~/Documents/Tabletop Simulator", can be changed in the setting of the Atom plugin, more info is [here](https://blog.onelivesleft.com/2017/08/atom-tabletop-simulator-package.html)).

## Usage

Open the scripts of one of your interactable objects in Atom and include the file corresponding to the booster set that this object should spawn. Example:

```
#include <TTS-YGO-sealed-draft/pack-logic/main-sets/001-LOB>

local packGenerator = PackGenerator:new()

function onButtonPressed()
    packGenerator:generateBoosterPack()
    -- or
    packGenerator:generateBoosterBox()
end
```

Deploy the changes with "Save and Play".

The card list of a set is downloaded and processed the first time the creation of a box/booster is requested. The `packGenerator` object caches the downloaded card list so don't recreate it with each button press/action.

## Code architecture

The generator is implemented as a base abstract class with common logic and separate subclasses which have booster set specific logic and parameters. The base class can be found in `common/Base.ttslua`, the subclasses in `pack-logic`

## Acknowledgements

Many thanks go to

* YGOPRODECK for their API
* [rxi](https://github.com/rxi) for providing a great [JSON library for Lua](https://github.com/rxi/json.lua) (which outperforms the native JSON decoding of TTS by a factor of 20)
