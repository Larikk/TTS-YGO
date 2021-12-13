import lib.wiki as wiki
import lib.deckutil as deckutil
import lib.files as files
import atexit
import traceback
import time
import re


title = "Structure Deck: Dragon's Roar"
counter = 1
folder = "../../src/preconstructed-decks/structure-decks"

ydkOutputFolder = "../../../ygo-ydk-files/deck/"

interactive = False

imageMappings = files.getImageMappings("structure-decks.csv")

# Run even if programm terminates unsuccessfully
atexit.register(files.compileDeckList, folder, "src/preconstructed-decks/structure-decks")

nextReleaseOutliers = {
    "Machine Re-Volt": "Structure Deck: Rise of the Dragon Lords",
    "Seto Kaiba": "Structure Deck: Pendulum Domination",
    "Machina Mayhem": "Structure Deck: Marik (TCG)",
    "Dragunity Legion": "Structure Deck: Lost Sanctuary (TCG)",
    "Realm of the Sea Emperor": "Structure Deck: Onslaught of the Fire Kings (TCG)",
    "Seto Kaiba": "Pendulum Domination Structure Deck",
    "Cyberse Link": "Structure Deck: Wave of Light",
    "Powercode Link": "Structure Deck: Zombie Horde",
    "Soulburner": "Structure Deck: Order of the Spellcasters",
    "Freezing Chains": None,
}

# this structure dont have the card list on their page bc something is broken on the wiki
# the list exeists on a separate site though; the linking just fails
# TODO: check in the future if its still broken
missingCardList = {
    "Spellcaster's Judgment",
    "Invincible Fortress",
    "Lord of the Storm",
}

def handleDeck(title):
    deck = {}

    soup = wiki.getSoup(title)
    name = re.sub(r"[\s]*(\(TCG\)|Structure Deck)[:]*[\s]*[-]*[\s]*", "", title)
    deck['name'] = name
    deck['code'] = wiki.extractCode(soup)

    if deck['code'] == "SR10":
        deck['image'] = "https://ms.yugipedia.com//0/09/SR10-DeckEN.png"
    else:
        deck['image'] = wiki.extractImage(soup, name)

    deck['release-date'] = wiki.extractReleaseDate(soup)

    if name in missingCardList:
        cardListTitle = f"Set Card Lists:Structure Deck: {name} (TCG-EN)"
        cardListSoup = wiki.getSoup(cardListTitle)
        deck['cards'] = wiki.extractCards(cardListSoup)
    elif deck['code'] == "SDCH":
        # Spirit charmers has three tables on its page
        tableOverride = soup.find("table", id="Preconstructed_Deck")
        deck['cards'] = wiki.extractCards(soup, tableOverride=tableOverride)
    else:
        deck['cards'] = wiki.extractCards(soup)

    # temporary shuffle of the cards to fix query to the API
    # TODO revisit this again in a couple days
    if deck['code'] == "SDMP":
        cards = deck['cards']
        cards[0], cards[1] = cards[1], cards[0]

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

    
    deck['image'] = imageMappings[deck['code']]
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
    filename = f"SU{counter:02d} {filename}.ydk"
    files.write(ydkOutputFolder, filename, content)

    return deck


while True:
    deck = handleDeck(title)
    
    if interactive:
        if "next" not in deck: break
        inp = input("Enter to continue, anything else to quit: ")
        if inp != "": break
    else:
        time.sleep(1)

    title = deck['next']
    counter += 1
