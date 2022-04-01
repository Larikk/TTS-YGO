local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Phantom Rage"
    o.setCodePrefix = "PHRA-EN"
    o.setNameUrl = "Phantom Rage"
    o.releaseDate = "2020-11-06"
    o.packTextures = imageHost .. "/textures/packs/coresets/077-PHRA.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/077-PHRA.png"

    return o
end

return PackGenerator
