local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Secrets of Eternity"
    o.setCodePrefix = "SECE-EN"
    o.setNameUrl = "Secrets of Eternity"
    o.releaseDate = "2015-01-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/054-SECE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/054-SECE.png"

    return o
end

return PackGenerator
