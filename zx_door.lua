local commands_path = "lua_modules/commands/zx/door/";
local commands      = { };
commands["setinvertstate"] = { 50, require(commands_path .. "setinvertstate"), "Set the invert state of target door" };
commands["setincline"] = { 50, require(commands_path .. "setincline"), "Set the incline of target door" };
commands["opentype"] = { 50, require(commands_path .. "opentype"), "Set the open type of target door" };
commands["model"] = { 50, require(commands_path .. "model"), "Set the model of target door" };
commands["save"] = { 50, require(commands_path .. "save"), "Save target door to the database" };
commands["edit"] = { 50, require(commands_path .. "edit"), "Edit target door" };

--- @param e PlayerEventCommand
local function zx_door(e)
    if #e.args < 2 then
        zx_door_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_door_usage(e)
        return
    end

    if not e.self:GetTarget() then
        e.self:Message(MT.Red, "No target")
        return
    end

    if not e.self:GetTarget():IsClient() then
        e.self:Message(MT.Red, "Target is not an door")
        return
    end

    local access, func = command[1], command[2]
    if access > e.self:Admin() then
        e.self:Message(MT.Red, "Access level not high enough.")
        return
    end

    func(e)
end

--- @param e PlayerEventCommand
function zx_door_usage(e)
    e.self:Message(MT.White, "Usage: #zx door <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_door_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_door_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end

return zx_door;