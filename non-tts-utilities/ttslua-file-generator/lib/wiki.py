import os
from pathlib import Path
import time
import requests
from bs4 import BeautifulSoup
import re
import datetime

CACHE_FOLDER = "cache/"
os.makedirs(CACHE_FOLDER, exist_ok=True)


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
    url = "https://yugipedia.com/api.php?"

    for param in params:
        key, value = param[0], param[1]
        url += f"{key}={value}&"

    cachedFileName = CACHE_FOLDER + re.sub(r"[^a-zA-Z0-9]", "", url)
    content = None

    if os.path.exists(cachedFileName):
        with open(cachedFileName, "r") as f:
            content = f.read()
    else:
        print("downloading")
        r = requests.get(url)

        if not r.ok:
            raise RuntimeError("Request failed.\n" + r)

        json = r.json()
        content = json["parse"]["text"]["*"]
        content = "<body>" + content + "</body>"
        with open(cachedFileName, "w") as f:
            f.write(content)
        time.sleep(1.5)

    soup = BeautifulSoup(content, features="html.parser")

    return soup


def extractInfobox(soup):
    infobox = soup.body.find_all("table", class_="infobox-yugipedia")
    infobox = ensureSingleSearchResult(infobox, "Infobox")
    return infobox


def extractLabelFromInfoboxRow(row):
    cell = row.find("th", class_="infobox-label")
    text = cell.text
    text = text.replace("\xa0", " ").strip()
    return text


def extractDataFromInfoboxRow(row):
    cell = row.find("td", class_="infobox-data")
    text = cell.text.strip()
    return text


def extractImage(soup, name):
    infobox = extractInfobox(soup)
    #pattern = re.compile("[.]*" + name + "$")
    #image = infobox.find_all("img", {"alt": pattern})
    #image = ensureSingleSearchResult(image, "Image")
    image = infobox.find("img")  # just take the first, should be good enough
    url = image['src']
    url = url.split("/revision")[0]

    return url


def extractReleaseDate(soup):
    infobox = extractInfobox(soup)
    dateHeaderRow = infobox.find("tr", string="Release dates")
    dateRows = dateHeaderRow.find_next_siblings("tr")

    def textFilter(row): return row.text.startswith("English")

    dateRows = list(filter(textFilter, dateRows))

    regions = ["English (na)", "English (world)"]

    dateRow = None
    # Nested loop because the first entry should be prioritized
    for region in regions:
        for row in dateRows:
            if extractLabelFromInfoboxRow(row) == region:
                dateRow = row
                break
        if dateRow is not None:
            break

    if dateRow is None:
        raise RuntimeError("Could not extract release date")

    dateRow = extractDataFromInfoboxRow(dateRow)
    dateRow = datetime.datetime.strptime(dateRow, "%B %d, %Y")
    dateRow = dateRow.strftime("%Y-%m-%d")
    return dateRow


def extractCode(soup):
    infobox = extractInfobox(soup)
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
    infobox = extractInfobox(soup)
    nextRelease = infobox.find_all("div", class_="nav-next")
    nextRelease = ensureSingleSearchResult(nextRelease, "Next")
    nextRelease = nextRelease.find("a")['title'].strip()
    return nextRelease


def getTableHeaders(row):
    cells = row.find_all("th")
    headers = [e.text.strip() for e in cells]

    replacements = {
        "Set number": "Card number"
    }

    result = []

    for header in headers:
        if header in replacements:
            result.append(replacements[header])
        else:
            result.append(header)

    return result


def extractCards(soup, tableOverride=None):
    #tableContainer = soup.find("div", {"title": re.compile(r"[\s]*(English|North American)[\s]*")}, class_="tabbertab")
    tableContainer = soup.find("div", class_="wds-tab__content wds-is-current")

    table = None
    if tableOverride != None:
        table = tableOverride
    elif tableContainer != None:
        # tables under tabs
        table = tableContainer.find("table")
    else:
        # no tabs, occurs when something releases only in one language
        tables = soup.find_all(table, class_="card-list")
        table = ensureSingleSearchResult(tables, "Card Table")

    rows = table.tbody(recursive=False)

    headers = getTableHeaders(rows[0])

    def linkExtractor(e): return e.a.text.strip()
    def directExtractor(e): return e.text.strip()
    extractors = [
        directExtractor,
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
        if card[headers[0]].endswith("TKN"):
            continue
        cards.append(card)

    return cards


def getName(title):
    sep = ":"

    if sep in title:
        return title.split(sep)[1].strip()
    else:
        return title


def writeToFile(title, path):
    soup = getSoup(title)
    with open(path, "w", encoding="utf-8") as f:
        f.write(soup.prettify())
