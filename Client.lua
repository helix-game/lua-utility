local callbackId = 0
local callbacks = {}

function GetNextCallbackId()
    callbackId = callbackId + 1
    return "cb_" .. tostring(callbackId)
end

function TriggerCallback(name, onResponse, ...)
    local args = { ... }

    local id = GetNextCallbackId()

    callbacks[id] = onResponse
    callbacks[id] = onResponse

    Events.SubscribeRemote("CallbackResponse:" .. name .. ":" .. id, function(...)
        if callbacks[id] then
            callbacks[id](...)
            callbacks[id] = nil
            Events.Unsubscribe("CallbackResponse:" .. name .. ":" .. id)
        end
    end)

    Events.CallRemote("RequestCallback", name, id, table.unpack(args))
end

-- use Example

function IsAdmin()
    TriggerCallback('player:IsAdmin', function(isAdmin)
        if isAdmin then
            print("player is admin :)")
        else
            print("player is not an admin :(")
        end
    end)
end
