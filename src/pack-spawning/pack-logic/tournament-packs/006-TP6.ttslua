local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/tournament-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Tournament Pack 6"
    o.setCodePrefix = "TP6-EN"
    o.setNameUrl = "Tournament Pack 6"
    o.releaseDate = "2005-06-01"
    o.packTextures = imageHost .. "/textures/packs/tournamentpacks/006-TP6.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
