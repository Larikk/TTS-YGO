local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Flaming Eternity"
    o.setCodePrefix = "FET-EN"
    o.setNameUrl = "Flaming Eternity"
    o.releaseDate = "2005-03-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/014-FET.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/014-FET.png"

    return o
end

return PackGenerator
