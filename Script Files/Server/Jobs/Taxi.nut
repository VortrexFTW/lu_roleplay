// -------------------------------------------------------------------------------------------------

function InitTaxiJobScript ( ) {

	AddTaxiJobCommandHandlers ( );
	
	print ( "[Server.Jobs.Taxi]: Script init complete." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AddTaxiJobCommandHandlers ( ) {
	
	print ( "[Server.Jobs.Taxi]: Command handlers added." );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerTaxiDriver ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveAJob ( pPlayer ) ) {
	
		if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Taxi ) {
		
			return true;
		
		}
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Taxi]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------