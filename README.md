    exports['4EV3R-Notify']:ShowNotification("Success Notify", "This is a Success Message!", 5000, "success", "notify.mp3")        -- Success Notify 'Title' 'Message' 'Duration' 'type' 'sound'

    exports['4EV3R-Notify']:ShowNotification("Error Notify", "This is an Error Message!", 5000, "error", "notify.mp3")             -- Error Notify 'Title' 'Message' 'Duration' 'type' 'sound'

    exports['4EV3R-Notify']:ShowNotification("Info Notify", "This is an Info Message!", 5000, "info", "notify.mp3")                -- Info Notify 'Title' 'Message' 'Duration' 'type' 'sound'

    exports['4EV3R-Notify']:ShowCircularProgress(5000)                                                                             -- Progressbar with a duration of 5000ms

    exports['4EV3R-Notify']:ShowCircularProgress(5000)                                                                             
   
    exports['4EV3R-Notify']:ShowButtons({                                                                                           -- Button chooser                                                                               
        { label = "Accept", value = "accept" },
        { label = "Decline", value = "decline" }
    }, function(selection)
        print("You selected: " .. selection)

        if value ~= "accept" then
            print("do something")
        end
    end)
