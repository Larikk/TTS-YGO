local assertEquals = require("TTS-YGO/test/Assert")
local stringUtil = require("TTS-YGO/src/common/StringUtil")


local function testStartsWith()
    local tag = "StartsWith"
    local f = stringUtil.startsWith
    assertEquals(tag, true, f, "abcd", "abc")
    assertEquals(tag, false, f, "Abcd", "abc")
    assertEquals(tag, false, f, "def", "abc")
end

local function testEndsWith()
    local tag = "EndsWith"
    local f = stringUtil.endsWith
    assertEquals(tag, true, f, "abcd", "cd")
    assertEquals(tag, true, f, "abcd!", "!")
    assertEquals(tag, false, f, "abcd", "!")
    assertEquals(tag, false, f, "abcd!", "cdef")
end

local function testFindOccurences()
    local tag = "FindOccurences"
    local f = stringUtil.findOccurences
    assertEquals(tag, {}, f, "abc", ";")
    assertEquals(tag, {}, f, "abc", "")
    assertEquals(tag, {}, f, "", "!")
    assertEquals(tag, { 2, 3, 5 }, f, "a!!b!c.", "!")
    assertEquals(tag, { 2, 4, 7 }, f, "a!2!2b!2c.", "!2")
    assertEquals(tag, { 1, 3 }, f, "!a!", "!")
    assertEquals(tag, { 1, 2, 4 }, f, "!!a!", "!")
    assertEquals(tag, { 1, 3, 4 }, f, "!a!!", "!")
end

local function testSplit()
    local tag = "Split"
    local f = stringUtil.split
    assertEquals(tag, { "a", "b" }, f, "a.b", ".")
    assertEquals(tag, { "a", "b", "c" }, f, "a.b.c", ".")
    assertEquals(tag, { "a", "b", "c", "" }, f, "a.b.c.", ".")
    assertEquals(tag, { "", "a", "b", "c" }, f, ".a.b.c", ".")
    assertEquals(tag, { "a", "b", "", "c" }, f, "a.b..c", ".")
end

local function testSplitByNewline()
    local tag = "SplitByNewline"
    local f = stringUtil.splitByNewLine
    assertEquals(tag, { "a", "b", "c", "" }, f, "a\r\nb\r\nc\r\n")
    assertEquals(tag, { "a", "b", "c", "" }, f, "a\nb\nc\n")
end

print("Running StringUtilTests...")
--testStartsWith()
--testEndsWith()
testFindOccurences()
testSplit()
testSplitByNewline()
print("Finished StringUtilTests")
