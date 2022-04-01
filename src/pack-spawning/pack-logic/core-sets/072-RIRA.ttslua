local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicF")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Rising Rampage"
    o.setCodePrefix = "RIRA-EN"
    o.setNameUrl = "Rising Rampage"
    o.releaseDate = "2019-07-26"
    o.packTextures = imageHost .. "/textures/packs/coresets/072-RIRA.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/072-RIRA.png"

    return o
end

return PackGenerator
