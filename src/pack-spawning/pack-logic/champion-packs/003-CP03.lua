local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/champion-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Champion Pack: Game Three"
    o.setCodePrefix = "CP03-EN"
    o.setNameUrl = "Champion Pack: Game Three"
    o.releaseDate = "2007-05-15"
    o.packTextures = imageHost .. "/textures/packs/championpacks/003-CP03.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
