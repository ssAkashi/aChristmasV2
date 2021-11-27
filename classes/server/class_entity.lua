---@class christmasServerEntity
christmasServerEntity = {}

---@class Vehicle
Vehicle = setmetatable({}, Vehicle)
Vehicle.__index = Vehicle
Vehicle.__call = function()
    return true
end

---createVehicle
---@param model string
---@param pos number
---@param heading number
---@return Vehicle
---@public
function christmasServerEntity:createVehicle(model, pos, heading)
    local self = {}
    local entity = CreateVehicle(model, pos.x, pos.y, pos.z, heading, true, false)
    self.id = entity
    return setmetatable(self, Vehicle)
end

---getId
---@return void
---@public
function Vehicle:getId()
    return self.id
end

---collectSnowballs
---@param source number
---@return void
---@public
function christmasServerEntity:collectSnowballs(source)
    FreezeEntityPosition(source, true)
    Wait(2000)
    FreezeEntityPosition(source, false)
    ClearPedTasks(source)
end