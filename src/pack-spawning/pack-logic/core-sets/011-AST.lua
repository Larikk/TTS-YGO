local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Ancient Sanctuary"
    o.setCodePrefix = "AST-"
    o.setNameUrl = "Ancient Sanctuary"
    o.releaseDate = "2004-06-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/011-AST.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/011-AST.png"

    return o
end

return PackGenerator
