local commands_path = "lua_modules/commands/zx/gm/pc/";
local commands      = { };

commands["ban"] = { 50, require(commands_path .. "ban"), "Ban an account by their character name" };
commands["info"] = { 50, require(commands_path .. "info"), "Show client version summary of players in zone" };
commands["ip"] = { 50, require(commands_path .. "ip"), "List players and their IPs, status, accountId, charID, LSID" };
commands["list"] = { 50, require(commands_path .. "list"), "List players in zone" };
commands["copycharacter"] = { 50, require(commands_path .. "copycharacter"), "Copy a character between accounts" };
commands["delacct"] = { 50, require(commands_path .. "delacct"), "Delete an account" };

--- @param e PlayerEventCommand
local function zx_gm_pc(e)
    if #e.args < 3 then
        zx_gm_pc_usage(e)
        return
    end

    local command = commands[e.args[3]];
    if not command then
        zx_gm_pc_usage(e)
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
function zx_gm_pc_usage(e)
    -- [help|stats|aggro|buffs|advspawn|aggrozone|ai|appearance|appearanceeffects|attack]
    e.self:Message(MT.White, "Usage: #zx gm pc <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_gm_pc_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_gm_pc_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end
return zx_gm_pc;