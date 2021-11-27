---@class ChristmasServer
ChristmasServer = {
    consoleLog = function(message)
        print("^0[^4CHRISTMAS^0] - "..message)
    end,
    log = function(message)
        local webhook = {
            {
                ["author"] = {
                ["name"] = "❤️ Christmas",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/780131463160397825/914225928329109504/240540287a006c004d13036ed8aead72974f2d72a518212664f0a8238303f0cb_200-removebg-preview.png" },
                ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/780131463160397825/914225928329109504/240540287a006c004d13036ed8aead72974f2d72a518212664f0a8238303f0cb_200-removebg-preview.png" },
                ["color"] = 16711680,
                ["title"] = Title,
                ["description"] = "**Christmas - Calendar**\n"..message,
                ["footer"] = { ["text"] = "🎅 "..os.date("%d/%m/%Y | %X"), ["icon_url"] = nil }, } }
        PerformHttpRequest(ChristmasWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Christmas", embeds = webhook, avatar_url = "https://cdn.discordapp.com/attachments/780131463160397825/914225928329109504/240540287a006c004d13036ed8aead72974f2d72a518212664f0a8238303f0cb_200-removebg-preview.png" }), { ['Content-Type'] = 'application/json' })
    end,
}