local util = {}

function util.getElementById(id, root)
    if type(root) ~= "table" then return nil end

    -- Check if root is an array-like table.
    -- Thats generally the case in two scenarios:
    -- 1. root is the outermost table returned by getXmlTable()
    -- 2. root is the children collection of a GUI element
    -- This section skips the Defaults tag because it does not have any GUI elements
    if root[1] ~= nil then
        for _, child in ipairs(root) do
            if child.tag ~= "Defaults" then
                local temp = util.getElementById(id, child)
                if temp ~= nil then return temp end
            end
        end
        -- Return nil if nothing is found
        return nil
    end

    -- root is a GUI element if execution reaches this point
    -- Check if root is the element with the id we are looking for
    if root.attributes ~= nil and root.attributes.id == id then
        return root
    end

    -- Check children of root
    return util.getElementById(id, root.children)
end

function util.createNavBar(title, additionalChildren)
    additionalChildren = additionalChildren or {}

    local children = {}

    table.insert(children, {
        tag = "Text",
        attributes = {
            class = "nav-bar",
            flexibleWidth = "1"
        },
        value = title
    })

    for _, e in pairs(additionalChildren) do table.insert(children, e) end

    return {
        tag = "HorizontalLayout",
        attributes = {
            class = "nav-bar"
        },
        children = children
    }
end

function util.createBox(title, description, content)
    local children = {}

    table.insert(children, {
        tag = "Text",
        attributes = {
            class = "box-title",
        },
        value = title
    })

    if description ~= nil and description ~= "" then
        table.insert(children, {
            tag = "Text",
            attributes = {
                class = "box-description",
            },
            value = description
        })
    end

    table.insert(children, content)

    return {
        tag = "VerticalLayout",
        attributes = {
            class = "box",
            flexibleWidth = "1"
        },
        children = children
    }
end

function util.createButton(id, text, color, alignment)
    local result = {
        tag = "Button",
        attributes = {
            id = id,
            class = color .. " button",
            onClick = "handleEvent",
        },
        value = text
    }

    if alignment then
        result = {
            tag = "HorizontalLayout",
            attributes = {
                childAlignment = alignment,
                flexibleWidth = "1",
            },
            children = result
        }
    end


    return result
end

return util
