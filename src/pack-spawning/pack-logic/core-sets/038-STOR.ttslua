local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Storm of Ragnarok"
    o.setCodePrefix = "STOR-EN"
    o.setNameUrl = "Storm of Ragnarok"
    o.releaseDate = "2011-02-08"
    o.packTextures = imageHost .. "/textures/packs/coresets/038-STOR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/038-STOR.png"

    return o
end

return PackGenerator
