
// NAME: Messaging.nut
// DESC: Provides functions, handlers, and info for messages.
// NOTE: None

// -- COMMANDS -------------------------------------------------------------------------------------

function AddMessagingCommandHandlers ( ) {

	return true;
	
}

// -- SCRIPT INIT ----------------------------------------------------------------------------------

function InitMessagingScript ( ) {
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ShowWelcomeMessage ( pPlayer ) {



	MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "WelcomeToServer" ) , "Life in Liberty City" ) , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( "This server is under development, and may restart often for updates." , pPlayer , GetRGBColour ( "BrightRed" ) );
	
	if ( IsLoginRegisterGUIEnabled ( ) ) {
		!MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "PleaseWaitAccountLoading" ) , pPlayer );
		return true;
		
	}
	
	::print ( "- Welcome message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function SendPlayerErrorMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralErrorHeader" ) + "ERROR: " + GetColourByType ( "GeneralErrorMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendAdminMessageToAll ( szMessage ) {

	Message ( GetColourByType ( "AdminAnnounceHeader" ) + "ADMIN: " + GetColourByType ( "AdminAnnounceMessage" ) + szMessage , GetCoreTable ( ).Colours.RGB.White );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendMessageToAdmins ( szMessage ) {

	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( GetPlayerData ( iv ).iStaffFlags != 0 ) {
		
			MessagePlayer ( szMessage , iv , GetRGBColour ( "White" ) );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendMessageToDevelopers ( szMessage ) {

	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( DoesPlayerHaveStaffPermission ( iv , "Developer" ) ) {
		
			SendPlayerAlertMessage ( iv , szMessage );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendConsoleMessageToDevelopers ( szMessage ) {

	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( DoesPlayerHaveStaffPermission ( iv , "Developer" ) ) {
		
			CallClientFunc ( iv , "lilc/Client.nut" , "ConsoleMessage" , szMessage );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendAlertToPlayersWithStaffFlag ( szMessage , szStaffFlag ) {

	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( DoesPlayerHaveStaffPermission ( iv , szStaffFlag ) ) {
		
			SendPlayerAlertMessage ( iv , szMessage );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSyntaxMessage ( pPlayer , szCommand , szParams = false ) {

	if ( !szParams ) {

		MessagePlayer ( GetColourByType ( "GeneralSyntaxHeader" ) + "USAGE: " + GetColourByType ( "GeneralSyntaxMessage" ) + szCommand , pPlayer , GetRGBColour ( "White" ) );
		
	} else {
	
		MessagePlayer ( GetColourByType ( "GeneralSyntaxHeader" ) + "USAGE: " + GetColourByType ( "GeneralSyntaxMessage" ) + "/" + szCommand + " " + szParams , pPlayer , GetRGBColour ( "White" ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerNormalMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetHexColour ( "White" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerAlertMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralAlertHeader" ) + "ALERT: " + GetColourByType ( "GeneralAlertMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SendPlayerSuccessMessage ( pPlayer , szMessage ) {

	MessagePlayer ( GetColourByType ( "GeneralSuccessHeader" ) + "SUCCESS: " + GetColourByType ( "GeneralSuccessMessage" ) + szMessage , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ShowAuthenticationGreeting ( pPlayer ) {
	
	if ( IsLoginRegisterGUIEnabled ( ) ) {
		
		return false;
	
	}
	
	local pPlayerData = GetPlayerData ( pPlayer );	
	
	if ( LoadAccountFromDatabaseByName ( pPlayer.Name ).iDatabaseID == 0 ) {
		
		MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "AccountNotRegistered" ) , pPlayer , GetRGBColour ( "Orange" ) );
		
		print ( "- NeedToRegister message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
		
		GetPlayerData ( pPlayer ).pLoginTimeout = NewTimer ( "PlayerRegisterTimeout" , 60000 , 1 , pPlayer );
		
		//MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "AccountNotRegistered" ) , pPlayer , GetRGBColour ( "Orange" ) );
		
		local iLocaleID = GetLocaleIDForCountry ( geoip_country_code_by_addr ( pPlayer.IP ) );
		
		if ( iLocaleID != 0 ) { 
			MessagePlayer ( GetLocaleMessage ( iLocaleID , "LocaleAvailable" ) , pPlayer , GetRGBColour ( "Orange" ) );
			MessagePlayer ( GetLocaleMessage ( iLocaleID , "LocaleRegionUse" ) , pPlayer , GetRGBColour ( "Yellow" ) );
		}
		
		return true;
		
	} else {
	
		if ( IsPlayerAutoIPLoginEnabled ( pPlayer ) ) {
			
			if ( IsIPAllowedToUseAccount ( pPlayerData , pPlayer.IP ) ) {
				
				MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "WelcomeBackIPLogin" ) , pPlayer.Name ) , pPlayer , GetRGBColour ( "Yellow" ) );   
				MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "SpawnAfterDelay" ) , pPlayer , GetRGBColour ( "Yellow" ) ); 
				
				pPlayerData.bAuthenticated = true;
				pPlayerData.bCanSpawn = true;
				pPlayerData.bCanUseCommands = true;
				
				NewTimer ( "DelayedSpawn" , 3000 , 1 , pPlayer );
				
				print ( "- AutoIPLoggedIn message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );

				return true;
				
			}
			
		}
		
		if ( IsPlayerAutoLUIDLoginEnabled ( pPlayer ) ) {
			
			if ( IsLUIDAllowedToUseAccount ( pPlayerData , pPlayer.LUID ) ) {
				
				MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "WelcomeBackLUIDLogin" ) , pPlayer.Name ) , pPlayer , GetRGBColour ( "Yellow" ) );   
				MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "SpawnAfterDelay" ) , pPlayer , GetRGBColour ( "Yellow" ) ); 
				
				pPlayerData.bAuthenticated = true;
				pPlayerData.bCanSpawn = true;
				pPlayerData.bCanUseCommands = true;
				
				NewTimer ( "DelayedSpawn" , 3000 , 1 , pPlayer );
				
				print ( "- AutoIPLoggedIn message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
				
				return true;
				
			}
			
		}	
	
		MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "WelcomeBackNoLogin" ) , pPlayer.Name ) , pPlayer , GetRGBColour ( "Yellow" ) );	
		
		print ( "- NeedToLogin message sent to Player " + GetPlayerNameAndIDForConsole ( pPlayer ) );
		
		GetPlayerData ( pPlayer ).pLoginTimeout = NewTimer ( "PlayerLoginTimeout" , 60000 , 1 , pPlayer );

		return true;	
	
	}
	
	pPlayerData.bCanUseCommands = true;
	
	return;
	
}

// -------------------------------------------------------------------------------------------------

function SendPlayerInfoMessage ( pPlayer , szMessage ) {

	//MessagePlayer ( GetColourByType ( "InfoMessageHeader" ) + GetPlayerLocaleMessage ( pPlayer , "InfoMessageHeader" ) + ": " + GetColourByType ( "InfoMessageMessage" ) + szMessage , pPlayer , GetCoreTable ( ).Colours.RGB.White );
	
	SendPlayerAlertMessage ( pPlayer , szMessage );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Messaging]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
