local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Invasion of Chaos"
    o.setCodePrefix = "IOC-EN"
    o.setNameUrl = "Invasion of Chaos"
    o.releaseDate = "2004-03-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/010-IOC.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/010-IOC.png"

    return o
end

return PackGenerator
