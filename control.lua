---Handles alerts
---@param tick integer
---@param force LuaForce
function handle_alert(tick, force)
	for player_index, player in pairs(force.players) do
		if not player.valid then return end
		local alerts = global.alerts[player_index]
		local psettings = settings.get_player_settings(player_index)
		local destruction_buffer = psettings["destroyed-building-buffer"].value - 1
		local destruction_time = math.floor(psettings["destroyed-building-timeout"].value * 60)
		local min_alert_time = math.floor(psettings["min-alert-time"].value * 60)

		if not alerts then
			global.alerts[player_index] = {
				index = 0,
				buffer = {},
				count = 0,
				last_alerted = 0,
			}
			alerts = global.alerts[player_index]
		end

		alerts.buffer[alerts.index - destruction_buffer] = nil
		alerts.index = alerts.index + 1
		alerts.buffer[alerts.index] = tick
		oldest_alert = alerts.buffer[alerts.index - destruction_buffer]
		if oldest_alert and tick - oldest_alert <= destruction_time then
			if tick - alerts.last_alerted > min_alert_time then
				alerts.last_alerted = tick
				-- TODO: add special logic for higher levels of alerts to sound different tiers of alerts?
				player.play_sound{
					path="cya-alert-destroyed"
				}
				alerts.count = 0
			else
				alerts.count = alerts.count + 1
			end
		end
	end
end

---Handles on_entity_died
---@param event EventData.on_entity_died
function handle_entity_death(event)
	local entity = event.entity
	if entity and entity.valid then
		if entity.type == "combat-robot" then return end

		local caused = event.force
		local force = entity.force

		if caused ~= force then
			handle_alert(event.tick, force)
		end
	end
end

script.on_event(defines.events.on_entity_died, handle_entity_death, {
	{
		filter = "type",
		type = "unit",
		invert = true
	}
})

script.on_init(function()
	global.alerts = {}
end)
script.on_configuration_changed(function()
	global.alerts = global.alerts or {}
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function (event)
	if event.setting == "destroyed-building-buffer" then
		local player_index = event.player_index
		if not player_index then log("How the hell did a player setting get set without a player"); return end
		local alerts = global.alerts[player_index]
		if not alerts then return end
		local newCuttoff = alerts.index - settings.get_player_settings(player_index)["destroyed-building-buffer"].value

		for index in pairs(alerts.buffer) do
			if index > newCuttoff then break end
			alerts.buffer[index] = nil
		end
	end
end)