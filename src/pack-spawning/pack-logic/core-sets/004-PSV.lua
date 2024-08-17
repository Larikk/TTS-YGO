local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Pharaoh's Servant"
    o.setCodePrefix = "PSV-EN"
    o.setNameUrl = "Pharaoh's Servant"
    o.releaseDate = "2002-10-20"
    o.packTextures = imageHost .. "/textures/packs/coresets/004-PSV.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/004-PSV.png"

    return o
end

return PackGenerator
