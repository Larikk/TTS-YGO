local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Flames of Destruction"
    o.setCodePrefix = "FLOD-EN"
    o.setNameUrl = "Flames of Destruction"
    o.releaseDate = "2018-05-04"
    o.packTextures = imageHost .. "/textures/packs/coresets/067-FLOD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/067-FLOD.png"

    return o
end

return PackGenerator
