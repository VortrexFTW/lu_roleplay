// -------------------------------------------------------------------------------------------------

function InitDrugsJobScript ( ) {

	AddDrugsJobCommandHandlers ( );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AddDrugsJobCommandHandlers ( ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerDrugDealer ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveAJob ( pPlayer ) ) {
	
		if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Drug ) {
		
			return true;
		
		}
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Drugs]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------