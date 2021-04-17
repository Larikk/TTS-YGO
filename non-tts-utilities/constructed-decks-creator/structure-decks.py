import lib.wiki as wiki
import lib.imgur as imgur
import lib.deckutil as deckutil

albumHash = "dhSibop" # can be found in url
imgur = imgur.Client(albumHash)

title = "Structure Deck: Dragon's Roar"
deck = wiki.download(title)
deck['imgur'] = imgur.getUrl(deck)
deckutil.printDeck(deck)
