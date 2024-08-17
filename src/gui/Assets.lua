local assets = {}

local packGeneratorsModule = require("TTS-YGO/src/gui/PackGenerators")
local preconstructedDecks = require("TTS-YGO/src/preconstructed-decks/Decks")

function assets.initAssets()
    local assets = {}

    local insertAsset = function(name, url)
        if assets[name] then
            error("Duplicate asset encountered: " .. name)
        end

        local asset = {
            name = name,
            url = url
        }
        table.insert(assets, asset)
    end

    for k,v in pairs(packGeneratorsModule.packGenerators) do
        insertAsset(k, v:getOnePackTexture())
    end

    for _,deck in pairs(preconstructedDecks.getStarterDecks()) do
        insertAsset(deck.code, deck.image)
    end

    for _,deck in pairs(preconstructedDecks.getStructureDecks()) do
        insertAsset(deck.code, deck.image)
    end

    self.UI.setCustomAssets(assets)
end

return assets
