local assertEquals = require("TTS-YGO/test/Assert")
local ydkImport = require("TTS-YGO/src/deck-import/YdkImport")

local function testSimpleCase()
    local tag = "SimpleCase"
    local f = ydkImport.parse

    local input = [[
#created by Larikk
#main
123
456
654
#extra
789
987
!side
234
]]

    local expected = {
        main = { "123", "456", "654" },
        extra = { "789", "987" },
        side = { "234" },
    }

    assertEquals(tag, expected, f, input)
end

local function testShouldIgnoreEmptyLine()
    local tag = "ShouldIgnoreEmptyLine"
    local f = ydkImport.parse

    local input = [[
#created by Larikk

#main
123
456

654
#extra
789
987

!side
234


]]

    local expected = {
        main = { "123", "456", "654" },
        extra = { "789", "987" },
        side = { "234" },
    }

    assertEquals(tag, expected, f, input)
end

local function testShouldAcceptMinialCase()
    local tag = "SimpleCase"
    local f = ydkImport.parse

    local input = [[
#main
123
456
654
]]

    local expected = {
        main = { "123", "456", "654" },
    }

    assertEquals(tag, expected, f, input)
end

local function testShouldSupportWindowsFileEndings()
    local tag = "ShouldSupportWindowsFileEndings"
    local f = ydkImport.parse

    local input = "#created by Larikk\r\n#main\r\n123\r\n#extra\r\n123\r\n!side\r\n123\r\n"

    local expected = {
        main = { "123" },
        extra = { "123" },
        side = { "123" },
    }

    assertEquals(tag, expected, f, input)
end

local function testShouldSupportUnixFileEndings()
    local tag = "ShouldSupportUnixFileEndings"
    local f = ydkImport.parse

    local input = "#created by Larikk\n#main\n123\n#extra\n123\n!side\n123\n"

    local expected = {
        main = { "123" },
        extra = { "123" },
        side = { "123" },
    }

    assertEquals(tag, expected, f, input)
end

print("Running YdkFileImportTest...")
testSimpleCase()
testShouldIgnoreEmptyLine()
testShouldAcceptMinialCase()
testShouldSupportWindowsFileEndings()
testShouldSupportUnixFileEndings()
print("Finished YdkFileImportTest")
