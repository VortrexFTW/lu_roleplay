// -------------------------------------------------------------------------------------------------

function InitBusJobScript ( ) {

	AddBusJobCommandHandlers ( );

	return true;

}

// -------------------------------------------------------------------------------------------------

function AddBusJobCommandHandlers ( ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function EnteredBusRouteMarker ( pPlayer , pSphere ) {

	pPlayer.Frozen = true;
	pPlayer.Vehicle.Velocity = Vector ( 0.0 , 0.0 , 0.0 );
	
	SmallMessage ( pPlayer , "Please wait while passengers get on and off the bus." , 5000 , 0 );
	
	NewTimer ( "BusRouteProceed" , 5000 , 1 , pPlayer );

}

// -------------------------------------------------------------------------------------------------

function GetRandomBusRoute ( iIsland ) {
	
	local pBusRoutes = GetCoreTable ( ).Locations.BusRoutes;
	local iBusRoute = Random ( 0 , pBusRoutes.len ( ) );
	
	while ( GetBusRouteData ( iBusRoute ).iIsland != iIsland ) {
		
		iBusRoute = Random ( 0 , pBusRoutes.len ( ) );
		
	}

	return iBusRoute;

}

// -------------------------------------------------------------------------------------------------

function ActivateRandomBusRoute ( pPlayer ) {
	
	local pPlayerData = GetPlayerData ( pPlayer );
	local iBusRoute = GetRandomBusRoute ( pPlayer.Island );
	
	pPlayerData.iBusRoute = iBusRoute;
	pPlayerData.iBusRouteStart = time ( );
	pPlayerData.iBusRouteNextStop = 0;
	pPlayerData.iBusRouteLastStopTime = 0;
	
	pPlayerData.pJobBlip = CreateClientBlip ( pPlayer , 0 , GetBusRouteStopData ( pPlayerData.iBusRoute , pPlayerData.iBusRouteNextStop ) );
	pPlayerData.pJobBlip.Size = 4;
	pPlayerData.pJobBlip.Colour = 8;
	
	GetVehicleData ( pPlayer.Vehicle ).pColour1 = GetBusRouteData ( iBusRoute ).pBusColour;
		
	pPlayerData.pJobSphere = CreateClientSphere ( GetBusRouteStopData ( pPlayerData.iBusRoute , pPlayerData.iBusRouteNextStop ) , 3 , Colour ( 144 , 192 , 72 ) , pPlayer );
	pPlayerData.pJobSphere.Type =  MARKER_TYPE_VEHICLE;
	
	SmallMessage ( pPlayer , "Bus Route: " + GetBusRouteData ( iBusRoute ).szName + ". Proceed to the checkpoint" , 5000 , 0 );
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function BusRouteProceed ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	if ( pPlayerData.iBusRouteNextStop < GetCoreTable ( ).Locations.BusRoutes [ pPlayerData.iBusRoute ].pPositions.len ( ) - 1 ) {
	
		pPlayerData.iBusRouteNextStop++;
		GivePlayerCash ( pPlayer , 250 );
		
		pPlayerData.pJobBlip.Pos = GetCoreTable ( ).Locations.BusRoutes [ pPlayerData.iBusRoute ].pPositions [ pPlayerData.iBusRouteNextStop ];
		pPlayerData.pJobSphere.Pos = GetCoreTable ( ).Locations.BusRoutes [ pPlayerData.iBusRoute ].pPositions [ pPlayerData.iBusRouteNextStop ];
		
		pPlayer.Frozen = false;
		
		SmallMessage ( pPlayer , "Proceed to the next stop." , 5000 , 0 );
	
	} else {
	
	
		pPlayerData.iBusRoute = -1;
		pPlayerData.iBusRouteNextStop = -1;
		
		pPlayer.Vehicle.Respawn ( );
		pPlayerData.pJobBlip.Remove ( );
		pPlayerData.pJobSphere.Remove ( );
		pPlayer.Frozen = false;
		
		SmallMessage ( pPlayer , "You have reached the end of the bus route" , 5000 , 0 );
		
	}

}

// -------------------------------------------------------------------------------------------------

function IsPlayerBusDriver ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveAJob ( pPlayer ) ) {
	
		if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Bus ) {
		
			return true;
		
		}
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function GetBusRouteStopData ( iBusRoute , iBusRouteStop ) {
	
	return GetCoreTable ( ).Locations.BusRoutes [ iBusRoute ] .pPositions [ iBusRouteStop ];
	
}

// -------------------------------------------------------------------------------------------------

function GetBusRouteData ( iBusRoute ) {
	
	return GetCoreTable ( ).Locations.BusRoutes [ iBusRoute ];
	
}

// -------------------------------------------------------------------------------------------------

function EndBusRoute ( pPlayer ) {

	if ( pPlayer.Vehicle ) {
		
		pPlayer.Vehicle.Respawn ( );
		
	}
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	pPlayerData.pJobBlip.Remove ( );
	pPlayerData.pJobSphere.Remove ( );
	
	pPlayerData.iBusRoute = -1;
	pPlayerData.iBusRouteNextStop = -1;	
	
	pPlayer.Frozen = false;
	
	SmallMessage ( pPlayer , "You have ended the bus route" , 5000 , 0 );	

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Bus]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------