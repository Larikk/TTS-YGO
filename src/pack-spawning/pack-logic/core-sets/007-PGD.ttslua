local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Pharaonic Guardian"
    o.setCodePrefix = "PGD-"
    o.setNameUrl = "Pharaonic Guardian"
    o.releaseDate = "2003-07-18"
    o.packTextures = imageHost .. "/textures/packs/coresets/007-PGD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/007-PGD.png"

    return o
end

return PackGenerator
