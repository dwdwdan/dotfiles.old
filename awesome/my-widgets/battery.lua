local wibox = require("wibox")
local watch = require("awful.widget.watch")
local theme = require("mytheme")

local bat_text = wibox.widget{
	font = theme.mono_font,
	widget = wibox.widget.textbox,
}

local bat_widget = wibox.widget.background()
bat_widget:set_widget(bat_text)

bat_widget:set_bg(theme.bg_widget)
bat_widget:set_fg(theme.fg_widget)

watch("acpi",15,function(widget, stdout, stderr, exitreason, exitcode)
	local bat_percent = string.match(stdout,"%d?%d?%d%%")
	bat_percent = bat_percent:sub(1,-2)
	if(tonumber(bat_percent) < 100) then
		bat_percent = " "..bat_percent
	end
	if(tonumber(bat_percent) < 10) then
		bat_percent = " "..bat_percent
	end
	bat_percent = "🔋"..bat_percent
	bat_percent = bat_percent.."%"
	bat_text:set_text(bat_percent)
end, bat_widget)

return bat_widget