local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/reprint-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dark Beginning 2"
    o.setCodePrefix = "DB2-EN"
    o.setNameUrl = "Dark Beginning 2"
    o.releaseDate = "2005-07-27"
    o.packTextures = imageHost .. "/textures/packs/reprintpacks/002-DB2.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
