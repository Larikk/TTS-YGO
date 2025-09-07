local jsonLib = require("TTS-YGO/lib/ttsjson/TTSjson")

local module = {}


function module.decode(str)
    return jsonLib.parse(str)
end

function module.encode(tbl)
    return jsonLib.write(tbl)
end

return module
