local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/reprint-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dark Revelation Volume 3"
    o.setCodePrefix = "DR3-EN"
    o.setNameUrl = "Dark Revelation Volume 3"
    o.releaseDate = "2006-11-25"
    o.packTextures = imageHost .. "/textures/packs/reprintpacks/005-DR3.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
