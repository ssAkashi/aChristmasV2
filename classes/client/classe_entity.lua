---@class christmasClientEntity
christmasClientEntity = {}

---playAnim
---@param source number
---@param dict string
---@param anim string
---@return void
---@public
function christmasClientEntity:playAnim(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Christmas.consoleLog("^2LOADING DICT ^4"..tostring(dict)) Wait(10) end
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
end

---stopAnim
---@return void
---@public
function christmasClientEntity:stopAnim()
    ClearPedTasks(PlayerPedId())
end

---color
---@return void
---@public
function christmasClientEntity:color(name)
    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(1000)
    SetTimecycleModifier(name)
end
