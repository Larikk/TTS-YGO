local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/tournament-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Tournament Pack: 2nd Season"
    o.setCodePrefix = "TP2-"
    o.setNameUrl = "Tournament Pack: 2nd Season"
    o.releaseDate = "2002-10-01"
    o.packTextures = imageHost .. "/textures/packs/tournamentpacks/002-TP2.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
