local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Savage Strike"
    o.setCodePrefix = "SAST-EN"
    o.setNameUrl = "Savage Strike"
    o.releaseDate = "2019-02-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/070-SAST.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/070-SAST.png"

    return o
end

return PackGenerator
