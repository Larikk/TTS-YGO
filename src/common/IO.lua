io = {}

local function tableToStringHelper(tt, indent, done)
    done = done or {}
    indent = indent or 0
    if type(tt) == "table" then
        local sb = {}
        for key, value in pairs (tt) do
            table.insert(sb, string.rep (" ", indent)) -- indent it
            if type (value) == "table" and not done [value] then
                done [value] = true
                table.insert(sb, key .. " = {\n");
                table.insert(sb, tableToStringHelper(value, indent + 2, done))
                table.insert(sb, string.rep (" ", indent)) -- indent it
                table.insert(sb, "}\n");
            elseif "number" == type(key) then
                table.insert(sb, string.format("\"%s\"\n", tostring(value)))
            else
                table.insert(sb, string.format(
                "%s = \"%s\"\n", tostring (key), tostring(value)))
            end
        end
        return table.concat(sb)
    else
        return tt .. "\n"
    end
end

function io.tableToString( tbl )
    if "nil" == type( tbl ) then
        return io.tableToString(nil)
    elseif "table" == type( tbl ) then
        return tableToStringHelper(tbl)
    elseif "string" == type( tbl ) then
        return tbl
    else
        return io.tableToString(tbl)
    end
end

function io.printTable(table)
    print(io.tableToString(table))
end

-- Prints a warning to all players
function io.warning(str)
    broadcastToAll(str, Color.Yellow)
end

function io.success(str)
    broadcastToAll(str, Color.Green)
end

function io.info(str)
    broadcastToAll(str, Color.Teal)
end

return io
