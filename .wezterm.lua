local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Настраиваем WSL как шелл по умолчанию
config.default_prog = { 'wsl.exe', '~' }

-- Включаем поддержку графики (в WezTerm включено по умолчанию, но для надежности)
config.enable_kitty_graphics = true

-- Приятный бонус: хорошая интеграция с буфером обмена Windows
config.win32_system_backdrop = 'Acrylic'
config.color_scheme = 'Gruvbox Dark'

return config
