// -------------------------------------------------------------------------------------------------

function InitVehicleHydraulicsScript ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function UseHydraulicsUp ( pPlayer ) {

    if ( pPlayer.Vehicle ) {
	
		if ( pPlayer.VehicleSeat == SEAT_DRIVER ) {
    
			if ( GetVehicleData ( pPlayer.Vehicle ).bHydraulics ) {
		
				pPlayer.Vehicle.SetHandlingData ( HANDLING_SUSPENSIONFORCELEVEL , 3.5 );
				
			}
		
		}
    
    }

}

// -------------------------------------------------------------------------------------------------

function UseHydraulicsDown ( pPlayer ) {

    if ( pPlayer.Vehicle ) {
	
		if ( pPlayer.VehicleSeat == SEAT_DRIVER ) {
    
			if ( GetVehicleData ( pPlayer.Vehicle ).bHydraulics ) {
		
				pPlayer.Vehicle.SetHandlingData ( HANDLING_SUSPENSIONFORCELEVEL , 0.65 );
				
			}
			
		}
    
    }

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.VehicleHydraulics]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------