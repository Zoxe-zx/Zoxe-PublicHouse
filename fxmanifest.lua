--#--
--Fx info--
--#--
fx_version 'cerulean'
use_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
version '1.0.0'

--#--
--Credits--
--#--

name 'Simple Public House'
author '! ^Zoxe$#5386'
version "1.0.0"
repository "https://github.com/Zoxe-zx/Zoxe-PublicHouse"
description 'Zoxe-PublicHouse'
discord 'https://discord.gg/avJYpPCfuG'

--#--
--Manifest--
--#--

client_scripts {
	'Client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'Server/*.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'Shared/*.lua',
}

files {
	'locales/*.json',
}

--#--
--Dependencies--
--#--

dependencies {
	'ox_inventory',
	'ox_lib',
	'ox_target',
	'pma-voice',
}
