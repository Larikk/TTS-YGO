local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "The Dark Illusion"
    o.setCodePrefix = "TDIL-EN"
    o.setNameUrl = "The Dark Illusion"
    o.releaseDate = "2016-08-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/060-TDIL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/060-TDIL.png"

    return o
end

return PackGenerator
