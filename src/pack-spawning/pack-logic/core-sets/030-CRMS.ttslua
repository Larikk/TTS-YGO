local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Crimson Crisis"
    o.setCodePrefix = "CRMS-EN"
    o.setNameUrl = "Crimson Crisis"
    o.releaseDate = "2009-03-03"
    o.packTextures = imageHost .. "/textures/packs/coresets/030-CRMS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/030-CRMS.png"

    return o
end

return PackGenerator
