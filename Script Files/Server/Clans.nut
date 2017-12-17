
// NAME: Clans.nut
// DESC: Handles commands, data, and other utilities for clans, clan turf wars, clan services, etc.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitClanScript ( ) {

	AddClanCommandHandlers ( );
	
	GetCoreTable ( ).Clans = LoadClansFromDatabase ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddClanCommandHandlers ( ) {

	print ( "[Server.Clans]: Loading command handlers" );

	// Clan Create
	AddCommandHandler ( "NewClan" 			, NewClanCommand 					, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "AddClan" 			, NewClanCommand 					, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "CreateClan" 		, NewClanCommand 					, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "MakeClan" 			, NewClanCommand 					, GetStaffFlagValue ( "None" ) );
	
	// Clan Delete
	AddCommandHandler ( "RemoveClan" 		, DeleteClanCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DeleteClan" 		, DeleteClanCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DelClan" 			, DeleteClanCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "RemClan" 			, DeleteClanCommand 				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Clan" 				, ToggleClanManagerCommand			, GetStaffFlagValue ( "None" ) );
	
	// Clan Members
	AddCommandHandler ( "RemClanMember" 	, RemoveClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DelClanMember" 	, RemoveClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DeleteClanMember" 	, RemoveClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DeleteMember" 		, RemoveClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "DelMember" 		, RemoveClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "AddMember" 		, InviteClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "AddClanMember" 	, InviteClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "ClanInvite" 		, InviteClanMemberCommand 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "MemberFlags" 		, SetClanMemberFlagsCommand 		, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "ClanMemberFlags" 	, SetClanMemberFlagsCommand			, GetStaffFlagValue ( "None" ) );
	
	// Clan Base/HQ
	//AddCommandHandler ( "ClanHQ" 			, SetClanBaseCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "ClanBase" 			, SetClanBaseCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "SetClanHQ" 		, SetClanBaseCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "SetClanBase"		, SetClanBaseCommand	 			, GetStaffFlagValue ( "None" ) );
	
	// Clan Skins
	//AddCommandHandler ( "AddClanSkin" 		, AddClanSkinCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "ClanSkin" 			, AddClanSkinCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "DelClanSkin" 		, DeleteClanSkinCommand	 			, GetStaffFlagValue ( "None" ) );
	
	// Clan Colour
	//AddCommandHandler ( "ClanColour" 		, SetClanColourCommand	 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "SetClanColour" 	, SetClanColourCommand	 			, GetStaffFlagValue ( "None" ) );	
	
	// Member Leave
	//AddCommandHandler ( "QuitClan" 			, LeaveClanCommand		 			, GetStaffFlagValue ( "None" ) );	
	//AddCommandHandler ( "LeaveClan" 		, LeaveClanCommand		 			, GetStaffFlagValue ( "None" ) );	
	//AddCommandHandler ( "ClanQuit" 			, LeaveClanCommand		 			, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "ClanLeave" 		, LeaveClanCommand		 			, GetStaffFlagValue ( "None" ) );
	
	// For Staff Only
	//AddCommandHandler ( "ReloadClans" 		, ReloadClansCommand 				, GetStaffFlagValue ( "ManageClans" ) );
	
	print ( "[Server.Clans]: Command handlers loaded" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveClanCommandHandlers ( ) {
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SaveAllClansToDatabase ( ) {

	foreach ( ii , iv in GetCoreTable ( ).Clans ) {
	
		
	
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function LoadClansFromDatabase ( ) {

	local pDatabaseConnection = ConnectToMySQL ( );
	local pAssocResult = false;
	local pClanData = false;
	local pClans = [ ];
		
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_main`" );

	if ( pQuery ) {
	
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanData = GetCoreTable ( ).Classes.ClanData ( pAssocResult );
			//pClanData.pAlliances = LoadClanAlliancesFromDatabase ( pClanData.iDatabaseID );
			//pClanData.pEnemies = LoadClanEnemiesFromDatabase ( pClanData.iDatabaseID );
			//pClanData.pBases = LoadClanBasesFromDatabase ( pClanData.iDatabaseID );
			pClanData.pTurfs = [ ]; //LoadClanTurfsFromDatabase ( pClanData.iDatabaseID );
			pClanData.pMembers = LoadClanMembersFromDatabase ( pClanData.iDatabaseID );
			pClanData.pRanks = LoadClanRanksFromDatabase ( pClanData.iDatabaseID );
			
			pClans.push ( pClanData );
			
			print ( "[Server.Clans]: Clan database ID " + pClanData.iDatabaseID + " loaded (Name: " + pClanData.szName + ")" );			
		
		}
	
	}
			
	::DisconnectFromMySQL ( pDatabaseConnection );
	
	EchoIRCConsoleDebug ( pClans.len ( ) + " clans loaded from the database!" );
	
	return pClans;

}

// -------------------------------------------------------------------------------------------------

function NewClanCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Creates a new clan." , [ "NewClan" , "AddClan" , "MakeClan" , "CreateClan" ] );
		
		return false;
	
	}
	
	local pPlayerData = GetPlayerData ( pPlayer );

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Full Clan Name>" );
		
		return false;
	
	}
	
	if ( szParams.len ( ) < GetClanConfiguration ( "iMinFullNameLength" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "FullClanNameTooShort" ) , GetClanConfiguration ( "iMinFullNameLength" ) ) );
		
		return false;
	
	}
	
	local pClanData = CreateNewClan ( szParams );
	
	if ( pClanData.iDatabaseID == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The '" + szParams + "' clan could not be created!" );
		
		return false;
	
	}

	SendPlayerSuccessMessage ( pPlayer , "The '" + pClanData.szName + "' clan has been created! Use '/Help Clan' for info and commands." );
	
	pClanData.iOwner = pPlayerData.iDatabaseID;
	pPlayerData.iClan = pClanData.iDatabaseID;
	pPlayerData.iClanFlags = -1;
	
	SendClanMembersToPlayer ( pPlayer );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function CreateNewClan ( szName ) {
	
	local pDatabaseConnection = ConnectToMySQL ( );
	
	if ( !pDatabaseConnection ) {
	
		return false;
	
	}
	
	local szSafeName = EscapeMySQLString ( false , szName );
	
	local szQueryString = "INSERT INTO `clan_main` ( `clan_name` , `clan_owner` ) VALUES ( '" + szSafeName + "' , 0 )";
	
	local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
	
	local pClanData = GetCoreTable ( ).Classes.ClanData ( );
	
	if ( pQuery ) {
		
		local iDatabaseID = mysql_insert_id ( pDatabaseConnection );
		pClanData.iDatabaseID = iDatabaseID;
		
		GetCoreTable ( ).Clans.push ( pClanData );
		
	}

	return pClanData;

}

// -------------------------------------------------------------------------------------------------

function ReloadClansCommand ( pPlayer , szCommand , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Reloads all clans." , [ "ReloadClans" ] , "Stops all turf wars too." );
		
		return false;
	
	}

	ReloadAllClans ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function DeleteClanCommand ( pPlayer , szCommand , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Deletes a clans." , [ "RemoveClan" , "DeleteClan" , "RemClan" , "DelClan" ] , "Stops all turf wars too." );
		
		return false;
	
	}

	ReloadAllClans ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ReloadAllClans ( ) {

	StopAllTurfWars ( );
	
	GetCoreTable ( ).Clans <- null;
	GetCoreTable ( ).Clans <- LoadClansFromDatabase ( );

}

// -------------------------------------------------------------------------------------------------

function StopAllTurfWars ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function TakeTurfCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Starts a turf war." , [ "TakeTurf" ] , "Must be in another clan's turf." );
		
		return false;
	
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function GiveTurfCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Gives a turf to another clan" , [ "GiveTurf" ] , "No turf war. Other clan has immediate ownership." );
		
		return false;
	
	}

	if ( DoesPlayerHaveClanPermission ( pPlayer , "Owner" ) ) {
	
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetClanOwnerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Sets a clan owner" , [ "ClanOwner" , "SetClanOwner" , "MakeClanOwner" ] , "" );
		
		return false;
	
	}

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageClans" ) ) {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/ClanOwner <Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
		
		if ( NumTok ( szParams , " " ) != 2 ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/ClanOwner <Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
	
		local iClan = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	
		if ( IsNum ( iClan ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "The clan ID must be a number!" );
			
			return false;
		
		}
	
		iClan = iClan.tointeger ( );
	
	} else {
		
		if ( GetPlayerData ( pPlayer ).iClan == 0 ) {
			
			SendPlayerErrorMessage ( pPlayer , "You are not in a clan!" );
			
			return false;
			
		}
		
		if ( !DoesPlayerHaveClanPermission ( pPlayer , "Owner" ) ) {
			
			SendPlayerErrorMessage ( pPlayer , "You can't change the owner of your clan!" );
			
			return false;
			
		}
		
	}
	
	local pClanData = GetClanFromDatabaseID ( iClan );
	
	if ( !pClanData ) {
	
		SendPlayerErrorMessage ( pPlayer , "That clan does not exist!" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( GetTok ( szParams , " " , 2 ) );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid or offline" );
		
		return false;
		
	}
	
	local pTargetData = GetCoreTable ( ).Players [ pTarget.ID ];
	
	if ( pTargetData.iClan != 0 ) {
	
		if ( pTargetData.iClan == pClanData.iDatabaseID ) {
		
			SetClanOwner ( pTarget , pClanData );
			
			SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "ClanLeaderSet" ) , pTarget.Name , pClanData.szName ) );
			
			return true;
		
		}
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerAlreadyInClan" ) );
		
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveClanMemberCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Removes a member from a clan" , [ "RemoveClanMember" , "RemoveMember" , "RemMember" , "DeleteMember" , "DelMember" ] , "" );
		
		return false;
	
	}

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageClans" ) ) {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
		
		if ( NumTok ( szParams , " " ) != 2 ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
	
		local iClan = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	
		if ( IsNum ( iClan ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "The clan ID must be a number!" );
			
			return false;
		
		}
	
		iClan = iClan.tointeger ( );
	
	} else {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player ID/Name>" );
			
			return false;
		
		}		
		
		if ( pPlayerData.iClan == 0 ) {
			
			SendPlayerErrorMessage ( pPlayer , "You are not in a clan!" );
			
			return false;
			
		}
		
		if ( !DoesPlayerHaveClanPermission ( pPlayer , "RemoveMember" ) ) {
			
			SendPlayerErrorMessage ( pPlayer , "You can't remove members from your clan!" );
			
			return false;
			
		}
		
		iClan = pPlayerData.iClan;
		
	}
	
	local pClanData = GetClanFromDatabaseID ( iClan );
	
	if ( !pClanData ) {
	
		SendPlayerErrorMessage ( pPlayer , "That clan does not exist!" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( GetTok ( szParams , " " , 2 ) );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid or offline" );
		
		return false;
		
	}
	
	local pTargetData = GetCoreTable ( ).Players [ pTarget.ID ];
	
	if ( pTargetData.iClan == 0 ) {
	
		if ( pTargetData.iClan == pClanData.iDatabaseID ) {
		
			pTargetData.iClan = 0;
			pTargetData.iClanRank = 0;
			
			SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "ClanMemberRemoved" ) , pTarget.Name , pClanData.szName ) );
			
			return true;
		
		}
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotInSameClan" ) );
		
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InviteClanMemberCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Removes a member from a clan" , [ "RemoveClanMember" , "RemoveMember" , "RemMember" , "DeleteMember" , "DelMember" ] , "" );
		
		return false;
	
	}

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageClans" ) ) {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
		
		if ( NumTok ( szParams , " " ) != 2 ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Clan ID> <Player ID/Name>" );
			SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list of all clan ID's" );
			
			return false;
		
		}
	
		local iClan = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	
		if ( IsNum ( iClan ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "The clan ID must be a number!" );
			
			return false;
		
		}
	
		iClan = iClan.tointeger ( );
	
	} else {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player ID/Name>" );
			
			return false;
		
		}		
		
		if ( pPlayerData.iClan == 0 ) {
			
			SendPlayerErrorMessage ( pPlayer , "You are not in a clan!" );
			
			return false;
			
		}
		
		if ( !DoesPlayerHaveClanPermission ( pPlayer , "RemoveMember" ) ) {
			
			SendPlayerErrorMessage ( pPlayer , "You can't remove members from your clan!" );
			
			return false;
			
		}
		
		iClan = pPlayerData.iClan;
		
	}
	
	local pClanData = GetClanFromDatabaseID ( iClan );
	
	if ( !pClanData ) {
	
		SendPlayerErrorMessage ( pPlayer , "That clan does not exist!" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( GetTok ( szParams , " " , 2 ) );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid or offline" );
		
		return false;
		
	}
	
	local pTargetData = GetCoreTable ( ).Players [ pTarget.ID ];
	
	if ( pTargetData.iClan == 0 ) {
	
		if ( pTargetData.iClan == pClanData.iDatabaseID ) {
		
			SetClanOwner ( pTarget , pClanData );
			
			SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "ClanInviteSent" ) , pTarget.Name , pClanData.szName ) );
			
			return true;
		
		}
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotInSameClan" ) );
		
		return false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetClanTagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Sets a clan tag (the letters in brackets)" , [ "ClanTag" , "SetClanTag" , "MakeClanTag" ] , "" );
		
		return false;
	
	}

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageClans" ) ) {
		
		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/ClanTag <Clan ID> <New Tag>" );
			
			return false;
		
		}
		
		if ( NumTok ( szParams , " " ) != 2 ) {
			
			SendPlayerSyntaxMessage ( pPlayer , "/ClanTag <Clan ID> <New Tag>" );
			
			return false;
			
		}
		
		local iClanID = GetTok ( szParams , " " , 1 );
		local szTag = GetTok ( szParams , " " , 2 );
		
	} else {

		if ( !DoesPlayerHaveClanPermission ( pPlayer , pPlayerData.iClan , "EditTag" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
			
			return false;
		
		}

		if ( !szParams ) {
		
			SendPlayerSyntaxMessage ( pPlayer , "/ClanTag <New Tag>" );
			
			return false;
		
		}
		
		local iClanID = pPlayerData.iClan
		local szTag = szParams;		
		
	}
	
	local pClanData = GetClanFromDatabaseID ( iClanID );
	
	pClanData.szTag = szTag;
	
	ResyncAllClanMemberTags ( );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ToggleClanManagerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Shows the clan manager" , [ "Clan" ] , "" );
		
		return false;
	
	}
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pPlayerData.iClan == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You aren't in a clan!" );
	
		return false;
	
	}
	
	if ( !DoesPlayerHaveClanPermission ( pPlayer , "ClanManager" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do that!" );
	
		return false;
	
	}
	
	ToggleClanManagerForPlayer ( pPlayer );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveClanPermission ( pPlayer , szClanFlag ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageClans" ) ) {
	
		return true;
	
	}
	
	if ( pPlayerData.iClan == pClanData.iDatabaseID ) {
	
		if ( HasBitFlag ( pPlayerData.iClanFlags , GetCoreTable ( ).BitFlags.ClanFlags [ szClanFlag ] ) ) {
		
			return true;
		
		}
		
		if ( HasBitFlag ( pPlayerData.iClanFlags , GetCoreTable ( ).BitFlags.ClanFlags [ "ClanOwner" ] ) ) {
		
			return true;
		
		}		
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function AreClansAllied ( pClan1Data , pClan2Data ) {

	// -- We are only going to check for pClan1Data's allies. They can add another clan as an ally, but it doesnt have to be two ways.
	// -- Meaning, clan 1 could consider clan 2 an ally, but clan 2 might not be the same for clan 1
	
	// -- Introduces a weakness though. If clan 1 leader allows clan 2 to use their stuff (vehicles and such), clan 2 might not have them
	// -- ... as an ally, which keeps clan 2 vehicles protected while they can use clan 1's vehicles.
	
	foreach ( ii , iv in pClan1Data.pAlliances ) {
	
		if ( iv.iClan == pClan2Data.iDatabaseID ) { 
			
			return true;
			
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function SetClanOwner ( pPlayer , pClanData ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	pPlayerData.iClan = pClanData.iDatabaseID;
	
	foreach ( ii , iv in GetCoreTable ( ).BitFlags.ClanFlags ) {
	
		GiveClanFlag ( pPlayer , iv );
	
	}
	
	pClanData.iOwner = pPlayerData.iDatabaseID;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddClanAlliance ( pClan1Data , pClan2Data ) {

	if ( AreClansAllied ( pClan1Data , pClan2Data ) ) {
		
		return false;
	
	}
	
	pClan1Data.pAlliances.push ( pClan2Data.iDatabaseID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResyncAllClanMemberTags ( ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function LoadClanMembersFromDatabase ( iClanID ) {

	local pClanMembers = [ ];
	local pClanMember = { };
	local pAssocResult = false;
	
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_members` WHERE `clan_member_clan` = " + iClanID );

	if ( pQuery ) {
		
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanMember = { };
			pClanMember.iDatabaseID <- pAssocResult [ "clan_member_id" ];
			pClanMember.iAccount <- pAssocResult [ "clan_member_acct" ];
			pClanMember.iRank <- pAssocResult [ "clan_member_rank" ];
			pClanMember.szCustomTag <- pAssocResult [ "clan_member_custom_tag" ];
			pClanMember.szCustomTitle <- pAssocResult [ "clan_member_custom_title" ];
			pClanMember.iPermissions <- pAssocResult [ "clan_member_flags" ];
			
			pClanMembers.push ( pClanMember );
		
		}
	
	}

	return pClanMembers;

}

// -------------------------------------------------------------------------------------------------

function GetAllClanMembers ( iClanID ) {

	local pClanMembers = [ ];
	local pClanMember = { };
	
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_members` WHERE `clan_member_clan` = " + iClanID );

	if ( pQuery ) {
	
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanMember = { };
			pClanMember.szName <- LoadAccountFromDatabaseByID ( pAssocResult [ "clan_member_acct" ] ) [ "acct_name" ];
			pClanMember.iRank <- pAssocResult [ "clan_member_rank" ];
			pClanMember.szCustomTag <- pAssocResult [ "clan_member_custom_tag" ];
			pClanMember.szCustomTitle <- pAssocResult [ "clan_member_custom_title" ];
			pClanMember.iPermissions <- pAssocResult [ "clan_member_flags" ];
			
			pClanMembers.push ( pClanMember );
		
		}
	
	}

	return pClanMembers;

}

// -------------------------------------------------------------------------------------------------

function LoadClanRanksFromDatabase ( iClanID ) {

	local pClanRanks = [ ];
	local pClanRank = { };
	
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_ranks` WHERE `clan_ranks_clan` = " + iClanID );

	if ( pQuery ) {
	
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanRank = { };
			pClanRank.iDatabaseID <- pAssocResult [ "clan_rank_id" ];
			pClanRank.szName <- pAssocResult [ "clan_rank_name" ];
			pClanRank.szCustomTag <- pAssocResult [ "clan_rank_custom_tag" ];
			pClanRank.iPermissions <- pAssocResult [ "clan_rank_flags" ];
			
			pClanRanks.push ( pClanRank );
		
		}
	
	}

	return pClanRanks;

}

// -------------------------------------------------------------------------------------------------

function GetAllClanRanks ( iClanID ) {

	local pClanRanks = [ ];
	local pClanRank = { };
	
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_ranks` WHERE `clan_ranks_clan` = " + iClanID );

	if ( pQuery ) {
	
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanRank = { };
			pClanRank.szName <- pAssocResult [ "clan_rank_name" ];
			pClanRank.szCustomTag <- pAssocResult [ "clan_rank_custom_tag" ];
			pClanRank.iPermissions <- pAssocResult [ "clan_rank_flags" ];
			
			pClanRanks.push ( pClanRank );
		
		}
	
	}

	return pClanRanks;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerInAnyClan ( pPlayer ) {

	if ( GetPlayerData ( pPlayer ).iClan > 0 ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------


function GetClanFromDatabaseID ( iDatabaseID ) {

	local pDatabaseConnection = ConnectToMySQL ( );
	local pAssocResult = false;
	local pClanData = false;
		
	local pQuery = ExecuteMySQLQuery ( ConnectToMySQL ( ) , "SELECT * FROM `clan_main` WHERE `clan_id` = " + iDatabaseID );

	if ( pQuery ) {
	
		while ( pAssocResult = GetMySQLAssocResult ( pQuery ) ) {
		
			pClanData = GetCoreTable ( ).Classes.ClanData ( pAssocResult );
			
			pClanData.pTurfs = [ ]; //LoadClanTurfsFromDatabase ( pClanData.iDatabaseID );
			pClanData.pMembers = LoadClanMembersFromDatabase ( pClanData.iDatabaseID );
			pClanData.pRanks = LoadClanRanksFromDatabase ( pClanData.iDatabaseID );			
		
		}
	
	}
			
	::DisconnectFromMySQL ( pDatabaseConnection );
	
	return pClanData;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Clan]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------