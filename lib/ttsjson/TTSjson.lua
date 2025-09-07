local module = {}

-- #region common

-- localize global lookups for performance gains
local type = type
local pairs = pairs
local tochar = string.char
local substring = string.sub
local gsub = string.gsub
local concat = table.concat
local insert = table.insert
local tonumber = tonumber
local format = string.format
local mathmax = math.max
---@diagnostic disable-next-line: undefined-field
local unicode = string.unicode

local errorf = function(s, ...) error(format(s, ...)) end

local ASCII_BACKSPACE = 0x08       -- \b
local ASCII_HORIZONTAL_TAB = 0x09  -- \t
local ASCII_LINE_FEED = 0x0A       -- \n
local ASCII_FORM_FEED = 0x0C       -- \f
local ASCII_CARRIAGE_RETURN = 0x0D -- \r
local ASCII_SPACE = 0x20
local ASCII_DOUBLE_QUOTE = 0x22
local ASCII_PLUS = 0x2B
local ASCII_COMMA = 0x2C
local ASCII_MINUS = 0x2D
local ASCII_DOT = 0x2E
local ASCII_FORWARDSLASH = 0x2F
local ASCII_0 = 0x30
local ASCII_1 = 0x31
local ASCII_2 = 0x32
local ASCII_3 = 0x33
local ASCII_4 = 0x34
local ASCII_5 = 0x35
local ASCII_6 = 0x36
local ASCII_7 = 0x37
local ASCII_8 = 0x38
local ASCII_9 = 0x39
local ASCII_COLON = 0x3A
local ASCII_UPPER_E = 0x45
local ASCII_OPENING_SQARE_BRACKET = 0x5B  -- [
local ASCII_BACKSLASH = 0x5C
local ASCII_CLOSING_SQUARE_BRACKET = 0x5D --]
local ASCII_LOWER_B = 0x62
local ASCII_LOWER_E = 0x65
local ASCII_LOWER_F = 0x66
local ASCII_LOWER_N = 0x6E
local ASCII_LOWER_R = 0x72
local ASCII_LOWER_T = 0x74
local ASCII_LOWER_U = 0x75
local ASCII_OPENING_CURLY_BRACE = 0x7B -- {
local ASCII_CLOSING_CURLY_BRACE = 0x7D -- }

--#endregion

-- #region parsing

-- all characters which are allowed in a json number
local validNumberCharacters = {
    [ASCII_0] = true,
    [ASCII_1] = true,
    [ASCII_2] = true,
    [ASCII_3] = true,
    [ASCII_4] = true,
    [ASCII_5] = true,
    [ASCII_6] = true,
    [ASCII_7] = true,
    [ASCII_8] = true,
    [ASCII_9] = true,
    [ASCII_MINUS] = true,
    [ASCII_PLUS] = true,
    [ASCII_DOT] = true,
    [ASCII_LOWER_E] = true,
    [ASCII_UPPER_E] = true,
}

-- maps ascii values of legal escaped characters inside json strings to their string representation
local escapedCharactersSubstitutions = {
    [ASCII_DOUBLE_QUOTE] = "\"",
    [ASCII_BACKSLASH] = "\\",
    [ASCII_FORWARDSLASH] = "/",
    [ASCII_LOWER_N] = "\n",
    [ASCII_LOWER_R] = "\r",
    [ASCII_LOWER_T] = "\t",
    [ASCII_LOWER_B] = "\b",
    [ASCII_LOWER_F] = "\f",
}

-- characters 0x00-0x1F and 0x7F are not allowed to be unescaped in json strings
local illegalControlCharactersInsideStrings = {
    [0x00] = true,
    [0x01] = true,
    [0x02] = true,
    [0x03] = true,
    [0x04] = true,
    [0x05] = true,
    [0x06] = true,
    [0x07] = true,
    [0x08] = true,
    [0x09] = true,
    [0x0A] = true,
    [0x0B] = true,
    [0x0C] = true,
    [0x0D] = true,
    [0x0E] = true,
    [0x0F] = true,
    [0x10] = true,
    [0x11] = true,
    [0x12] = true,
    [0x13] = true,
    [0x14] = true,
    [0x15] = true,
    [0x16] = true,
    [0x17] = true,
    [0x18] = true,
    [0x19] = true,
    [0x1A] = true,
    [0x1B] = true,
    [0x1C] = true,
    [0x1D] = true,
    [0x1E] = true,
    [0x1F] = true,
    [0x7F] = true,
}

local whiteSpaceCharacters = {
    [ASCII_SPACE] = true,
    [ASCII_HORIZONTAL_TAB] = true,
    [ASCII_LINE_FEED] = true,
    [ASCII_CARRIAGE_RETURN] = true,
}

local parseTrue
local parseFalse
local parseNull
local parseNumber
local parseString
local parseValue
local parseObject
local parseArray
local parseJson

parseTrue = function(ctx)
    local startpos = ctx.pos
    local endpos = startpos + 3
    local token = substring(ctx.buffer, startpos, endpos)
    if token ~= "true" then
        errorf("expected true, got '%s'", token)
    end
    ctx.setPosition(endpos + 1)
    return true
end

parseFalse = function(ctx)
    local startpos = ctx.pos
    local endpos = startpos + 4
    local token = substring(ctx.buffer, startpos, endpos)
    if token ~= "false" then
        errorf("expected false, got '%s'", token)
    end
    ctx.setPosition(endpos + 1)
    return false
end

parseNull = function(ctx)
    local startpos = ctx.pos
    local endpos = startpos + 3
    local token = substring(ctx.buffer, startpos, endpos)
    if token ~= "null" then
        errorf("expected null, got '%s'", token)
    end
    ctx.setPosition(endpos + 1)
    return nil
end

--[[
This function accepts numbers which are not valid JSON (like -01 or 0.e1).
This is a result of tonumber() being more lax than the JSON specification and it being able to parse these numbers.

This discrepancy to the JSON specification is accepted since using the builtin tonumber()
is more performant and simple than any custom made parsing of numbers in Lua.
]]
parseNumber = function(ctx)
    local startPos = ctx.pos
    while true do
        if not validNumberCharacters[ctx.currentCodepoint] then
            break
        end
        ctx.nextCodepoint()
    end

    local s = substring(ctx.buffer, startPos, ctx.pos - 1)
    local n = tonumber(s)
    if n == nil then errorf("not a number: '%s'", s) end
    return n
end

--[[
To convert JSON strings into Lua strings the following rules must be taken into account:
* The unescaped characters 0x00 to 0x1F and 0x7F are illegal in the json.
  If they are encountered, the parsing must be aborted with an error.
  These characters should not occur in valid json and leaving the check out would improve
  the parsing speed considerably (since the check must be performed for every single character
  in a object key or string value). Doing so however could lead to undesired behavior when
  the parsed strings are processed or displayed by the caller.
* Escaped constrol characters like \t or \n must be processed into their unescaped forms.
* Escaped unicode sequences (like \uABCD) must be parsed into the corresponding character.
* Every other characters can be passed as is into the Lua string.

This algorithm uses a table as a string builder.
It scans the string for segments without any escaped characters.
Once it encounters an escaped character, it end the currently processed segment and inserts it into the string builder.
Afterwards the escaped character is processed and the result is put into the string builder.
Once that is completed, the algorithm continues scanning for the next segment or escaped character.

Cutting segments out of the source string was proven to be faster then working on each character in isolation.
]]
parseString = function(ctx)
    ctx.nextCodepoint() -- skip opening double quote

    local sb = {}
    local sbPos = 1
    local lastSegmentStart = ctx.pos

    while true do
        local b = ctx.currentCodepoint
        if b == ASCII_BACKSLASH then
            -- Append the segment of non-escaped characters so far
            -- For consecutive escaped character lastSegmentStart and ctx.pos have the same value here
            if lastSegmentStart < ctx.pos then
                sb[sbPos] = substring(ctx.buffer, lastSegmentStart, ctx.pos - 1)
                sbPos = sbPos + 1
            end

            -- Handle the escaped character
            b = ctx.nextCodepoint()
            if b == ASCII_LOWER_U then
                -- converts four hex digits after a "\u" to a unicode symbol and places cursor to char after last digit
                local hex = substring(ctx.buffer, ctx.pos + 1, ctx.pos + 4)
                if #hex ~= 4 then errorf("invalid unicode escape sequence: '\\u%s'", hex) end
                local n = tonumber(hex, 16)
                if n == nil then error("not a hex number: " .. hex) end
                sb[sbPos] = tochar(n)
                sbPos = sbPos + 1
                ctx.setPosition(ctx.pos + 4)
            else
                local substitute = escapedCharactersSubstitutions[b]
                if substitute ~= nil then
                    sb[sbPos] = substitute
                    sbPos = sbPos + 1
                else
                    errorf("unsupported escaped symbol: '%s'", ctx.currentChar())
                end
            end
            lastSegmentStart = ctx.pos + 1 -- Start next segment after the escaped char
        elseif b == ASCII_DOUBLE_QUOTE then
            -- End of string, append the final segment
            if lastSegmentStart < ctx.pos then
                sb[sbPos] = substring(ctx.buffer, lastSegmentStart, ctx.pos - 1)
            end
            ctx.nextCodepoint() -- move to character after the closing double quote
            return concat(sb)
        elseif illegalControlCharactersInsideStrings[b] then
            errorf("unescaped control character encountered: 0x%02X", b)
        end
        ctx.nextCodepoint()
    end
end

parseObject = function(ctx)
    ctx.nextCodepoint() -- skip opening brace
    ctx.skipWhiteSpace()

    if ctx.currentCodepoint == ASCII_CLOSING_CURLY_BRACE then
        ctx.nextCodepoint()
        return {}
    end

    local obj = {}

    while true do
        if ctx.currentCodepoint ~= ASCII_DOUBLE_QUOTE then
            errorf("expected start of object key, got '%s'", ctx.currentChar())
        end
        local key = parseString(ctx)
        ctx.skipWhiteSpace()
        if ctx.currentCodepoint ~= ASCII_COLON then errorf("expected ':', got '%s'", ctx.currentChar()) end
        ctx.nextCodepoint()
        ctx.skipWhiteSpace()
        local value = parseValue(ctx)
        obj[key] = value
        if ctx.currentCodepoint == ASCII_COMMA then
            ctx.nextCodepoint()
            ctx.skipWhiteSpace()
        elseif ctx.currentCodepoint == ASCII_CLOSING_CURLY_BRACE then
            ctx.nextCodepoint()
            return obj
        else
            errorf("expected ',' or '}' after object value, got '%s'", ctx.currentChar())
        end
    end

    return obj
end

parseArray = function(ctx)
    ctx.nextCodepoint() -- skip opening square brace
    ctx.skipWhiteSpace()

    if ctx.currentCodepoint == ASCII_CLOSING_SQUARE_BRACKET then
        ctx.nextCodepoint()
        return {}
    end

    local tbl = {}
    local tblPos = 1

    while true do
        local value = parseValue(ctx)
        tbl[tblPos] = value
        tblPos = tblPos + 1
        if ctx.currentCodepoint == ASCII_COMMA then
            ctx.nextCodepoint()
            ctx.skipWhiteSpace()
        elseif ctx.currentCodepoint == ASCII_CLOSING_SQUARE_BRACKET then
            ctx.nextCodepoint()
            return tbl
        else
            errorf("expected ',' or ']' after array value, got '%s'", ctx.currentChar())
        end
    end

    return tbl
end

-- maps the first character of a value token to the corresponding handler
local valuePrefixToValueHandlers = {
    [ASCII_DOUBLE_QUOTE] = parseString,
    [ASCII_MINUS] = parseNumber,
    [ASCII_0] = parseNumber,
    [ASCII_1] = parseNumber,
    [ASCII_2] = parseNumber,
    [ASCII_3] = parseNumber,
    [ASCII_4] = parseNumber,
    [ASCII_5] = parseNumber,
    [ASCII_6] = parseNumber,
    [ASCII_7] = parseNumber,
    [ASCII_8] = parseNumber,
    [ASCII_9] = parseNumber,
    [ASCII_LOWER_T] = parseTrue,
    [ASCII_LOWER_F] = parseFalse,
    [ASCII_LOWER_N] = parseNull,
    [ASCII_OPENING_CURLY_BRACE] = parseObject,
    [ASCII_OPENING_SQARE_BRACKET] = parseArray,
}

parseValue = function(ctx)
    local handler = valuePrefixToValueHandlers[ctx.currentCodepoint]
    if handler ~= nil then
        local value = handler(ctx)
        ctx.skipWhiteSpace()
        return value
    end
    errorf("expected start of a value, got '%s'", ctx.currentChar())
end

parseJson = function(str)
    local ctx = {}
    ctx.pos = 1
    ctx.buffer = str
    ctx.currentCodepoint = unicode(str, 1)
    ctx.nextCodepoint = function()
        if ctx.currentCodepoint == nil then error("json is not terminated properly") end
        ctx.pos = ctx.pos + 1
        ctx.currentCodepoint = unicode(str, ctx.pos)
        return ctx.currentCodepoint
    end
    ctx.setPosition = function(pos)
        ctx.pos = pos
        ctx.currentCodepoint = unicode(str, pos)
    end
    ctx.currentChar = function()
        local b = ctx.currentCodepoint
        if (b == nil) then return "" end
        return tochar(b)
    end
    ctx.skipWhiteSpace = function()
        local b = ctx.currentCodepoint
        while whiteSpaceCharacters[b] do
            b = ctx.nextCodepoint()
        end
    end

    ctx.skipWhiteSpace()
    local value = parseValue(ctx)
    ctx.skipWhiteSpace()

    if ctx.currentCodepoint ~= nil then error("json has data past the parsed value") end

    return value
end

-- #endregion

-- #region writing

local writeNil
local writeBoolean
local writeNumber
local writeString
local writeTable
local writeValue
local writeJson

writeNil = function(ctx, value)
    ctx.append("null")
end

writeBoolean = function(ctx, value)
    ctx.append(tostring(value))
end

writeNumber = function(ctx, value)
    local s = tostring(value)
    if (s == "NaN") then errorf("encountered NaN during serialization") end
    ctx.append(s)
end

local characterToEscapedSubstitution = {
    [0x00] = "\\u0000",
    [0x01] = "\\u0001",
    [0x02] = "\\u0002",
    [0x03] = "\\u0003",
    [0x04] = "\\u0004",
    [0x05] = "\\u0005",
    [0x06] = "\\u0006",
    [0x07] = "\\u0007",
    [0x08] = "\\b",
    [0x09] = "\\t",
    [0x0A] = "\\n",
    [0x0B] = "\\u000B",
    [0x0C] = "\\f",
    [0x0D] = "\\r",
    [0x0E] = "\\u000E",
    [0x0F] = "\\u000F",
    [0x10] = "\\u0010",
    [0x11] = "\\u0011",
    [0x12] = "\\u0012",
    [0x13] = "\\u0013",
    [0x14] = "\\u0014",
    [0x15] = "\\u0015",
    [0x16] = "\\u0016",
    [0x17] = "\\u0017",
    [0x18] = "\\u0018",
    [0x19] = "\\u0019",
    [0x1A] = "\\u001A",
    [0x1B] = "\\u001B",
    [0x1C] = "\\u001C",
    [0x1D] = "\\u001D",
    [0x1E] = "\\u001E",
    [0x1F] = "\\u001F",
    [0x7F] = "\\u007F",
    [ASCII_DOUBLE_QUOTE] = "\\\"",
    [ASCII_BACKSLASH] = "\\\\",
}

-- pattern matches constrol characters (0x00-0x1F and 0x7F), double quote and backslash
local patternForAsciiCharactersRequiringEscaping = '[%c"\\]'
local characterEscapingFunction = function(c)
    local codepoint = unicode(c, 1)
    -- Two-byte charaters whose second byte equals the ASCII value of a character that needs to be escaped are wrongfully picked up by gsub
    -- Example: U+0122, 0x22 equals double quotes
    -- Therefore we do not manipulate any characters whose codepoint is over 0x7F
    if (codepoint > 0x7F) then
        return c
    else
        return characterToEscapedSubstitution[codepoint]
    end
end

writeString = function(ctx, str)
    ctx.append("\"")
    local escapedString = gsub(str, patternForAsciiCharactersRequiringEscaping, characterEscapingFunction)
    ctx.append(escapedString)
    ctx.append("\"")
end

writeTable = function(ctx, tbl)
    if (ctx.encounteredTables[tbl]) then
        errorf("detected a cycle between tables, aborting serialization")
    end
    ctx.encounteredTables[tbl] = true

    local firstKey, firstValue = next(tbl)
    local firstKeyType = type(firstKey)

    if firstKeyType == "number" then
        local maxNumericalKey = 0
        for key, _ in pairs(tbl) do
            if (type(key) ~= "number") then errorf("encountered non-numerical key in array-like table: '%s' with type '%s'", tostring(key), type(key)) end
            maxNumericalKey = mathmax(maxNumericalKey, key)
        end

        ctx.append("[")
        if maxNumericalKey >= 1 then
            writeValue(ctx, tbl[1])
            for i = 2, maxNumericalKey do
                ctx.append(",")
                writeValue(ctx, tbl[i])
            end
        end
        ctx.append("]")
    elseif firstKeyType == "string" then
        ctx.append("{")
        writeString(ctx, firstKey)
        ctx.append(":")
        writeValue(ctx, firstValue)
        local key, value = next(tbl, firstKey)
        while key do
            if (type(key) ~= "string") then errorf("encountered non-string key in object-like table: '%s' with type '%s'", tostring(key), type(key)) end
            ctx.append(",")
            writeString(ctx, key)
            ctx.append(":")
            writeValue(ctx, value)
            key, value = next(tbl, key)
        end
        ctx.append("}")
    elseif firstKey == nil then
        ctx.append("[]")
    else
        errorf("encountered unsupported key type: '%s' with type '%s'", tostring(firstKey), firstKeyType)
    end
end

local writeHandlers = {
    ["nil"] = writeNil,
    ["boolean"] = writeBoolean,
    ["number"] = writeNumber,
    ["string"] = writeString,
    ["table"] = writeTable,
}

writeValue = function(ctx, value)
    local _type = type(value)
    local handler = writeHandlers[_type]
    if (handler ~= nil) then
        handler(ctx, value)
    else
        errorf("unsupported value type '%s'", _type)
    end
end

writeJson = function(value)
    local stringBuilder = {}
    local stringBuilderNextIndex = 1
    local ctx = {}
    ctx.encounteredTables = {}
    ctx.append = function(element)
        stringBuilder[stringBuilderNextIndex] = element
        stringBuilderNextIndex = stringBuilderNextIndex + 1
    end

    writeValue(ctx, value)

    local json = concat(stringBuilder)
    return json
end

--#region

module.parse = parseJson
module.write = writeJson

return module
