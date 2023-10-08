local commands_path = "lua_modules/commands/zx/self/";
local commands      = { };

commands["castspell"] = { 50, require(commands_path .. "castspell"), "Cast a spell on self" };
commands["countitem"] = { 50, require(commands_path .. "countitem"), "Counts how many of an item held on self" };
commands["doanim"] = { 50, require(commands_path .. "doanim"), "Do an animation on self" };

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

    local access, func = command[1], command[2]
    if access > e.self:Admin() then
        e.self:Message(MT.Red, "Access level not high enough.")
        return
    end

    func(e)
end

--- @param e PlayerEventCommand
function zx_pc_usage(e)
    e.self:Message(MT.White, "Usage: #zx gm self <context>")
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