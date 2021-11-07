import lib.wiki as wiki
import lib.boosterutil as boosterutil
import lib.files as files
import traceback
import time

title = "Legend of Blue Eyes White Dragon"
counter = 1
folder = "core-sets"

path = "../../src/pack-spawning/pack-logic/" + folder

interactive = False

packImageMappings = files.getImageMappings("core-sets-packs.csv")
boxImageMappings = files.getImageMappings("core-sets-boxes.csv")

nextReleaseOutliers = {
}

# do not append "EN" to the setcode
shortSetCode = {
    "Pharaonic Guardian",
    "Magician's Force",
    "Ancient Sanctuary",
}

def parentLogic(counter):
    if 1 <= counter <= 11:
        return "A"
    elif 12 <= counter <= 21:
        return "B"
    elif 22 <= counter <= 23:
        return "C"
    elif 24 <= counter:
        return "D"

def handleBooster(title):
    booster = {}

    soup = wiki.getSoup(title)
    name = title
    booster['name'] = name
    booster['name-url'] = name
    booster['code'] = wiki.extractCode(soup)

    if name in shortSetCode:
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

        
    booster['pack-texture'] = packImageMappings[booster['code']]
    
    if booster['code'] in boxImageMappings:
        booster['box-texture'] = boxImageMappings[booster['code']]
    else:
        booster['box-texture'] = "nil"

    boosterutil.printBooster(booster)

    # Write tts file
    content = boosterutil.asTtsLuaFile(booster, folder, "_CoreSetLogic" + parentLogic(counter))
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
