import http.client
import json
import sys

# this is just a script to print information about single sets
# its very hacky and gets modfied on the fly

NAME = "Battle Pack 2: War of the Giants"
SET_CODE_PREFIX = "BP02-EN"
NAME_URL = NAME.replace(" ", "%20")

def extractSetData(card):
    entries = []
    for set in card['card_sets']:
        if set['set_name'] == NAME and set['set_code'][:-3] == SET_CODE_PREFIX:
            entry = {}
            entry['rarity'] = set['set_rarity']
            entry['setCode'] = set['set_code']
            entries.append(entry)

    return entries

def cardToString(card):
    str = card['setCode'] + " " + card['name'] + "\n"
    for entry in card['setData']:
        str += "\t" + entry['rarity'] + "\n"
    return str

con = http.client.HTTPSConnection("db.ygoprodeck.com")
con.request("GET", "/api/v7/cardinfo.php?cardset=" + NAME_URL)
body = con.getresponse().read()
cards = json.loads(body)

counters = {}

parsedCards = []

for card in cards['data']:
    setData = extractSetData(card)
    card['setData'] = setData
    card['setCode'] = setData[0]['setCode']
    parsedCards.append(card)

    for entry in setData:
        rarity = entry['rarity']
        if rarity not in counters:
            counters[rarity] = 0
        counters[rarity] = counters[rarity] + 1



sortedCards = sorted(parsedCards, key=lambda card: card['setCode'])

for k, v in counters.items(): print(k, v)
print()
print("Sum", len(cards['data']))
print()

n = 1
areCardsMissing = False
missingSetCodes = []
for card in sortedCards:
    code = card['setCode'][-3:]
    code = int(code)

    while n < code:
        areCardsMissing = True
        missingCode = "%03d" % (n)
        print(missingCode + " seems to be missing #########################################\n", file=sys.stderr)
        missingSetCodes.append(missingCode)
        n = n + 1

    print(cardToString(card))
    n = n + 1

print()
if areCardsMissing:
    print(str(len(missingSetCodes)) + " cards seem to be missing:", file=sys.stderr)
    for v in missingSetCodes: print(v)
else:
    print("No cards seem to be missing")
