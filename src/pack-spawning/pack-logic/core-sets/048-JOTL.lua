local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Judgment of the Light"
    o.setCodePrefix = "JOTL-EN"
    o.setNameUrl = "Judgment of the Light"
    o.releaseDate = "2013-08-09"
    o.packTextures = imageHost .. "/textures/packs/coresets/048-JOTL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/048-JOTL.png"

    return o
end

return PackGenerator
