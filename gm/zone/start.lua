--- @param e PlayerEventCommand
local function zx_gm_zone_start(e)
    local command_args = ""
    if #e.args > 3 then
        command_args = " " .. table.concat(e.args, " ", 4)
    end
    local command = string.format("#zonebootup%s", command_args)
    e.self:Message(MT.White, "Running command: " .. command)
    e.self:SendGMCommand(command)
end

return zx_gm_zone_start;