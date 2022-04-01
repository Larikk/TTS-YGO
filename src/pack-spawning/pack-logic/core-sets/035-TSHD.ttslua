local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "The Shining Darkness"
    o.setCodePrefix = "TSHD-EN"
    o.setNameUrl = "The Shining Darkness"
    o.releaseDate = "2010-05-11"
    o.packTextures = imageHost .. "/textures/packs/coresets/035-TSHD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/035-TSHD.png"

    return o
end

return PackGenerator
