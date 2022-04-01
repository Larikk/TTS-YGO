local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Phantom Darkness"
    o.setCodePrefix = "PTDN-EN"
    o.setNameUrl = "Phantom Darkness"
    o.releaseDate = "2008-02-13"
    o.packTextures = imageHost .. "/textures/packs/coresets/026-PTDN.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/026-PTDN.png"

    return o
end

return PackGenerator
