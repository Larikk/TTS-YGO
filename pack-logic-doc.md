# Documentation for the parameters of the files in src/pack-logic

## SET_NAME
Name of the set. Must be the real and full name. Is usually used as SET_NAME_URL too if that one is not overridden.

Examples: "Legend of Blue Eyes White Dragon", "Battle Pack: Epic Dawn"

## SET_CODE_PREFIX
The set code the cards in this set have minus the last three digits. Is used in combination of SET_NAME to extract rarities of cards without having duplicates. Is not optional

Examples: "LOB-", "BP01-EN"


## SET_NAME_URL
Usually SET_NAME is used as a parameter for the API query. In case something else should be used this can be set here.

Query looks like this: "https://db.ygoprodeck.com/api/v7/cardinfo.php?cardset="..SET_NAME_URL

Examples: "Metal Raiders", "metal%20raiders"

## PACK_TEXTURES
Textures used for the packs. Should be strings of links to images. Can be nil, a string or a table of strings.

* nil: A default texture is used
* string: The link to the image
* table of string: Each pack will use a random texture

Examples: "https://example.com/foo.png"

## BOX_TEXTURE
Texture used for the spawned box. Should be a string with a link to an image. If nil, a default texture is used.

## CARDS_IN_PACKS
How many cards are in a pack.

## PACKS_IN_BOX
How many packs are in a box. If set to one, only a pack without box will be spawned.

## Rarities
The PackGenerators usually have all rarities as separate global constants. They just enable autocompletion and are a safe-guard against typos.

## RATIOS
Many packs have one or more cards with a random rarity. The ratios of these rarities are stored in the RATIOS table. This table is a mapping of rarity and this rarity to occur. The ratios must add exactly to 1.0. the ratios can have any number of decimal places but are usually rounded up to only have two.

Example:
```
local RATIOS = {}
RATIOS[COMMON] = 0.71
RATIOS[SUPER_RARE] = 0.17
RATIOS[ULTRA_RARE] = 0.08
RATIOS[SECRET_RARE] = 0.04
```

## SET_DATA_EXTRACTOR
A card object returned by the API has all of its releases in an array. This field holds an object responsible for extracting entries the relevant releases to obtain the rarity and set code of a card.

#### extract(cardApiData)
Returns a table with all of the relevant releases/rarities of the card.

This class is built with a builder pattern. The available settings are:

#### replace(replacements)
Takes a table with replacements of rarities "Short Print" -> "Common"

#### ignore(...)
Takes an arbitrary number of rarities that should be ignored during extraction.

Example: `ignore("Starfoil Rare", "Test")`

#### addPostListener(listener)
Accepts a listener which can examine and modify the extracted releases before they are returned. Instead of modifying the passed table a new table should be returned.

See BP02 in pack-logic/battle-packs for an example which filters the Mosaic Rare rarity from cards that have another rarity besides this one.

#### findAll()
The extractor usually stops after the first hit. This setting makes him return all hits.

#### build(spawner)
Take the PackGenerator object as parameter. Sets some internal fields that are necessary for the extraction.
