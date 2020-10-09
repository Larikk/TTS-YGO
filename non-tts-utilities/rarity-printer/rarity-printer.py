import http.client
import json

# this is just a script to print information about single sets
# its very hacky and gets modfied on the fly

NAME = "Tournament Pack: 1st Season"
SET_CODE_PREFIX = "TP1-E"
NAME_URL = NAME.replace(" ", "%20")

def extractSetData(card):
    for set in card['card_sets']:
        if set['set_name'] == NAME and set['set_code'][:-3] == SET_CODE_PREFIX:
            result = {}
            result['rarity'] = set['set_rarity']
            result['setCode'] = set['set_code']
            return result

    return None

con = http.client.HTTPSConnection("db.ygoprodeck.com")
con.request("GET", "/api/v7/cardinfo.php?cardset=" + NAME_URL)
body = con.getresponse().read()
cards = json.loads(body)

counters = {}

parsedCards = []

for card in cards['data']:
    setData = extractSetData(card)
    if setData == None:
        print("Set data for " + card['name'] + " not found")
        continue

    rarity = setData['rarity']
    card['rarity'] = rarity
    card['setCode'] = setData['setCode']

    if rarity not in counters:
        counters[rarity] = 0

    counters[rarity] = counters[rarity] + 1
    parsedCards.append(card)

sortedCards = sorted(parsedCards, key=lambda card: card['setCode'])

for k, v in counters.items(): print(k, v)
print()
print("Sum", len(parsedCards))
for v in sortedCards: print(v['setCode'] + " " + v['name'] + " " + v['rarity'])

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
