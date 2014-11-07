local NAME, S = ...
local KIT = KethoInstanceTimer

local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

local L = S.L
local options = S.options

local profile, char

	---------------------------
	--- Ace3 Initialization ---
	---------------------------

function KIT:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("KethoInstanceTimerDB", S.defaults, true)
	
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
	ACD:AddToBlizOptions(NAME, S.NAME)
	ACD:SetDefaultSize(NAME, 550, 430)
	
	----------------------
	--- Slash Commands ---
	----------------------
	
	for _, v in ipairs({"kit", "kinstance", "kinstancetimer", "kethoinstance", "kethoinstancetimer"}) do
		self:RegisterChatCommand(v, "SlashCommand")
	end
	
	-----------------------------
	--- Custom SavedVariables ---
	-----------------------------
	
	char.TimeInstanceList = char.TimeInstanceList or {}
	
	-- time data should be preserved between every /reload
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
		CUSTOM_CLASS_COLORS:RegisterCallback("WipeCache", self)
	end
	
	-- player is not in a group (anymore) -> reset timer
	if not IsInGroup() then
		self:ResetTime(true)
	end
	
	-- initialize stopwatch while in an instance
	if S.IsStopwatch() then
		S.instance = select(2, IsInInstance())
		S.StopwatchStart()
	end
end

function KIT:OnDisable()
	self:UnregisterAllEvents()
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:UnregisterCallback("WipeCache", self)
	end
	
	if S.IsStopwatch() then
		S.StopwatchEnd()
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

local enable = {
	["1"] = true,
	on = true,
	enable = true,
	load = true,
}

local disable = {
	["0"] = true,
	off = true,
	disable = true,
	unload = true,
}

function KIT:SlashCommand(input)
	if enable[input] then
		self:Enable()
		self:Print("|cffADFF2F"..VIDEO_OPTIONS_ENABLED.."|r")
	elseif disable[input] then
		self:Disable()
		self:Print("|cffFF2424"..VIDEO_OPTIONS_DISABLED.."|r")
	elseif input == "toggle" then
		self:SlashCommand(self:IsEnabled() and "0" or "1")
	else
		ACD:Open(NAME)
	end
end

	-------------
	--- Start ---
	-------------

function KIT:PLAYER_ENTERING_WORLD(event)
	S.instance = select(2, IsInInstance())
	
	if S.pve[S.instance] then
		-- entered instance
		if char.timeInstance == 0 then
			self:StartData()
		end
		
		if profile.Stopwatch then
			S.StopwatchStart()
		end
	elseif S.instance == "none" and not IsInGroup() then
		-- left instance
		self:ResetTime(true)
		
		if profile.Stopwatch then
			S.StopwatchEnd()
		end
	end
end

	-----------
	--- End ---
	-----------

local npc = {
	Creature = true,
	Vehicle = true,
}

function KIT:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	
	if subevent ~= "UNIT_DIED" then return end
	
	local unitType, _, _, _, _, npcId = strsplit(":", destGUID)
	npcId = tonumber(npcId)
	local id = S.RaidBossIDs[npcId] or S.Seasonal[npcId]
	
	if npc[unitType] and id and char.timeInstance > 0 then
		-- exceptions/overrides
		local override = (type(id) == "string") and id
		
		-- Record
		if profile.RecordInstance then
			self:Record(override, S.Seasonal[npcId])
		end
		
		-- Report
		if profile[S.instance] then
			self:Pour(self:InstanceText(nil, override))
		end
		
		self:Finalize()
	end
end

	---------------------
	--- Leave / Reset ---
	---------------------

-- dunno how to find a string consisting of 2 words, with just %s
local INSTANCE_RESET_SUCCESS = INSTANCE_RESET_SUCCESS:gsub("%%s", "")

function KIT:CHAT_MSG_SYSTEM(event, msg)
	-- left or kicked from group; or reset through ResetInstances()
	if msg == ERR_LEFT_GROUP_YOU or msg == ERR_UNINVITE_YOU or strfind(msg, INSTANCE_RESET_SUCCESS) then
		self:ResetTime(true)
		
		if profile.Stopwatch then
			S.StopwatchEnd()
		end
	end
end

	-----------------------
	--- Secondary Start ---
	-----------------------

function KIT:LFG_PROPOSAL_SUCCEEDED(event)
	C_Timer.After(20, function()
		if char.timeInstance == 0 then
			self:StartData()
			
			if S.IsStopwatch() then
				S.StopwatchStart()
			end
		end
	end)
end

	---------------------
	--- Secondary End ---
	---------------------

function KIT:SecondaryCompletion()
	-- delay it a bit, so it doesn't react on the same time as boss death
	C_Timer.After(1, function()
		if char.timeInstance > 0 then
			if profile.RecordInstance then
				self:Record()
			end
			
			if profile[S.instance] then
				self:Pour(self:InstanceText())
			end
			
			self:Finalize()
		end
	end)
end

-- only fires after completing a random dungeon
function KIT:LFG_COMPLETION_REWARD(event)
	self:SecondaryCompletion()
end

-- scenarios and instances (since WoD)
function KIT:SCENARIO_COMPLETED(event)
	self:SecondaryCompletion()
end
