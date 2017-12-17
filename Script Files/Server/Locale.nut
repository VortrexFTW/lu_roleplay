// -------------------------------------------------------------------------------------------------

function InitLocaleGlobalTable ( ) {

	// 0 - English
	// 1 - Spanish
	// 2 - Russian
	// 3 - Dutch
	// 4 - Croatian
	
	local pLocaleTable = [ 
		
		// 0 - English
		dofile ( szScriptsPath + "Script Files/Server/Locale/English.nut" , true ) , 
		
		// 1 - Spanish
		dofile ( szScriptsPath + "Script Files/Server/Locale/Spanish.nut" , true ) , 
		
		// 2 - Russian
		dofile ( szScriptsPath + "Script Files/Server/Locale/Russian.nut" , true ) , 
		
		// 3 - Dutch
		dofile ( szScriptsPath + "Script Files/Server/Locale/Dutch.nut" , true ) , 

		// 4 - Croatian
		dofile ( szScriptsPath + "Script Files/Server/Locale/Croatian.nut" , true ) , 
		
		// 5 - Chinese
		dofile ( szScriptsPath + "Script Files/Server/Locale/Chinese.nut" , true ) ,	

		// 6 - Chinese
		dofile ( szScriptsPath + "Script Files/Server/Locale/Arabic.nut" , true ) ,				

	];
	
	return pLocaleTable;
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMessage ( pPlayer , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetLocaleMessage ( iLocaleID , szMessageType ) {

	return GetCoreTable ( ).Locale [ iLocaleID ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerGroupedLocaleMessage ( pPlayer , szGroupName , szMessageType ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	return GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] [ szMessageType ];
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerLocaleMultiMessage ( pPlayer , szGroupName ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	local pMessages = [ ];

	foreach ( ii , iv in GetCoreTable ( ).Locale [ pPlayerData.iLocale ] [ szGroupName ] ) {
	
		pMessages.push ( iv );
	
	}
	
	return pMessages;

}

// -------------------------------------------------------------------------------------------------

function IsValidLocaleID ( iLocaleID ) {

	if ( iLocaleID < 0 ) {
	
		return false;
	
	}
	
	if ( iLocaleID >= GetCoreTable ( ).Locale.len ( ) ) {
	
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetLocaleIDForCountry ( szCountryCode ) {
	
	switch ( szCountryCode.toupper ( ) ) {
		
		case "NL":
			return 3;
			
		case "RU":
		case "UA":
			return 2;
			
		case "HR":
			return 4;
			
		case "MX":
		case "ES":
		case "SV":
		case "CU":
		case "DO":
		case "EC":
			return 1;
			
		case "SG":
		case "CN":
		case "HK":
		case "MO":
			return 5;
			
		default:
			return 0;
		
	}
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Locale]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------