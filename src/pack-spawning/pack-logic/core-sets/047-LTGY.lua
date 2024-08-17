local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Lord of the Tachyon Galaxy"
    o.setCodePrefix = "LTGY-EN"
    o.setNameUrl = "Lord of the Tachyon Galaxy"
    o.releaseDate = "2013-05-17"
    o.packTextures = imageHost .. "/textures/packs/coresets/047-LTGY.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/047-LTGY.png"

    return o
end

return PackGenerator
