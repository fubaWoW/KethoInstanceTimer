local _, S = ...

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
		RECORD_INSTANCE = "Record "..INSTANCE,
		
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
		["Maraudon - The Wicked Grotto"] = "Maraudon - Die T\195\188ckische Grotte", -- "Maraudon - Die Tückische Grotte"
		["Maraudon - Foulspore Cavern"] = "Maraudon - Faulsporenh\195\182hle", -- "Maraudon - Faulsporenhöhle"
		["Maraudon - Earth Song Falls"] = "Maraudon - F\195\164lle des Irdenen Gesangs", -- "Maraudon - Fälle des Irdenen Gesangs"
		["Blackrock Depths - Detention Block"] = "Schwarzfelstiefen - Gef\195\164ngnisblock", -- "Schwarzfelstiefen - Gefängnisblock"
		["Blackrock Depths - Upper City"] = "Schwarzfelstiefen - Oberes Viertel", -- "Schwarzfelstiefen - Oberes Viertel"
		["Dire Maul - Warpwood Quarter"] = "D\195\188sterbruch - Wucherborkenviertel", -- "Düsterbruch - Wucherborkenviertel"
		["Dire Maul - Capital Gardens"] = "D\195\188sterbruch - Hauptstadtg\195\164rten", -- "Düsterbruch - Hauptstadtgärten"
		["Dire Maul - Gordok Commons"] = "D\195\188sterbruch - Gordokhallen", -- "Düsterbruch - Gordokhallen"
		["Stratholme - Main Gate"] = "Stratholme - Haupttor", -- "Stratholme - Haupttor"
		["Stratholme - Service Entrance"] = "Stratholme - Dienstboteneingang", -- "Stratholme - Dienstboteneingang"
		["Lower Blackrock Spire"] = "Untere Schwarzfelsspitze", -- "Untere Schwarzfelsspitze"
		["Upper Blackrock Spire"] = "Obere Schwarzfelsspitze", -- "Obere Schwarzfelsspitze"
		["The Siege of Wyrmrest Temple"] = "Belagerung des Wyrmruhtempels", -- "Belagerung des Wyrmruhtempels"
		["Fall of Deathwing"] = "Todesschwinges Sturz", -- "Todesschwinges Sturz"
		["The Headless Horseman"] = "Der Kopflose Reiter", -- "Der Kopflose Reiter"
		["Coren Direbrew"] = "Coren D\195\188sterbr\195\164u", -- "Coren Düsterbräu"
		["The Frost Lord Ahune"] = "Frostf\195\188rst Ahune", -- "Frostfürst Ahune"
		["The Crown Chemical Co."] = "Chemiemanufaktur Krone", -- "Chemiemanufaktur Krone"
		
		INSTANCE_TIMER = "Instanz-Zeitnehmer",
		INSTANCE_TIMER_MSG = "[<INSTANCE>] beendet in <TIME> [<START>]-[<END>]",
		
		BROKER_CLICK = "|cffFFFFFFKlickt|r, um das Optionsmen\195\188 zu \195\182ffnen",
		BROKER_SHIFT_CLICK = "|cffFFFFFFShift-klickt|r, um dieses AddOn ein-/auszuschalten",
	},
	--esES = {},
	esMX = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - La Gruta Maligna", -- "Maraudon - La Gruta Maligna"
		["Maraudon - Foulspore Cavern"] = "Maraudon - Gruta de la Espora F\195\169tida", -- "Maraudon - Gruta de la Espora Fétida"
		["Maraudon - Earth Song Falls"] = "Maraudon - Cascadas del Canto de la Tierra", -- "Maraudon - Cascadas del Canto de la Tierra"
		["Blackrock Depths - Detention Block"] = "Profundidades de Roca Negra - Bloque de Detenci\195\179n", -- "Profundidades de Roca Negra - Bloque de Detención"
		["Blackrock Depths - Upper City"] = "Profundidades de Roca Negra - Alto Arrabal", -- "Profundidades de Roca Negra - Alto Arrabal"
		["Dire Maul - Warpwood Quarter"] = "La Masacre - Barrio Alabeo", -- "La Masacre - Barrio Alabeo"
		["Dire Maul - Capital Gardens"] = "La Masacre - Jardines de la Capital", -- "La Masacre - Jardines de la Capital"
		["Dire Maul - Gordok Commons"] = "La Masacre - \195\129gora de Gordok", -- "La Masacre - Ágora de Gordok"
		["Stratholme - Main Gate"] = "Stratholme - Puerta principal", -- "Stratholme - Puerta principal"
		["Stratholme - Service Entrance"] = "Stratholme - Entrada del servicio", -- "Stratholme - Entrada del servicio"
		["Lower Blackrock Spire"] = "Cumbre de Roca Negra inferior", -- "Cumbre de Roca Negra inferior"
		["Upper Blackrock Spire"] = "Cumbre de Roca Negra superior", -- "Cumbre de Roca Negra superior"
		["The Siege of Wyrmrest Temple"] = "Asedio Templo Reposo del Drag\195\179n", -- "Asedio Templo Reposo del Dragón"
		["Fall of Deathwing"] = "Ca\195\173da de Alamuerte", -- "Caída de Alamuerte"
		["The Headless Horseman"] = "El Jinete decapitado", -- "El Jinete decapitado"
		["Coren Direbrew"] = "Coren Cerveza Temible", -- "Coren Cerveza Temible"
		["The Frost Lord Ahune"] = "El Se\195\177or de la Escarcha Ahune", -- "El Señor de la Escarcha Ahune"
		["The Crown Chemical Co."] = "Qu\195\173micos La Corona, S.L.", -- "Químicos La Corona, S.L."
		
		BROKER_CLICK = "|cffffffffHaz clic|r para ver opciones.",
		BROKER_SHIFT_CLICK = "|cffffffffMayús-clic|r para activar/desactivar.",
	},
	frFR = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - La grotte Maudite", -- "Maraudon - La grotte Maudite"
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverne Vilespore", -- "Maraudon - Caverne Vilespore"
		["Maraudon - Earth Song Falls"] = "Maraudon - Chutes de Chanteterre", -- "Maraudon - Chutes de Chanteterre"
		["Blackrock Depths - Detention Block"] = "Profondeurs de Rochenoire - Le mitard", -- "Profondeurs de Rochenoire - Le mitard"
		["Blackrock Depths - Upper City"] = "Profondeurs de Rochenoire - Ville haute", -- "Profondeurs de Rochenoire - Ville haute"
		["Dire Maul - Warpwood Quarter"] = "Hache-Tripes - Quartier de Crochebois", -- "Hache-Tripes - Quartier de Crochebois"
		["Dire Maul - Capital Gardens"] = "Hache-Tripes - Grands jardins", -- "Hache-Tripes - Grands jardins"
		["Dire Maul - Gordok Commons"] = "Hache-Tripes - Communs gordok", -- "Hache-Tripes - Communs gordok"
		["Stratholme - Main Gate"] = "Stratholme - Grande porte", -- "Stratholme - Grande porte"
		["Stratholme - Service Entrance"] = "Stratholme - Entr\195\169e de service", -- "Stratholme - Entrée de service"
		["Lower Blackrock Spire"] = "Bas du pic Rochenoire", -- "Bas du pic Rochenoire"
		["Upper Blackrock Spire"] = "Sommet du pic Rochenoire", -- "Sommet du pic Rochenoire"
		["The Siege of Wyrmrest Temple"] = "Le si\195\168ge du temple du Repos du ver", -- "Le siège du temple du Repos du ver"
		["Fall of Deathwing"] = "La chute d\226\128\153Aile de mort", -- "La chute d’Aile de mort"
		["The Headless Horseman"] = "Le Cavalier sans t\195\170te", -- "Le Cavalier sans tête"
		["Coren Direbrew"] = "Coren Navrebi\195\168re", -- "Coren Navrebière"
		["The Frost Lord Ahune"] = "Le seigneur du Givre Ahune", -- "Le seigneur du Givre Ahune"
		["The Crown Chemical Co."] = "Cie de Chimie La Royale", -- "Cie de Chimie La Royale"
	},
	itIT = { -- MoP 5.0.1.15781
		["Maraudon - The Wicked Grotto"] = "Maraudon - Grotta Perversa", -- "Maraudon - Grotta Perversa"
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverna Spora Funesta", -- "Maraudon - Caverna Spora Funesta"
		["Maraudon - Earth Song Falls"] = "Maraudon - Cascate Cantaterra", -- "Maraudon - Cascate Cantaterra"
		["Blackrock Depths - Detention Block"] = "Sotterranei di Roccianera - Blocco di Detenzione", -- "Sotterranei di Roccianera - Blocco di Detenzione"
		["Blackrock Depths - Upper City"] = "Sotterranei di Roccianera - Città Superiore", -- "Sotterranei di Roccianera - Citt\195\160 Superiore"
		["Dire Maul - Warpwood Quarter"] = "Maglio Infausto - Quartiere di Legnotorto", -- "Maglio Infausto - Quartiere di Legnotorto"
		["Dire Maul - Capital Gardens"] = "Maglio Infausto - Giardini della Capitale", -- "Maglio Infausto - Giardini della Capitale"
		["Dire Maul - Gordok Commons"] = "Maglio Infausto - Sale di Gordok", -- "Maglio Infausto - Sale di Gordok"
		["Stratholme - Main Gate"] = "Stratholme - Porta Principale", -- "Stratholme - Porta Principale"
		["Stratholme - Service Entrance"] = "Stratholme - Ingresso di Servizio", -- "Stratholme - Ingresso di Servizio"
		["Lower Blackrock Spire"] = "Bastioni di Roccianera Inferiori", -- "Bastioni di Roccianera Inferiori"
		["Upper Blackrock Spire"] = "Bastioni di Roccianera Superiori", -- "Bastioni di Roccianera Superiori"
		["The Siege of Wyrmrest Temple"] = "Assedio al Tempio", -- "Assedio al Tempio"
		["Fall of Deathwing"] = "Caduta di Alamorte", -- "Caduta di Alamorte"
		["The Headless Horseman"] = "Cavaliere Senza Testa", -- "Cavaliere Senza Testa"
		["Coren Direbrew"] = "Coren Birranera", -- "Coren Birranera"
		["The Frost Lord Ahune"] = "Signore del Gelo Ahune", -- "Signore del Gelo Ahune"
		["The Crown Chemical Co."] = "Industrie F.lli Corona", -- "Industrie F.lli Corona"
	},
	koKR = {
		["Maraudon - The Wicked Grotto"] = "\235\167\136\235\157\188\236\154\176\235\143\136 - \236\149\133\236\157\152 \235\143\153\234\181\180", -- "마라우돈 - 악의 동굴"
		["Maraudon - Foulspore Cavern"] = "\235\167\136\235\157\188\236\154\176\235\143\136 - \236\141\169\236\157\128\237\143\172\236\158\144 \235\143\153\234\181\180", -- "마라우돈 - 썩은포자 동굴"
		["Maraudon - Earth Song Falls"] = "\235\167\136\235\157\188\236\154\176\235\143\136 - \235\140\128\236\167\128\235\133\184\235\158\152 \237\143\173\237\143\172", -- "마라우돈 - 대지노래 폭포"
		["Blackrock Depths - Detention Block"] = "\234\178\128\236\157\128\235\176\148\236\156\132 \235\130\152\235\157\189 - \234\176\144\234\184\136 \234\181\172\236\151\173", -- "검은바위 나락 - 감금 구역"
		["Blackrock Depths - Upper City"] = "\234\178\128\236\157\128\235\176\148\236\156\132 \235\130\152\235\157\189 - \236\131\129\235\182\128 \235\143\132\236\139\156", -- "검은바위 나락 - 상부 도시"
		["Dire Maul - Warpwood Quarter"] = "\237\152\136\237\136\172\236\157\152 \236\160\132\236\158\165 - \234\181\189\236\157\180\235\130\152\235\172\180 \236\167\128\234\181\172", -- "혈투의 전장 - 굽이나무 지구"
		["Dire Maul - Capital Gardens"] = "\237\152\136\237\136\172\236\157\152 \236\160\132\236\158\165 - \236\136\152\235\143\132 \236\160\149\236\155\144", -- "혈투의 전장 - 수도 정원"
		["Dire Maul - Gordok Commons"] = "\237\152\136\237\136\172\236\157\152 \236\160\132\236\158\165 - \234\179\160\235\165\180\235\143\133 \234\180\145\236\158\165", -- "혈투의 전장 - 고르독 광장"
		["Stratholme - Main Gate"] = "\236\138\164\237\138\184\235\157\188\236\134\148\235\166\132 - \236\160\149\235\172\184", -- "스트라솔름 - 정문"
		["Stratholme - Service Entrance"] = "\236\138\164\237\138\184\235\157\188\236\134\148\235\166\132 - \234\179\181\235\172\180\236\154\169 \236\158\133\234\181\172", -- "스트라솔름 - 공무용 입구"
		["Lower Blackrock Spire"] = "\234\178\128\236\157\128\235\176\148\236\156\132 \236\178\168\237\131\145 \237\149\152\236\184\181", -- "검은바위 첨탑 하층"
		["Upper Blackrock Spire"] = "\234\178\128\236\157\128\235\176\148\236\156\132 \236\178\168\237\131\145 \236\131\129\236\184\181", -- "검은바위 첨탑 상층"
		["The Siege of Wyrmrest Temple"] = "\234\179\160\235\163\161\236\137\188\237\132\176 \236\130\172\236\155\144 \237\131\136\237\153\152", -- "고룡쉼터 사원 탈환"
		["Fall of Deathwing"] = "\235\141\176\236\138\164\236\156\153\236\157\152 \236\182\148\235\157\189", -- "데스윙의 추락"
		["The Headless Horseman"] = "\236\160\128\236\163\188\235\176\155\236\157\128 \234\184\176\236\130\172", -- "저주받은 기사"
		["Coren Direbrew"] = "\236\189\148\235\160\140 \235\139\164\236\157\180\236\150\180\235\184\140\235\163\168", -- "코렌 다이어브루"
		["The Frost Lord Ahune"] = "\236\132\156\235\166\172 \234\181\176\236\163\188 \236\149\132\237\155\136", -- "서리 군주 아훈"
		["The Crown Chemical Co."] = "\236\153\149\234\180\128\237\153\148\237\149\153\237\154\140\236\130\172", -- "왕관화학회사"
	},
	ptBR = {
		["Maraudon - The Wicked Grotto"] = "Maraudon - Gruta Nociva", -- "Maraudon - Gruta Nociva"
		["Maraudon - Foulspore Cavern"] = "Maraudon - Caverna Esporelama", -- "Maraudon - Caverna Esporelama"
		["Maraudon - Earth Song Falls"] = "Maraudon - Cachoeiras da Can\195\167\195\163o Tel\195\186rica", -- "Maraudon - Cachoeiras da Canção Telúrica"
		["Blackrock Depths - Detention Block"] = "Abismo Rocha Negra - Bloco da Deten\195\167\195\163o", -- "Abismo Rocha Negra - Bloco da Detenção"
		["Blackrock Depths - Upper City"] = "Abismo Rocha Negra - Cidade Superior", -- "Abismo Rocha Negra - Cidade Superior"
		["Dire Maul - Warpwood Quarter"] = "Gl\195\161dio Cruel - Distrito Lenhatorta", -- "Gládio Cruel - Distrito Lenhatorta"
		["Dire Maul - Capital Gardens"] = "Gl\195\161dio Cruel - Jardins Capitais", -- "Gládio Cruel - Jardins Capitais"
		["Dire Maul - Gordok Commons"] = "Gl\195\161dio Cruel - P\195\161tio Gordok", -- "Gládio Cruel - Pátio Gordok"
		["Stratholme - Main Gate"] = "Stratholme - Port\195\163o Principal", -- "Stratholme - Portão Principal"
		["Stratholme - Service Entrance"] = "Stratholme - Entrada de Servi\195\167o", -- "Stratholme - Entrada de Serviço"
		["Lower Blackrock Spire"] = "Pico da Rocha Negra Inferior", -- "Pico da Rocha Negra Inferior"
		["Upper Blackrock Spire"] = "Pico da Rocha Negra Superior", -- "Pico da Rocha Negra Superior"
		["The Siege of Wyrmrest Temple"] = "Cerco ao Repouso das Serpes", -- "Cerco ao Repouso das Serpes"
		["Fall of Deathwing"] = "Queda do Asa da Morte", -- "Queda do Asa da Morte"
		["The Headless Horseman"] = "Cavaleiro Sem Cabe\195\167a", -- "Cavaleiro Sem Cabeça"
		["Coren Direbrew"] = "Coren Cervatroz", -- "Coren Cervatroz"
		["The Frost Lord Ahune"] = "Ahune, o Senhor do Gelo", -- "Ahune, o Senhor do Gelo"
		["The Crown Chemical Co."] = "Qu\195\173micos Coroa S.A.", -- "Químicos Coroa S.A."
	},
	ruRU = {
		["Maraudon - The Wicked Grotto"] = "\208\156\208\176\209\128\208\190\208\180\208\190\208\189 - \208\158\209\129\208\186\208\178\208\181\209\128\208\189\208\181\208\189\208\189\209\139\208\185 \208\179\209\128\208\190\209\130", -- "Мародон - Оскверненный грот"
		["Maraudon - Foulspore Cavern"] = "\208\156\208\176\209\128\208\190\208\180\208\190\208\189 - \208\151\208\187\208\190\208\178\208\190\208\189\208\189\208\176\209\143 \208\191\208\181\209\137\208\181\209\128\208\176", -- "Мародон - Зловонная пещера"
		["Maraudon - Earth Song Falls"] = "\208\156\208\176\209\128\208\190\208\180\208\190\208\189 - \208\159\208\190\209\142\209\137\208\184\208\181 \208\178\208\190\208\180\208\190\208\191\208\176\208\180\209\139", -- "Мародон - Поющие водопады"
		["Blackrock Depths - Detention Block"] = "\208\147\208\187\209\131\208\177\208\184\208\189\209\139 \208\167\208\181\209\128\208\189\208\190\208\185 \208\179\208\190\209\128\209\139 - \208\162\209\142\209\128\208\181\208\188\208\189\209\139\208\185 \208\177\208\187\208\190\208\186", -- "Глубины Черной горы - Тюремный блок"
		["Blackrock Depths - Upper City"] = "\208\147\208\187\209\131\208\177\208\184\208\189\209\139 \208\167\208\181\209\128\208\189\208\190\208\185 \208\179\208\190\209\128\209\139 - \208\146\208\181\209\128\209\133\208\189\208\184\208\185 \208\179\208\190\209\128\208\190\208\180", -- "Глубины Черной горы - Верхний город"
		["Dire Maul - Warpwood Quarter"] = "\208\151\208\176\208\177\209\139\209\130\209\139\208\185 \208\147\208\190\209\128\208\190\208\180 - \208\154\208\178\208\176\209\128\209\130\208\176\208\187 \208\154\209\128\208\184\208\178\208\190\208\180\209\128\208\181\208\178\208\190\208\178", -- "Забытый Город - Квартал Криводревов"
		["Dire Maul - Capital Gardens"] = "\208\151\208\176\208\177\209\139\209\130\209\139\208\185 \208\147\208\190\209\128\208\190\208\180 - \208\166\208\181\208\189\209\130\209\128\208\176\208\187\209\140\208\189\209\139\208\185 \209\129\208\176\208\180", -- "Забытый Город - Центральный сад"
		["Dire Maul - Gordok Commons"] = "\208\151\208\176\208\177\209\139\209\130\209\139\208\185 \208\147\208\190\209\128\208\190\208\180 - \208\159\208\176\208\187\208\176\209\130\209\139 \208\147\208\190\209\128\208\180\208\190\208\186\208\176", -- "Забытый Город - Палаты Гордока"
		["Stratholme - Main Gate"] = "\208\161\209\130\209\128\208\176\209\130\209\133\208\190\208\187\209\140\208\188 - \208\147\208\187\208\176\208\178\208\189\209\139\208\181 \208\178\209\128\208\176\209\130\208\176", -- "Стратхольм - Главные врата"
		["Stratholme - Service Entrance"] = "\208\161\209\130\209\128\208\176\209\130\209\133\208\190\208\187\209\140\208\188 - \208\167\208\181\209\128\208\189\209\139\208\185 \209\133\208\190\208\180", -- "Стратхольм - Черный ход"
		["Lower Blackrock Spire"] = "\208\157\208\184\208\182\208\189\209\143\209\143 \209\135\208\176\209\129\209\130\209\140 \208\167\208\181\209\128\208\189\208\190\208\185 \208\179\208\190\209\128\209\139", -- "Нижняя часть Черной горы"
		["Upper Blackrock Spire"] = "\208\146\208\181\209\128\209\133\208\189\209\143\209\143 \209\135\208\176\209\129\209\130\209\140 \208\167\208\181\209\128\208\189\208\190\208\185 \208\179\208\190\209\128\209\139", -- "Верхняя часть Черной горы"
		["The Siege of Wyrmrest Temple"] = "\208\158\209\129\208\176\208\180\208\176 \208\165\209\128\208\176\208\188\208\176 \208\148\209\128\208\176\208\186\208\190\208\189\209\140\208\181\208\179\208\190 \208\159\208\190\208\186\208\190\209\143", -- "Осада Храма Драконьего Покоя"
		["Fall of Deathwing"] = "\208\159\208\176\208\180\208\181\208\189\208\184\208\181 \208\161\208\188\208\181\209\128\209\130\208\190\208\186\209\128\209\139\208\187\208\176", -- "Падение Смертокрыла"
		["The Headless Horseman"] = "\208\146\209\129\208\176\208\180\208\189\208\184\208\186 \208\177\208\181\208\183 \208\179\208\190\208\187\208\190\208\178\209\139", -- "Всадник без головы"
		["Coren Direbrew"] = "\208\154\208\190\209\128\208\181\208\189 \208\165\209\131\208\180\208\190\208\178\208\176\209\128", -- "Корен Худовар"
		["The Frost Lord Ahune"] = "\208\159\208\190\208\178\208\181\208\187\208\184\209\130\208\181\208\187\209\140 \208\165\208\190\208\187\208\190\208\180\208\176 \208\144\209\133\209\131\208\189", -- "Повелитель Холода Ахун"
		["The Crown Chemical Co."] = "\208\154\208\190\209\128\208\190\208\187\208\181\208\178\209\129\208\186\208\176\209\143 \209\133\208\184\208\188\208\184\209\135\208\181\209\129\208\186\208\176\209\143 \208\186\208\190\208\188\208\191\208\176\208\189\208\184\209\143", -- "Королевская химическая компания"
	},
	zhCN = {
		["Maraudon - The Wicked Grotto"] = "\231\142\155\230\139\137\233\161\191\239\188\141\233\130\170\230\129\182\230\180\158\231\169\180", -- "玛拉顿－邪恶洞穴"
		["Maraudon - Foulspore Cavern"] = "\231\142\155\230\139\137\233\161\191\239\188\141\230\175\146\232\143\135\230\180\158\231\169\180", -- "玛拉顿－毒菇洞穴"
		["Maraudon - Earth Song Falls"] = "\231\142\155\230\139\137\233\161\191\239\188\141\229\156\176\230\173\140\231\128\145\229\184\131", -- "玛拉顿－地歌瀑布"
		["Blackrock Depths - Detention Block"] = "\233\187\145\231\159\179\230\183\177\230\184\138\239\188\141\231\166\129\233\151\173\229\174\164", -- "黑石深渊－禁闭室"
		["Blackrock Depths - Upper City"] = "\233\187\145\231\159\179\230\183\177\230\184\138\239\188\141\228\184\138\229\177\130\229\140\186", -- "黑石深渊－上层区"
		["Dire Maul - Warpwood Quarter"] = "\229\142\132\232\191\144\228\185\139\230\167\140 - \230\137\173\230\156\168\229\185\191\229\156\186", -- "厄运之槌 - 扭木广场"
		["Dire Maul - Capital Gardens"] = "\229\142\132\232\191\144\228\185\139\230\167\140 - \228\184\173\229\191\131\232\138\177\229\155\173", -- "厄运之槌 - 中心花园"
		["Dire Maul - Gordok Commons"] = "\229\142\132\232\191\144\228\185\139\230\167\140 - \230\136\136\229\164\154\229\133\139\232\174\174\228\188\154", -- "厄运之槌 - 戈多克议会"
		["Stratholme - Main Gate"] = "\230\150\175\229\157\166\231\180\162\229\167\134\239\188\141\230\173\163\233\151\168", -- "斯坦索姆－正门"
		["Stratholme - Service Entrance"] = "\230\150\175\229\157\166\231\180\162\229\167\134\239\188\141\229\144\142\233\151\168", -- "斯坦索姆－后门"
		["Lower Blackrock Spire"] = "\233\187\145\231\159\179\229\161\148\228\184\139\229\177\130", -- "黑石塔下层"
		["Upper Blackrock Spire"] = "\233\187\145\231\159\179\229\161\148\228\184\138\229\177\130", -- "黑石塔上层"
		["The Siege of Wyrmrest Temple"] = "\229\155\180\230\148\187\233\190\153\231\156\160\231\165\158\230\174\191", -- "围攻龙眠神殿"
		["Fall of Deathwing"] = "\230\173\187\228\186\161\228\185\139\231\191\188\231\154\132\233\153\168\232\144\189", -- "死亡之翼的陨落"
		["The Headless Horseman"] = "\230\151\160\229\164\180\233\170\145\229\163\171", -- "无头骑士"
		["Coren Direbrew"] = "\231\167\145\230\158\151\194\183\231\131\136\233\133\146", -- "科林·烈酒"
		["The Frost Lord Ahune"] = "\229\134\176\233\156\156\228\185\139\231\142\139\229\159\131\233\156\141\230\129\169", -- "冰霜之王埃霍恩"
		["The Crown Chemical Co."] = "\231\154\135\229\134\160\232\141\175\229\137\130\229\133\172\229\143\184", -- "皇冠药剂公司"
		
		DATA = "\230\149\176\230\141\174", -- "数据"
		INSTANCE_TIMER = "\229\137\175\230\156\172\232\174\161\230\151\182\229\153\168", -- "副本计时器"
		INSTANCE_TIMER_MSG = "[<INSTANCE>] \229\183\178\229\174\140\230\136\144\239\188\140\231\148\168\230\151\182 <TIME> [<START>]-[<END>]", -- "[<INSTANCE>] 已完成，用时 <TIME> [<START>]-[<END>]"
		MANUAL_RESET = "\230\137\139\229\138\168\233\135\141\231\189\174", -- "手动重置"
		MANUAL_START = "\230\137\139\229\138\168\229\188\128\229\167\139", -- "手动开始"
		RECORD_INSTANCE = "\232\174\176\229\189\149\229\137\175\230\156\172", -- "记录副本"
		
		BROKER_CLICK = "|cffFFFFFF点击|r打开选项菜单",
		BROKER_SHIFT_CLICK = "|cffFFFFFFShift-点击|r 启用或禁用插件",
	},
	zhTW = {
		["Maraudon - The Wicked Grotto"] = "\231\145\170\230\139\137\233\160\147 - \233\130\170\230\131\161\230\180\158\231\169\180", -- "瑪拉頓 - 邪惡洞穴"
		["Maraudon - Foulspore Cavern"] = "\231\145\170\230\139\137\233\160\147 - \230\175\146\232\143\135\230\180\158\231\169\180", -- "瑪拉頓 - 毒菇洞穴"
		["Maraudon - Earth Song Falls"] = "\231\145\170\230\139\137\233\160\147 - \229\156\176\230\173\140\231\128\145\229\184\131", -- "瑪拉頓 - 地歌瀑布"
		["Blackrock Depths - Detention Block"] = "\233\187\145\231\159\179\230\183\177\230\183\181 - \231\166\129\233\150\137\229\174\164", -- "黑石深淵 - 禁閉室"
		["Blackrock Depths - Upper City"] = "\233\187\145\231\159\179\230\183\177\230\183\181 - \228\184\138\229\159\142\229\141\128", -- "黑石深淵 - 上城區"
		["Dire Maul - Warpwood Quarter"] = "\229\142\132\233\129\139\228\185\139\230\167\140 - \230\137\173\230\156\168\229\187\163\229\160\180", -- "厄運之槌 - 扭木廣場"
		["Dire Maul - Capital Gardens"] = "\229\142\132\233\129\139\228\185\139\230\167\140 - \228\184\173\229\191\131\232\138\177\229\156\146", -- "厄運之槌 - 中心花園"
		["Dire Maul - Gordok Commons"] = "\229\142\132\233\129\139\228\185\139\230\167\140 - \230\136\136\229\164\154\229\133\139\229\185\179\230\176\145\229\141\128", -- "厄運之槌 - 戈多克平民區"
		["Stratholme - Main Gate"] = "\230\150\175\229\157\166\231\180\162\229\167\134 - \228\184\187\233\150\128", -- "斯坦索姆 - 主門"
		["Stratholme - Service Entrance"] = "\230\150\175\229\157\166\231\180\162\229\167\134 - \229\131\149\229\190\158\229\133\165\229\143\163", -- "斯坦索姆 - 僕從入口"
		["Lower Blackrock Spire"] = "\228\189\142\233\154\142\233\187\145\231\159\179\229\161\148", -- "低階黑石塔"
		["Upper Blackrock Spire"] = "\233\187\145\231\159\179\229\161\148\228\184\138\229\177\164", -- "黑石塔上層"
		["The Siege of Wyrmrest Temple"] = "\229\156\141\230\148\187\233\190\141\231\156\160\231\165\158\230\174\191", -- "圍攻龍眠神殿"
		["Fall of Deathwing"] = "\230\173\187\228\186\161\228\185\139\231\191\188\233\154\149\232\144\189", -- "死亡之翼隕落"
		["The Headless Horseman"] = "\231\132\161\233\160\173\233\168\142\229\163\171", -- "無頭騎士"
		["Coren Direbrew"] = "\229\175\135\228\187\129\194\183\230\129\144\233\133\146", -- "寇仁·恐酒"
		["The Frost Lord Ahune"] = "\229\134\176\233\156\156\233\160\152\228\184\187\232\137\190\232\131\161\230\129\169", -- "冰霜領主艾胡恩"
		["The Crown Chemical Co."] = "\231\142\139\229\134\160\229\140\150\229\173\184\232\163\189\232\151\165\229\133\172\229\143\184", -- "王冠化學製藥公司"
		
		INSTANCE_TIMER = "\229\137\175\230\156\172\232\168\136\230\153\130\229\153\168", -- "副本計時器"
		INSTANCE_TIMER_MSG = "[<INSTANCE>] <TIME> \229\133\167\233\135\141\231\189\174 [<START>]-[<END>]", -- "[<INSTANCE>] <TIME> 內重置 [<START>]-[<END>]"
	},
}

L.esES = L.esMX -- instance strings are identical

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
