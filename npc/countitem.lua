--- @param e PlayerEventCommand
local function zx_npc_countitem(e)
    local command_args = ""
    if #e.args > 2 then
        command_args = " " .. table.concat(e.args, " ", 3)
    end
    local command = string.format("#countitem%s", command_args)
    e.self:Message(MT.White, "running command: " .. command)
    e.self:SendGMCommand(command)
end

return zx_npc_countitem;