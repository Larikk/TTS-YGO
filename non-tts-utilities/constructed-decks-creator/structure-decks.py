import lib.wiki as wiki
import lib.imgur as imgur

def printDeck(deck):
    print("Name", deck['name'])
    print("Code", deck['code'])
    print("Image", deck['image'])
    print("Next", deck['next'])

    cards = ""
    for card in deck['cards']:
        cards += card['Card number'] + " "
        cards += card['Name'].ljust(60) + " "
        cards += card['Rarity'].ljust(15) + " "
        cards += card['Category'].ljust(30) + " "
        if 'Qty' in card:
            cards += card['Qty'] + " "
        cards += "\n"

    print(cards)

albumHash = "dhSibop" # can be found in url
imgur = imgur.Client(albumHash)

title = "Structure Deck: Zombie World"
deck = wiki.download(title)
deck['imgur'] = imgur.getUrl(deck)
printDeck(deck)
