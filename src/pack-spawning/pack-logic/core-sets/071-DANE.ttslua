local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dark Neostorm"
    o.setCodePrefix = "DANE-EN"
    o.setNameUrl = "Dark Neostorm"
    o.releaseDate = "2019-05-03"
    o.packTextures = imageHost .. "/textures/packs/coresets/071-DANE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/071-DANE.png"

    return o
end

return PackGenerator
