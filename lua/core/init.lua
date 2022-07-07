--
-- lua/core/init.lua
--
-- Initliazie core configuration


local utils = require('core.utils')

utils.disable_builtins()
require('core.autocmds')
require('core.cmds')
require('core.global')
require('core.options')
require('core.signs')


