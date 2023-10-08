--- @param e PlayerEventCommand
local function zx_gm_door_showmodelsfromfile(e)
    local command_args = ""
    if #e.args > 3 then
        command_args = " " .. table.concat(e.args, " ", 4)
    end
    local command = string.format("#door showmodelsfromfile%s", command_args)
    e.self:Message(MT.White, "running command: " .. command)
    e.self:SendGMCommand(command)
end

return zx_gm_door_showmodelsfromfile;