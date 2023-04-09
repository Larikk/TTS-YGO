local mathUtil = {}

math.randomseed(os.time())

-- Returns a number between [0, 1)
function mathUtil.randomFloat()
    return math.random()
end

-- Returns an integer between [1, max]
function mathUtil.randomInt(max)
    return math.random(max)
end

-- Return a sequence of n numbers with distinct and unordered values between [1, max]
function mathUtil.randomSequence(n, max)
    if n > max then
        error(string.format("randomSequence(): n %d is larger than max %d", n, max))
    end

    local sequence = {}
    local count = 0
    local taken = {}

    while count < n do
        local num = mathUtil.randomInt(max)
        if taken[num] ~= true then
            taken[num] = true
            table.insert(sequence, num)
            count = count + 1
        end
    end

    return sequence
end

function mathUtil.lshift(x, by)
    return x * 2 ^ by
end

function mathUtil.rshift(x, by)
    return math.floor(x / 2 ^ by)
end

return mathUtil
