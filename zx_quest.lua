local commands_path = "lua_modules/commands/zx/quest/";
local commands      = { };

commands["info"] = { 50, require(commands_path .. "info"), "Displays info about quests running in the current zone" };

--- @param e PlayerEventCommand
local function zx_quest(e)
    if #e.args < 2 then
        zx_quest_usage(e)
        return
    end
    local command = commands[e.args[2]];
    if not command then
        zx_quest_usage(e)
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
function zx_quest_usage(e)
    e.self:Message(MT.White, "Usage: #zx quest <context>")
    e.self:Message(MT.White, "Contexts are:")
    for k, v in pairs(commands) do
        zx_quest_usage_command(e, k, v[1], v[3])
    end
end


--- @param e PlayerEventCommand
--- @param name string
--- @param access integer
--- @param desc string
function zx_quest_usage_command(e, name, access, desc)
    if access > e.self:Admin() then
        return
    end

    e.self:Message(MT.White, "  " .. name .. " - " .. desc)
end
return zx_quest;