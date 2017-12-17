
// NAME: Moderation.nut
// DESC: Handles anything related to basic moderation. Commands and information for server staff.
// NOTE: Does not include specific staff abilities like ban or vehicle management.

// -- COMMANDS -------------------------------------------------------------------------------------

function AddModerationCommandHandlers ( ) {

	AddCommandHandler ( "Kick" 				, KickPlayerCommand					, GetStaffFlagValue ( "BasicModeration" ) );

	AddCommandHandler ( "Mute"				, MutePlayerCommand					, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Unmute"			, UnmutePlayerCommand				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Freeze"			, FreezePlayerCommand				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "Unfreeze"			, UnfreezePlayerCommand				, GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "Goto"				, GotoPlayerCommand 				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GetHere"			, GetPlayerToMeCommand				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GotoHouse"			, GotoHouseCommand					, GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "Report"			, ForumStaffReportCommand			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Reports"			, ListAllStaffReportsCommand		, GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "ResetReport"		, ResetStaffReportCommand			, GetStaffFlagValue ( "ManageServer" ) | GetStaffFlagValue ( "ManageAdmins" ) | GetStaffFlagValue ( "Developer" ) );
	AddCommandHandler ( "AcceptReport"		, AcceptStaffReportCommand			, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "DenyReport"		, DenyStaffReportCommand			, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "ForumReport"		, ForumStaffReportCommand			, GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "GiveStaffFlag"		, GivePlayerStaffFlagCommand		, GetStaffFlagValue ( "ManageAdmins" ) );
	AddCommandHandler ( "TakeStaffFlag"		, TakePlayerStaffFlagCommand		, GetStaffFlagValue ( "ManageAdmins" ) );
	AddCommandHandler ( "StaffFlags"		, ListAllStaffFlagsCommand			, GetStaffFlagValue ( "ManageAdmins" ) );
	
	AddCommandHandler ( "SetSkin"			, SetPlayerSkinCommand				, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "GiveMoney"			, GivePlayerMoneyCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "TakeMoney"			, TakePlayerMoneyCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "GiveGun"			, GivePlayerWeaponCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	
	AddCommandHandler ( "BlockGuns"			, PlayerBlockWeaponsCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockWeapons"		, PlayerBlockWeaponsCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockAmmu"			, PlayerBlockAmmunationsCommand		, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockAmmunation"	, PlayerBlockAmmunationsCommand		, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockAmmus"		, PlayerBlockAmmunationsCommand		, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockAmmunations"	, PlayerBlockAmmunationsCommand		, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockAllJobs"		, PlayerBlockAllJobsCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	AddCommandHandler ( "BlockJob"			, PlayerBlockAllJobsCommand			, GetStaffFlagValue ( "ManagePlayerStats" ) );
	
	AddCommandHandler ( "SaveAll"			, SaveServerDataCommand				, GetStaffFlagValue ( "ManageServer" ) );	
	AddCommandHandler ( "GTAVSpawn"			, ToggleGTAVSpawnCamCommand			, GetStaffFlagValue ( "ManageServer" ) );
	
	//AddCommandHandler ( "AddStaffNote"		, AddStaffNoteToPlayer				, GetStaffFlagValue ( "BasicModeration" ) );
	//AddCommandHandler ( "DelStaffNote"		, DeleteStaffNoteFromPlayer				, GetStaffFlagValue ( "ManageNotes" ) );
	//AddCommandHandler ( "StaffNotes"		, ListStaffNotesForPlayer			, GetStaffFlagValue ( "BasicModeration" ) );
	
	AddCommandHandler ( "AdminDuty"			, TogglePlayerAdminDutyCommand		, GetStaffFlagValue ( "BasicModeration" ) );
	
	return true;

}

// -- SCRIPT INIT ----------------------------------------------------------------------------------

function InitModerationScript ( ) {

	AddModerationCommandHandlers ( )
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AdminChatCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Talks on admin chat" , [ "SC" , "StaffChat" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Message>" );
		
		return false;
	
	}
	
	SendMessageToAdmins ( GetHexColour ( "MediumRed" ) + "(Staff Chat) " + GetHexColour ( "MediumGrey" ) + "<" + GetPlayerData ( pPlayer ).szStaffTitle + "> " + GetHexColour ( "LightGrey" ) + pPlayer.Name + ": " + GetHexColour ( "White" ) + szMessage );	
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function KickPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescKick" ) , [ "Kick" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	KickPlayer ( pTarget );
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerKicked" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function MutePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescMute" ) , [ "Mute" , "MutePlayer" ] , "This also blocks chat-related commands (ME, DO, etc)" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	GetPlayerData ( pTarget ).bMuted = true;	
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerMuted" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnmutePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescUnmute" ) , [ "Unmute" , "UnmutePlayer" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	GetPlayerData ( pTarget ).bMuted = false;
		
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerUnmuted" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function FreezePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescFreeze" ) , [ "Freeze" , "FreezePlayer" ] , "They can still look around with their mouse." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	GetPlayerData ( pTarget ).bFrozen = true;
	pTarget.Frozen = true;	
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerFrozen" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnfreezePlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescUnfreeze" ) , [ "Unfreeze" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	GetPlayerData ( pTarget ).bFrozen = false;
	pTarget.Frozen = false;	
	
	foreach ( ii , iv in GetCoreTable ( ).Players ) {
	
		MessagePlayer ( pPlayer , GetColourByType ( "AdminAnnounceHeader" ) + GetPlayerLocaleMessage ( pPlayer , "AdminAnnounceHeader" ) + ": " + GetColourByType ( "AdminAnnounceMessage" ) + format ( GetPlayerLocaleMessage ( pPlayer , "PlayerUnfrozen" ) , pTarget.Name , pPlayer.Name ) );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GotoPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGoto" ) , [ "Goto" , "GotoPlayer" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( pTarget.Vehicle ) {
	
		pPlayer.Pos = GetVectorAboveVector ( pTarget.Pos , 3.0 );
	
	} else {
	
		pPlayer.Pos = GetVectorInFrontOfVector ( pTarget.Pos , pTarget.Angle , 3.0 );
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported to player '" + pTarget.Name + "' (ID " + pTarget.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerToMeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGetHere" ) , [ "Get" , "GetHere" , "BringPlayer" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( pPlayer.Vehicle ) {
	
		pTarget.Pos = GetVectorAboveVector ( pPlayer.Pos , 3.0 );
	
	} else {
	
		pTarget.Pos = GetVectorInFrontOfVector ( pPlayer.Pos , pPlayer.Angle , 3.0 );
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported '" + pTarget.Name + "' (ID " + pTarget.ID + ") to you." );
	SendPlayerSuccessMessage ( pTarget , "You have been teleported to '" + pPlayer.Name + "' (ID " + pPlayer.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerStaffFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGiveStaffFlag" ) , [ "GiveStaffFlag" ] , "" );

		return false;

	}

	local pTarget;
	local szFlagName;

	if ( !szParams ) {

		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );

		return false;

	}

	if ( NumTok ( szParams , " " ) != 2 ) {

		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );
		
		return false;

	}

	pTarget = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	szFlagName = GetTok ( szParams , " " , 2 );

	if ( !pTarget ) {

		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );

		return false;

	}

	if ( !DoesStaffFlagExist ( szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , "There is no staff flag called '" + szFlagName + "'!" );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );

		return false;

	}

	if ( szFlagName == "Developer" ) {

		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "Developer" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't give " + pTarget.Name + " the 'Developer' staff flag!" );

		   return false;

		}

	}	

	if ( DoesPlayerHaveStaffPermission ( pTarget , "Developer" ) ) {
	
		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "Developer" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't modify " + pTarget.Name + "'s flags!" );

		   return false;
		   
		}
		

		return false;

	}	

	if ( DoesPlayerHaveStaffPermission ( pPlayer , szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " already has the '" + szFlagName + "' staff flag!" );

		return false;

	}

	SendPlayerSuccessMessage ( pPlayer , "You have given " + pTarget.Name + " the '" + szFlagName + "' staff flag." );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has given you the '" + szFlagName + "' staff flag." );

	AddStaffPermission ( pPlayer , szFlagName );

	return true;

}

// -------------------------------------------------------------------------------------------------

function TakePlayerStaffFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescTakeStaffFlag" ) , [ "TakeStaffFlag" ] , "" );

		return false;

	}

	local pTarget;
	local szFlagName;

	if ( !szParams ) {

		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForPlayerStaffFlags" ) );

		return false;

	}

	if ( NumTok ( szParams , " " ) != 2 ) {

		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Staff Flag Name>" );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForPlayerStaffFlags" ) );
		
		return false;

	}

	pTarget = FindPlayer ( GetTok ( szParams , " " , 1 ) );
	szFlagName = GetTok ( szParams , " " , 2 );

	if ( !pTarget ) {

		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );

		return false;

	}

	if ( !GetRootTable ( ).BitFlags.StaffFlags.rawin ( szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , format ( SendPlayerLocaleMessage ( pPlayer , "StaffFlagDoesntExist" ) , szFlagName ) );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForStaffFlags" ) );

		return false;

	}

	if ( szFlagName == "Developer" ) {

		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "Developer" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , format ( SendPlayerLocaleMessage ( pPlayer , "CantRemoveDeveloperFlag" ) , pTarget.Name ) );

		   return false;

		}

	}

	if ( !DoesPlayerHaveStaffPermission ( pPlayer , szFlagName ) ) {

		SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "PlayerDoesntHaveStaffFlag" ) , pPlayer.Name , szFlagName ) );
		SendPlayerInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UseCommandForPlayerStaffFlags" ) );

		return false;

	}

	if ( DoesPlayerHaveStaffPermission ( pTarget , "Developer" ) ) {
	
		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "Developer" ) ) {
		   
		   SendPlayerErrorMessage ( pPlayer , "You can't modify " + pTarget.Name + "'s flags!" );

		   return false;
		   
		}
		

		return false;

	}

	SendPlayerSuccessMessage ( pPlayer , "You have taken the '" + szFlagName + "' staff flag from " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has taken the '" + szFlagName + "' staff flag away from you." );

	RemoveStaffPermission ( pPlayer , szFlagName );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ListAllStaffFlagsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescStaffFlags" ) , [ "StaffFlags" ] , "" );

		return false;

	}
	
	foreach ( ii , iv in GetCoreTable ( ).BitFlags.StaffFlags ) {
	
		if ( HasBitFlag ( pPlayerData.StaffFlags , iv ) ) {
		
			SendPlayerNormalMessage ( pPlayer , GetCoreTable ( ).Colours.Hex.Lime + ii );
		
		} else {
		
			SendPlayerNormalMessage ( pPlayer , GetCoreTable ( ).Colours.Hex.BrightRed + ii );
		
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescReport" ) , [ "Report" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Message>" );
		
		return false;
	
	}
	
	if ( !CanPlayerSubmitStaffReport ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You cannot submit a report right now!" );
		
		return false;
	
	}
	
	SubmitStaffReport ( pPlayer , szParams );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ListAllStaffReportsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescReports" ) , [ "Reports" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand );
		//SendPlayerNormalMessage ( pPlayer , "Leaving the extra part out will show all unhandled reports." );
		
		return false;
	
	}
	
	local pStaffReports = GetAllUnhandledStaffReports ( );
	local iReportCount = 0;
	
	SendPlayerNormalMessage ( pPlayer , "== STAFF REPORTS ===============================" );
	
	foreach ( ii , iv in pStaffReports ) {
	
		if ( iv.iResponseType == GetCoreTable ( ).Utilities.StaffReportResponse.None ) {
		
			SendPlayerNormalMessage ( iv.iReportID + ": (From " + iv.szReporterName + ") " + iv.szMessage + " (sent " + GetTimeDifferenceDisplay ( time ( ) , iv.iTime ) + " ago)" );
			
			iReportCount++;
		
		}
	
	}
	
	if ( iReportCount ) {
		
		SendPlayerAlertMessage ( pPlayer , "There are no reports to show!" );
		
		return false;
	
	}
	
	SendPlayerNormalMessage ( pPlayer , "================================================" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AcceptStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescAR" ) , [ "AcceptReport" , "AR" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already being handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Developer" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	AcceptStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function DenyStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescDR" ) , [ "DenyReport" , "DR" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Developer" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	DenyStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ForumStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescForumReport" ) , [ "ForumReport" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report is already handled!" );
		
		if ( DoesPlayerHaveStaffFlag ( pPlayer , "ManageAdmins" ) || DoesPlayerHaveStaffFlag ( pPlayer , "Developer" ) || DoesPlayerHaveStaffFlag ( pPlayer , "ManageServer" ) ) {
			
			SendPlayerAlertMessage ( pPlayer , "You can reset the report with /ResetReport" );
			
			return false;
		
		}
		
		return false;
	
	}
	
	SetAsForumStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetStaffReportCommand ( pPlayer , szCommand , szParams , bShowHelpOnly ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescResetReport" ) , [ "ResetReport" ] , "" );

		return false;

	}

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Report ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The Report ID must be a number!" );
		
		return false;
	
	}
	
	local pStaffReport = GetStaffReportByID ( szParams.tointeger ( ) );
	
	if ( !pStaffReport ) {
		
		SendPlayerErrorMessage ( pPlayer , "There is no report with that ID!" );
		
		return false;
		
	}
	
	if ( !IsStaffReportAlreadyHandled ( pPlayer , pStaffReport ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That report has not been handled! No need to reset it!" );
		
		return false;
	
	}
	
	OverrideStaffReport ( pPlayer , pStaffReport );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitStaffReport ( pPlayer , szMessage ) {

	local pStaffReport = GetCoreTable ( ).Classes.StaffReports ( );
	
	pStaffReport.iTime = time ( );
	pStaffReport.szReporterName = pPlayer.Name;
	pStaffReport.szMessage = szMessage;

	GetCoreTable ( ).StaffReports.push ( pStaffReport );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AcceptStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Accepted;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have accepted " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has accepted your report." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function DenyStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have denied " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has denied your report." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function SetAsForumStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have set " + pStaffReport.pReporter.Name + "'s as needing to be posted on forum. (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pStaffReport.pReporter , pPlayer.Name + " has set your report as needing to post on the forum." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetStaffReport ( pPlayer , pStaffReport ) {

	pStaffReport.iResponseType = GetCoreTable ( ).Utilities.StaffReportResponse.Denied;
	
	pStaffReport.iResponseTime = time ( );
	pStaffReport.pResponseAdmin = pPlayer;
	
	SendPlayerSuccessMessage ( pPlayer , "You have reset " + pStaffReport.pReporter.Name + "'s report (ID: " + pReportData.iReportID + ")" );
	SendPlayerAlertMessage ( pPlayer , "The report has now been set as unhandled." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function GetStaffReportByID ( iStaffReportID ) {

	if ( !( iStaffReportID in GetAllStaffReports ( ) ) ) {
	
		return GetAllStaffReports ( ) [ iStaffReportID ]; 
	
	}

	return false;

}

// -------------------------------------------------------------------------------------------------

function GetAllStaffReports ( ) {

	return GetCoreTable ( ).StaffReports;

}

// -------------------------------------------------------------------------------------------------

function GetAllUnhandledStaffReports ( ) {

	local pTempReports = [ ];

	foreach ( ii , iv in GetAllStaffReports ( ) ) {
	
		if ( iv.iResponseType == GetCoreTable ( ).Utilities.StaffReportResponse.None ) {
		
			pTempReports.push ( iv );
		
		}
	
	}
	
	return pTempReports;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerSkinCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescSetSkin" ) , [ "SetSkin" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szSkinParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Skin ID>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Skin ID>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szSkinParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( !IsNum ( szSkinParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The skin ID must be a number!" );
		
		return false;	
	
	}
	
	szSkinParam = szSkinParam.tointeger ( );
	
	if ( !IsValidSkinID ( szSkinParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That skin ID is invalid!" );
		
		return false;	
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You set " + pTarget.Name + "'s skin to ID " + szSkinParam );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has set your skin to ID " + szSkinParam );
	
	SetPlayerSkin ( pTarget , szSkinParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TakePlayerMoneyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescTakeMoney" ) , [ "TakeMoney" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szMoneyParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Amount>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Amount>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szMoneyParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( !IsNum ( szMoneyParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount of money must be a number!" );
		
		return false;	
	
	}
	
	szMoneyParam = szMoneyParam.tointeger ( );
	
	if ( szMoneyParam > 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be more than 0!" );
		
		return false;	
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You took $" + szMoneyParam + " from " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has taken $" + szMoneyParam + " from you" );
	
	TakePlayerCash ( pTarget , szMoneyParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerMoneyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGiveMoney" ) , [ "GiveMoney" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szMoneyParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Amount>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Amount>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szMoneyParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( !IsNum ( szMoneyParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount of money must be a number!" );
		
		return false;	
	
	}
	
	szMoneyParam = szMoneyParam.tointeger ( );
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You gave " + pTarget.Name + " $" + szMoneyParam );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has given you $" + szMoneyParam );
	
	GivePlayerCash ( pTarget , szMoneyParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerWeaponCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGiveWeapon" ) , [ "GiveGun" , "GiveWeapon" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local szWeaponParam = false;
	local szAmmoParam = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Weapon ID> <Ammo>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 3 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Weapon ID> <Ammo>" );
		
		return false;
	
	}	
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	szWeaponParam = GetTok ( szParams , " " , 2 );
	szAmmoParam = GetTok ( szParams , " " , 3 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( !IsNum ( szWeaponParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;	
	
	}
	
	szWeaponParam = szWeaponParam.tointeger ( );
	
	if ( !IsNum ( szAmmoParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The ammo amount must be a number!" );
		
		return false;	
	
	}	
	
	szAmmoParam = szAmmoParam.tointeger ( );
	
	if ( szWeaponParam.tointeger ( ) > 11 || szWeaponParam.tointeger ( ) < 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 1 and 11!" );
		
		return false;	
	
	}
	
	if ( szAmmoParam.tointeger ( ) > 99999 || szAmmoParam.tointeger ( ) < 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The ammo must be between 1 and 99999!" );
		
		return false;	
	
	}	
	
	local pTarget = FindPlayer ( szTargetParam );
	
	SendPlayerSuccessMessage ( pPlayer , "You gave " + pTarget.Name + " a " + GetWeaponName ( szWeaponParam.tointeger ( ) ) + " with " + szAmmoParam.tointeger ( ) + " ammo." );
	SendPlayerAlertMessage ( pTarget , pTarget.Name + " has given you a " + GetWeaponName ( szWeaponParam.tointeger ( ) ) + " with " + szAmmoParam.tointeger ( ) + " ammo." );
	
	GivePlayerWeapon ( pTarget , szWeaponParam , szAmmoParam );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function CanPlayerSubmitStaffReport ( pPlayer ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function SaveServerDataCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	SendAdminMessageToAll ( "All server data is being saved. You might experience some lag!" );

	SaveServerDataToDatabase ( );
	
	SendAdminMessageToAll ( "All server data has been saved! The lag should be gone now!" );
	
	SendPlayerSuccessMessage ( pPlayer , "All server data has been saved!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SaveServerDataTimerFunction ( ) {

	// GivePaydayToAllPlayers ( );

	//SendAdminMessageToAll ( "All server data is being saved. You might experience some lag!" );

	SaveServerDataToDatabase ( );
	
	//SendAdminMessageToAll ( "All server data has been saved! The lag should be gone now!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TogglePlayerAdminDutyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
	
		SendPlayerCommandInfoMessage ( pPlayer , "Allows an admin to go on or off duty." , [ "AdminDuty" , "ADuty" , "AdministratorDuty" ] , "" );
		
		return false;
	
	}
	
	if ( IsPlayerOnAdminDuty ( pPlayer ) ) {
	
		GetPlayerData ( pPlayer ).iDuty = 0;
	
		TurnOffPlayerAdminDuty ( pPlayer );
		
		SendPlayerSuccessMessage ( pPlayer , "You are now OFF admin duty!" );
		
		return 
	
	} else {
	
		GetPlayerData ( pPlayer ).iDuty = 1;
	
		TurnOnPlayerAdminDuty ( pPlayer );
		
		SendPlayerSuccessMessage ( pPlayer , "You are now ON admin duty!" );
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TurnOnPlayerAdminDuty ( pPlayer ) {

	GetPlayerData ( pPlayer ).iDuty = 1;
	
	pPlayer.ColouredName = GetHexColour ( "Red" ) + pPlayer.Name;
	pPlayer.NametagColour = GetRGBColour ( "Red" );
	
	GetPlayerData ( pPlayer ).bDeveloperDuty = true;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TurnOffPlayerAdminDuty ( pPlayer ) {

	GetPlayerData ( pPlayer ).iDuty = 0;

	pPlayer.ColouredName = GetHexColour ( "White" ) + pPlayer.Name;
	pPlayer.NametagColour = GetRGBColour ( "White" );
	
	GetPlayerData ( pPlayer ).bDeveloperDuty = false;
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerBlockWeaponsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Prevents player from using weapons" , [ "BlockWeapons" , "BlockWep" ] , "This will clear their current weapons." );

		return false;

	}

	local szTargetParam = false;
	local pTarget = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	if ( CanPlayerUseWeapons ( pPlayer ) ) {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags | GetModerationFlagValue ( "BlockGuns" );
	
		SendPlayerSuccessMessage ( pPlayer , "You blocked " + pPlayer.Name + " from using any weapons!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has blocked you from using any weapons!" );
		
		pPlayer.ClearWeapons ( );
		
	} else {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags & ~GetModerationFlagValue ( "BlockGuns" );
	
		SendPlayerSuccessMessage ( pPlayer , "You allowed " + pPlayer.Name + " to use weapons!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has allowed you to use weapons!" );	
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerBlockAllJobsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Prevents player from using any jobs" , [ "BlockJobs" , "BlockAllJobs" ] , "This will clear their current weapons." );

		return false;

	}

	local szTargetParam = false;
	local pTarget = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	if ( CanPlayerUseJobs ( pPlayer ) ) {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags | GetModerationFlagValue ( "BlockJobs" );
	
		SendPlayerSuccessMessage ( pPlayer , "You blocked " + pPlayer.Name + " from using any jobs!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has blocked you from using any jobs!" );
		
		PlayerStopWorkCommand ( pPlayer , "StopWork" , "" , false );
		
	} else {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags & ~GetModerationFlagValue ( "BlockJobs" );
	
		SendPlayerSuccessMessage ( pPlayer , "You allowed " + pPlayer.Name + " to use jobs!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has allowed you to use jobs!" );	
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerBlockAmmunationsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if( bShowHelpOnly ) {

		SendPlayerCommandInfoMessage ( pPlayer , "Prevents player from using any ammunations" , [ "BlockAmmu" , "BlockAmmunation" , "BlockAmmunations" ] , "" );

		return false;

	}

	local szTargetParam = false;
	local pTarget = false;
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	szTargetParam = GetTok ( szParams , " " , 1 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	if ( CanPlayerUseAmmunations ( pPlayer ) ) {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags | GetModerationFlagValue ( "BlockAmmunation" );
	
		SendPlayerSuccessMessage ( pPlayer , "You blocked " + pPlayer.Name + " from using any ammunations!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has blocked you from using any ammunations!" );
		
	} else {
	
		GetPlayerData ( pPlayer ).iModerationFlags = GetPlayerData ( pPlayer ).iModerationFlags & ~GetModerationFlagValue ( "BlockAmmunation" );
	
		SendPlayerSuccessMessage ( pPlayer , "You allowed " + pPlayer.Name + " to use ammunations!" );
		SendPlayerAlertMessage ( pTarget , "An administrator has allowed you to use ammunations!" );	
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ToggleGTAVSpawnCamCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( bShowHelpOnly ) {
		
		return true;
		
	}
	
	if ( GetUtilityConfiguration ( ).pGTASpawnCam.Enabled ) {
		
		GetUtilityConfiguration ( ).pGTASpawnCam.Enabled = false;
		
		WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bUseGTAVSpawnCam" , false );
		
		Message ( pPlayer.Name + " has disabled the GTA V spawn camera" , GetRGBColour ( "Orange" ) );
		
		return true;
		
	} else {
		
		GetUtilityConfiguration ( ).pGTASpawnCam.Enabled = true;
		
		WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bUseGTAVSpawnCam" , true );
		
		Message ( pPlayer.Name + " has enabled the GTA V spawn camera" , GetRGBColour ( "Orange" ) );
		
	}
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Moderation]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------