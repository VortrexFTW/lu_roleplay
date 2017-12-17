// STYLED AFTER SINGLEPLAYER GTA PARAMEDIC MISSIONS

// -------------------------------------------------------------------------------------------------

function InitMedicJobScript ( ) {

	AddMedicJobCommandHandlers ( );
	
	print ( "[Server.Jobs.Medic]: Script init complete." );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AddMedicJobCommandHandlers ( ) {
	
	print ( "[Server.Jobs.Medic]: Command handlers added." );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetRandomMedicMissionPos ( ) {

	return false;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerMedic ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveAJob ( pPlayer ) ) {
	
		if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Medic ) {
		
			return true;
		
		}
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Medic]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------