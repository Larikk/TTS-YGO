import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil
import lib.files as files
import os
import atexit
import time

title = "Starter Deck: Yugi"
counter = 1
folder = "../../src/preconstructed-decks/starter-decks"

albumHash = "xKSFdRb" # can be found in url
imgur = imgur.Client(albumHash)

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder, "src/preconstructed-decks/starter-decks")

def handleDeck(title):
    deck = wiki.download(title)
    deck['imgur'] = imgur.getUrl(deck['name'], deck['image'])
    deck['cards'] = deckutil.sortCards(deck)
    deck['ydk'] = deckutil.asYdkFile(deck)
    deckutil.printDeck(deck)


    # Write deck
    content = deckutil.asTtsLuaFile(deck)
    filename = f"{counter:03d}-{deck['code']}.ttslua"
    files.write(folder, filename, content)

    return deck

nextReleaseExceptions = {
    "Starter Deck: Kaiba Evolution": "Starter Deck 2006",
    "Starter Deck 2006": "Starter Deck: Jaden Yuki",
    "Starter Deck: Xyz Symphony": "Super Starter: V for Victory",
    "Starter Deck: Kaiba Reloaded": "Super Starter: Space-Time Showdown",
    "Super Starter: Space-Time Showdown": "Saber Force Starter Deck",
    "Saber Force Starter Deck": "Dark Legion Starter Deck",
}

while True:
    deck = handleDeck(title)
    
    inp = input("Enter to continue, anything else to quit: ")
    if "next" not in deck or inp != "": break

    if deck['name'] in nextReleaseExceptions:
        title = nextReleaseExceptions[deck['name']]
    elif not deck['next'].startswith("Starter Deck"):
        title = "Starter Deck: " + deck['next']
    else:
        title = deck['next']
            
    counter += 1