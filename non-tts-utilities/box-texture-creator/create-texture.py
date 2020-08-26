from PIL import Image
import sys

def scaleTuple(tuple, scale):
    return (int(tuple[0]*scale), int(tuple[1]*scale))

def pasteAlphaComposite(background, foreground):
    fw, fh = foreground.size
    bw, bh = background.size
    offset = ((bw - fw) // 2, (bh - fh) // 2)
    background.alpha_composite(foreground, offset)

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
    return front

def addTop(img):
    top = Image.new("RGBA", (290, 194), "black")
    img.paste(top, (215, 7))

def addBottom(img):
    bottom = Image.new("RGBA", (290, 194), "black")
    img.paste(bottom, (727, 7))

def addLeft(img, logo):
    size = (194, 386)
    logoSize = scaleTuple(size, 0.8)
    left = Image.new("RGBA", size, "black")
    logo = logo.rotate(-90, expand = True)
    logo.thumbnail(logoSize)
    pasteAlphaComposite(left, logo)
    img.paste(left, (7, 215))

def addRight(img, logo):
    size = (194, 386)
    logoSize = scaleTuple(size, 0.8)
    left = Image.new("RGBA", size, "black")
    logo = logo.rotate(90, expand = True)
    logo.thumbnail(logoSize)
    pasteAlphaComposite(left, logo)
    img.paste(left, (519, 215))

def addFront(img, front):
    img.paste(front, (215, 215))

def addBack(img):
    back = Image.new("RGBA", (290, 386), "black")
    img.paste(back, (727, 215))



logo = Image.open("logo.png")
img = Image.new("RGBA", (1024, 768), None)

front = None
if len(sys.argv) < 2:
    print("No front image specified, creating placeholder")
    front = createPlaceholderFront(logo)
else:
    cover = Image.open(sys.argv[1])
    front = createFront(cover)


addTop(img)
addBottom(img)
addLeft(img, logo)
addRight(img, logo)
addFront(img, front)
addBack(img)
img.save("out.png", "PNG")
