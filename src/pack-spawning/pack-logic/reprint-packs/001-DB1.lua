local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/reprint-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dark Beginning 1"
    o.setCodePrefix = "DB1-EN"
    o.setNameUrl = "Dark Beginning 1"
    o.releaseDate = "2004-10-12"
    o.packTextures = imageHost .. "/textures/packs/reprintpacks/001-DB1.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
