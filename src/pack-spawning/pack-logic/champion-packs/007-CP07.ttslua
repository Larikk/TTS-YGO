local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/champion-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Champion Pack: Game Seven"
    o.setCodePrefix = "CP07-EN"
    o.setNameUrl = "Champion Pack: Game Seven"
    o.releaseDate = "2008-09-01"
    o.packTextures = imageHost .. "/textures/packs/championpacks/007-CP07.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
