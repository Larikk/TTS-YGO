import requests

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

def getIds(deck):
    cards = deck['cards']

    names = [card['Name'] for card in cards]
    names = "|".join(names)

    r = requests.get("https://db.ygoprodeck.com/api/v7/cardinfo.php", params={"name": names})
    
    nameToIdMapping = {}
    json = r.json()

    for card in json['data']:
        id = card['id']
        name = card['name']
        nameToIdMapping[name] = str(id)
    
    return nameToIdMapping

def isExtraDeckCard(card):
    category = card['Category']
    types = ["Fusion", "Synchro", "Xyz", "Link"]

    isExtra = False
    for type_ in types:
        if type_ in category:
            isExtra = True
            break
    return isExtra

def asYdkFile(deck):
    nameToIdMapping = getIds(deck)

    main = []
    extra = []

    for card in deck['cards']:
        isExtra = isExtraDeckCard(card)
        id = nameToIdMapping[card['Name']]
        n = 1
        if 'Qty' in card: n = int(card['Qty'])
        for _ in range(n):
            if isExtra:
                extra.append(id)
            else:
                main.append(id)

    if len(main) > 0:
        main = "#main\n" + "\n".join(main) + "\n"
    else:
        main = "#main\n"

    if len(extra) > 0:
        extra = "#extra\n" + "\n".join(extra) + "\n"
    else:
        extra = "#extra\n"
    
    result = "#created by ...\n"
    result += main
    result += extra
    result += "!side"

    return result
