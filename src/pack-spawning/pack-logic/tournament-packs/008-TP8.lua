local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/tournament-packs/_Logic")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Tournament Pack 8"
    o.setCodePrefix = "TP8-EN"
    o.setNameUrl = "Tournament Pack 8"
    o.releaseDate = "2006-04-28"
    o.packTextures = imageHost .. "/textures/packs/tournamentpacks/008-TP8.jpg"
    o.boxTexture = nil

    return o
end

return PackGenerator
