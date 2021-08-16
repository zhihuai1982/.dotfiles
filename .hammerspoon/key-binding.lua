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
  left = wm.throwLeft,
  l = wm.throwRight,
  right = wm.throwRight
})

-- * Set Window Position on screen
windowBind({"alt", "ctrl"}, {
  m = wm.maximizeWindow,
  n = wm.centerOnScreen,
  j = wm.leftHalf,
  --left = wm.leftHalf,
  k = wm.rightHalf,
  --right = wm.rightHalf,
  --up = wm.topHalf,
  --down = wm.bottomHalf
})

-- * Set Window Position on screen
--windowBind({"ctrl", "alt", "shift"}, {
  --left = wm.rightToLeft,      -- ⌃⌥⇧ + ←
  --right = wm.rightToRight,    -- ⌃⌥⇧ + →
  --up = wm.bottomUp,           -- ⌃⌥⇧ + ↑
  --down = wm.bottomDown        -- ⌃⌥⇧ + ↓
--})
-- * Set Window Position on screen
--windowBind({"alt", "cmd", "shift"}, {
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
