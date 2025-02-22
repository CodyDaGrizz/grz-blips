fx_version 'cerulean'
game 'gta5'

lua54 'yes' -- Enables Lua 5.4 support

author 'Your Name'
description 'Standalone Blip System with Command Support'
version '1.2'

shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}