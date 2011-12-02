-------------------------------------------
--- Author: Ketho (EU-Boulderfist)		---
--- License: Public Domain				---
--- Created: 2011.05.27					---
--- Version: 0.3 [2011.12.02]			---
-------------------------------------------
--- Curse			http://www.curse.com/addons/wow/kinstancetimer
--- WoWInterface	http://www.wowinterface.com/downloads/info19910-kInstanceTimer.html

-- To Do: new record time

local NAME = ...
local VERSION = 0.3
local BUILD = "Release"

	-----------------
	--- Libraries ---
	-----------------

kInstanceTimer = LibStub("AceAddon-3.0"):NewAddon(NAME, "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "LibSink-2.0")
local KIT = kInstanceTimer

local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("kInstanceTimer", true)

	----------------
	--- Upvalues ---
	----------------

local _G = _G
local date, time = date, time
local floor, mod = floor, mod
local format, gsub = format, gsub 

local IsInInstance = IsInInstance
local GetBattlefieldInstanceRunTime = GetBattlefieldInstanceRunTime

local profile, char

local timeInstance2
local lastTimeInst, lastTimeBG

local cropped = ":64:64:4:60:4:60"

local pve = {
	["party"] = true,
	["raid"] = true,
}

local pvp = {
	["pvp"] = true,
	["arena"] = true,
}

	--------------------
	--- Time Strings ---
	--------------------

local D_SECONDS = strlower(D_SECONDS)
local D_MINUTES = strlower(D_MINUTES)
local D_HOURS = strlower(D_HOURS)
local D_DAYS = strlower(D_DAYS)

if GetLocale() == "deDE" then
	D_SECONDS = _G.D_SECONDS
	D_MINUTES = _G.D_MINUTES
	D_HOURS = _G.D_HOURS
	D_DAYS = _G.D_DAYS
end

local bttn = CreateFrame("Button")

local MINUTES2 = gsub(bttn:GetText(bttn:SetFormattedText(D_MINUTES, 2)), "2 ", "") -- plural minutes
local SECONDS2 = gsub(bttn:GetText(bttn:SetFormattedText(D_SECONDS, 2)), "2 ", "") -- plural seconds

local D_MINUTES2 = gsub(D_MINUTES, "%%d", "%%.1f") -- integer -> float

	----------------
	--- Boss IDs ---
	----------------

local BossIDs = { -- Instance Timer
--	[01-60] Classic
	[1853] = true, -- Darkmaster Gandling; Scholomance
	[2748] = true, -- Archaedas; Uldaman
	[3975] = true, -- Herod; Scarlet Monastery: Armory
	[3977] = true, -- High Inquisitor Whitemane; Scarlet Monastery: Cathedral
	[3654] = true, -- Mutanus the Devourer; Wailing Caverns
	[4275] = true, -- Archmage Arugal; Shadowfang Keep (Normal/Heroic)
	[4421] = true, -- Charlga Razorflank; Razorfen Kraul
	[4543] = true, -- Bloodmage Thalnos; Scarlet Monastery: Graveyard
	[4829] = true, -- Aku'mai; Blackfathom Deeps
	[5709] = true, -- Shade of Eranikus; Sunken Temple
	[6487] = true, -- Arcanist Doan; Scarlet Monastery: Library
	[7267] = true, -- Chief Ukorz Sandscalp; Zul'Farrak
	[7358] = true, -- Amnennar the Coldbringer; Razorfen Downs
	[7800] = true, -- Mekgineer Thermaplugg; Gnomeregan
	[9018] = true, -- High Interrogator Gerstahn; Blackrock Depths: Prison
	[9019] = true, -- Emperor Dagran Thaurissan; Blackrock Depths: Upper City
	[9568] = true, -- Overlord Wyrmthalak; Lower Blackrock Spire
	[10813] = true, -- Balnazzar; Stratholme: Main Gate
	[11486] = true, -- Prince Tortheldrin; Dire Maul: Capital Gardens
	[11492] = true, -- Alzzin the Wildshaper; Dire Maul: Warpwood Quarter
	[11501] = true, -- King Gordok; Dire Maul: Gordok Commons
	[11520] = true, -- Taragaman the Hungerer; Ragefire Chasm
	[12201] = true, -- Princess Theradras; Maraudon: Earth Song Falls
	[12236] = true, -- Lord Vyletongue; Maraudon: The Wicked Grotto
	[12258] = true, -- Razorlash; Maraudon: Foulspore Cavern
	[45412] = true, -- Lord Aurius Rivendare; Stratholme - Service Entrance
	[46964] = true, -- Lord Godfrey; Shadowfang Keep
	[46254] = true, -- Hogger; Stormwind Stockade
	[47739] = true, -- "Captain" Cookie; Deadmines (Normal)
	[49541] = true, -- Vanessa VanCleef; Deadmines (Heroic)

--	[60-70] The Burning Crusade
	[16808] = true, -- Warchief Kargath Bladefist; Hellfire Citadel: The Shattered Halls
	[17377] = true, -- Keli'dan the Breaker; Hellfire Citadel: The Blood Furnace
--	[17536] = true, -- [Old] Nazan; Hellfire Citadel: Hellfire Ramparts
	[17307] = true, -- Nazan; Hellfire Citadel: Hellfire Ramparts
	[17798] = true, -- Warlord Kalithresh; Coilfang Reservoir: The Steamvault
	[17881] = true, -- Aeonus; Caverns of Time: The Black Morass
	[17882] = true, -- The Black Stalker; Coilfang Reservoir: The Underbog
	[17942] = true, -- Quagmirran; Coilfang Reservoir: The Slave Pens
	[17977] = true, -- Warp Splinter; Tempest Keep: The Botanica
	[18344] = true, -- Nexus-Prince Shaffar; Auchindoun: Mana-Tombs
	[18373] = true, -- Exarch Maladaar; Auchindoun: Auchenai Crypts
	[18473] = true, -- Talon King Ikiss; Auchindoun: Sethekk Halls
	[18708] = true, -- Murmur; Auchindoun: Shadow Labyrinth
	[18096] = true, -- Epoch Hunter; Caverns of Time: Old Hillsbrad Foothills
	[19220] = true, -- Pathaleon the Calculator; Tempest Keep: The Mechanar
	[20912] = true, -- Harbinger Skyriss; Tempest Keep: The Arcatraz

--	[70-80] Wrath of the Lich King
	[26632] = true, -- The Prophet Tharon'ja; Drak'Tharon Keep (name has an extra space at the end when transformed] = true, GUID remains unchanged though)
	[26723] = true, -- Keristrasza; The Nexus: The Nexus
	[26861] = true, -- King Ymiron; Utgarde Keep: Utgarde Pinnacle
	[27656] = true, -- Ley-Guardian Eregos; The Nexus: The Oculus
	[27978] = true, -- Sjonnir The Ironshaper; Ulduar: Halls of Stone
	[28923] = true, -- Loken; Ulduar: Halls of Lightning
	[29120] = true, -- Anub'arak; Azjol-Nerub: Azjol-Nerub
	[29306] = true, -- Gal'darah; Gundrak
	[29311] = true, -- Herald Volazj; Azjol-Nerub: Ahn'kahet: The Old Kingdom
	[31134] = true, -- Cyanigosa; The Violet Hold
	[36502] = true, -- Devourer of Souls; Icecrown Citadel: The Forge of Souls
	[36658] = true, -- Scourgelord Tyrannus; Icecrown Citadel: Pit of Saron
--	[23954] = true, -- Ingvar the Plunderer; Utgarde Keep: Utgarde Pinnacle (dies 2x)
--	[26533] = true, -- Mal'Ganis; Caverns of Time: The Culling of Stratholme (no death)
--	[35451] = true, -- The Black Knight; Crusaders' Coliseum: Trial of the Champion (dies 3x)
--	[36954] = true, -- The Lich King; Icecrown Citadel: Halls of Reflection (no death)

--	[80-85] Cataclysm
	[39705] = true, -- Ascendant Lord Obsidius; Blackrock Caverns
	[39378] = true, -- Rajh; Halls of Origination
	[40484] = true, -- Erudax; Grim Batol
	[42333] = true, -- High Priestess Azil; The Stonecore
	[43875] = true, -- Asaad; The Vortex Pinnacle
--	[44566] = true, -- Ozumat; Throne of the Tides [no death; 1hp]
	[44819] = true, -- Siamat; Lost City of the Tol'vir
	[52148] = true, -- Jin'do the Godbreaker; Zul'Gurub (does he actually die?)
--	[52150] = true, -- Jin'do the Godbreaker; Zul'Gurub (the phase 2 version)
	[23863] = true, -- Daakara; Zul'Aman
	[54432] = true, -- Murozond; End Time
	[54969] = true, -- Mannoroth; Well of Eternity (not sure if this one works)
	[54938] = true, -- Archbishop Benedictus; Hour of Twilight
}

local RaidBossIDs = { -- untested
	[52363] = true, -- Occu'thar; Baradin Hold
	[43324] = true, -- Cho'gall; The Bastion of Twilight
	[41376] = true, -- Nefarian; Blackwing Descent
	[46753] = true, -- Al'Akir; Throne of the Four Winds
	[52409] = true, -- Ragnaros; Firelands
	[55689] = true, -- Hagara the Stormbinder; Dragon Soul
	[56173] = true, -- Deathwing; Dragon Soul (not sure if this one works)
}

local SubZoneBossIDs = {
	-- Scarlet Monastery
	[4543] = L["Graveyard"], -- [27-37?] Bloodmage Thalnos
	[6487] = L["Library"], -- [30-40?] Arcanist Doan
	[3975] = L["Armory"], -- [32-42?] Herod
	[3977] = L["Cathedral"], -- [35-45] High Inquisitor Whitemane
	-- Maraudon
	[12236] = L["The Wicked Grotto"], -- [39-49?] Lord Vyletongue
	[12258] = L["Foulspore Cavern"], -- [41-51?] Razorlash
	[12201] = L["Earth Song Falls"], -- [34-44] Princess Theradras
	-- Blackrock Depths
	[9018] = L["Detention Block"], -- [47-57] High Interrogator Gerstahn
	[9019] = L["Upper City"], -- [51-61] Emperor Dagran Thaurissan
	-- Dire Maul
	[11492] = L["Warpwood Quarter"], -- [36-46] Alzzin the Wildshaper
	[11486] = L["Capital Gardens"], -- [39-49] Prince Tortheldrin
	[11501] = L["Gordok Commons"], -- [42-52] King Gordok
	-- Stratholme
	[10813] = L["Main Gate"], -- [42-52] Balnazzar
	[45412] = L["Service Entrance"], -- [46-56] Lord Aurius Rivendare
}

local SubRaidZoneBossIDs = {
	-- Dragon Soul
	[55689] = L["Fall of Deathwing"], -- Hagara the Stormbinder
	[56173] = L["The Siege of Wyrmrest Temple"], --  Deathwing
}

local preBossIDs = {
	[12236] = true, -- Lord Vyletongue
	[12258] = true, -- Razorlash
	[9018] = true, -- High Interrogator Gerstahn
	[10813] = true, -- Balnazzar
}

local finalBossIDs = {
	[12201] = true, -- Princess Theradras
	[9019] = true, -- Emperor Dagran Thaurissan
	[45412] = true, -- Lord Aurius Rivendare
}

	-----------------
	--- Stopwatch ---
	-----------------

local function StopwatchStart()
	StopwatchFrame:Show()
	Stopwatch_Clear()
	Stopwatch_Play()
end

local function StopwatchEnd()
	Stopwatch_Clear()
	StopwatchFrame:Hide()
end

local function IsStopwatch()
	local instanceType = select(2, IsInInstance())
	local isParty = profile.InstanceStopwatch and instanceType == "party"
	local isRaid = profile.RaidStopwatch and instanceType == "raid"
	local isBG = profile.BattlegroundStopwatch and pvp[instanceType]
	return isParty or isRaid or isBG
end

local function CalibrateStopwatch()
	local instanceType = select(2, IsInInstance())
	if pve[instanceType] then
		local startTime = timeInstance2 or char.timeInstance
		StopwatchTicker.timer = lastTimeInst and lastTimeInst or startTime > 0 and time() - startTime or 0
	elseif pvp[instanceType] then
		local runTime = GetBattlefieldInstanceRunTime()
		StopwatchTicker.timer = lastTimeBG and lastTimeBG or runTime > 0 and runTime / 1000 or 0
	end
end

local function ToggleStopwatch(show)
	if select(2, IsInInstance()) == "none" then return end

	if show then
		StopwatchFrame:Show()
		Stopwatch_Play()
	else
		Stopwatch_Clear()
		StopwatchFrame:Hide()
	end
end

	---------------
	--- Options ---
	---------------

local defaults = {
	profile = {
		Instance = true,
		instanceTimerMsg = L["instanceTimerMsg"],
		TimeFormat = 1,
		RecordInstance = true,
		sink20OutputSink = "Channel",
		sink20ScrollArea = GROUP,
	},
	-- dont know the proper way for this (=.=)
	char = {
		timeInstance = 0,
		timeInstanceStart = "",
		timeInstanceStart2 = "",
	},
}

local tempList = {}

local options = {
	type = "group",
	name = "|TInterface\\Icons\\Spell_Holy_BorrowedTime:16:16:3:0"..cropped.."|t  "..NAME.." |cffADFF2Fv"..VERSION.."|r",
	handler = KIT,
	args = {
		spacing1 = {type = "description", order = 1, name = " "},
		Timer = {
			type = "group", order = 2,
			name = L["Instance Timer"],
			inline = true,
			args = {
				Instance = {
					type = "toggle", order = 1,
					width = "full", descStyle = "",
					name = " |cffA8A8FF"..INSTANCE.."|r",
					get = "GetValue", set = "SetValue",
				},
				Raid = {
					type = "toggle", order = 2,
					width = "full", descStyle = "",
					name = " |cffFF7F00"..RAID.."|r",
					get = "GetValue", set = "SetValue",
				},
			},
		},
		spacing2 = {type = "description", order = 3, name = " "},
		Stopwatch = {
			type = "group", order = 4,
			name = STOPWATCH_TITLE,
			inline = true,
			args = {
				InstanceStopwatch = {
					type = "toggle", order = 1,
					width = "full", descStyle = "",
					name = " "..INSTANCE,
					get = "GetValue", set = "SetValueStopwatch",
				},
				RaidStopwatch = {
					type = "toggle", order = 2,
					width = "full", descStyle = "",
					name = " "..RAID,
					get = "GetValue", set = "SetValueStopwatch",
				},
				BattlegroundStopwatch = {
					type = "toggle", order = 3,
					width = "full", descStyle = "",
					name = " "..BATTLEGROUND,
					get = "GetValue", set = "SetValueStopwatch",
				},
			},
		},
		inputInstanceTimerMsg = {
			type = "input", order = 5,
			width = "full",
			name = " ",
			usage = "\n|cffA8A8FF[INSTANCE]|r |cffFFFFFF= "..INSTANCE.."|r\n|cff71D5FF[TIME]|r |cffFFFFFF= Time|r\n|cffF6ADC6[START]|r |cffFFFFFF= Start Time|r\n|cffADFF2F[END]|r |cffFFFFFF= End Time|r\n|cff0070DD[DATE]|r |cffFFFFFF= MM/DD/YY|r\n|cff0070DD[DATE2]|r |cffFFFFFF= YYYY.MM.DD|r",
			get = function(i) return profile.instanceTimerMsg end,
			set = function(i, v) profile.instanceTimerMsg = v
				if #strtrim(v) == 0 then
					profile.instanceTimerMsg = defaults.profile.instanceTimerMsg
				end
			end,
		},
		descriptionExample = {
			type = "description", order = 6,
			name = function() return "   "..KIT:ReplaceText(profile.instanceTimerMsg, nil, true) end,
		},
		spacing3 = {
			type = "description", order = 7,
			name = "\n\n\n\n\n\n\n\n",
		},
		TimeFormat = {
			type = "select", order = 8,
			descStyle = "",
			name = "   Time Format",
			values = {"|cffB6CA00x|r "..MINUTES2..", |cffF6ADC6y|r "..SECONDS2.."", "|cffB6CA00x|r.|cffF6ADC6y|r "..MINUTES2},
			get = "GetValue", set = "SetValue",
		},
		newline1 = {type = "description", order = 9, name = ""},
		RecordInstance = {
			type = "toggle", order = 10,
			width = "full", descStyle = "",
			name = " Record "..INSTANCE,
			get = "GetValue", set = "SetValue",
		},
		executePrintInstanceTimer = {
			type = "execute", order = 11,
			descStyle = "",
			name = "|cffFFFFFFInstance Data|r",
			func = function()
				wipe(tempList)
				for k in pairs(char.timeInstanceList) do
					tinsert(tempList, k)
				end
				sort(tempList)
				for _, v in ipairs(tempList) do
					print(v.." "..char.timeInstanceList[v])
				end
			end,
			disabled = function() return not profile.RecordInstance end,
		},
	},
}

function KIT:GetValue(i)
	return profile[i[#i]]
end

function KIT:SetValue(i, v)
	profile[i[#i]] = v
end

function KIT:SetValueStopwatch(i, v)
	profile[i[#i]] = v
	ToggleStopwatch(IsStopwatch())
	CalibrateStopwatch()
end

	----------------------
	--- Initialization ---
	----------------------

function KIT:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("kInstanceTimerDB", defaults, true)

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshDB")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshDB")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshDB")
	self:RefreshDB()

	self.db.global.version = VERSION
	self.db.global.build = BUILD

	ACR:RegisterOptionsTable("kInstanceTimer_Main", options)
	ACR:RegisterOptionsTable("kInstanceTimer_LibSink", self:GetSinkAce3OptionsDataTable())
	ACR:RegisterOptionsTable("kInstanceTimer_Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
	self.optionsFrame = ACD:AddToBlizOptions("kInstanceTimer_Main", NAME)
	ACD:AddToBlizOptions("kInstanceTimer_LibSink", "|TINTERFACE\\ICONS\\inv_scroll_03:16:16:1:0"..cropped.."|t  LibSink", NAME)
	ACD:AddToBlizOptions("kInstanceTimer_Profiles", "|TInterface\\Icons\\INV_Misc_Note_01:16:16:1:0"..cropped.."|t  "..L["Profiles"], NAME)

	self:RegisterChatCommand("kit", "SlashCommand")
	self:RegisterChatCommand("kinstance", "SlashCommand")
	self:RegisterChatCommand("kinstancetimer", "SlashCommand")

	char.timeInstanceList = char.timeInstanceList or {}
end

function KIT:OnEnable()
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	-- fallback/secondary events
	self:RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
	self:RegisterEvent("LFG_COMPLETION_REWARD")

	if GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 and not IsOnePersonParty() then
		char.timeInstance, timeInstance2 = 0, nil
	end

	-- initialize stopwatch
	if IsStopwatch() then
		CalibrateStopwatch()
		ToggleStopwatch(true)
	end
end

function KIT:RefreshDB()
	profile, char = self.db.profile, self.db.char
	self:SetSinkStorage(profile) -- LibSink
end

function KIT:SlashCommand()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

	-----------------
	--- Callbacks ---
	-----------------

function KIT:TimetoString(value)
	local seconds = mod(floor(value), 60)
	local minutes = mod(floor(value/60), 60)
	local hours = floor(value/3600)

	local fseconds = bttn:GetText(bttn:SetFormattedText(D_SECONDS, seconds))
	local fminutes = bttn:GetText(bttn:SetFormattedText(D_MINUTES, minutes))
	local fhours = bttn:GetText(bttn:SetFormattedText(D_HOURS, hours))

	if value >= 3600 then
		return minutes > 0 and format("%s, %s", fhours, fminutes) or fhours
	elseif value >= 60 then
		if seconds >= 6 then
			if profile.TimeFormat == 1 then
				return format("%s, %s", fminutes, fseconds)
			else
				local xseconds = floor(seconds/6)
				if xseconds == 1 then
					-- problem: incorrectly returned as "x.1 minute"
					return format("%s.%s %s", minutes, xseconds, MINUTES2)
				else
					return bttn:GetText(bttn:SetFormattedText(D_MINUTES2, minutes.."."..xseconds))
				end
			end
		else
			return fminutes
		end
	elseif value >= 0 then
		return fseconds
	else
		return "ERROR: "..value
	end
end

function KIT:AnnounceInstance(subZone)
	self:Pour(self:ReplaceText(profile.instanceTimerMsg, subZone))
end

local cache = {}

local function GetClassColor(class)
	if cache[class] then
		return cache[class]
	else
		local color = RAID_CLASS_COLORS[class]
		cache[class] = format("%02X%02X%02X", color.r*255, color.g*255, color.b*255)
		return cache[class]
	end
end

local party = {}

-- Save Instance Timer data
function KIT:RecordInstance(subZone)
	subZone = subZone and ": "..subZone.."]" or "]"
	wipe(party)
	for i = 1, GetNumPartyMembers() do
		local name, class = UnitName("party"..i), select(2, UnitClass("party"..i))
		party[i] = format("|cff%s%s|r", GetClassColor(class), name)
	end
	-- this part might need to be rewritten, instead of saving stuff as formatted strings
	char.timeInstanceList[format("%s-|cff71D5FF[%s]|r", char.timeInstanceStart2, date("%H:%M"))] = format("|cffADFF2F[%s%s|r in |cff71D5FF%s.|r %s", GetRealZoneText(), subZone, self:TimetoString(time() - char.timeInstance), strjoin(", ", unpack(party)))
end

	-----------------------
	--- Substitute Text ---
	-----------------------

function KIT:ReplaceText(msg, subZone, isExample)
	if not msg then return "[ERROR] No Message" end

	if isExample then
		local instanceType = select(2, IsInInstance())
		msg = msg:gsub("%[[Ii][Nn][Ss][Tt][Aa][Nn][Cc][Ee]%]", "|cffA8A8FF"..GetRealZoneText().."|r")
		msg = msg:gsub("%[[Tt][Ii][Mm][Ee]%]", "|cff71D5FF"..self:TimetoString(char.timeInstance > 0 and time() - char.timeInstance or 0).."|r")
		msg = msg:gsub("%[[Ss][Tt][Aa][Rr][Tt]%]", "|cffF6ADC6"..(char.timeInstance > 0 and char.timeInstanceStart or date("%H:%M")).."|r")
		msg = msg:gsub("%[[Ee][Nn][Dd]%]", "|cffADFF2F"..date("%H:%M").."|r")
		msg = msg:gsub("%[[Dd][Aa][Tt][Ee]%]", "|cff0070DD"..date("%m/%d/%y").."|r")
		msg = msg:gsub("%[[Dd][Aa][Tt][Ee]2%]", "|cff0070DD"..date("%Y.%m.%d").."|r")
	else
		if subZone then subZone = ": "..subZone else subZone = "" end
		msg = msg:gsub("%[[Ii][Nn][Ss][Tt][Aa][Nn][Cc][Ee]%]", GetRealZoneText()..subZone)
		msg = msg:gsub("%[[Tt][Ii][Mm][Ee]%]", self:TimetoString(time() - (timeInstance2 or char.timeInstance)))
		msg = msg:gsub("%[[Ss][Tt][Aa][Rr][Tt]%]", char.timeInstanceStart)
		msg = msg:gsub("%[[Ee][Nn][Dd]%]", date("%H:%M"))
		msg = msg:gsub("%[[Dd][Aa][Tt][Ee]%]", date("%m/%d/%y"))
		msg = msg:gsub("%[[Dd][Aa][Tt][Ee]2%]", date("%Y.%m.%d"))
	end
	return msg
end

	--------------
	--- Events ---
	--------------

function KIT:CHAT_MSG_CHANNEL_NOTICE(event, msg)
	if msg == "YOU_CHANGED" then
		local instanceType = select(2, IsInInstance())
		if pve[instanceType] then
			-- 6 hours deadline
			if char.timeInstance == 0 or time() > char.timeInstance + 21600 then
				char.timeInstance, char.timeInstanceStart, char.timeInstanceStart2 = time(), date("%H:%M"), date("%Y.%m.%d |cffF6ADC6[%H:%M]|r")
			end
			if IsStopwatch() then
				StopwatchStart()
				CalibrateStopwatch()
			end
		elseif pvp[instanceType] and profile.BattlegroundStopwatch then
			StopwatchStart()
			-- delay registering for UPDATE_BATTLEFIELD_STATUS, because it fires at the start/end of a battleground, and we only want to react at the end
			self:ScheduleTimer(function()
				self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
				CalibrateStopwatch()
			end, 10)
		elseif instanceType == "none" and char.timeInstance == 0 then
			lastTimeInst, lastTimeBG = nil, nil
			if profile.InstanceStopwatch or profile.RaidStopwatch or profile.BattlegroundStopwatch then
				StopwatchEnd()
			end
		end
	end
end

function KIT:CHAT_MSG_SYSTEM(event, msg)
	-- left or kicked from group
	if msg == ERR_LEFT_GROUP_YOU or msg == ERR_UNINVITE_YOU then
		char.timeInstance, timeInstance2 = 0, nil
		if IsStopwatch() then
			StopwatchEnd()
		end
	end
end

function KIT:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	if subevent == "UNIT_DIED" and tonumber(strsub(destGUID, 5, 5)) == 3 and (timeInstance2 or char.timeInstance) then
		local destNPC = tonumber(strsub(destGUID, 7, 10), 16)
		if BossIDs[destNPC] or RaidBossIDs[destNPC] then
			-- damn you, cookie!
			if destNPC == 47739 and GetInstanceDifficulty() == 2 then return end

			-- Record
			local subZone = SubZoneBossIDs[destNPC] or SubRaidZoneBossIDs[destNPC]
			if profile.RecordInstance then
				self:RecordInstance(subZone)
			end
			-- Announce
			if (profile.Instance and BossIDs[destNPC]) or (profile.Raid and RaidBossIDs[destNPC]) then
				self:AnnounceInstance(subZone)
			end
			-- Stopwatch
			local instanceType = select(2, IsInInstance())
			if IsStopwatch() then
				Stopwatch_Pause()
			end

			-- pre-boss in a subzone
			if preBossIDs[destNPC] then
				timeInstance2 = char.timeInstance
			-- final boss in a subzone
			elseif finalBossIDs[destNPC] then
				timeInstance2 = 0
			end
			-- pause LibDataBroker display 
			local startTime = timeInstance2 or char.timeInstance
			lastTimeInst = startTime > 0 and time() - startTime or 0
			-- reset variables
			char.timeInstance, char.timeInstanceStart, char.timeInstanceStart2 = 0, "", ""
		end
	end
end

function KIT:UPDATE_BATTLEFIELD_STATUS()
	local runTime = GetBattlefieldInstanceRunTime()
	if runTime and runTime > 0 then
		if profile.BattlegroundStopwatch then
			-- battleground finished; recalibrate Stopwatch
			StopwatchTicker.timer = runTime / 1000
			StopwatchTicker_Update()
			Stopwatch_Pause()
		end
		lastTimeBG = runTime / 1000
		self:UnregisterEvent("UPDATE_BATTLEFIELD_STATUS")
	end
end

	------------------------
	--- Secondary Events ---
	------------------------

function KIT:LFG_PROPOSAL_SUCCEEDED()
	self:ScheduleTimer(function()
		-- backup timer
		if char.timeInstance == 0 then
			char.timeInstance = time()
			char.timeInstanceStart, char.timeInstanceStart2 = date("%H:%M"), date("%Y.%m.%d |cffF6ADC6[%H:%M]|r")
			if IsStopwatch() then
				StopwatchStart()
			end
		end
	end, 30)
end

-- only fires after completing a random dungeon
-- delay it a bit, so it doesn't react on the same time as boss death
function KIT:LFG_COMPLETION_REWARD()
	self:ScheduleTimer(function()
		if char.timeInstance > 0 then
			if profile.RecordInstance then
				self:RecordInstance()
			end
			if profile.Instance or profile.Raid then
				self:AnnounceInstance()
			end
			if IsStopwatch() then
				Stopwatch_Pause()
			end
		end
		local startTime = timeInstance2 or char.timeInstance
		lastTimeInst = startTime > 0 and time() - startTime or 0
		char.timeInstance, char.timeInstanceStart, char.timeInstanceStart2 = 0, "", ""
	end, 1)
end

	---------------------
	--- LibDataBroker ---
	---------------------

local dataobject = {
	type = "data source",
	icon = "Interface\\Icons\\Spell_Holy_BorrowedTime",
	OnClick = function(clickedframe, button)
		if InterfaceOptionsFrame:IsShown() and InterfaceOptionsFramePanelContainer.displayedPanel.name == NAME then
			InterfaceOptionsFrame:Hide()
		else
			InterfaceOptionsFrame_OpenToCategory(KIT.optionsFrame)
		end
	end,
	OnTooltipShow = function(tt)
		tt:AddLine("|cffADFF2F"..NAME.."|r")
		tt:AddLine("|cffFFFFFFClick|r to open the options menu")
	end,
}

local function MilitaryTime(value)
	local seconds = mod(floor(value), 60)
	local minutes = mod(floor(value/60), 60)
	local hours = floor(value/3600)
	if hours > 0 then
		return format("%s:%02.f:%02.f", hours, minutes, seconds)
	else
		return format("%02.f:%02.f", minutes, seconds)
	end
end

KIT:ScheduleRepeatingTimer(function()
	local runTime = GetBattlefieldInstanceRunTime()
	if runTime > 0 then
		dataobject.text = MilitaryTime(lastTimeBG and lastTimeBG or runTime/1000)
	elseif lastTimeInst or char.timeInstance > 0 then
		local startTime = timeInstance2 or char.timeInstance
		dataobject.text = MilitaryTime(lastTimeInst and lastTimeInst or startTime > 0 and time() - startTime or 0)
	else
		dataobject.text = MilitaryTime(0)
	end
end, 1)

LibStub("LibDataBroker-1.1"):NewDataObject("kInstanceTimer", dataobject)