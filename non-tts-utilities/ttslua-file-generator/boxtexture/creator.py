from PIL import Image, ImageDraw
import sys
import requests
import os

def scaleTuple(tuple, scale):
    return (int(tuple[0]*scale), int(tuple[1]*scale))

def pasteAlphaComposite(background, foreground):
    fw, fh = foreground.size
    bw, bh = background.size
    offset = ((bw - fw) // 2, (bh - fh) // 2)
    background.alpha_composite(foreground, offset)

def drawBorders(img):
    draw = ImageDraw.Draw(img)
    w, h = img.size
    draw.rectangle((0, 0, w-1, h-1), outline="grey", width=4)

def drawBack(img):
    draw = ImageDraw.Draw(img)
    w, h = img.size

    polygons = [
        # Outer trapeze
        (
            (0, 0),
            (w*0.6, h*0.25),
            (w*0.6, h*0.75),
            (0, h-1),
        ),
        
        # Upper line
        (
            (w-1, 0),
            (w*0.49, h*0.2)
        ),

        # Lower line
        (
            (w-1, h-1),
            (w*0.49, h*0.8)
        ),
    ]

    for polygon in polygons:
        draw.line(polygon, fill="grey", width=4, joint="curve")

def createFront(cover):
    size = (290, 386)
    cover = cover.rotate(90, expand = True)
    cover = cover.resize(size, Image.LANCZOS)
    return cover

def createPlaceholderFront(logo):
    size = (290, 386)
    logoSize = scaleTuple(size, 0.8)
    logo = logo.rotate(90, expand = True)
    logo.thumbnail(logoSize, Image.LANCZOS)
    front = Image.new("RGBA", size, "black")
    pasteAlphaComposite(front, logo)
    drawBorders(front)
    return front

def addTop(img):
    top = Image.new("RGBA", (290, 194), "black")
    drawBorders(top)
    img.paste(top, (215, 7))

def addBottom(img):
    bottom = Image.new("RGBA", (290, 194), "black")
    drawBorders(bottom)
    img.paste(bottom, (727, 7))

def addLeft(img, logo):
    size = (194, 386)
    logoSize = scaleTuple(size, 0.8)
    left = Image.new("RGBA", size, "black")
    logo = logo.rotate(-90, expand = True)
    logo.thumbnail(logoSize)
    pasteAlphaComposite(left, logo)
    drawBorders(left)
    img.paste(left, (7, 215))

def addRight(img, logo):
    size = (194, 386)
    logoSize = scaleTuple(size, 0.8)
    right = Image.new("RGBA", size, "black")
    logo = logo.rotate(90, expand = True)
    logo.thumbnail(logoSize)
    pasteAlphaComposite(right, logo)
    drawBorders(right)
    img.paste(right, (519, 215))

def addFront(img, front):
    img.paste(front, (215, 215))

def addBack(img):
    back = Image.new("RGBA", (290, 386), "black")
    drawBorders(back)
    drawBack(back)
    img.paste(back, (727, 215))


def create(path):
    logo = os.path.join(os.path.dirname(__file__), 'logo.png')
    logo = Image.open(logo)
    img = Image.new("RGBA", (1024, 768), None)

    front = None
    if path == None:
        print("No front image specified, creating placeholder")
        front = createPlaceholderFront(logo)
    else:
        cover = path
        # if true -> url, otherwise local file
        if cover.startswith("http"):
            cover = requests.get(cover, stream=True).raw
        cover = Image.open(cover)
        front = createFront(cover)


    addTop(img)
    addBottom(img)
    addLeft(img, logo)
    addRight(img, logo)
    addFront(img, front)
    addBack(img)
    img.save("box.png", "PNG")
