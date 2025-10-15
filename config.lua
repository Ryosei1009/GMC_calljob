Config = {}

Config.Locations = {
    {
        id = "police",
        coords = vector3(445.03, -980.7, 30.71),
        distance = 2.0,
        cooldown = 300,
        ui_message = '[E] 警察を呼び出す',
        success_message = '警察を呼び出しました。',
        cooldown_message = '呼び出し済みです。5分後に再度呼び出せます。',
        cooldown_remaining_message = '呼び出し済みです。%s後に再度呼び出せます。',
        dispatch = {
            message = "お呼び出し",
            information_template = "本署ロビーで%s%s様がお待ちです。",
            codeName = '911call',
            code = '10-35',
            icon = 'fas fa-phone',
            priority = 2,
            jobs = { 'leo' }
        }
    },
    {
        id = "ambulance",
        coords = vector3(-489.43, -988.12, 24.29),
        distance = 2.0,
        cooldown = 300,
        ui_message = '[E] 救急隊を呼び出す',
        success_message = '救急隊を呼び出しました。',
        cooldown_message = '呼び出し済みです。5分後に再度呼び出せます。',
        cooldown_remaining_message = '呼び出し済みです。%s後に再度呼び出せます。',
        dispatch = {
            message = "お呼び出し",
            information_template = "病院で%s%s様がお待ちです。",
            codeName = 'medical_call',
            code = '10-54',
            icon = 'fas fa-ambulance',
            priority = 2,
            jobs = { 'ambulance' }
        }
    },
}

Config.UI = {
    success_color = 'success',
    error_color = 'red',
    info_color = 'darkblue',
    text_position = 'left',
    notification_duration = 5000,
    cooldown_message_duration = 5000
}