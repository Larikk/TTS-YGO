local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Lightning Overdrive"
    o.setCodePrefix = "LIOV-EN"
    o.setNameUrl = "Lightning Overdrive"
    o.releaseDate = "2021-06-04"
    o.packTextures = imageHost .. "/textures/packs/coresets/079-LIOV.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/079-LIOV.png"

    return o
end

return PackGenerator
