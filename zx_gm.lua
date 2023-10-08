local commands_path = "lua_modules/commands/zx/gm/";
local commands      = { };

commands["acceptrules"] = { 50, require(commands_path .. "acceptrules"), "Accept rules" };
commands["augmentitem"] = { 50, require(commands_path .. "augmentitem"), "Augment an item" };
commands["bug"] = { 50, require(commands_path .. "bug"), "Bug related commands" };
commands["corpse"] = { 50, require(commands_path .. "corpse"), "Corpse related commands" };
commands["info"] = { 50, require(commands_path .. "info"), "Display the #dev gm info menu" };
commands["network_info"] = { 50, require(commands_path .. "network_info"), "Display network info for your account" };
commands["npc"] = { 50, require(commands_path .. "npc"), "NPC related commands" };
commands["pc"] = { 50, require(commands_path .. "pc"), "Player related commands" };
commands["zone"] = { 50, require(commands_path .. "zone"), "Zone related commands" };
commands["databucket"] = { 50, require(commands_path .. "databucket"), "Databucket view or delete manager" };
commands["delpetition"] = { 50, require(commands_path .. "databucket"), "Delete a petition" };
commands["disablerecipe"] = { 50, require(commands_path .. "disablerecipe"), "Disable a recipe" };
commands["door"] = { 50, require(commands_path .. "door"), "Door related commands" };

--- @param e PlayerEventCommand
local function zx_gm(e)
    if #e.args < 2 then
        zx_gm_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_gm_usage(e)
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
function zx_gm_usage(e)
    -- [help|stats|aggro|buffs|advspawn|aggrozone|ai|appearance|appearanceeffects|attack]
    e.self:Message(MT.White, "Usage: #zx gm <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_gm_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_gm_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end
return zx_gm;