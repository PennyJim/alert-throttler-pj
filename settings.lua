data:extend ({
	{
		type = "int-setting",
		name = "destroyed-building-buffer",
		setting_type = "runtime-per-user",
		default_value = 5,
		minimum_value = 1,
		order = "a"
	},
	{
		type = "double-setting",
		name = "destroyed-building-timeout",
		setting_type = "runtime-per-user",
		default_value = 10,
		minimum_value = 1,
		order = "b"
	},
})