local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Raging Tempest"
    o.setCodePrefix = "RATE-EN"
    o.setNameUrl = "Raging Tempest"
    o.releaseDate = "2017-02-10"
    o.packTextures = imageHost .. "/textures/packs/coresets/062-RATE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/062-RATE.png"

    return o
end

return PackGenerator
