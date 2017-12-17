// -------------------------------------------------------------------------------------------------

function InitVehicleSpeedLimiterScript ( ) {

	AddVehicleSpeedLimiterCommandHandlers ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddVehicleSpeedLimiterCommandHandlers ( ) {

	AddCommandHandler ( "Speed" , VehicleSpeedLimiterCommand , GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "SpeedLimit" , VehicleSpeedLimiterCommand , GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "SpeedLimiter" , VehicleSpeedLimiterCommand , GetStaffFlagValue ( "None" ) );

}

// -------------------------------------------------------------------------------------------------

function VehicleSpeedLimiterCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns the vehicle speed limiter on or off" , [ "Speed" , "SpeedLimit" , "SpeedLimiter" ] , "" );
		
		return false;
	
	}

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be driving a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be driving a vehicle!" );
		
		return false;
	
	}
			
	if ( !IsVehicleSpeedLimiterEnabled ( pPlayer.Vehicle ) ) {

		SetVehicleSpeedLimiter ( pPlayer.Vehicle , true );
		
		SendPlayerSuccessMessage ( pPlayer , "Speed limiter has been turned on!" );
		//SendPlayerAlertMessage ( pPlayer , "This command also accepts a speed, use '/Help CMD Speed' for info." );
		
	} else {
	
		SetVehicleSpeedLimiter ( pPlayer.Vehicle , false );
		
		SendPlayerSuccessMessage ( pPlayer , "Speed limiter has been turned off!" );
		//SendPlayerAlertMessage ( pPlayer , "This command also accepts a speed, use '/Help CMD Speed' for info." );
	
	}
		
	return true;	
		
}

// -------------------------------------------------------------------------------------------------

function SetVehicleSpeedLimiter ( pVehicle , bState ) {

	if ( bState ) {
		
		pVehicle.SetHandlingData ( 9 , 72.4 );
		
		GetVehicleData ( pVehicle ).bSpeedLimiter = true;
		
	} else {
	
		pVehicle.SetHandlingData ( 9 , GetVehicleHandlingData ( pVehicle.Model , 9 ) );
		
		GetVehicleData ( pVehicle ).bSpeedLimiter = false;
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function IsVehicleSpeedLimiterEnabled ( pVehicle ) {

	if ( GetVehicleData ( pVehicle ).bSpeedLimiter ) {
		
		return true;
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Extras.VehicleSpeedLimiter]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------