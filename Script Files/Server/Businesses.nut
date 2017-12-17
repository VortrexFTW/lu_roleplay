
// NAME: Business.nut
// DESC: Adds and manages business commands and services.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitBusinessScript ( ) {

	GetCoreTable ( ).Businesses = ::LoadBusinessesFromDatabase ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddBusinessCommandHandlers ( ) {

	AddCommandHandler ( "Buy" 					, BuyFromBusinessCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "AddBiz" 				, CreateBusinessCommand 				, GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "DelBiz" 				, DeleteBusinessCommand 				, GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "SetBizOwner" 			, SetBusinessOwnerCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "SetBizName" 			, SetBusinessNameCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "LockBiz" 				, LockBusinessCommand 					, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "UnlockBiz" 			, UnlockBusinessCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "GiveBizFlag" 			, GiveBusinessFlagCommand 				, GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "TakeBizFlag" 			, TakeBusinessFlagCommand 				, GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "GiveBizSellFlag" 		, GiveBusinessSellFlagCommand 			, GetStaffFlagValue ( "ManageBusinesses" ) );
	AddCommandHandler ( "TakeBizSellFlag" 		, TakeBusinessSellFlagCommand 			, GetStaffFlagValue ( "ManageBusinesses" ) );

}

// -------------------------------------------------------------------------------------------------

function SaveAllBusinessesToDatabase ( ) {

	foreach ( ii , iv in GetCoreTable ( ).Businesses ) {
	
		SaveBusinessToDatabase ( iv );
	
	}

	return true;

}

function SaveBusinessToDatabase ( pBusinessData ) {

	local pDatabaseConnection = ::ConnectToMySQL ( );
	
	if ( !pDatabaseConnection ) {
	
		return false;
	
	}
	
	local szQueryString = "UPDATE `biz_main` SET `biz_id`="+pBusinessData.iDatabaseID+",`biz_name`='"+pBusinessData.szName+"',`biz_owner_type`="+pBusinessData.iOwnerType+",biz_owner_id="+pBusinessData.iOwnerID+",`biz_locked`="+::BoolToInteger(pBusinessData.bLocked)+",`biz_pos_x`="+pBusinessData.pPosition.x+",biz_pos_y="+pBusinessData.pPosition.y+",`biz_pos_z`="+pBusinessData.pPosition.z+",`biz_buy_price`="+pBusinessData.iBuyPrice+" WHERE `biz_id`="+pBusinessData.iDatabaseID;

	local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CreateBusinessPickups ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyFromBusinessPickups ( ) {	

	return true;

}

// -------------------------------------------------------------------------------------------------

function CreateBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Creates a new business" , [ "CreateBiz" , "AddBiz" ] , "Must be accepted by an admin." );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function DeleteBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Deletes a business" , [ "DeleteBiz" , "DelBiz" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyFromBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Buys an item from a business" , [ "Buy" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetBusinessOwnerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Changes the owner of a business" , [ "BizOwner" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetBusinessNameCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Changes the name of a business" , [ "BizName" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function LockBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Locks a business" , [ "LockBiz" ] , "Players can't buy from a locked business." );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function UnlockBusinessCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Unlocks a business" , [ "UnlockBiz" ] , "" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GiveBusinessFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Gives a business a business flag" , [ "GiveBizFlag" ] , "For a list, use /bizflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TakeBusinessFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Takes a business flag from a business" , [ "TakeBizFlag" ] , "For a list, use /bizflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GiveBusinessSellFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Gives a business a business sell flag" , [ "GiveBizSellFlag" ] , "For a list, use /bizsellflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function TakeBusinessSellFlagCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Takes a business sell flag from a business" , [ "TakeBizSellFlag" ] , "For a list, use /bizsellflags" );
		
		return false;
	
	}
	
	SendPlayerErrorMessage ( pPlayer , "Command coming soon!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function LoadBusinessesFromDatabase ( ) {

	local pDatabaseConnection = ::ConnectToMySQL ( );
	local pAssocResult = false;
	local pBusinessData = false;
	local pBusinesses = [ ];
		
	local pQuery = ::ExecuteMySQLQuery ( ::ConnectToMySQL ( ) , "SELECT * FROM `biz_main`" );

	if ( pQuery ) {
	
		while ( pAssocResult = ::GetMySQLAssocResult ( pQuery ) ) {
		
			pBusinessData = ::GetCoreTable ( ).Classes.BusinessData ( pAssocResult );
			
			pBusinesses.push ( pBusinessData );
			
			print ( "[Server.Database]: Business database ID " + pBusinessData.iDatabaseID + " loaded (" + pBusinessData.szName + ")" );			
		
		}
	
	}
			
	::DisconnectFromMySQL ( pDatabaseConnection );
	
	EchoIRCConsoleDebug ( pBusinesses.len ( ) + " businesses loaded from the database!" );
	
	return pBusinesses;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Business]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------