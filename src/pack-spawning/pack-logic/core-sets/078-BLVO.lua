local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Blazing Vortex"
    o.setCodePrefix = "BLVO-EN"
    o.setNameUrl = "Blazing Vortex"
    o.releaseDate = "2021-02-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/078-BLVO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/078-BLVO.png"

    return o
end

return PackGenerator
