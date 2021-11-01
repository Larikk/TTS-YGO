import requests
from functools import cmp_to_key

def printDeck(deck):
    print("Name", deck['name'])
    print("Code", deck['code'])
    print("Date", deck['release-date'])
    print("Image", deck['image'])
    if 'next' in deck:
        print("Next", deck['next'])

    cards = ""
    for card in deck['cards']:
        cards += card['Card number'] + " "
        cards += card['Name'].ljust(60) + " "
        cards += card['Rarity'].ljust(25) + " "
        cards += card['Category'].ljust(30) + " "
        if 'Qty' in card:
            cards += card['Qty'] + " "
        cards += "\n"

    print(cards)

#Sorts by rarity and then set code
rarityOrder = ["Secret Rare", "Ultra Rare", "Shatterfoil Rare", "Super Rare", "Rare", "Common"]
def compareCards(a, b):
    deltaRarity = a['__r'] - b['__r']
    
    if deltaRarity == 0:
        return a['__n'] - b['__n']
    
    return deltaRarity

def sortCards(deck):
    cards = deck['cards']

    lengthCodeNumber = 0
    for c in reversed(cards[0]['Card number']):
        if c.isdigit():
            lengthCodeNumber += 1
        else:
            break

    # makes comparing above faster and easier
    for card in cards:
        card['__r'] = rarityOrder.index(card['Rarity'])
        card['__n'] = int(card['Card number'][-lengthCodeNumber])

    return sorted(cards, key=cmp_to_key(compareCards))

def isExtraDeckCard(cardType):
    types = ["Fusion", "Synchro", "XYZ", "Link"]

    isExtra = False
    for type_ in types:
        if type_ in cardType:
            isExtra = True
            break
    return isExtra

def attachAdditionalData(deck):
    cards = deck['cards']

    names = [card['Name'] for card in cards]
    names = "|".join(names)

    r = requests.get("https://db.ygoprodeck.com/api/v7/cardinfo.php", params={"name": names, "misc": "yes"})
    
    nameToDataMapping = {}
    json = r.json()

    for cardData in json['data']:
        name = cardData['name'].lower()
        nameToDataMapping[name] = cardData

        # handle renames
        for misc in cardData['misc_info']:
            if 'beta_name' in misc:
                name = misc['beta_name'].lower()
                nameToDataMapping[name] = cardData

    for card in cards:
        name = card['Name'].lower()
        data = nameToDataMapping[name]
        card['id'] = str(data['id'])
        card['isExtraDeckCard'] = isExtraDeckCard(data['type'])
    

def asYdkFile(deck):
    attachAdditionalData(deck)

    main = []
    extra = []

    for card in deck['cards']:
        id = card['id']
        isExtra = card['isExtraDeckCard']
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

def asTtsLuaFile(deck):
    return f"""\
return {{
    code = "{deck['code']}",
    name = "{deck['name']}",
    releaseDate = "{deck['release-date']}",
    image = "{deck['image']}",
    cards = [[
{deck['ydk']}
]]
}}
"""
