// -------------------------------------------------------------------------------------------------

function InitGarbageJobScript ( ) {

    AddGarbageJobCommandHandlers ( );

    return true;

}

// -------------------------------------------------------------------------------------------------

function AddGarbageJobCommandHandlers ( ) {
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function EnteredGarbageRouteMarker ( pPlayer , pSphere ) {

    pPlayer.Frozen = true;
    pPlayer.Vehicle.Velocity = Vector ( 0.0 , 0.0 , 0.0 );
    
    SmallMessage ( pPlayer , "Please wait a moment, while the trash is loaded" , 5000 , 0 );
    
    NewTimer ( "GarbageRouteProceed" , 5000 , 1 , pPlayer );

}

// -------------------------------------------------------------------------------------------------

function GetRandomGarbageRoute ( iIsland ) {
    
    local pGarbageRoutes = GetCoreTable ( ).Locations.GarbageRoutes;
    local iGarbageRoute = Random ( 0 , pGarbageRoutes.len ( ) );
    
    while ( GetGarbageRouteData ( iGarbageRoute ).iIsland != iIsland ) {
        
        iGarbageRoute = Random ( 0 , pGarbageRoutes.len ( ) );
        
    }

    return iGarbageRoute;

}

// -------------------------------------------------------------------------------------------------

function ActivateRandomGarbageRoute ( pPlayer ) {
    
    local pPlayerData = GetPlayerData ( pPlayer );
    local iGarbageRoute = GetRandomGarbageRoute ( pPlayer.Island );
    
    pPlayerData.iGarbageRoute = iGarbageRoute;
    pPlayerData.iGarbageRouteStart = time ( );
    pPlayerData.iGarbageRouteNextStop = 0;
    pPlayerData.iGarbageRouteLastStopTime = 0;
    
    pPlayerData.pJobBlip = CreateClientBlip ( pPlayer , 0 , GetGarbageRouteStopData ( pPlayerData.iGarbageRoute , pPlayerData.iGarbageRouteNextStop ) );
    pPlayerData.pJobBlip.Size = 4;
    pPlayerData.pJobBlip.Colour = 8;
        
    pPlayerData.pJobSphere = CreateClientSphere ( GetGarbageRouteStopData ( pPlayerData.iGarbageRoute , pPlayerData.iGarbageRouteNextStop ) , 3 , GetRGBColour ( "MediumGrey" ) , pPlayer );
    pPlayerData.pJobSphere.Type =  MARKER_TYPE_VEHICLE;
    
    SmallMessage ( pPlayer , "Garbage Route: " + GetGarbageRouteData ( iGarbageRoute ).szName + ". Proceed to the checkpoint" , 5000 , 0 );
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function GarbageRouteProceed ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( pPlayerData.iGarbageRouteNextStop < GetCoreTable ( ).Locations.GarbageRoutes [ pPlayerData.iGarbageRoute ].pPositions.len ( ) - 1 ) {
    
        pPlayerData.iGarbageRouteNextStop++;
        GivePlayerCash ( pPlayer , 250 );
        
        pPlayerData.pJobBlip.Pos = GetCoreTable ( ).Locations.GarbageRoutes [ pPlayerData.iGarbageRoute ].pPositions [ pPlayerData.iGarbageRouteNextStop ];
        pPlayerData.pJobSphere.Pos = GetCoreTable ( ).Locations.GarbageRoutes [ pPlayerData.iGarbageRoute ].pPositions [ pPlayerData.iGarbageRouteNextStop ];
        
        pPlayer.Frozen = false;
        
        SmallMessage ( pPlayer , "Proceed to the next checkpoint." , 5000 , 0 );
    
    } else {
    
    
        pPlayerData.iGarbageRoute = -1;
        pPlayerData.iGarbageRouteNextStop = -1;
        
        pPlayer.Vehicle.Respawn ( );
        pPlayerData.pJobBlip.Remove ( );
        pPlayerData.pJobSphere.Remove ( );
        pPlayer.Frozen = false;
        
        SmallMessage ( pPlayer , "You have reached the end of the garbage route" , 5000 , 0 );
        
    }

}

// -------------------------------------------------------------------------------------------------

function IsPlayerGarbageCollector ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( DoesPlayerHaveAJob ( pPlayer ) ) {
    
        if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Garbage ) {
        
            return true;
        
        }
        
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetGarbageRouteStopData ( iGarbageRoute , iGarbageRouteStop ) {
    
    return GetCoreTable ( ).Locations.GarbageRoutes [ iGarbageRoute ] .pPositions [ iGarbageRouteStop ];
    
}

// -------------------------------------------------------------------------------------------------

function GetGarbageRouteData ( iGarbageRoute ) {
    
    return GetCoreTable ( ).Locations.GarbageRoutes [ iGarbageRoute ];
    
}

// -------------------------------------------------------------------------------------------------

function EndGarbageRoute ( pPlayer ) {

    if ( pPlayer.Vehicle ) {
        
        pPlayer.Vehicle.Respawn ( );
        
    }
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    pPlayerData.pJobBlip.Remove ( );
    pPlayerData.pJobSphere.Remove ( );
    
    pPlayerData.iGarbageRoute = -1;
    pPlayerData.iGarbageRouteNextStop = -1; 
    
    pPlayer.Frozen = false;
    
    SmallMessage ( pPlayer , "You have ended the garbage route" , 5000 , 0 );   

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Garbage]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------