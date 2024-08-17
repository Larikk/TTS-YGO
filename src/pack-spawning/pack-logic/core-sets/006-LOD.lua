local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Legacy of Darkness"
    o.setCodePrefix = "LOD-EN"
    o.setNameUrl = "Legacy of Darkness"
    o.releaseDate = "2003-06-06"
    o.packTextures = imageHost .. "/textures/packs/coresets/006-LOD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/006-LOD.png"

    return o
end

return PackGenerator
