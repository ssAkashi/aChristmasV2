isMenuOpened = false
local christmasMainMenu = RageUI.CreateMenu(" ", ChristmasConfig.messages["submenu_title"], nil, nil, "noel_banniere","banniere")
local christmasMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", ChristmasConfig.messages["christmas_menu_subtitle"], nil, nil, "noel_banniere","banniere")
local christmasAnimationsMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", ChristmasConfig.messages["christmas_animations_name"], nil, nil, "noel_banniere","banniere")
local christmasCalendarMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", ChristmasConfig.messages["christmas_calendar_name"], nil, nil, "noel_banniere","banniere")
local christmasColorsMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", ChristmasConfig.messages["christmas_color_name"], nil, nil, "noel_banniere","banniere")
local christmasSettingsMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", ChristmasConfig.messages["christmas_settings_name"], nil, nil, "noel_banniere","banniere")
local christmasCreditMenu = RageUI.CreateSubMenu(christmasMainMenu, " ", "~p~CrÉdit", nil, nil, "noel_banniere","banniere")
christmasMainMenu.Closed = function()
    Destroy("christmasMusic")
end

local isVehicleIsUsed = false
local accessSpawnVehicle = true
local accessTakeSnowball = true
local cooldownSnowball = 3000
local accessOutfit = true

function cooldown(action)
    if action == 'snowball' then
        accessTakeSnowball = false
        SetTimeout(cooldownSnowball, function()
            accessTakeSnowball = true
        end)
    end
    if action == 'vehicle' then
        accessSpawnVehicle = false
        SetTimeout(ChristmasConfig.cooldown.spawnVehicle * 1000, function()
            accessSpawnVehicle = true
        end)
    end
end

function openMenu()
    if isMenuOpened then
        isMenuOpened = false
        RageUI.Visible(christmasMainMenu, false)
    else
        isMenuOpened = true
        RageUI.Visible(christmasMainMenu, true)
        CreateThread(function()
            while isMenuOpened do
                Wait(0)
                RageUI.IsVisible(christmasMainMenu, function()
                    RageUI.Button(ChristmasConfig.messages["christmas_menu_name"], nil, { RightLabel = "→" }, true, {}, christmasMenu)
                    RageUI.Button(ChristmasConfig.messages["christmas_animations_name"], nil, { RightLabel = "→" }, true, {}, christmasAnimationsMenu)
                    RageUI.Button(ChristmasConfig.messages["christmas_calendar_name"], nil, { RightLabel = "→" }, true, {}, christmasCalendarMenu)
                    RageUI.Button(ChristmasConfig.messages["christmas_color_name"], nil, { RightLabel = "→" }, true, {}, christmasColorsMenu)
                    RageUI.Button(ChristmasConfig.messages["christmas_settings_name"], nil, { RightLabel = "→" }, true, {}, christmasSettingsMenu)
                    RageUI.Button("Crédit", nil, { RightLabel = "→" }, true, {}, christmasCreditMenu)
                end)

                RageUI.IsVisible(christmasMenu, function()
                    RageUI.Separator(ChristmasConfig.messages["snowball_separator_name"])
                    if accessTakeSnowball then
                        RageUI.Button(ChristmasConfig.messages["snowball_button_name"], nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                cooldown('snowball')
                                ExecuteCommand(ChristmasConfig.messages["collect_snowball_me"]:format("me"))
                                christmasClientEntity:playAnim('anim@mp_snowball', 'pickup_snowball')
                                TriggerServerEvent('christmas:collectSnowballs')
                                Wait(2000)
                                local snowballs = math.random(1,3)
                                GiveWeaponToPed(PlayerPedId(), 'weapon_snowball', snowballs, false, false)
                                TriggerEvent('christmas:notify', ChristmasConfig.messages["notif_collect_snowball"]:format(snowballs))
                            end
                        })
                    else
                        RageUI.Button(ChristmasConfig.messages["snowball_button_name"], ChristmasConfig.messages["button_message_cooldown"]:format(cooldownSnowball-2997), { RightBadge = RageUI.BadgeStyle.Lock }, false, {})
                    end
                    RageUI.Separator(ChristmasConfig.messages["vehicle_separator_name"])
                    if not isVehicleIsUsed then
                        if accessSpawnVehicle then
                            RageUI.Button(ChristmasConfig.messages["vehicle_button_name"], nil, { RightLabel = "→→" }, true, {
                                onSelected = function()
                                    cooldown('vehicle')
                                    isVehicleIsUsed = true
                                    TriggerServerEvent('christmas:actionVehicle', 'spawn')
                                end
                            })
                        else
                            RageUI.Button(ChristmasConfig.messages["vehicle_button_name"], ChristmasConfig.messages["button_message_cooldown"]:format(ChristmasConfig.cooldown.spawnVehicle * 1000), { RightBadge = RageUI.BadgeStyle.Lock }, true, {})
                        end
                    else
                        RageUI.Button(ChristmasConfig.messages["vehicle_button_name2"], nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                cooldown('vehicle')
                                isVehicleIsUsed = false
                                TriggerServerEvent('christmas:actionVehicle', 'delete')
                            end
                        })
                    end
                    RageUI.Separator(ChristmasConfig.messages["outfit_separator_name"])
                    if accessOutfit then
                        RageUI.Button(ChristmasConfig.messages["outfit_button_name"], nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                accessOutfit = false
                                Outfit(true)
                                christmasClientEntity:playAnim('missheist_agency2ahelmet', 'take_off_helmet_stand')
                                Wait(1500)
                                christmasClientEntity:stopAnim()
                            end
                        })
                    else
                        RageUI.Button(ChristmasConfig.messages["outfit_button_name2"], nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                accessOutfit = true
                                Outfit(false)
                                christmasClientEntity:playAnim('missheist_agency2ahelmet', 'take_off_helmet_stand')
                                Wait(1500)
                                christmasClientEntity:stopAnim()
                            end
                        })
                    end
                end)

                RageUI.IsVisible(christmasCalendarMenu, function()
                    RageUI.Separator(ChristmasConfig.messages["calendar_separator_name"])
                    if ChristmasConfig.accessCalendar then
                        RageUI.Button(ChristmasConfig.messages["calendar_button_name"], nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                TriggerServerEvent('christmas:gift')
                            end
                        })
                    else
                        RageUI.Button(ChristmasConfig.messages["calendar_button_name"], ChristmasConfig.messages["description_calendar_no_access_name"], { RightBadge = RageUI.BadgeStyle.Lock }, false, {})
                    end
                end)

                RageUI.IsVisible(christmasAnimationsMenu, function()
                    RageUI.Separator(ChristmasConfig.messages["menu_animations_separator_name"])
                    RageUI.Button(ChristmasConfig.messages["stopanim_button_name"], nil, { RightLabel = "→→" }, true, {
                        onSelected = function()
                            christmasClientEntity:stopAnim()
                        end
                    })
                    RageUI.Separator("___________________")
                    for _,animation in pairs(ChristmasConfig.animations) do
                        RageUI.Button(animation.label, nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                christmasClientEntity:playAnim(animation.dict, animation.anim)
                            end
                        })
                    end
                end)

                RageUI.IsVisible(christmasColorsMenu, function()
                    RageUI.Separator(ChristmasConfig.messages["menu_colors_separator_name"])
                    RageUI.Button(ChristmasConfig.messages["resetcolor_button_name"], nil, { RightLabel = "→→" }, true, {
                        onSelected = function()
                            SetTimecycleModifier('')
                        end
                    })
                    RageUI.Separator("___________________")
                    for _,color in pairs(ChristmasConfig.colors) do
                        RageUI.Button(color.label, nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                christmasClientEntity:color(color.name)
                            end
                        })
                    end
                end)

                RageUI.IsVisible(christmasSettingsMenu, function()
                    RageUI.Button(ChristmasConfig.messages["startmusic_button_name"], nil, { RightLabel = "→→" }, true, {
                        onSelected = function()
                            ChristmasConfig.enableMusic = true
                            PlayUrl("christmasMusic", "https://www.youtube.com/watch?v=f61Q4tGLeCQ", 0.2, false)
                            TriggerEvent('christmas:notify', ChristmasConfig.messages["notif_music_start"])
                        end
                    })
                    RageUI.Button(ChristmasConfig.messages["stopmusic_button_name"], nil, { RightLabel = "→→" }, true, {
                        onSelected = function()
                            ChristmasConfig.enableMusic = false
                            Destroy("christmasMusic")
                            TriggerEvent('christmas:notify', ChristmasConfig.messages["notif_music_stop"])
                        end
                    })
                end)

                RageUI.IsVisible(christmasCreditMenu, function()
                    RageUI.Separator("🐀🐀 ~p~Developped ~r~By ~b~Akashi 🐀🐀")
                end)
            end
        end)
    end
end