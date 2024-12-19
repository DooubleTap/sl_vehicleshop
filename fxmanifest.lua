fx_version 'cerulean'
game 'gta5'

author 'dooubletap for RPQC'
description 'Essential Services Vehicle Showroom to work with keep-sharedgarages'
version '1.0.0'

shared_script 'config.lua'
client_script 'client.lua'
server_script {
    'server.lua',
    '@oxmysql/lib/MySQL.lua'
}

dependencies {
    'qb-core',
    'ox_inventory',
    'ox_target',
    'ox_lib',
    'oxmysql'
}
