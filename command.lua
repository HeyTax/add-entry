Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/addtext", "Create a addtext",{ 
		{name = "model", help = "The Model Name Of The Vehicle"},
		{name = "name", help = "The Name that should be replaced with NULL"},
	})
end)

RegisterCommand("addtext", function(source, args, rawCommand)

    -- Check if the first argument is missing
    if not args[1] then
		ShowNotification('You need to add in the model and the name')
    else
        -- Concatenate all arguments after args[1] into a single string
        local remainingArgs = table.concat(args, " ", 2)

        -- Call the server-side event with the concatenated arguments
        TriggerServerEvent("esx_addtext:SaveOnConfig", args[1], remainingArgs)
    end
end)
