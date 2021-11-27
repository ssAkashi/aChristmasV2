fx_version 'cerulean'
game 'gta5'

author 'Akashi'

shared_script 'config.lua'

client_scripts {
    'services/RageUI/RMenu.lua',
    'services/RageUI/menu/RageUI.lua',
    'services/RageUI/menu/Menu.lua',
    'services/RageUI/menu/MenuController.lua',
    'services/RageUI/components/*.lua',
    'services/RageUI/menu/elements/*.lua',
    'services/RageUI/menu/items/*.lua',
    'services/RageUI/menu/panels/*.lua',
    'services/RageUI/menu/windows/*.lua',
    'services/xSound/client/*.lua',
    'classes/client/*.lua',
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'webhook.lua',
    'classes/server/*.lua',
    'server/*.lua',
}

ui_page 'services/xSound/html/index.html'
files {
    'services/xSound/html/index.html',
    'services/xSound/html/jquery.js',
    'services/xSound/html/nui.js',
    'services/xSound/html/ytListener.js',
    'services/xSound/html/ytPlayer.js',
}