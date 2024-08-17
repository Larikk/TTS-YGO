local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Legend of Blue Eyes White Dragon"
    o.setCodePrefix = "LOB-EN"
    o.setNameUrl = "Legend of Blue Eyes White Dragon"
    o.releaseDate = "2002-03-08"
    o.packTextures = imageHost .. "/textures/packs/coresets/001-LOB.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/001-LOB.png"

    return o
end

return PackGenerator
