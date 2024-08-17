local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Abyss Rising"
    o.setCodePrefix = "ABYR-EN"
    o.setNameUrl = "Abyss Rising"
    o.releaseDate = "2012-11-09"
    o.packTextures = imageHost .. "/textures/packs/coresets/045-ABYR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/045-ABYR.png"

    return o
end

return PackGenerator
