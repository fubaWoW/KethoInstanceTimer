local _, S = ...

local L = {
	deDE = {
		Armory = "Waffenkammer",
		["Capital Gardens"] = "Hauptstadtg\195\164rten",
		Cathedral = "Kathedrale",
		["Detention Block"] = "Gef\195\164ngnisblock",
		["Earth Song Falls"] = "F\195\164lle des irdenen Gesangs",
		["Fall of Deathwing"] = "Todesschwinges Sturz",
		["Foulspore Cavern"] = "Faulsporenh\195\182hle",
		["Gordok Commons"] = "Gordokhallen",
		Graveyard = "Friedhof",
		INSTANCE_TIMER = "Instanz-Zeitnehmer",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] beendet in <TIME> [<START>]-[<END>]",
		Library = "Bibliothek",
		["Main Gate"] = "Haupttor",
		["Service Entrance"] = "Bediensteteneingang",
		["The Siege of Wyrmrest Temple"] = "Die Belagerung des Wyrmruhtempels",
		["The Wicked Grotto"] = "Die t\195\188ckische Grotte",
		["Upper City"] = "Obere Stadt",
		["Warpwood Quarter"] = "Wucherborkenviertel",
		BROKER_CLICK = "|cffFFFFFFKlickt|r, um das Optionsmen\195\188 zu \195\182ffnen",
	},
	enUS = {
		INSTANCE_TIMER = INSTANCE.." Timer",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] cleared in <TIME> [<START>]-[<END>]",
		
		DATA = "Data",
		RECORD_INSTANCE = "Record "..INSTANCE,
		
		TIME_FORMAT = "Time Format",
		TIME_FORMAT_LEGACY = "Legacy Time Format",
		TIME_OMIT_ZERO_VALUE = "Omit Zero Value",
		TIME_MAX_UNITS = "Max time units",
		TIME_OMIT_SECONDS = "Omit "..SECONDS,
		TIME_LOWER_CASE = "Lower Case",
		TIME_ABBREVIATE = "Abbreviate",
		
		MANUAL_START = TRACKER_SORT_MANUAL.." "..START,
		MANUAL_RESET = TRACKER_SORT_MANUAL.." "..RESET,
		
		BROKER_CLICK = "|cffFFFFFFClick|r to open the options menu",
		
		-- Scarlet Monastery
		Graveyard = "Graveyard",
		Library = "Library",
		Armory = "Armory",
		Cathedral = "Cathedral",
		
		-- Maraudon
		["The Wicked Grotto"] = "The Wicked Grotto",
		["Foulspore Cavern"] = "Foulspore Cavern",
		["Earth Song Falls"] = "Earth Song Falls",
		
		-- Blackrock Depths
		["Detention Block"] = "Detention Block",
		["Upper City"] = "Upper City",
		
		-- Dire Maul
		["Warpwood Quarter"] = "Warpwood Quarter",
		["Capital Gardens"] = "Capital Gardens",
		["Gordok Commons"] = "Gordok Commons",
		
		-- Stratholme
		["Main Gate"] = "Main Gate",
		["Service Entrance"] = "Service Entrance",
		
		-- Blackrock Spire
		["Lower Blackrock Spire"] = "Lower Blackrock Spire",
		["Upper Blackrock Spire"] = "Upper Blackrock Spire",
		
		-- Dragon Soul (4.3)
		["The Siege of Wyrmrest Temple"] = "The Siege of Wyrmrest Temple",
		["Fall of Deathwing"] = "Fall of Deathwing",
		
		-- Seasonal
		["The Headless Horseman"] = "The Headless Horseman",
		["Coren Direbrew"] = "Coren Direbrew",
		["The Frost Lord Ahune"] = "The Frost Lord Ahune",
		["The Crown Chemical Co."] = "The Crown Chemical Co.",
	},
	esES = {
	},
	esMX = {
	},
	frFR = {
	},
	itIT = {
	},
	koKR = {
	},
	ptBR = {
	},
	ruRU = {
	},
	zhCN = {
		BROKER_CLICK = "|cffFFFFFF\231\130\185\229\135\187|r\230\137\147\229\188\128\233\128\137\233\161\185\232\143\156\229\141\149", -- "点击打开选项菜单"
	},
	zhTW = {
		Armory = "\232\187\141\230\162\176\229\186\171", -- "軍械庫"
		["Capital Gardens"] = "\228\184\173\229\191\131\232\138\177\229\156\146", --  "中心花園"
		Cathedral = "\229\164\167\230\149\153\229\160\130", -- "大教堂"
		["Detention Block"] = "\231\166\129\233\150\137\229\174\164", -- "禁閉室"
		["Earth Song Falls"] = "\229\156\176\230\173\140\231\128\145\229\184\131", -- "地歌瀑布"
		["Foulspore Cavern"] = "\230\175\146\232\143\135\230\180\158\231\169\180", -- "毒菇洞穴"
		["Gordok Commons"] = "\230\136\136\229\164\154\229\133\139\229\185\179\230\176\145\229\141\128", -- "戈多克平民區"
		Graveyard = "\229\162\147\229\156\146", --  "墓園"
		INSTANCE_TIMER = "\229\137\175\230\156\172\232\168\136\230\153\130\229\153\168", -- "副本計時器"
		INSTANCE_TIMER_MSG = "[<INSTANCE>] <TIME> \229\133\167\233\135\141\231\189\174 [<START>]-[<END>]", -- "[<INSTANCE>] <TIME> 內重置 [<START>]-[<END>]"
		Library = "\229\156\150\230\155\184\233\164\168", -- "圖書館"
		["Main Gate"] = "\228\184\187\233\150\128", -- "主門"
		["Service Entrance"] = "\229\131\149\229\190\158\229\133\165\229\143\163", -- "僕從入口"
		["The Wicked Grotto"] = "\233\130\170\230\131\161\230\180\158\231\169\180", -- "邪惡洞穴"
		["Upper City"] = "\228\184\138\229\159\142\229\141\128", -- "上城區"
		["Warpwood Quarter"] = "\230\137\173\230\156\168\229\187\163\229\160\180", -- "扭木廣場"
	},
}

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
