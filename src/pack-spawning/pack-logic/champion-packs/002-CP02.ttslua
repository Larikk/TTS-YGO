local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/champion-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Champion Pack: Game Two"
    o.setCodePrefix = "CP02-EN"
    o.setNameUrl = "Champion Pack: Game Two"
    o.releaseDate = "2007-02-06"
    o.packTextures = imageHost .. "/textures/packs/championpacks/002-CP02.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
