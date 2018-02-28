wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid=""
station_cfg.pwd=""
station_cfg.save=true
wifi.sta.config(station_cfg)
-- Initialize variables
firstrun=0
coinlogo=""
coinname=""
coinrate=0
coinchange=0
coinbtcprice=0
offset=0
counter=0
coinflag=0


-- Run getcoins.lua every 60 seconds
tmr.alarm(0, 60000, 1, function() dofile('getcoins.lua') end )
-- Run getcoins.lua once, 12 seconds after boot.
tmr.alarm(1, 12000, tmr.ALARM_SINGLE, function() dofile('getcoins.lua') end )
