import requests
from bs4 import BeautifulSoup
import re
import datetime
import traceback

def ensureSingleSearchResult(resultSet, name):
    if len(resultSet) > 1:
        print(f"more than one hit for '{name}' found")
        exit(1)
    
    if len(resultSet) == 0:
        print(f"No hit for '{name}' found")
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
    #pattern = re.compile("[.]*" + name + "$")
    #image = infobox.find_all("img", {"alt": pattern})
    #image = ensureSingleSearchResult(image, "Image")
    image = infobox.find("img") # just take the first, should be good enough
    url = image['src']
    url = url.split("/revision")[0]

    return url

def extractReleaseDate(soup):
    infobox = soup.body.div.p.aside
    date = infobox.find("h2", string="Release dates").find_next_sibling()

    regions = ["North America", "Worldwide"]
    while date.h3.text not in regions :
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

    prefix = prefix.split(" ")[0].split("-")[0]
    return prefix

def extractNext(soup):
    infobox = soup.body.div.p.aside
    nextRelease = infobox.find_all("td", {"data-source" : "next"})
    nextRelease = ensureSingleSearchResult(nextRelease, "Next")
    nextRelease = nextRelease.i.a.text.strip()
    return nextRelease

def getTableHeaders(row):
    cells = row.find_all("th")
    headers = [e.text.strip() for e in cells]

    replacements = {
        "Set number": "Card number"
    }

    result = []

    for header in headers:
        if header in replacements: result.append(replacements[header])
        else: result.append(header)

    return result

def extractCards(soup):
    tableContainer = soup.find("div", {"title": re.compile(r"[\s]*(English|North American)[\s]*")}, class_="tabbertab")

    table = None
    if tableContainer != None:
        # tables under tabs
        table = tableContainer.find("table")
    else:
        # no tabs, occurs when something releases only in one language
        tables = soup.find_all(table, class_="card-list")
        table = ensureSingleSearchResult(tables, "Card Table")
        

    rows = table.tbody(recursive=False)

    headers = getTableHeaders(rows[0])

    linkExtractor = lambda e: e.a.text.strip()
    directExtractor = lambda e: e.text.strip()
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

def getName(title):
    sep = ":"

    if sep in title:
        return title.split(sep)[1].strip()
    else:
        return title

def download(title):
    deck = {}

    soup = getSoup(title)
    deck['name'] = title
    deck['code'] = extractCode(soup)
    deck['image'] = extractImage(soup, deck['name'])
    deck['release-date'] = extractReleaseDate(soup)
    deck['cards'] = extractCards(soup)

    try:
        deck['next'] = extractNext(soup)
    except Exception as e:
        print("WARNING: Extraction of next failed")
        print(e)
        print(traceback.format_exc())

    return deck

def writeToFile(title, path):
    soup = getSoup(title)
    with open(path, "w", encoding="utf-8") as f:
        f.write(soup.prettify())

def foo():
    print("Foo")
