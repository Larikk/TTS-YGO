import http.client
import json

NAME = "Metal Raiders"
NAME_URL = NAME.replace(" ", "%20")

def extractRarity(card):
    for set in card['card_sets']:
        if set['set_name'] == NAME:
            return set['set_rarity']

    print("Rarity for " + card['name'] + " not found")
    return None

con = http.client.HTTPSConnection("db.ygoprodeck.com")
con.request("GET", "/api/v7/cardinfo.php?cardset=" + NAME_URL)
body = con.getresponse().read()
cards = json.loads(body)

counters = {}

for card in cards['data']:
    rarity = extractRarity(card)

    if rarity not in counters:
        counters[rarity] = 0

    counters[rarity] = counters[rarity] + 1

print(counters)
