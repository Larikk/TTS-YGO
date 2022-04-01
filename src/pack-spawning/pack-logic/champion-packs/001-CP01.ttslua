local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/champion-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Champion Pack: Game One"
    o.setCodePrefix = "CP01-EN"
    o.setNameUrl = "Champion Pack: Game One"
    o.releaseDate = "2006-11-11"
    o.packTextures = imageHost .. "/textures/packs/championpacks/001-CP01.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
