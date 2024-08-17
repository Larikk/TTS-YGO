local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Code of the Duelist"
    o.setCodePrefix = "COTD-EN"
    o.setNameUrl = "Code of the Duelist"
    o.releaseDate = "2017-08-04"
    o.packTextures = imageHost .. "/textures/packs/coresets/064-COTD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/064-COTD.png"

    return o
end

return PackGenerator
