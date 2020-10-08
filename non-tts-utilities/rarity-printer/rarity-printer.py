import http.client
import json

# this is just a script to print information about single sets
# its very hacky and gets modfied on the fly

NAME = "Pharaonic Guardian"
NAME_URL = NAME.replace(" ", "%20")

def extractRarity(card):
    for set in card['card_sets']:
        if set['set_name'] == NAME:
            return set['set_rarity']

    print("Rarity for " + card['name'] + " not found")
    return None

def extractSetCode(card):
    for set in card['card_sets']:
        if set['set_name'] == NAME:
            return set['set_code']

    print("SetCode for " + card['name'] + " not found")
    return None

con = http.client.HTTPSConnection("db.ygoprodeck.com")
con.request("GET", "/api/v7/cardinfo.php?cardset=" + NAME_URL)
body = con.getresponse().read()
cards = json.loads(body)

counters = {}
sum = 0

for card in cards['data']:
    rarity = extractRarity(card)
    setCode = extractSetCode(card)

    card['rarity'] = rarity
    card['setCode'] = setCode

    if rarity not in counters:
        counters[rarity] = 0

    counters[rarity] = counters[rarity] + 1
    sum = sum + 1

sortedCards = sorted(cards['data'], key=lambda card: card['setCode'])

for k, v in counters.items(): print(k, v)
print()
print("Sum", sum)
#for v in sortedCards: print(v['setCode'] + " " + v['name'] + " " + v['rarity'])

n = 0
missingSetCodes = []
for card in sortedCards:
    code = card['setCode'][-3:]
    code = int(code)

    while n < code:
        missingSetCodes.append("%03d" % (n))
        n = n + 1

    n = n + 1

for v in missingSetCodes: print(v)
