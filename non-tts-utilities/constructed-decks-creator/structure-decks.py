import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil

albumHash = "dhSibop" # can be found in url
imgur = imgur.Client(albumHash)

title = "Structure Deck: Dragon's Roar"
deck = wiki.download(title)
deck['imgur'] = imgur.getUrl(deck['name'])
deck['cards'] = deckutil.sortCards(deck)
deck['ydk'] = deckutil.asYdkFile(deck)
deckutil.printDeck(deck)
