--- @param e PlayerEventCommand
local function zx_pc_fov(e)
    local command_args = ""
    if #e.args > 2 then
        command_args = " " .. table.concat(e.args, " ", 3)
    end
    local command = string.format("#show fov%s", command_args)
    e.self:Message(MT.White, "Running command: " .. command)
    e.self:SendGMCommand(command)
end

return zx_pc_fov;