ESX = nil
local doorInfo = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Config Saving (for the command)
RegisterServerEvent('esx_addtext:SaveOnConfig')
AddEventHandler('esx_addtext:SaveOnConfig', function(text1, text2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= "user" then
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~w~Text~g~ added!~w~')
		TriggerClientEvent('esx_addtext:sendNotify', xPlayer.source)


		local path = GetResourcePath(GetCurrentResourceName())
		local lines_config = lines_from(path.."/client.lua")

		--------- Remove the } to add the other line ---------
		
		for k,v in pairs(lines_config) do
			if k == #lines_config then
				DeleteString(path.."/client.lua", "end)") -- Remove the } to add the other line
				print(lines_config)
			end
		end
		
		--------- Open the file ---------
		local file = io.open(path.."/client.lua", "a") -- Append mode

		-- Its formatted like that to simply edit (if you have to edit)
		file:write("\nAddTextEntry('".. text1 .. "', '".. text2.. "')")
		file:write("\nend)")
		
		
		file:close()
		
		
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You dont have permission to do that')
end
end)

function round2(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function DeleteString(path, before)
    local inf = assert(io.open(path, "r+"), "Failed to open input file")
    local lines = ""
    while true do
        local line = inf:read("*line")
		if not line then break end
		
		if line ~= before then lines = lines .. line .. "\n" end
    end
    inf:close()
    file = io.open(path, "w")
    file:write(lines)
    file:close()
end

function AddString(path, content)
    local file = assert(io.open(path, "a+"), "Failed to open file for appending")
    file:write(content .. "")
    file:close()
end

function lines_from(file)
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end



