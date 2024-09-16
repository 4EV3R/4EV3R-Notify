fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'Enhanced Notification System with Sounds'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/default.mp3',
    'html/notify.mp3',     
    'html/progress.mp3',
    'html/button.mp3',
    'html/error-icon.png',
    'html/success-icon.png',
    'html/warning-icon.png',
    'html/info-icon.png'
}

client_scripts {
    'client.lua'
}

exports {
    'ShowNotification'
}
