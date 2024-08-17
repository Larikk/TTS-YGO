local json = require("TTS-YGO/src/common/Json")
local io = require("TTS-YGO/src/common/IO")
local state = require("TTS-YGO/src/gui/State")

local LANGUAGE_SETTING_KEY = "settings:language-selection"

local module = {}

function module.cardinfo(query, callback)
    local url = "https://db.ygoprodeck.com/api/v7/cardinfo.php?"

    local currentLanguage = state.get(LANGUAGE_SETTING_KEY)
    if currentLanguage and currentLanguage ~= "" and currentLanguage ~= "en" then
        url = url .. "language=" .. currentLanguage .. "&"
    end

    url = url .. query

    local handler = function(response)
        if response.is_error or response.response_code ~= 200 then
            local msg = "Request failed:"
            if response.error ~= nil then msg = msg .. "\n" .. response.error end
            if response.text ~= nil then msg = msg .. "\n" .. response.text end
            io.warning(msg)
            return
        end

        -- array of cards
        local data = json.decode(response.text).data
        io.success("Download completed.")

        if type(callback) == "function" then callback(data) end
    end

    io.info("Downloading cards...")
    WebRequest.get(url, handler)
end

return module
