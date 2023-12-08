hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.y == max.y and f.h <= max.h / 2 then
    f.w = max.w
    f.x = max.x
  else
    f.y = max.y
    f.h = max.h / 2
  end
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.y >= (max.y + (max.h / 4)) then
    f.x = max.x
    f.w = max.w
  else
    f.y = max.y + max.h / 2
    f.h = max.h / 2
  end
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.x == max.x and f.w == max.w / 2 then
    f.y = max.y
    f.h = max.h
  else
    f.x = max.x
    f.w = max.w / 2
  end
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.x >= max.x + max.w / 4 and f.w <= max.w / 2 then
    f.y = max.y
    f.h = max.h
  else
    f.x = max.x + max.w / 2
    f.w = max.w / 2
  end
  win:setFrame(f)
end)

-- make window full screen (but not fullscreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", function()
  local win = hs.window.focusedWindow()
  if not win then return end  -- Check if there is a focused window

  local screen = win:screen()
  local max = screen:frame()

  win:setFrame(max)
end)

-- Move window to next monitor
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "N", function()
  local win = hs.window.focusedWindow()
  if not win then return end  -- Check if there is a focused window

  local screen = win:screen()
  local nextScreen = screen:next()
  if not nextScreen then return end  -- Check if there is a next screen

  win:moveToScreen(nextScreen, true, true)
end)

-- Move window to next monitor
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "N", function()
  local win = hs.window.focusedWindow()
  if not win then return end  -- Check if there is a focused window

  local screen = win:screen()
  local previousScreen = screen:previous()
  if not previousScreen then return end  -- Check if there is a previous screen

  win:moveToScreen(previousScreen, true, true)
end)

-- Move window to previous monitor
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "P", function()
  local win = hs.window.focusedWindow()
  if not win then return end  -- Check if there is a focused window

  local screen = win:screen()
  local nextScreen = screen:next()
  if not nextScreen then return end  -- Check if there is a next screen

  win:moveToScreen(nextScreen, true, true)
end)
