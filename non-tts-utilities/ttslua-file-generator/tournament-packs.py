import lib.wiki as wiki
import lib.imgur as imgur
import lib.boosterutil as boosterutil
import lib.files as files
import traceback
import time

title = "Tournament Pack: 1st Season"
counter = 1
folder = "tournament-packs"

path = "../../src/pack-spawning/pack-logic/" + folder

interactive = True

packAlbumHash = "1UnBy9J" # can be found in url
packsImgur = imgur.Client(packAlbumHash)

nextReleaseOutliers = {
}

def handleBooster(title):
    booster = {}

    soup = wiki.getSoup(title)
    name = title
    booster['name'] = name
    booster['name-url'] = name
    booster['code'] = wiki.extractCode(soup)
    if counter <= 4 and title.startswith("Tournament Pack"):
        booster['code-long'] = booster['code'] + "-"
    else:
        booster['code-long'] = booster['code'] + "-EN"
    
    booster['image'] = wiki.extractImage(soup, name)
    booster['release-date'] = wiki.extractReleaseDate(soup)

    if name in nextReleaseOutliers:
        booster['next'] = nextReleaseOutliers[name]
    else:
        try:
            nextRelease = wiki.extractNext(soup)
            booster['next'] = nextRelease
        except Exception as e:
            print("WARNING: Extraction of next failed")
            print(e)
            print(traceback.format_exc())

    
    booster['pack-texture'] = packsImgur.getUrl(name, booster['image'])
    booster['box-texture'] = "nil"

    boosterutil.printBooster(booster)

    # Write tts file
    content = boosterutil.asTtsLuaFile(booster, folder, "_Logic")
    filename = f"{counter:03d}-{booster['code']}.ttslua"
    files.write(path, filename, content)

    return booster


while True:
    booster = handleBooster(title)
    
    if interactive:
        if "next" not in booster: break
        inp = input("Enter to continue, anything else to quit: ")
        if inp != "": break
    else:
        time.sleep(2)

    title = booster['next']
    counter += 1
