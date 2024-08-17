local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Absolute Powerforce"
    o.setCodePrefix = "ABPF-EN"
    o.setNameUrl = "Absolute Powerforce"
    o.releaseDate = "2010-02-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/034-ABPF.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/034-ABPF.png"

    return o
end

return PackGenerator
