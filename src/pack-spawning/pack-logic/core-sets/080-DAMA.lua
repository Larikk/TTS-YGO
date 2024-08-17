local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dawn of Majesty"
    o.setCodePrefix = "DAMA-EN"
    o.setNameUrl = "Dawn of Majesty"
    o.releaseDate = "2021-08-13"
    o.packTextures = imageHost .. "/textures/packs/coresets/080-DAMA.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/080-DAMA.png"

    return o
end

return PackGenerator
