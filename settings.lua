data:extend ({
	{
		type = "int-setting",
		name = "destroyed-building-buffer",
		setting_type = "runtime-per-user",
		default_value = 3,
		minimum_value = 1,
		order = "a"
	},
	{
		type = "double-setting",
		name = "destroyed-building-timeout",
		setting_type = "runtime-per-user",
		default_value = 60,
		minimum_value = 1,
		order = "b"
	},
	{
		type = "double-setting",
		name = "min-alert-time",
		setting_type = "runtime-per-user",
		default_value = 0.597506,
		minimum_value = 0,
		order = "c"
	},
})