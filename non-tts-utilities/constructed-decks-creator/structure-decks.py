import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil
import lib.files as files
import os
import atexit
import traceback
import time
import re


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

# this structure dont have the card list on their page bc something is broken on the wiki
# the list exeists on a separate site though; the linking just fails
# TODO: check in the future if its still broken
missingCardList = {
    "Structure Deck: Spellcaster's Judgment",
    "Structure Deck: Invincible Fortress",
    "Structure Deck: Lord of the Storm",
}

def handleDeck(title):
    deck = {}

    soup = wiki.getSoup(title)
    name = re.sub(r"[\s]*\(TCG\)[\s]*", "", title)
    deck['name'] = name
    deck['code'] = wiki.extractCode(soup)
    deck['image'] = wiki.extractImage(soup, name)
    deck['release-date'] = wiki.extractReleaseDate(soup)

    if name in missingCardList:
        cardListTitle = f"Set Card Lists:{name} (TCG-EN)"
        cardListSoup = wiki.getSoup(cardListTitle)
        deck['cards'] = wiki.extractCards(cardListSoup)
    else:
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