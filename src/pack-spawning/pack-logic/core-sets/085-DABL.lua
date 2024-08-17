local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Darkwing Blast"
    o.setCodePrefix = "DABL-EN"
    o.setNameUrl = "Darkwing Blast"
    o.releaseDate = "2022-10-21"
    o.packTextures = imageHost .. "/textures/packs/coresets/085-DABL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/085-DABL.png"

    return o
end

return PackGenerator
