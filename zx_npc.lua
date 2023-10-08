local commands_path = "lua_modules/commands/zx/npc/";
local commands      = { };

commands["advspawn"] = { 50, require(commands_path .. "advspawn"), "Edit spawn data in an advanced context" };
commands["aggro"] = { 50, require(commands_path .. "aggro"), "Displays aggro information for your target NPC" };
commands["aggrozone"] = { 50, require(commands_path .. "aggrozone"), "Aggro entire zone on target NPC" };
commands["ai"] = { 50, require(commands_path .. "ai"), "Edit AI data such as <consider|faction|guard|roambox|spells>" };
commands["appearance"] = { 50, require(commands_path .. "appearance"), "Edit appearance of a NPC" };
commands["appearanceeffects"] = { 50, require(commands_path .. "appearanceeffects"), "Edit appearance effects of a NPC" };
commands["attack"] = { 50, require(commands_path .. "attack"), "Issue order for target NPC to attack <entityid>" };
commands["buff"] = { 50, require(commands_path .. "buff"), "Displays buffs for your target NPC" };
commands["castspell"] = { 50, require(commands_path .. "castspell"), "Cast a spell from target NPC on self" };
commands["countitem"] = { 50, require(commands_path .. "countitem"), "Counts how many of an item held by a target NPC" };
commands["damage"] = { 50, require(commands_path .. "damage"), "Deal damage on target NPC" };
commands["distance"] = { 50, require(commands_path .. "distance"), "Displays distance between you and your target NPC" };
commands["emotes"] = { 50, require(commands_path .. "emotes"), "List emotes of your target NPC" };
commands["fov"] = { 50, require(commands_path .. "fov"), "Show field of view info relative to your target NPC" };
commands["hate_list"] = { 50, require(commands_path .. "hate_list"), "Displays hate list for your target NPC" };
commands["info"] = { 50, require(commands_path .. "info"), "Displays info for your target NPC" };
commands["los"] = { 50, require(commands_path .. "los"), "Show line of sight info relative to your target NPC" };
commands["depop"] = { 50, require(commands_path .. "depop"), "Depop target NPC" };
commands["disarmtrap"] = { 50, require(commands_path .. "disarmtrap"), "Disarm a trap on target NPC" };
commands["doanim"] = { 50, require(commands_path .. "doanim"), "Do an animation on target NPC" };

--- @param e PlayerEventCommand
local function zx_npc(e)
    if #e.args < 2 then
        zx_npc_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_npc_usage(e)
        return
    end

    if not e.self:GetTarget() then
        e.self:Message(MT.Red, "No target")
        return
    end

    if not e.self:GetTarget():IsNPC() then
        e.self:Message(MT.Red, "Target is not an NPC")
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
function zx_npc_usage(e)
    -- [help|stats|aggro|buffs|advspawn|aggrozone|ai|appearance|appearanceeffects|attack]
    e.self:Message(MT.White, "Usage: #zx npc <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_npc_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_npc_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end

return zx_npc;