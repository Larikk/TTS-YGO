local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Labyrinth of Nightmare"
    o.setCodePrefix = "LON-EN"
    o.setNameUrl = "Labyrinth of Nightmare"
    o.releaseDate = "2003-03-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/005-LON.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/005-LON.png"

    return o
end

return PackGenerator
