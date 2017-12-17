
// NAME: Bans.nut
// DESC: Provides utility functions and commands for managing bans.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitBansScript ( ) {
	
	AddBansCommandHandlers ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddBansCommandHandlers ( ) {

	//AddCommandHandler ( "Ban"				, BanPlayerCommand					, GetStaffFlagValue ( "BasicModeration" ) );
	//AddCommandHandler ( "TempBan"			, TempBanPlayerCommand				, GetStaffFlagValue ( "BasicModeration" ) );

	return true;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerTempBanned ( pPlayer ) {


}

// -------------------------------------------------------------------------------------------------

function IsPlayerLUIDBanned ( pPlayer ) {


}

// -------------------------------------------------------------------------------------------------

function IsPlayerIPBanned ( pPlayer ) {


}

// -------------------------------------------------------------------------------------------------

function IsPlayerRangeBanned ( pPlayer ) {


}

// -------------------------------------------------------------------------------------------------

function IsPlayerRouteBanned ( pPlayer ) {


}

// -------------------------------------------------------------------------------------------------

function IsPlayerBanned ( pPlayer ) {

	// Start with the most severe. If they don't have this, move on down the list.
	
	if ( IsPlayerRouteBanned ( pPlayer ) ) {
	
		return GetUtilitiesValues ( ).iBanTypes.Route;
	
	}
	
	if ( IsPlayerRangeBanned ( pPlayer ) ) {
	
		return GetUtilitiesValues ( ).iBanTypes.Range;
	
	}	
	
	if ( IsPlayerLUIDBanned ( pPlayer ) ) {
	
		return GetUtilitiesValues ( ).iBanTypes.LUID;
	
	}	
	
	if ( IsPlayerIPBanned ( pPlayer ) ) {
	
		return GetUtilitiesValues ( ).iBanTypes.IP;
	
	}
	
	if ( IsPlayerTempBanned ( pPlayer ) ) {
	
		return GetUtilitiesValues ( ).iBanTypes.Temp;
	
	}
	
	return GetUtilitiesValues ( ).iBanTypes.Temp;

}

// -------------------------------------------------------------------------------------------------

function GetBansByIP ( szIPAddress ) {

	local pBans = [ ];
	local pBan = { };
	local pDatabaseConnection = false;
	local szQueryString = false;
	local pQuery = false;
	local pAssocResult = false;

	if ( pDatabaseConnection ) {
			
		szQueryString = format ( "SELECT * , INET_NTOA ( 'ban_ip_start' ) AS `ipstart` , INET_NTOA ( 'ban_ip_end' ) AS `ipend` FROM `ban` WHERE `ban_ip_start` >= INET_ATON ( '%s' ) AND `ban_ip_end` <= INET_ATON ( '%s' ) LIMIT 1" , szIPAddress );
		
		if ( szQueryString ) {
		
			pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
		
			if ( pQuery ) {
			
				while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
				
					pBan = { };
					
					pBan.iDatabaseID 			= pAssocResult [ "ban_id" ].tointeger ( );
					pBan.szIPStart 				= pAssocResult [ "ipstart" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szIPEnd 				= pAssocResult [ "ipend" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szLUID 				= pAssocResult [ "ban_luid" ].tostring ( );
					pBan.iBanType 				= pAssocResult [ "ban_type" ].tointeger ( );
					pBan.szName 				= pAssocResult [ "ban_name" ].tostring ( );
					pBan.iWhenAdded 			= pAssocResult [ "ban_when_added" ].tointeger ( );
					pBan.iAddedByAccountID 		= pAssocResult [ "ban_added_by" ].tointeger ( );
					
					pBans.push ( pBan );
				
				}
			
			}
		
		}
	
	}
	
	return pBans;

}

// -------------------------------------------------------------------------------------------------

function GetBansByLUID ( szLUID ) {

	local pBans = [ ];
	local pBan = { };
	local pDatabaseConnection = false;
	local szQueryString = false;
	local pQuery = false;
	local pAssocResult = false;

	if ( pDatabaseConnection ) {
			
		szQueryString = format ( "SELECT * , INET_NTOA ( 'ban_ip_start' ) AS `ipstart` , INET_NTOA ( 'ban_ip_end' ) AS `ipend` FROM `ban` WHERE `ban_ip_luid` = '%s' LIMIT 1" , szLUID );
		
		if ( szQueryString ) {
		
			pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
		
			if ( pQuery ) {
			
				while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
				
					pBan = { };
					
					pBan.iDatabaseID 			= pAssocResult [ "ban_id" ].tointeger ( );
					pBan.szIPStart 				= pAssocResult [ "ipstart" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szIPEnd 				= pAssocResult [ "ipend" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szLUID 				= pAssocResult [ "ban_luid" ].tostring ( );
					pBan.iBanType 				= pAssocResult [ "ban_type" ].tointeger ( );
					pBan.szName 				= pAssocResult [ "ban_name" ].tostring ( );
					pBan.iWhenAdded 			= pAssocResult [ "ban_when_added" ].tointeger ( );
					pBan.iAddedByAccountID 		= pAssocResult [ "ban_added_by" ].tointeger ( );
					
					pBans.push ( pBan );
				
				}
			
			}
		
		}
	
	}
	
	return pBans;

}

// -------------------------------------------------------------------------------------------------

function GetBansByName ( szName ) {

	local pBans = [ ];
	local pBan = { };
	local pDatabaseConnection = false;
	local szQueryString = false;
	local pQuery = false;
	local pAssocResult = false;

	if ( pDatabaseConnection ) {
			
		szQueryString = format ( "SELECT * , INET_NTOA ( 'ban_ip_start' ) AS `ipstart` , INET_NTOA ( 'ban_ip_end' ) AS `ipend` FROM `ban` WHERE `ban_ip_luid` = '%s' LIMIT 1" , szLUID );
		
		if ( szQueryString ) {
		
			pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
		
			if ( pQuery ) {
			
				while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
				
					pBan = { };
					
					pBan.iDatabaseID 			= pAssocResult [ "ban_id" ].tointeger ( );
					pBan.szIPStart 				= pAssocResult [ "ipstart" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szIPEnd 				= pAssocResult [ "ipend" ].tostring ( ); // Careful, this one is selected manually!
					pBan.szLUID 				= pAssocResult [ "ban_luid" ].tostring ( );
					pBan.iBanType 				= pAssocResult [ "ban_type" ].tointeger ( );
					pBan.szName 				= pAssocResult [ "ban_name" ].tostring ( );
					pBan.iWhenAdded 			= pAssocResult [ "ban_when_added" ].tointeger ( );
					pBan.iAddedByAccountID 		= pAssocResult [ "ban_added_by" ].tointeger ( );
					
					pBans.push ( pBan );
				
				}
			
			}
		
		}
	
	}
	
	return pBans;

}

// -------------------------------------------------------------------------------------------------

function BanPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Bans a player from the server" , [ "Ban" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Ban <Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	// SendAdminMessageToAll ( pTarget.Name + " has been banned by " + pPlayer.Name );
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerBanned" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	BanPlayer ( pTarget , BANTYPE_LUID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TempBanPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescTempBan" ) , [ "TempBan" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/TempBan <Player Name/ID> <Time in Hours>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	BanPlayer ( pTarget , BANTYPE_LUID );
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerTempBanned" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Bans]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------