local notificationCallbacks = {}

function ShowNotification(title, message, duration, notifType, sound, callback)
    local notificationId = math.random(100000, 999999)
    
    if callback then
        notificationCallbacks[notificationId] = callback
    end

    SendNUIMessage({
        type = "showNotification",
        id = notificationId,
        title = title or "",
        text = message,
        duration = duration or 5000,
        notifType = notifType or "info",
        sound = sound or "notify.mp3"
    })

    Citizen.SetTimeout(duration or 5000, function()
        SetNuiFocus(false, false)
    end)
end

exports("ShowNotification", ShowNotification)

RegisterCommand('testnotification', function()
    ShowNotification('Success!', 'lorem ipsum is a soldier!', 3000, 'success', "notify.mp3")
end, false)

RegisterCommand('testinfo', function()
    ShowNotification('Info', 'lorem ipsum is a soldier...', 5000, 'info', "notify.mp3")
end, false)

RegisterCommand('testerrornotification', function()
    ShowNotification('Error', 'lorem ipsum is a soldier!', 5000, 'error', "notify.mp3")
end, false)

RegisterCommand('testcircularprogress', function()
    SendNUIMessage({
        type = "showCircularProgress",
        duration = 10000
    })
end, false)

RegisterNUICallback('closeNotification', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('testexport', function()
    exports['4EV3R-Notify']:ShowNotification("Export Title Title", "This is an export message!.", 5000, "info")
end, false)




RegisterCommand('testbuttons', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showButtons"
    })
end, false)

RegisterNUICallback('buttonSelected', function(data, cb)
    print("You selected: " .. data.selection)
    SetNuiFocus(false, false)
    cb('ok')
end)

