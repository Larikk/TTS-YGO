local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Shining Victories"
    o.setCodePrefix = "SHVI-EN"
    o.setNameUrl = "Shining Victories"
    o.releaseDate = "2016-05-06"
    o.packTextures = imageHost .. "/textures/packs/coresets/059-SHVI.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/059-SHVI.png"

    return o
end

return PackGenerator
