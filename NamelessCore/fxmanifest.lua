fx_version 'cerulean'
game 'gta5'

lua54 'on'

name "NamelessCore"

description "NamelessCore"

author "Physics_is_ki"

version "1.0.0"

shared_scripts {
	"@ox_lib/init.lua",
	'shared/*.lua'
}

client_scripts {
	'client/*.lua',
	'client_core/*.lua'
}

server_scripts {
	'server/*.lua',
	'server_core/*.lua'
}

files {
	'shared/init.lua'
}