local alert = data.raw["utility-sounds"]["default"]["alert_destroyed"][1]
local new_alert = table.deepcopy(alert) --[[@as data.SoundPrototype]]
alert.filename = "__core__/sound/silence-1sec.ogg"

new_alert.type = "sound"
new_alert.name = "cya-alert-destroyed"
new_alert.category = "alert"
data:extend{
	new_alert
}