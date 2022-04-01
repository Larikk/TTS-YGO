import lib.wiki as wiki
import lib.deckutil as deckutil
import lib.files as files
import traceback
import atexit
import time
import re

title = "Starter Deck: Yugi"
counter = 1
folder = "../../src/preconstructed-decks/starter-decks"

ydkOutputFolder = "../../../ygo-ydk-files/deck/"

interactive = False

imageMappings = files.getImageMappings("starter-decks.csv")

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder,
                "src/preconstructed-decks/starter-decks")

nextReleaseOutliers = {
    "Starter Deck: Kaiba Evolution": "Starter Deck 2006",
    "Starter Deck 2006": "Starter Deck: Jaden Yuki",
    "Starter Deck: Xyz Symphony": "Super Starter: V for Victory",
    "Starter Deck: Kaiba Reloaded": "Super Starter: Space-Time Showdown",
    "Super Starter: Space-Time Showdown": "Saber Force Starter Deck",
    "Saber Force Starter Deck": "Dark Legion Starter Deck",
    "Starter Deck: Codebreaker": "Egyptian God Deck: Slifer the Sky Dragon",
    "Egyptian God Deck: Slifer the Sky Dragon": "Egyptian God Deck: Obelisk the Tormentor",
    "Egyptian God Deck: Obelisk the Tormentor": None,
}


def handleDeck(title):
    deck = {}

    soup = wiki.getSoup(title)
    name = title
    deck['name'] = name

    # These two have the same code prefix
    if name == "Saber Force Starter Deck":
        deck['code'] = "YS15F"
    elif name == "Dark Legion Starter Deck":
        deck['code'] = "YS15L"
    else:
        deck['code'] = wiki.extractCode(soup)

    deck['image'] = wiki.extractImage(soup, name)
    deck['release-date'] = wiki.extractReleaseDate(soup)
    deck['cards'] = wiki.extractCards(soup)

    if name in nextReleaseOutliers:
        deck['next'] = nextReleaseOutliers[name]
    else:
        try:
            nextRelease = wiki.extractNext(soup)
            deck['next'] = nextRelease
        except Exception as e:
            print("WARNING: Extraction of next failed")
            print(e)
            print(traceback.format_exc())

    deck['image'] = f'/textures/decks/starter/{counter:03d}-{deck["code"]}.jpg'
    deck['cards'] = deckutil.sortCards(deck)
    deck['ydk'] = deckutil.asYdkFile(deck)
    deckutil.printDeck(deck)

    # Write tts file
    content = deckutil.asTtsLuaFile(deck)
    filename = f"{counter:03d}-{deck['code']}.ttslua"
    files.write(folder, filename, content)

    # Write ydk file
    content = deck['ydk']
    filename = deck['name'].replace(":", "")
    filename = re.sub(r"^Starter Deck[^a-zA-Z0-9']*", "", filename)
    filename = f"STA{counter:02d} {filename}.ydk"
    files.write(ydkOutputFolder, filename, content)

    return deck


while True:
    deck = handleDeck(title)

    if interactive:
        inp = input("Enter to continue, anything else to quit: ")
        if "next" not in deck or inp != "":
            break
    else:
        time.sleep(1)

    title = deck['next']
    counter += 1
