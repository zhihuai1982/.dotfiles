local wm = require('window-management')
local hk = require "hs.hotkey"

-- * Key Binding Utility
--- Bind hotkey for window management.
-- @function windowBind
-- @param {table} hyper - hyper key set
-- @param { ...{key=value} } keyFuncTable - multiple hotkey and function pairs
--   @key {string} hotkey
--   @value {function} callback function
local function windowBind(hyper, keyFuncTable)
  for key,fn in pairs(keyFuncTable) do
    hk.bind(hyper, key, fn)
  end
end

-- * Move window to screen
windowBind({"alt","ctrl"}, {
  h = wm.throwLeft,
  --left = wm.throwLeft,
  l = wm.throwRight,
  --right = wm.throwRight
})

-- * Set Window Position on screen
windowBind({"alt", "ctrl"}, {
  --m = wm.maximizeWindow,
  --n = wm.centerOnScreen,
  j = wm.leftHalf,
  --left = wm.leftHalf,
  k = wm.rightHalf,
  --right = wm.rightHalf,
  --up = wm.topHalf,
  --down = wm.bottomHalf
})

-- * Set Window Position on screen
--windowBind({"ctrl", "alt"}, {
  --y = wm.rightToLeft,      -- ⌃⌥⇧ + ←
  --o = wm.rightToRight,    -- ⌃⌥⇧ + →
  --i = wm.bottomUp,           -- ⌃⌥⇧ + ↑
  --u = wm.bottomDown        -- ⌃⌥⇧ + ↓
  --left = wm.rightToLeft,      -- ⌃⌥⇧ + ←
  --right = wm.rightToRight,    -- ⌃⌥⇧ + →
  --up = wm.bottomUp,           -- ⌃⌥⇧ + ↑
  --down = wm.bottomDown        -- ⌃⌥⇧ + ↓
--})

-- * Set Window Position on screen
--windowBind({"ctrl", "alt"}, {
  --n = wm.leftToLeft,      -- ⌥⌘⇧ + ←
  --["."] = wm.leftToRight,    -- ⌥⌘⇧ + →
  --[","] = wm.topUp,             -- ⌥⌘⇧ + ↑
  --m = wm.topDown          -- ⌥⌘⇧ + ↓
  --left = wm.leftToLeft,      -- ⌥⌘⇧ + ←
  --right = wm.leftToRight,    -- ⌥⌘⇧ + →
  --up = wm.topUp,             -- ⌥⌘⇧ + ↑
  --down = wm.topDown          -- ⌥⌘⇧ + ↓
--})

---- * Windows-like cycle
--windowBind({"ctrl", "alt"}, {
  --u = wm.cycleLeft,          -- ⌃⌥⌘ + u
  --i = wm.cycleRight          -- ⌃⌥⌘ + i
--})


--folk from https://github.com/sugood/hammerspoon
-- window management
local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local screen = require "hs.screen"
local fnutils = require "hs.fnutils"
local geometry = require "hs.geometry"
local mouse = require "hs.mouse"

-- move cursor to previous monitor
--hotkey.bind({"alt","ctrl"}, "u", function ()
  --focusScreen(window.focusedWindow():screen():previous())
--end)

 --move cursor to next monitor
hotkey.bind({"alt","ctrl"}, "i", function ()
  focusScreen(window.focusedWindow():screen():next())
end)

-- top half
hotkey.bind({"ctrl","alt"}, "p", function()
  window.focusedWindow():moveToUnit'[0,0,100,50]'
end)

---- bottom half
hotkey.bind({"ctrl","alt"}, "/", function()
  window.focusedWindow():moveToUnit'[0,50,100,100]'
end)

-- left top quarter
hotkey.bind({"ctrl","alt"}, "-", function()
  window.focusedWindow():moveToUnit'[0,0,50,50]'
end)

---- right bottom quarter
hotkey.bind({"ctrl","alt"}, "]", function()
  window.focusedWindow():moveToUnit'[50,50,100,100]'
end)

---- right top quarter
hotkey.bind({"ctrl","alt"}, "=", function()
  window.focusedWindow():moveToUnit'[50,0,100,50]'
end)

---- left bottom quarter
hotkey.bind({"ctrl","alt"}, "[", function()
  window.focusedWindow():moveToUnit'[0,50,50,100]'
end)

---- left bottom corner
hotkey.bind({"ctrl","alt"}, "b", function()
  window.focusedWindow():moveToUnit'[0,50,25,100]'
end)

---- right bottom corner
hotkey.bind({"ctrl","alt"}, ",", function()
  window.focusedWindow():moveToUnit'[75,50,100,100]'
end)

---- full screen
--hotkey.bind({"ctrl","alt"}, ";", function()
  --window.focusedWindow():toggleFullScreen()
--end)

---- center window
hotkey.bind({"ctrl","alt"}, "n", function()
  --window.focusedWindow():centerOnScreen()
  toggle_center()
end)

---- defines for window maximize toggler
local frameCenterCache = {}
---- toggle a window between its normal size, and being maximized
function toggle_center()
    local win = window.focusedWindow()
    if frameCenterCache[win:id()] then
        win:setFrame(frameCenterCache[win:id()])
        frameCenterCache[win:id()] = nil
    else
        frameCenterCache[win:id()] = win:frame()
        --win:centerOnScreen()
        win:moveToUnit'[25,0,75,100]'
    end
end

---- maximize window
hotkey.bind({"ctrl","alt"}, 'm', function() toggle_maximize() end)

---- defines for window maximize toggler
local frameCache = {}
---- toggle a window between its normal size, and being maximized
function toggle_maximize()
    local win = window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = fnutils.filter(
      window.orderedWindows(),
      fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or window.desktop()
  windowToFocus:focus()

  -- move cursor to center of screen
  local pt = geometry.rectMidPoint(screen:fullFrame())
  mouse.setAbsolutePosition(pt)
end

