local assertEquals = require("TTS-YGO/test/Assert")
local ydkeImport = require("TTS-YGO/src/deck-import/YdkeImport")

local function testAllSectionsPresent()
    local tag = "SimpleCase"
    local f = ydkeImport.parse

    local input = "ydke://o6lXBaOpVwVKcEkD!0iNuAdIjbgE=!o6lXBQ==!"

    local expected = {
        main = { "89631139", "89631139", "55144522" },
        extra = { "23995346", "23995346" },
        side = { "89631139" },
    }

    assertEquals(tag, expected, f, input)
end

local function testMainMissing()
    local tag = "MainMissing"
    local f = ydkeImport.parse

    local input = "ydke://!0iNuAdIjbgE=!o6lXBQ==!"

    local expected = {
        extra = { "23995346", "23995346" },
        side = { "89631139" },
    }

    assertEquals(tag, expected, f, input)
end

local function testExtraMissing()
    local tag = "ExtraMissing"
    local f = ydkeImport.parse

    local input = "ydke://o6lXBaOpVwVKcEkD!!o6lXBQ==!"

    local expected = {
        main = { "89631139", "89631139", "55144522" },
        side = { "89631139" },
    }

    assertEquals(tag, expected, f, input)
end

local function testSideMissing()
    local tag = "SideMissing"
    local f = ydkeImport.parse

    local input = "ydke://o6lXBaOpVwVKcEkD!0iNuAdIjbgE=!!"

    local expected = {
        main = { "89631139", "89631139", "55144522" },
        extra = { "23995346", "23995346" },
    }

    assertEquals(tag, expected, f, input)
end

local function testOnlyMainPresent()
    local tag = "OnlyMainPresent"
    local f = ydkeImport.parse

    local input = "ydke://o6lXBaOpVwVKcEkD!!!"

    local expected = {
        main = { "89631139", "89631139", "55144522" },
    }

    assertEquals(tag, expected, f, input)
end

local function testOnlyExtraPresent()
    local tag = "OnlyExtraPresent"
    local f = ydkeImport.parse

    local input = "ydke://!0iNuAdIjbgE=!!"

    local expected = {
        extra = { "23995346", "23995346" },
    }

    assertEquals(tag, expected, f, input)
end

local function testOnlySidePresent()
    local tag = "OnlySidePresent"
    local f = ydkeImport.parse

    local input = "ydke://!!o6lXBQ==!"

    local expected = {
        side = { "89631139" },
    }

    assertEquals(tag, expected, f, input)
end

local function testEmptyDeck()
    local tag = "EmptyDeck"
    local f = ydkeImport.parse

    local input = "ydke://!!!"

    local expected = {}

    assertEquals(tag, expected, f, input)
end

local function testShouldBeAbleToHandleIdsWithLessThanEightDigits()
    local tag = "ShouldBeAbleToHandleIdsWithLessThanEightDigits"
    local f = ydkeImport.parse

    local input = "ydke://n2sAAJ9rAAA=!!!"

    local expected = {
        main = { "27551", "27551" },
    }

    assertEquals(tag, expected, f, input)
end

print("Running YdkeLinkImportTest...")
testAllSectionsPresent()
testMainMissing()
testExtraMissing()
testSideMissing()
testOnlyMainPresent()
testOnlyExtraPresent()
testOnlySidePresent()
testEmptyDeck()
testShouldBeAbleToHandleIdsWithLessThanEightDigits()
print("Finished YdkeLinkImportTest")
