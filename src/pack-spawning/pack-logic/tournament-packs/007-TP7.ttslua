local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/tournament-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Tournament Pack 7"
    o.setCodePrefix = "TP7-EN"
    o.setNameUrl = "Tournament Pack 7"
    o.releaseDate = "2005-11-01"
    o.packTextures = imageHost .. "/textures/packs/tournamentpacks/007-TP7.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
