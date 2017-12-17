// STYLED AFTER SINGLEPLAYER GTA FIREFIGHTER MISSIONS


// -------------------------------------------------------------------------------------------------

function InitFireJobScript ( ) {

    AddFireJobCommandHandlers ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddFireJobCommandHandlers ( ) {
    
    return true;
    
}


// -------------------------------------------------------------------------------------------------

function GetRandomFireMission ( ) {

    return Random ( 0 , GetCoreTable ( ).Locations.FireJobVehicles.len ( ) );

}

// -------------------------------------------------------------------------------------------------

function GetRandomInactiveFireMission ( iIsland ) {

    local iFireMissionID = GetRandomFireMission ( );

    while ( IsFireJobMissionActive ( iFireMissionID ) || GetIsland ( GetFireMissionData ( iFireMissionID ).pPosition ) != iIsland ) {
    
        iFireMissionID = GetRandomFireMission ( );
    
    }
    
    return iFireMissionID;
    
}

// -------------------------------------------------------------------------------------------------

function CreateFireJobBurningVehicle ( iFireJobID ) {

    local pVehicle = CreateNewVehicle ( GetFireJobRandomVehicleModel ( ) , GetCoreTable ( ).Locations.FireJobVehicles [ iFireJobID ].pPosition , Random ( 0 , 359 ) );
    
    pVehicle.Locked = true;
    pVehicle.SetEngineState ( false );
    
    GetVehicleData ( pVehicle ).bTempVehicle = true;

    return true;

}

// -------------------------------------------------------------------------------------------------

function IsFireJobMissionActive ( iFireJobID ) {

    return GetCoreTable ( ).Locations.FireJobVehicles [ iFireJobID ].bActive;

}

// -------------------------------------------------------------------------------------------------

function GetFireMissionData ( iFireMissionID ) {

    return GetCoreTable ( ).Locations.FireJobVehicles [ iFireMissionID ];

}

// -------------------------------------------------------------------------------------------------

function IsFiretruckAimingAtVehicle ( pFiretruck , pVehicle ) {

    local fDistanceToVehicle = GetDistance ( pFiretruck.Pos , pVehicle.Pos );
    local pFrontOfFiretruck = GetVectorInFrontOfVector ( pFiretruck.Pos , pFiretruck.Angle , fDistanceToVehicle );
    
    if ( fDistanceToVehicle > 40.0 ) {
    
        return false;
    
    }
    
    if ( GetDistance ( pFrontOfFiretruck , pVehicle.Pos ) < 5.0 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function AttemptVehicleFireExtinguish ( pPlayer ) {
    
    if ( GetPlayerData ( pPlayer ).iFireMission == -1 ) {
    
        return true;
    
    }

    if ( IsFiretruckAimingAtVehicle ( pPlayer.Vehicle , GetFireMissionData ( GetPlayerData ( pPlayer ).iFireMission ).pVehicle ) ) {
    
        RemoveFireMissionVehicle ( GetPlayerData ( pPlayer ).iFireMission );
                
        GetFireMissionData ( GetPlayerData ( pPlayer ).iFireMission ).pBlip.Remove ( );
    
        NewTimer ( "ActivateRandomFireMission" , 5000 , 1 , pPlayer );

        GivePlayerCash ( pPlayer , 100 );
    
        GetPlayerData ( pPlayer ).iFireMission = -1;
    
    }

} 

// -------------------------------------------------------------------------------------------------

function PlayerFireMissionSuccessful ( pPlayer ) {
    
    GetFireMissionData ( GetPlayerData ( pPlayer ).iFireMission ).pBlip.Remove ( );
    
    SmallMessage ( pPlayer , "You got $100 for putting out the fire" , 5000 , 0 );
    
    NewTimer ( "ActivateRandomFireMission" , 7000 , 1 , pPlayer );

    GivePlayerCash ( pPlayer , 100 );

}

// -------------------------------------------------------------------------------------------------

function RemoveFireMissionVehicle ( iFireMission ) {

    GetFireMissionData ( iFireMission ).bActive = false;
    GetFireMissionData ( iFireMission ).pVehicle.VirtualWorld = 3;
    
    local iVehicleDataID = GetCoreTable ( ).VehicleToData [ GetFireMissionData ( iFireMission ).pVehicle.ID ];
    GetCoreTable ( ).VehicleToData [ GetFireMissionData ( iFireMission ).pVehicle.ID ] = false;
    GetCoreTable ( ).Vehicles [ iVehicleDataID ].pVehicle = false;
    
    GetFireMissionData ( iFireMission ).pVehicle.Remove ( );

}

// -------------------------------------------------------------------------------------------------

function GetRandomFireMissionVehicleModel ( ) {

    local pTempVehicles = [ VEH_LANDSTALKER , VEH_IDAHO , VEH_PERENIAL , VEH_SENTINEL , VEH_MANANA , VEH_BLISTA , VEH_PONY , VEH_MOONBEAM , VEH_ESPERANTO , VEH_KURUMA , VEH_BOBCAT , VEH_STALLION , VEH_RUMPO ];
    
    return pTempVehicles [ Random ( 0 , pTempVehicles.len ( ) ) ];

}

// -------------------------------------------------------------------------------------------------

function ActivateRandomFireMission ( pPlayer ) {

    local iFireMission = GetRandomInactiveFireMission ( GetIsland ( pPlayer.Pos ) );
    
    local iTestModel = GetRandomFireMissionVehicleModel ( );
    local pTestPosition = GetFireMissionData ( iFireMission ).pPosition;
    local iTestAngle = Random ( 0 , 359 );
    local pTestColour = Colour ( Random ( 0 , 255 ) , Random ( 0 , 255 ) , Random ( 0 , 255 ) );

    local pTestVehicle = CreateNewVehicle ( iTestModel , pTestPosition , iTestAngle , pTestColour , pTestColour );
    
    if ( pTestVehicle ) {
    
        pTestVehicle.Locked = true;
        pTestVehicle.SetEngineState ( false );
        
        GetVehicleData ( pTestVehicle ).bTempVehicle = true;
        
        GetFireMissionData ( iFireMission ).bActive = true;
        GetFireMissionData ( iFireMission ).pVehicle = pTestVehicle;
        GetFireMissionData ( iFireMission ).pBlip = CreateClientBlip ( pPlayer , 0 , pTestPosition );
        GetFireMissionData ( iFireMission ).pBlip.Size = 4;
        GetFireMissionData ( iFireMission ).pBlip.Colour = 8;
        
        SmallMessage ( pPlayer , "A vehicle fire has been reported at ~r~" + GetDistrictName ( pTestPosition.x , pTestPosition.y ) , 6000 , 0 );
        
        GetPlayerData ( pPlayer ).iFireMission = iFireMission;
    
    } else {
    
        SendPlayerAlertMessage ( pPlayer , "There are no firefighter missions for you to do! Try again later!" );
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function FireJobTimerFunction ( ) {

    foreach ( ii , iv in GetCoreTable ( ).Locations.FireJobVehicles ) {
    
        if ( iv.bActive ) {
        
            iv.pVehicle.Health = 250;
        
        }
    
    }

}

// -------------------------------------------------------------------------------------------------

function PlayerFireMissionFailed ( pPlayer ) {

    SmallMessage ( pPlayer , "You failed to extinguish the fire!" , 5000 , 0 );

    if ( GetPlayerData ( pPlayer ).iFireMission == -1 ) {
    
        return false;
    
    }

    GetFireMissionData ( GetPlayerData ( pPlayer ).iFireMission ).pBlip.Remove ( );
    
    RemoveFireMissionVehicle ( GetPlayerData ( pPlayer ).iFireMission );
    
    GetPlayerData ( pPlayer ).iFireMission = -1;
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerFirefighter ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( DoesPlayerHaveAJob ( pPlayer ) ) {
    
        if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Fire ) {
        
            return true;
        
        }
        
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Fire]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------