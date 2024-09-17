local notificationCallbacks = {}

function ShowNotification(title, message, duration, notifType, sound, callback)
    local notificationId = math.random(100000, 999999)
    
    if callback then
        notificationCallbacks[notificationId] = callback
    end

    SendNUIMessage({
        type = "showNotification",
        id = notificationId,
        title = title or "NO TEXT",
        text = message,
        duration = duration or 5000,
        notifType = notifType or "error",
        sound = sound or "notify.mp3"
    })
end

function ShowButtons(buttons, callback)
    SetNuiFocus(true, true)
    
    SendNUIMessage({
        type = "showButtons",
        buttons = buttons
    })

    if callback then
        notificationCallbacks['button'] = callback
    end
end

function ShowCircularProgress(duration)
    SendNUIMessage({
        type = "showCircularProgress",
        duration = duration or 10000
    })
end

exports("ShowNotification", ShowNotification)
exports("ShowButtons", ShowButtons)
exports("ShowCircularProgress", ShowCircularProgress)

RegisterNUICallback('buttonSelected', function(data, cb)
    if notificationCallbacks['button'] then
        notificationCallbacks['button'](data.selection)
        notificationCallbacks['button'] = nil
    end
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('closeNotification', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)






RegisterCommand('testall', function()
    exports['4EV3R-Notify']:ShowNotification("Success Notify", "This is a Success Message!", 5000, "success", "notify.mp3")
    Citizen.Wait(1000)
    exports['4EV3R-Notify']:ShowNotification("Error Notify", "This is an Error Message!", 5000, "error", "notify.mp3")
    Citizen.Wait(1000)
    exports['4EV3R-Notify']:ShowNotification("Info Notify", "This is an Info Message!", 5000, "info", "notify.mp3")
    Citizen.Wait(1000)
    exports['4EV3R-Notify']:ShowCircularProgress(5000)
    Citizen.Wait(6000)
    exports['4EV3R-Notify']:ShowButtons({
        { label = "Accept", value = "accept" },
        { label = "Decline", value = "decline" }
    }, function(selection)
        print("You selected: " .. selection)

        if value ~= "accept" then
            print("do something")
        end
    end)
end, false)

RegisterCommand('testsuccess', function()
    exports['4EV3R-Notify']:ShowNotification("Success Notify", "This is a Success Message!", 5000, "success", "notify.mp3")
end, false)

RegisterCommand('testerror', function()
    exports['4EV3R-Notify']:ShowNotification("Error Notify", "This is an Error Message!", 5000, "error", "notify.mp3")
end, false)

RegisterCommand('testinfo', function()
    exports['4EV3R-Notify']:ShowNotification("Info Notify", "This is an Info Message!", 5000, "info", "notify.mp3")
end, false)

RegisterCommand('testprogress', function()
    exports['4EV3R-Notify']:ShowCircularProgress(10000)
end, false)

RegisterCommand('testbuttons', function()
    exports['4EV3R-Notify']:ShowButtons({
        { label = "Accept", value = "accept" },
        { label = "Decline", value = "decline" }
    }, function(selection)
        print("You selected: " .. selection)

        if value ~= "accept" then
            print("example")
        end
    end)
end, false)
