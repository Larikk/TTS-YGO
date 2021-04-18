import requests
from bs4 import BeautifulSoup
import re
import datetime

def ensureSingleSearchResult(resultSet, name):
    if len(resultSet) > 1:
        print(f"more than one hit for '{name}' found")
        exit(1)
    return resultSet[0]

def getSoup(title):
    params = [
        ("action", "parse"),
        ("format", "json"),
        ("prop", "text"),
        ("redirects", "true"),
        ("page", title),
    ]
    url = "https://yugioh.fandom.com/api.php?"

    for param in params:
        key, value = param[0], param[1]
        url += f"{key}={value}&"

    r = requests.get(url)

    if not r.ok:
        raise RuntimeError("Request failed.\n" + r)

    json = r.json()
    content = json["parse"]["text"]["*"]
    content = "<body>" + content + "</body>"
    soup = BeautifulSoup(content, features="html.parser")

    return soup

def extractImage(soup, name):
    infobox = soup.body.div.p.aside
    pattern = re.compile("[.]*" + name + "$")
    image = infobox.find_all("img", {"alt": pattern})
    image = ensureSingleSearchResult(image, "Image")
    url = image['src']
    url = url.split("/revision")[0]

    return url

def extractReleaseDate(soup):
    infobox = soup.body.div.p.aside
    date = infobox.find("h2", string="Release dates").find_next_sibling()

    while date.h3.text != "North America":
        date = date.find_next_sibling()
    
    date = date.div.text
    date = datetime.datetime.strptime(date, "%B %d, %Y")
    date = date.strftime("%Y-%m-%d")
    return date

def extractCode(soup):
    infobox = soup.body.div.p.aside
    prefix = infobox.find_all(string=re.compile("Prefix[.]*"))
    prefix = ensureSingleSearchResult(prefix, "Prefix")
    prefix = prefix \
        .parent \
        .find_next_sibling() \
        .ul \
        .li \
        .text

    prefix = prefix.split("-")[0]
    return prefix

def extractNext(soup):
    infobox = soup.body.div.p.aside
    next = infobox.find_all("td", {"data-source" : "next"})
    next = ensureSingleSearchResult(next, "Next")
    next = next.i.a.text
    return next

def extractCards(soup):
    tableContainer = soup.find("div", {"title": re.compile(r"[\s]*English[\s]*")}, class_="tabbertab")
    table = tableContainer.find("table", {"id": "Top_table"})

    rows = table.tbody(recursive=False)

    headerRow = rows[0]
    headers = [e.text for e in headerRow.children]

    linkExtractor = lambda e: e.a["title"]
    directExtractor = lambda e: e.text
    extractors = [
        linkExtractor,
        linkExtractor,
        linkExtractor,
        linkExtractor,
        directExtractor
    ]

    dataRows = rows[1:]
    cards = []
    for row in dataRows:
        card = {}
        i = 0
        for cell in row(recursive=False):
            text = extractors[i](cell)
            card[headers[i]] = text
            i = i+1
        cards.append(card)

    return cards

def download(title):
    deck = {}

    soup = getSoup(title)
    deck['name'] = title.split("-")[1].strip()
    deck['code'] = extractCode(soup)
    deck['image'] = extractImage(soup, deck['name'])
    deck['release-date'] = extractReleaseDate(soup)
    deck['cards'] = extractCards(soup)

    try:
        deck['next'] = "Structure Deck - " + extractNext(soup)
    except:
        print("WARNING: Extraction of next failed")
        deck['next'] = None

    return deck

def writeToFile(title, path):
    soup = getSoup(title)
    with open("test.html", "w", encoding="utf-8") as f:
        f.write(soup.prettify())

def foo():
    print("Foo")
