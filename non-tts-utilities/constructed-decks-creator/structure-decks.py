import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil
import lib.files as files
import os
import atexit

title = "Structure Deck: Dragon's Roar"
counter = 1
folder = "../../src/preconstructed-decks/structure-decks"

albumHash = "dhSibop" # can be found in url
imgur = imgur.Client(albumHash)

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder, "src/preconstructed-decks/structure-decks")

def handleDeck(title):
    deck = wiki.download(title)
    deck['imgur'] = imgur.getUrl(deck['name'], deck['image'])
    deck['cards'] = deckutil.sortCards(deck)
    deck['ydk'] = deckutil.asYdkFile(deck)
    deckutil.printDeck(deck)

    # Write deck
    content = deckutil.asTtsLuaFile(deck)
    filename = f"{counter:03d} - {deck['name']}.ttslua"
    files.write(folder, filename, content)

    return deck


while True:
    deck = handleDeck(title)
    
    inp = input("Enter to continue, anything else to quit: ")
    if "next" not in deck or inp != "": break

    title = "Structure Deck: " + deck['next']
    counter += 1