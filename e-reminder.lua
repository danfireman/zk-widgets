function widget:GetInfo()
	return {
		name         = "e-reminder",
		desc         = "Reminds you to E. Version 0.1",
		author       = "dyth68",
		date         = "2023",
		license      = "PD", -- should be compatible with Spring
		layer        = 11,
		enabled      = true
	}
end

local spGetMyTeamID = Spring.GetMyTeamID
local spGetTeamResources = Spring.GetTeamResources
local spPlaySoundFile = Spring.PlaySoundFile
local max = math.max

local lastReminder = 0

function widget:GameFrame(n)
    if n > 4000 and n > lastReminder + 1000 then
        local teamId = spGetMyTeamID() 
        local _, _, _, mIncome, mExpense = spGetTeamResources(teamId, "metal")
        local energy, _, _, eIncome, eExpense = spGetTeamResources(teamId, "energy")
        if eExpense - eIncome > max(0, mExpense - mIncome) then
            spPlaySoundFile("LuaUI/Widgets/build_e_reminder_snd.wav")
            
            lastReminder = n
        end

    end

end

function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget(widget)
		return
	end
end
