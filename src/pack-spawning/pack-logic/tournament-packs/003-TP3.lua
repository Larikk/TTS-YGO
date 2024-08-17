local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/tournament-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Tournament Pack: 3rd Season"
    o.setCodePrefix = "TP3-"
    o.setNameUrl = "Tournament Pack: 3rd Season"
    o.releaseDate = "2003-03-01"
    o.packTextures = imageHost .. "/textures/packs/tournamentpacks/003-TP3.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
