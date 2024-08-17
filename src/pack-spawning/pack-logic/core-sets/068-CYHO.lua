local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Cybernetic Horizon"
    o.setCodePrefix = "CYHO-EN"
    o.setNameUrl = "Cybernetic Horizon"
    o.releaseDate = "2018-07-27"
    o.packTextures = imageHost .. "/textures/packs/coresets/068-CYHO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/068-CYHO.png"

    return o
end

return PackGenerator
