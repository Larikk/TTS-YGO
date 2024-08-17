local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Shadow of Infinity"
    o.setCodePrefix = "SOI-EN"
    o.setNameUrl = "Shadow of Infinity"
    o.releaseDate = "2006-03-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/018-SOI.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/018-SOI.png"

    return o
end

return PackGenerator
