local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Enemy of Justice"
    o.setCodePrefix = "EOJ-EN"
    o.setNameUrl = "Enemy of Justice"
    o.releaseDate = "2006-05-17"
    o.packTextures = imageHost .. "/textures/packs/coresets/019-EOJ.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/019-EOJ.png"

    return o
end

return PackGenerator
