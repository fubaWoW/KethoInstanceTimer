local NAME, S = ...
local KIT = kInstanceTimer

local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

local L = S.L
local options = S.options

local profile, char

	----------------------
	--- Initialization ---
	----------------------

local slashCmds = {"kit", "kinstance", "kinstancetimer"}

function KIT:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("kInstanceTimerDB", S.defaults, true)

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshDB")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshDB")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshDB")
	self:RefreshDB()

	self.db.global.version = S.VERSION
	self.db.global.build = S.BUILD
	
	options.args.libsink = self:GetSinkAce3OptionsDataTable()
	options.args.libsink.order = 3
	
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles.order = 4
	
	ACR:RegisterOptionsTable(NAME, S.options)
	ACD:AddToBlizOptions(NAME, NAME)
	ACD:SetDefaultSize(NAME, 550, 410)
	
	----------------------
	--- Slash Commands ---
	----------------------
	
	for _, v in ipairs(slashCmds) do
		self:RegisterChatCommand(v, "SlashCommand")
	end
	
	-----------------------------
	--- Custom SavedVariables ---
	-----------------------------
	
	char.TimeInstanceList = char.TimeInstanceList or {}
	
	-- time data should be preserved between /reload's
	char.timeInstance = char.timeInstance or 0
	char.startDate = char.startDate or ""
	char.startTime = char.startTime or ""
end

function KIT:OnEnable()
	for _, v in ipairs(S.events) do
		self:RegisterEvent(v)
	end
	
	-- support [Class Colors] by Phanx
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(function()
			wipe(S.classCache)
		end, self)
	end
	
	-- player is not in a group (anymore) -> reset timer
	if self:NoGroup() then
		self:ResetTime(true)
	end
	
	-- initialize stopwatch while in an instance
	if S.IsStopwatch() then
		S.StopwatchStart()
	end
end

function KIT:RefreshDB()
	profile = self.db.profile
	char = self.db.char
	
	self:SetSinkStorage(profile) -- LibSink
	
	-- update table references in other files
	for i = 1, 2 do
		self["RefreshDB"..i](self)
	end
end

function KIT:SlashCommand()
	ACD:Open(NAME)
end

	-------------
	--- Start ---
	-------------

function KIT:CHAT_MSG_CHANNEL_NOTICE(event, msg)
	if msg == "YOU_CHANGED" then
		local instance = select(2, IsInInstance())
		
		if S.pve[instance] then
			-- entered instance
			if self:GetInstanceTime() == 0 then
				self:StartData()
			end
			
			if profile.Stopwatch then
				S.StopwatchStart()
			end
		elseif instance == "none" and self:NoGroup() then
			-- left instance
			self:ResetTime(true)
			
			if profile.Stopwatch then
				S.StopwatchEnd()
			end
		end
	end
end

	-------------
	--- Leave ---
	-------------

function KIT:CHAT_MSG_SYSTEM(event, msg)
	-- left or kicked from group
	if msg == ERR_LEFT_GROUP_YOU or msg == ERR_UNINVITE_YOU then
		self:ResetTime(true)
		
		if profile.Stopwatch then
			S.StopwatchEnd()
		end
	end
end

	-----------
	--- End ---
	-----------

function KIT:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	
	if subevent == "UNIT_DIED" and strsub(destGUID, 5, 5) == "3" then
		local destNPC = tonumber(strsub(destGUID, 7, 10), 16)
		if (S.BossIDs[destNPC] or S.RaidBossIDs[destNPC]) and self:GetInstanceTime() > 0 then
			
			-- damn you, cookie!
			if destNPC == 47739 and GetInstanceDifficulty() == 2 then return end

			-- Record
			local subZone = S.SubZoneBossIDs[destNPC] or S.SubRaidZoneBossIDs[destNPC]
			if profile.RecordInstance then
				self:Record(subZone)
			end
			
			-- Report
			if (profile.Instance and S.BossIDs[destNPC]) or (profile.Raid and S.RaidBossIDs[destNPC]) then
				self:Pour(self:InstanceText(subZone))
			end
			
			if profile.Stopwatch then
				Stopwatch_Pause()
			end
			
			if profile.Screenshot then
				self:ScheduleTimer(function()
					Screenshot()
				end, 1)
			end
			
			-- pre-boss in a subzone
			if S.PreBossIDs[destNPC] then
				S.backupInstance = char.timeInstance
			-- final boss in a subzone
			elseif S.FinalBossIDs[destNPC] then
				S.backupInstance = nil
			end
			
			-- pause LibDataBroker display 
			local startTime = self:GetInstanceTime()
			S.LastInst = startTime > 0 and time() - startTime
			
			-- reset variables
			self:ResetTime()
		end
	end
end

	-----------------------
	--- Secondary Start ---
	-----------------------

function KIT:LFG_PROPOSAL_SUCCEEDED()
	self:ScheduleTimer(function()
		if self:GetInstanceTime() == 0 then
			self:StartData()
			
			if S.IsStopwatch() then
				S.StopwatchStart()
			end
		end
	end, 30)
end

	---------------------
	--- Secondary End ---
	---------------------

-- only fires after completing a random dungeon
-- delay it a bit, so it doesn't react on the same time as boss death
function KIT:LFG_COMPLETION_REWARD()
	self:ScheduleTimer(function()
		if self:GetInstanceTime() > 0 then
			if profile.RecordInstance then
				self:Record()
			end
			
			local instance = select(2, IsInInstance())
			if (profile.Instance and instance == "party") or (profile.Raid and instance == "raid") then
				self:Pour(self:InstanceText())
			end
			
			if S.IsStopwatch() then
				Stopwatch_Pause()
			end
			
			if profile.Screenshot then
				self:ScheduleTimer(function()
					Screenshot()
				end, 1)
			end
			
			-- pause LibDataBroker display 
			local startTime = self:GetInstanceTime()
			S.LastInst = startTime > 0 and time() - startTime
			
			-- reset variables
			self:ResetTime()
		end
	end, 1)
end
