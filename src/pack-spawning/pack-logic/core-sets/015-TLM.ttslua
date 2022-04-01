local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "The Lost Millennium"
    o.setCodePrefix = "TLM-EN"
    o.setNameUrl = "The Lost Millennium"
    o.releaseDate = "2005-06-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/015-TLM.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/015-TLM.png"

    return o
end

return PackGenerator
