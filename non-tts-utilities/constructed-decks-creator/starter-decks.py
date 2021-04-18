import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil
import lib.files as files
import os
import atexit

title = "Starter Deck: Yugi"
counter = 1
folder = "../../src/preconstructed-decks/starter-decks"

albumHash = "xKSFdRb" # can be found in url
imgur = imgur.Client(albumHash)

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder, "src/preconstructed-decks/starter-decks")

def handleDeck(title):
    os.system('cls' if os.name=='nt' else 'clear') # works in powershell too
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

    title = "Starter Deck: " + deck['next']
    counter += 1