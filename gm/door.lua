local commands_path = "lua_modules/commands/zx/gm/door/";
local commands      = { };

commands["create"] = { 50, require(commands_path .. "create"), "Create a door from a model. E.g. IT78 for campfire" };
commands["list"] = { 50, require(commands_path .. "list"), "List doors in zone" };
commands["showmodelsfromfile"] = { 50, require(commands_path .. "showmodelsfromfile"), "Show all models from a file. Example tssequip.eqg or wallet01.eqg" };
commands["showmodelszone"] = { 50, require(commands_path .. "showmodelszone"), "Show all models in the current zone" };
commands["showmodelsglobal"] = { 50, require(commands_path .. "showmodelsglobal"), "Show all models globally" };

--- @param e PlayerEventCommand
local function zx_gm_door(e)
    if #e.args < 3 then
        zx_gm_door_usage(e)
        return
    end

    local command = commands[e.args[3]];
    if not command then
        zx_gm_door_usage(e)
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
function zx_gm_door_usage(e)
    e.self:Message(MT.White, "Usage: #zx gm door <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_gm_door_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_gm_door_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end
return zx_gm_door;