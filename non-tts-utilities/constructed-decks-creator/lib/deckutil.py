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
