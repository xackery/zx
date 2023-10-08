local commands_path = "lua_modules/commands/zx/pc/";
local commands      = { };

commands["appearance"] = { 50, require(commands_path .. "appearance"), "Edit appearance of a PC" };
commands["appearanceeffects"] = { 50, require(commands_path .. "appearanceeffects"), "Edit appearance effects of a PC" };
commands["buff"] = { 50, require(commands_path .. "buff"), "Displays buffs for your target PC" };
commands["corpse_count"] = { 50, require(commands_path .. "info"), "Displays how many buried corpses are there for your target PC" };
commands["countitem"] = { 50, require(commands_path .. "countitem"), "Counts how many of an item held by a target PC" };
commands["currencies"] = { 50, require(commands_path .. "currencies"), "Displays currencies for your target PC" };
commands["damage"] = { 50, require(commands_path .. "damage"), "Deal damage on target PC" };
commands["distance"] = { 50, require(commands_path .. "distance"), "Displays distance between you and your target PC" };
commands["flag"] = { 50, require(commands_path .. "flag"), "Displays zone flags for your target PC" };
commands["fov"] = { 50, require(commands_path .. "fov"), "Show field of view info relative to your target PC" };
commands["group"] = { 50, require(commands_path .. "group"), "Displays group info for your target PC" };
commands["info"] = { 50, require(commands_path .. "info"), "Displays info for your target PC" };
commands["inventory"] = { 50, require(commands_path .. "inventory"), "Displays inventory for your target PC" };
commands["los"] = { 50, require(commands_path .. "los"), "Show line of sight info relative to your target PC" };
commands["doanim"] = { 50, require(commands_path .. "doanim"), "Do an animation on target PC" };

--- @param e PlayerEventCommand
local function zx_pc(e)
    if #e.args < 2 then
        zx_pc_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_pc_usage(e)
        return
    end

    if not e.self:GetTarget() then
        e.self:Message(MT.Red, "No target")
        return
    end

    if not e.self:GetTarget():IsClient() then
        e.self:Message(MT.Red, "Target is not an PC")
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
function zx_pc_usage(e)
    e.self:Message(MT.White, "Usage: #zx pc <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_pc_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_pc_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end

return zx_pc;