local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Maximum Crisis"
    o.setCodePrefix = "MACR-EN"
    o.setNameUrl = "Maximum Crisis"
    o.releaseDate = "2017-05-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/063-MACR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/063-MACR.png"

    return o
end

return PackGenerator
