import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil
import lib.files as files
import os
import atexit
import traceback
import time


title = "Structure Deck: Dragon's Roar"
counter = 1
folder = "../../src/preconstructed-decks/structure-decks"

interactive = True

albumHash = "dhSibop" # can be found in url
imgur = imgur.Client(albumHash)

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder, "src/preconstructed-decks/structure-decks")

nextReleaseOutliers = {
    "Structure Deck: Machine Re-Volt": "Structure Deck: Rise of the Dragon Lords",
    "Structure Deck: Seto Kaiba": "Structure Deck: Pendulum Domination",
}

def handleDeck(title):
    deck = {}

    soup = wiki.getSoup(title)
    name = title
    deck['name'] = name
    deck['code'] = wiki.extractCode(soup)
    deck['image'] = wiki.extractImage(soup, name)
    deck['release-date'] = wiki.extractReleaseDate(soup)
    deck['cards'] = wiki.extractCards(soup)

    if name in nextReleaseOutliers:
        deck['next'] = nextReleaseOutliers[name]
    else:
        try:
            nextRelease = wiki.extractNext(soup)
            if not nextRelease.startswith("Structure Deck"):
                nextRelease = "Structure Deck: " + nextRelease
            deck['next'] = nextRelease
        except Exception as e:
            print("WARNING: Extraction of next failed")
            print(e)
            print(traceback.format_exc())

    
    deck['imgur'] = imgur.getUrl(name, deck['image'])
    deck['cards'] = deckutil.sortCards(deck)
    deck['ydk'] = deckutil.asYdkFile(deck)
    deckutil.printDeck(deck)


    # Write deck
    content = deckutil.asTtsLuaFile(deck)
    filename = f"{counter:03d}-{deck['code']}.ttslua"
    files.write(folder, filename, content)

    return deck


while True:
    deck = handleDeck(title)
    
    if interactive:
        inp = input("Enter to continue, anything else to quit: ")
        if "next" not in deck or inp != "": break
    else:
        time.sleep(1)

    title = deck['next']
    counter += 1