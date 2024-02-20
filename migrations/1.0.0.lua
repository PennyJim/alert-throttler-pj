for _, alerts in pairs(global.alerts) do
	alerts.count = 0
	alerts.last_alerted = 0
end