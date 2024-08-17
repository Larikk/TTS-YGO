local module = {}

function module.forwardTransform(yRotation)
    -- Simplified from https://forum.unity.com/threads/what-is-the-math-behind-calculating-transform-forward-of-an-object.521318/#post-3420448
    local rotationRad = yRotation * math.pi / 180.0
    return Vector(
        math.sin(rotationRad),
        0,
        math.cos(rotationRad)
    )
end

function module.rightTransform(yRotation)
    local forward = module.forwardTransform(yRotation)
    return Vector(
        forward.z,
        0,
        -forward.x
    )
end

-- Returns a list of positions to spawn multiple elements neatly arranged in a grid
-- Example params:
-- {
--     n = numberOfElements,
--     center = Vector(0, 1, 0),
--     yRotation = 90,
--     hDelta = 3,
--     vDelta = 5,
--     itemsPerRow = 4,
-- }
function module.arrangePositionsForSpawning(params)
    local positions = {}

    local n = params.n
    local rotation = ((params.yRotation + 180) % 360) - 180
    local hDelta = params.hDelta
    local vDelta = params.vDelta
    local itemsPerRow = params.itemsPerRow

    -- Calculate movement directions
    local right = module.rightTransform(rotation)
    local forward = module.forwardTransform(rotation)

    -- Position for the next element to be spawned
    local cursor = params.center

    -- Number of rows and columns to adjust the position of the first element
    local numberOfColumns = n <= itemsPerRow and n or itemsPerRow
    local numberOfRows = math.floor(n / itemsPerRow) + math.min(1, n % itemsPerRow)

    -- Adjust position of the first element
    cursor = cursor + (numberOfColumns-1) * hDelta * right * 0.5
    if numberOfRows > 1 then
        cursor = cursor - ((numberOfRows - 1) * 0.5 * vDelta * forward)
    end

    -- Calcualte positins for the elements
    for i = 1, n do
        table.insert(positions, cursor)
        cursor = cursor - hDelta * right
        if i % itemsPerRow == 0 then
            cursor = cursor + itemsPerRow * hDelta * right + vDelta * forward
        end
    end

    return positions
end

return module
