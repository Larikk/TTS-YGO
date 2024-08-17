local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Soul Fusion"
    o.setCodePrefix = "SOFU-EN"
    o.setNameUrl = "Soul Fusion"
    o.releaseDate = "2018-10-19"
    o.packTextures = imageHost .. "/textures/packs/coresets/069-SOFU.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/069-SOFU.png"

    return o
end

return PackGenerator
