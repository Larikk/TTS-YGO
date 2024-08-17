local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/champion-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Champion Pack: Game Five"
    o.setCodePrefix = "CP05-EN"
    o.setNameUrl = "Champion Pack: Game Five"
    o.releaseDate = "2008-01-08"
    o.packTextures = imageHost .. "/textures/packs/championpacks/005-CP05.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
