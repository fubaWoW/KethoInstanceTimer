﻿local _, S = ...

-- extracted DBFilesClient\LFGDungeons.dbc (4.3.4.15595) with MPQ Editor by Ladislav Zezula - http://www.zezula.net/en/mpq/download.html
-- converted to csv with WoWParser2 by Carlos Ramzuel - http://code.google.com/p/cntc2/

local L = {
	enUS = {
		-- Maraudon
		["Maraudon - The Wicked Grotto"] = "Maraudon - The Wicked Grotto",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Foulspore Cavern",
		["Maraudon - Earth Song Falls"] = "Maraudon - Earth Song Falls",
		
		-- Blackrock Depths
		["Blackrock Depths - Detention Block"] = "Blackrock Depths - Detention Block",
		["Blackrock Depths - Upper City"] = "Blackrock Depths - Upper City",
		
		-- Dire Maul
		["Dire Maul - Warpwood Quarter"] = "Dire Maul - Warpwood Quarter",
		["Dire Maul - Capital Gardens"] = "Dire Maul - Capital Gardens",
		["Dire Maul - Gordok Commons"] = "Dire Maul - Gordok Commons",
		
		-- Stratholme
		["Stratholme - Main Gate"] = "Stratholme - Main Gate",
		["Stratholme - Service Entrance"] = "Stratholme - Service Entrance",
		
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
		
		DATA = "Data",
		INSTANCE_TIMER = INSTANCE.." Timer",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] cleared in <TIME> [<START>]-[<END>]",
		MANUAL_RESET = TRACKER_SORT_MANUAL.." "..RESET,
		MANUAL_START = TRACKER_SORT_MANUAL.." "..START,
		RECORD_DATA = "Record Data",
		
		TIME_FORMAT = "Time Format",
		TIME_FORMAT_LEGACY = "Legacy Time Format",
		TIME_OMIT_ZERO_VALUE = "Omit Zero Value",
		TIME_MAX_UNITS = "Max time units",
		TIME_OMIT_SECONDS = "Omit "..SECONDS,
		TIME_LOWER_CASE = "Lower Case",
		TIME_ABBREVIATE = "Abbreviate",
		
		BROKER_CLICK = "|cffFFFFFFClick|r to open the options menu",
		BROKER_SHIFT_CLICK = "|cffFFFFFFShift-click|r to toggle this AddOn",
	},
	deDE = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - Die Tückische Grotte",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Faulsporenhöhle",
		["Maraudon - Earth Song Falls"] = "Maraudon - Fälle des Irdenen Gesangs",
		["Blackrock Depths - Detention Block"] = "Schwarzfelstiefen - Gefängnisblock",
		["Blackrock Depths - Upper City"] = "Schwarzfelstiefen - Oberes Viertel",
		["Dire Maul - Warpwood Quarter"] = "Düsterbruch - Wucherborkenviertel",
		["Dire Maul - Capital Gardens"] = "Düsterbruch - Hauptstadtgärten",
		["Dire Maul - Gordok Commons"] = "Düsterbruch - Gordokhallen",
		["Stratholme - Main Gate"] = "Stratholme - Haupttor",
		["Stratholme - Service Entrance"] = "Stratholme - Dienstboteneingang",
		["Lower Blackrock Spire"] = "Untere Schwarzfelsspitze",
		["Upper Blackrock Spire"] = "Obere Schwarzfelsspitze",
		["The Siege of Wyrmrest Temple"] = "Belagerung des Wyrmruhtempels",
		["Fall of Deathwing"] = "Todesschwinges Sturz",
		["The Headless Horseman"] = "Der Kopflose Reiter",
		["Coren Direbrew"] = "Coren Düsterbräu",
		["The Frost Lord Ahune"] = "Frostfürst Ahune",
		["The Crown Chemical Co."] = "Chemiemanufaktur Krone",
		
		DATA = "Daten",
		INSTANCE_TIMER = "Instanz-Zeitnehmer",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] beendet in <TIME> [<START>]-[<END>]",
		MANUAL_RESET = "Manuell zurücksetzen",
		MANUAL_START = "Manuell starten",
		RECORD_DATA = "Daten speichern",
		
		BROKER_CLICK = "|cffFFFFFFKlickt|r, um das Optionsmenü zu öffnen",
		BROKER_SHIFT_CLICK = "|cffFFFFFFShift-klickt|r, um dieses AddOn ein-/auszuschalten",
	},
	--esES = {},
	esMX = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - La Gruta Maligna",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Gruta de la Espora Fétida",
		["Maraudon - Earth Song Falls"] = "Maraudon - Cascadas del Canto de la Tierra",
		["Blackrock Depths - Detention Block"] = "Profundidades de Roca Negra - Bloque de Detención",
		["Blackrock Depths - Upper City"] = "Profundidades de Roca Negra - Alto Arrabal",
		["Dire Maul - Warpwood Quarter"] = "La Masacre - Barrio Alabeo",
		["Dire Maul - Capital Gardens"] = "La Masacre - Jardines de la Capital",
		["Dire Maul - Gordok Commons"] = "La Masacre - Ágora de Gordok",
		["Stratholme - Main Gate"] = "Stratholme - Puerta principal",
		["Stratholme - Service Entrance"] = "Stratholme - Entrada del servicio",
		["Lower Blackrock Spire"] = "Cumbre de Roca Negra inferior",
		["Upper Blackrock Spire"] = "Cumbre de Roca Negra superior",
		["The Siege of Wyrmrest Temple"] = "Asedio Templo Reposo del Dragón",
		["Fall of Deathwing"] = "Caída de Alamuerte",
		["The Headless Horseman"] = "El Jinete decapitado",
		["Coren Direbrew"] = "Coren Cerveza Temible",
		["The Frost Lord Ahune"] = "El Señor de la Escarcha Ahune",
		["The Crown Chemical Co."] = "Químicos La Corona, S.L.",
		
		BROKER_CLICK = "|cffffffffHaz clic|r para ver opciones.",
		BROKER_SHIFT_CLICK = "|cffffffffMayús-clic|r para activar/desactivar.",
	},
	frFR = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - La grotte Maudite",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverne Vilespore",
		["Maraudon - Earth Song Falls"] = "Maraudon - Chutes de Chanteterre",
		["Blackrock Depths - Detention Block"] = "Profondeurs de Rochenoire - Le mitard",
		["Blackrock Depths - Upper City"] = "Profondeurs de Rochenoire - Ville haute",
		["Dire Maul - Warpwood Quarter"] = "Hache-Tripes - Quartier de Crochebois",
		["Dire Maul - Capital Gardens"] = "Hache-Tripes - Grands jardins",
		["Dire Maul - Gordok Commons"] = "Hache-Tripes - Communs gordok",
		["Stratholme - Main Gate"] = "Stratholme - Grande porte",
		["Stratholme - Service Entrance"] = "Stratholme - Entrée de service",
		["Lower Blackrock Spire"] = "Bas du pic Rochenoire",
		["Upper Blackrock Spire"] = "Sommet du pic Rochenoire",
		["The Siege of Wyrmrest Temple"] = "Le siège du temple du Repos du ver",
		["Fall of Deathwing"] = "La chute d’Aile de mort",
		["The Headless Horseman"] = "Le Cavalier sans tête",
		["Coren Direbrew"] = "Coren Navrebière",
		["The Frost Lord Ahune"] = "Le seigneur du Givre Ahune",
		["The Crown Chemical Co."] = "Cie de Chimie La Royale",
	},
	itIT = { -- MoP 5.0.1.15781
		["Maraudon - The Wicked Grotto"] = "Maraudon - Grotta Perversa",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverna Spora Funesta",
		["Maraudon - Earth Song Falls"] = "Maraudon - Cascate Cantaterra",
		["Blackrock Depths - Detention Block"] = "Sotterranei di Roccianera - Blocco di Detenzione",
		["Blackrock Depths - Upper City"] = "Sotterranei di Roccianera - Città Superiore",
		["Dire Maul - Warpwood Quarter"] = "Maglio Infausto - Quartiere di Legnotorto",
		["Dire Maul - Capital Gardens"] = "Maglio Infausto - Giardini della Capitale",
		["Dire Maul - Gordok Commons"] = "Maglio Infausto - Sale di Gordok",
		["Stratholme - Main Gate"] = "Stratholme - Porta Principale",
		["Stratholme - Service Entrance"] = "Stratholme - Ingresso di Servizio",
		["Lower Blackrock Spire"] = "Bastioni di Roccianera Inferiori",
		["Upper Blackrock Spire"] = "Bastioni di Roccianera Superiori",
		["The Siege of Wyrmrest Temple"] = "Assedio al Tempio",
		["Fall of Deathwing"] = "Caduta di Alamorte",
		["The Headless Horseman"] = "Cavaliere Senza Testa",
		["Coren Direbrew"] = "Coren Birranera",
		["The Frost Lord Ahune"] = "Signore del Gelo Ahune",
		["The Crown Chemical Co."] = "Industrie F.lli Corona",
	},
	koKR = {
		["Maraudon - The Wicked Grotto"] = "마라우돈 - 악의 동굴",
		["Maraudon - Foulspore Cavern"] = "마라우돈 - 썩은포자 동굴",
		["Maraudon - Earth Song Falls"] = "마라우돈 - 대지노래 폭포",
		["Blackrock Depths - Detention Block"] = "검은바위 나락 - 감금 구역",
		["Blackrock Depths - Upper City"] = "검은바위 나락 - 상부 도시",
		["Dire Maul - Warpwood Quarter"] = "혈투의 전장 - 굽이나무 지구",
		["Dire Maul - Capital Gardens"] = "혈투의 전장 - 수도 정원",
		["Dire Maul - Gordok Commons"] = "혈투의 전장 - 고르독 광장",
		["Stratholme - Main Gate"] = "스트라솔름 - 정문",
		["Stratholme - Service Entrance"] = "스트라솔름 - 공무용 입구",
		["Lower Blackrock Spire"] = "검은바위 첨탑 하층",
		["Upper Blackrock Spire"] = "검은바위 첨탑 상층",
		["The Siege of Wyrmrest Temple"] = "고룡쉼터 사원 탈환",
		["Fall of Deathwing"] = "데스윙의 추락",
		["The Headless Horseman"] = "저주받은 기사",
		["Coren Direbrew"] = "코렌 다이어브루",
		["The Frost Lord Ahune"] = "서리 군주 아훈",
		["The Crown Chemical Co."] = "왕관화학회사",
	},
	ptBR = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - Gruta Nociva",
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverna Esporelama",
		["Maraudon - Earth Song Falls"] = "Maraudon - Cachoeiras da Canção Telúrica",
		["Blackrock Depths - Detention Block"] = "Abismo Rocha Negra - Bloco da Detenção",
		["Blackrock Depths - Upper City"] = "Abismo Rocha Negra - Cidade Superior",
		["Dire Maul - Warpwood Quarter"] = "Gládio Cruel - Distrito Lenhatorta",
		["Dire Maul - Capital Gardens"] = "Gládio Cruel - Jardins Capitais",
		["Dire Maul - Gordok Commons"] = "Gládio Cruel - Pátio Gordok",
		["Stratholme - Main Gate"] = "Stratholme - Portão Principal",
		["Stratholme - Service Entrance"] = "Stratholme - Entrada de Serviço",
		["Lower Blackrock Spire"] = "Pico da Rocha Negra Inferior",
		["Upper Blackrock Spire"] = "Pico da Rocha Negra Superior",
		["The Siege of Wyrmrest Temple"] = "Cerco ao Repouso das Serpes",
		["Fall of Deathwing"] = "Queda do Asa da Morte",
		["The Headless Horseman"] = "Cavaleiro Sem Cabeça",
		["Coren Direbrew"] = "Coren Cervatroz",
		["The Frost Lord Ahune"] = "Ahune, o Senhor do Gelo",
		["The Crown Chemical Co."] = "Químicos Coroa S.A.",
	},
	ruRU = {
		["Maraudon - The Wicked Grotto"] = "Мародон - Оскверненный грот",
		["Maraudon - Foulspore Cavern"] = "Мародон - Зловонная пещера",
		["Maraudon - Earth Song Falls"] = "Мародон - Поющие водопады",
		["Blackrock Depths - Detention Block"] = "Глубины Черной горы - Тюремный блок",
		["Blackrock Depths - Upper City"] = "Глубины Черной горы - Верхний город",
		["Dire Maul - Warpwood Quarter"] = "Забытый Город - Квартал Криводревов",
		["Dire Maul - Capital Gardens"] = "Забытый Город - Центральный сад",
		["Dire Maul - Gordok Commons"] = "Забытый Город - Палаты Гордока",
		["Stratholme - Main Gate"] = "Стратхольм - Главные врата",
		["Stratholme - Service Entrance"] = "Стратхольм - Черный ход",
		["Lower Blackrock Spire"] = "Нижняя часть Черной горы",
		["Upper Blackrock Spire"] = "Верхняя часть Черной горы",
		["The Siege of Wyrmrest Temple"] = "Осада Храма Драконьего Покоя",
		["Fall of Deathwing"] = "Падение Смертокрыла",
		["The Headless Horseman"] = "Всадник без головы",
		["Coren Direbrew"] = "Корен Худовар",
		["The Frost Lord Ahune"] = "Повелитель Холода Ахун",
		["The Crown Chemical Co."] = "Королевская химическая компания",
	},
	zhCN = {
		["Maraudon - The Wicked Grotto"] = "玛拉顿－邪恶洞穴",
		["Maraudon - Foulspore Cavern"] = "玛拉顿－毒菇洞穴",
		["Maraudon - Earth Song Falls"] = "玛拉顿－地歌瀑布",
		["Blackrock Depths - Detention Block"] = "黑石深渊－禁闭室",
		["Blackrock Depths - Upper City"] = "黑石深渊－上层区",
		["Dire Maul - Warpwood Quarter"] = "厄运之槌 - 扭木广场",
		["Dire Maul - Capital Gardens"] = "厄运之槌 - 中心花园",
		["Dire Maul - Gordok Commons"] = "厄运之槌 - 戈多克议会",
		["Stratholme - Main Gate"] = "斯坦索姆－正门",
		["Stratholme - Service Entrance"] = "斯坦索姆－后门",
		["Lower Blackrock Spire"] = "黑石塔下层",
		["Upper Blackrock Spire"] = "黑石塔上层",
		["The Siege of Wyrmrest Temple"] = "围攻龙眠神殿",
		["Fall of Deathwing"] = "死亡之翼的陨落",
		["The Headless Horseman"] = "无头骑士",
		["Coren Direbrew"] = "科林·烈酒",
		["The Frost Lord Ahune"] = "冰霜之王埃霍恩",
		["The Crown Chemical Co."] = "皇冠药剂公司",
		
		DATA = "数据",
		INSTANCE_TIMER = "副本计时器",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] 已完成，用时 <TIME> [<START>]-[<END>]",
		MANUAL_RESET = "手动重置",
		MANUAL_START = "手动开始",
		RECORD_DATA = "记录数据",
		
		BROKER_CLICK = "|cffFFFFFF点击|r打开选项菜单",
		BROKER_SHIFT_CLICK = "|cffFFFFFFShift-点击|r 启用或禁用插件",
	},
	zhTW = {
		["Maraudon - The Wicked Grotto"] = "瑪拉頓 - 邪惡洞穴",
		["Maraudon - Foulspore Cavern"] = "瑪拉頓 - 毒菇洞穴",
		["Maraudon - Earth Song Falls"] = "瑪拉頓 - 地歌瀑布",
		["Blackrock Depths - Detention Block"] = "黑石深淵 - 禁閉室",
		["Blackrock Depths - Upper City"] = "黑石深淵 - 上城區",
		["Dire Maul - Warpwood Quarter"] = "厄運之槌 - 扭木廣場",
		["Dire Maul - Capital Gardens"] = "厄運之槌 - 中心花園",
		["Dire Maul - Gordok Commons"] = "厄運之槌 - 戈多克平民區",
		["Stratholme - Main Gate"] = "斯坦索姆 - 主門",
		["Stratholme - Service Entrance"] = "斯坦索姆 - 僕從入口",
		["Lower Blackrock Spire"] = "低階黑石塔",
		["Upper Blackrock Spire"] = "黑石塔上層",
		["The Siege of Wyrmrest Temple"] = "圍攻龍眠神殿",
		["Fall of Deathwing"] = "死亡之翼隕落",
		["The Headless Horseman"] = "無頭騎士",
		["Coren Direbrew"] = "寇仁·恐酒",
		["The Frost Lord Ahune"] = "冰霜領主艾胡恩",
		["The Crown Chemical Co."] = "王冠化學製藥公司",
		
		DATA = "數據",
		INSTANCE_TIMER = "副本計時器",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] 已完成，用時 <TIME> [<START>]-[<END>]",
		MANUAL_RESET = "手動重置",
		MANUAL_START = "手動開始",
		RECORD_DATA = "紀錄數據",
	},
}

L.esES = L.esMX -- instance strings are identical

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
