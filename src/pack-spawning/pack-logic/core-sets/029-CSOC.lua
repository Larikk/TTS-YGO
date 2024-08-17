local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Crossroads of Chaos"
    o.setCodePrefix = "CSOC-EN"
    o.setNameUrl = "Crossroads of Chaos"
    o.releaseDate = "2008-11-18"
    o.packTextures = imageHost .. "/textures/packs/coresets/029-CSOC.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/029-CSOC.png"

    return o
end

return PackGenerator
