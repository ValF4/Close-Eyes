local ServerScriptService = game:GetService("ServerScriptService")

local listCodes = require(ServerScriptService.ServerLists.codeList)

local codeSystem = {}

function codeSystem.checkingList(Code: string): string | boolean
    local getCode: string? = listCodes[Code]

    if getCode then
        return true
    else
        return
    end
end

return codeSystem