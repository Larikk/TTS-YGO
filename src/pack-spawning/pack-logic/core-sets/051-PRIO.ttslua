local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Primal Origin"
    o.setCodePrefix = "PRIO-EN"
    o.setNameUrl = "Primal Origin"
    o.releaseDate = "2014-05-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/051-PRIO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/051-PRIO.png"

    return o
end

return PackGenerator
