local wibox = require("wibox")
local watch = require("awful.widget.watch")
local awful = require("awful")
local theme = require("mytheme")
require("weather_conf")

local weather_text = wibox.widget{
	font = theme.mono_font,
	widget = wibox.widget.textbox,
}

local weather_widget = wibox.widget.background()
weather_widget:set_widget(weather_text)

weather_widget:set_bg(theme.bg_widget)
weather_widget:set_fg(theme.fg_widget)

watch("curl 'https://api.openweathermap.org/data/2.5/weather?id="..city.."&APPID="..api_key.."&units=metric'",600,function(widget, stdout, stderr, exitreason, exitcode)
	local temp = string.match(stdout,"\"temp\":%d+")
	temp = temp:sub(8)
	weather_text:set_text("🌥 "..temp.."℃")
end, weather_widget)

local open_weather = function(lx, ly, button, mods, find_widgets_result)
	awful.spawn("firefox https://openweathermap.org/city/"..city)
end

weather_widget:connect_signal("button::press",open_weather)

return weather_widget