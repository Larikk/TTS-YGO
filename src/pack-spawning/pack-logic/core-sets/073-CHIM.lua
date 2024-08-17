local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicF")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Chaos Impact"
    o.setCodePrefix = "CHIM-EN"
    o.setNameUrl = "Chaos Impact"
    o.releaseDate = "2019-10-25"
    o.packTextures = imageHost .. "/textures/packs/coresets/073-CHIM.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/073-CHIM.png"

    return o
end

return PackGenerator
