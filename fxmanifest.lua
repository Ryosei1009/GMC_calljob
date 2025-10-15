shared_script '@fiveguard/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

author 'GMC RP'
description 'GMC Calling JOB System'
version '1.0.0'

shared_script '@qb-core/shared/locale.lua'
shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'qb-core',
    'ps-dispatch'
}
