local commands_path = "lua_modules/commands/zx/gm/zone/";
local commands      = { };

commands["start"] = { 50, require(commands_path .. "start"), "Starts a new zone up with shortname" };
commands["shutdown"] = { 50, require(commands_path .. "shutdown"), "Shuts down a zone with shortname" };
commands["depop"] = { 50, require(commands_path .. "depop"), "Depop all NPCs in a zone" };
commands["corpsefix"] = { 50, require(commands_path .. "corpsefix"), "Fixes corpses in a zone" };

--- @param e PlayerEventCommand
local function zx_gm_zone(e)
    if #e.args < 3 then
        zx_gm_zone_usage(e)
        return
    end

    local command = commands[e.args[3]];
    if not command then
        zx_gm_zone_usage(e)
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
function zx_gm_zone_usage(e)
    e.self:Message(MT.White, "Usage: #zx gm zone <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_gm_zone_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_gm_zone_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end
return zx_gm_zone;