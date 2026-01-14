fx_version 'cerulean'
game 'gta5'

lua54 'yes'

name "NamelessCore"

description "NamelessCore"

author "Reachard King"

version "1.0.0"

shared_scripts {
	'Init.lua',
	'shared/main.lua'
}

client_scripts {
	'client/*.lua',
	'client_core/*.lua'
}

server_scripts {
	'server/*.lua',
	'server_core/*.lua'
}

exports 'GetServerObjcts'
client_exports 'GetServerObjcts'
server_exports {'GetServerObjcts'}

server_exports {
	'NewCharacter',
	'FetchCharacters',
	'SetActiveCharacter',
	'FetchAllCharacters',
	'SetData'
}

exports {
	'NewCharacter',
	'FetchCharacters',
	'SetActiveCharacter',
	'FetchAllCharacters',
	'SetData'
}