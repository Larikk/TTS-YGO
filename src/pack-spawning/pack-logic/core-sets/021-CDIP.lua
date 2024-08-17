local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Cyberdark Impact"
    o.setCodePrefix = "CDIP-EN"
    o.setNameUrl = "Cyberdark Impact"
    o.releaseDate = "2006-11-15"
    o.packTextures = imageHost .. "/textures/packs/coresets/021-CDIP.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/021-CDIP.png"

    return o
end

return PackGenerator
