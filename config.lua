ChristmasConfig = {
    getESX = '::{korioz#0110}::esx:getSharedObject', -- put your esx lib event
    useCalifornia = true, -- if you use california base
    vehicle = 'bf400',
    accessCalendar = true,
    enableMusic = true,
    events = {
      -- pur your event name
        skinchangerchange = 'skinchanger:change',
        getPlayerSkin = 'esx_skin:getPlayerSkin',
        loadskin = 'skinchanger:loadSkin',

    },
    time = {
        enableSnow = true
    },
    commands = {
        commandName = 'noel',
        keyOpen = 'F2'
    },
    cooldown = {
        spawnVehicle = 15, -- in seconds
    },
    outfits = {
      helmet1 = 22,
      helmet2 = 0,
    },
    animations = {
        {label = "Donner un cadeau", dict = 'anim@heists@box_carry@', anim = 'idle'},
        {label = "S'allonger sur la neige", dict = 'amb@world_human_sunbathe@male@back@base', anim = 'base'},
        {label = "S'asseoir sur la neige", dict = 'anim@amb@business@bgen@bgen_no_work@', anim = 'sit_phone_phoneputdown_idle_nowork'},
        {label = "Se nettoyer la neige du corps", dict = 'move_m@_idles@shake_off', anim = 'shakeoff_1'},
    },
    colors = {
        {label = "Couleur Amplifiées (neige)", name = 'rply_saturation'},
    },
    maxItem = 2, -- put your max item in the itemList
    maxWeapon = 2, -- put your max weapon in the weaponList
    giftList = { -- for the reward in calendar
        weaponList = {
            [1] = {label = "SMG", name = "weapon_smg" },
            [1] = {label = "Pistolet", name = "weapon_pistol" },
        },
        itemList = {
            [1] = { label = "Pain", name = "bread" },
            [2] = { label = "Eau", name = "water" },
        },
    },
    rewards = {
      [1] = { name = 'money', quantity = math.random(10000,15000) },
      [2] = { name = 'weapon', weaponAmmo = 150},
      [3] = { name = 'item', quantity = math.random(1,50) },
    },
    messages = {
        ["christmas_notif_title"] = "<C>~b~Christmas",
        ["christmas_notif_subtitle"] = "<C>Système",
        ["command_description"] = "Ouvrir le menu noël";
        ["submenu_title"] = "∑ Bienvenue sur le menu noËl",
        ["button_message_cooldown"] = "~r~Vous devez attendre %s secondes pour faire cette action.",
        ["christmas_menu_name"] = "Menu Noël",
        ["christmas_animations_name"] = "Menu animations",
        ["christmas_calendar_name"] = "Calendrier de l'avant",
        ["christmas_color_name"] = "Menu couleurs",
        ["christmas_settings_name"] = "Reglages",
        ["christmas_menu_subtitle"] = "∑ Menu noËl - Actions",
        ["christmas_animations_subtitle"] = "∑ Menu noËl - Animations",
        ["christmas_calendar_subtitle"] = "∑ Menu noËl - Calendrier",
        ["christmas_color_subtitle"] = "∑ Menu noËl - Couleurs",
        ["christmas_menu_subtitle"] = "∑ Menu noËl - Actions",
        ["snowball_separator_name"] = "~r~↓ ~b~Boule de neiges ~r~↓",
        ["snowball_button_name"] = "Ramasser des boules de neiges",
        ["collect_snowball_me"] = "%s l'individu ramasse des boules de neiges",
        ["notif_collect_snowball"] = "<C>Vous avez ramassé ~b~x%s ~s~boules de neiges.",
        ["vehicle_separator_name"] = "~r~↓ ~b~Véhicule ~r~↓",
        ["vehicle_button_name"] = "~g~Sortir sa moto de poche",
        ["vehicle_button_name2"] = "~r~Ranger sa moto de poche",
        ["outfit_separator_name"] = "~r~↓ ~b~Vêtements ~r~↓",
        ["outfit_button_name"] = "~g~Mettre son bonnet de noël",
        ["outfit_button_name2"] = "~r~Enlever son bonnet de noël",
        ["outfit_button_name2"] = "~r~Enlever son bonnet de noël",
        ["menu_animations_separator_name"] = "~b~→~s~ Animations",
        ["stopanim_button_name"] = "~r~Arrêter l'animation",
        ["menu_colors_separator_name"] = "~b~→~s~ Animations",
        ["resetcolor_button_name"] = "~r~Réinitialiser les couleurs",
        ["calendar_separator_name"] = "~b~→~s~ Calendrier de l'avant",
        ["calendar_button_name"] = "Récupérer ma récompense du jour",
        ["description_calendar_no_access_name"] = "~r~Vous avez déjà pris votre récompense.",
        ["startmusic_button_name"] = "~g~Relancer la musique",
        ["stopmusic_button_name"] = "~r~Arrêter la musique",
        ["notif_music_start"] = "Musique relancée avec succès !",
        ["notif_music_stop"] = "Musique stoppée avec succès !",
        ["reward_money_message"] = "Vous avez gagné ~g~%s $ ~s~ en cash ! Revenez demain pour un nouveau cadeau.",
        ["reward_weapon_message"] = "Vous avez gagné ~b~%s ~s~avec ~b~x%s~s~ balles. Revenez demain pour un nouveau cadeau.",
        ["reward_item_message"] = "Vous avez gagné ~b~x%s %s~s~. Revenez demain pour un nouveau cadeau.",
    }
}