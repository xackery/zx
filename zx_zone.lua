local commands_path = "lua_modules/commands/zx/zone/";
local commands      = { };

commands["corpsefix"] = { 50, require(commands_path .. "wp"), "Attempt to fix corpses in current zone" };
commands["depop"] = { 50, require(commands_path .. "depop"), "Depops all NPCs in the current zone" };
commands["grid"] = { 50, require(commands_path .. "grid"), "Add or remove NPC grids for the current zone" };
commands["info"] = { 50, require(commands_path .. "info"), "Displays header data about the current zone" };
commands["repop"] = { 50, require(commands_path .. "repop"), "Repops all NPCs in the current zone" };
commands["shutdown"] = { 50, require(commands_path .. "shutdown"), "Shuts down the current zone" };
commands["wp"] = { 50, require(commands_path .. "wp"), "Add or remove NPC waypoints for the current zone" };

--- @param e PlayerEventCommand
local function zx_zone(e)
    if #e.args < 2 then
        zx_zone_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_zone_usage(e)
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
function zx_zone_usage(e)
    e.self:Message(MT.White, "Usage: #zx zone <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_zone_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_zone_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end

return zx_zone;