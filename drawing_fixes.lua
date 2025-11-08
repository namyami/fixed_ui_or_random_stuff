--[[

what does this do?
this fixes the issue with "Bunni's drawing"
they're too limited, so I made a solution..!

this should be working with all the drawing such as volcano being limited
bunni having a shitty drawing.

]]

local y = Drawing.new
local function G(y)
    local G = {}
    local h = {}
    h.__index = function(G, h)
        local q = (y)[h]
        if type(q) == "function" then
            return function(G, ...)
                return q(y, ...)
            end
        end
        return q
    end
    h.__newindex = function(G, h, q)
        pcall(function()
            (y)[h] = q
        end)
    end
    h.__tostring = function()
        return tostring(y)
    end
    h.__metatable = "nigga"
    return setmetatable(G, h)
end
Drawing.new = function(h, ...)
    local q, P = pcall(y, h, ...)
    if not q or not P then
        return nil
    end
    return G(P)
end
