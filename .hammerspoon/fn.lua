-- https://kevinmarsh.com/2016/10/24/spotify-volume-control-with-hammerspoon.html
-- Remap Fn keys to itune-priority equivalents
hs.hotkey.bind({}, "f7", function()
  hs.itunes.previous()
end)

hs.hotkey.bind({}, "f8", function()
  hs.itunes.playpause()
end)

hs.hotkey.bind({}, "f9", function()
  hs.itunes.next()
end)

--https://github.com/Hammerspoon/hammerspoon/issues/1275
-- 需要在系统设置键盘里把显示桌面的快捷键改为其他，而且取消勾选
local function sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local volume = {
    up   = function() sendSystemKey("SOUND_UP") end,
    down = function() sendSystemKey("SOUND_DOWN") end,
    mute = function() sendSystemKey("MUTE") end,
}
hs.hotkey.bind({}, "f10", volume.mute)
hs.hotkey.bind({}, "f11", volume.down, nil, volume.down)
hs.hotkey.bind({}, "f12", volume.up, nil, volume.up)
