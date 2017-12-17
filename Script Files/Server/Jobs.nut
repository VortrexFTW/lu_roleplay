// -------------------------------------------------------------------------------------------------

function InitJobsScript ( ) {

    CreateJobPickupsAndBlips ( );
    AddJobCommandHandlers ( );

}

// -------------------------------------------------------------------------------------------------s
 
function AddJobCommandHandlers ( ) {

    AddCommandHandler ( "TakeJob" , TakeJobCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "StartWork" , StartWorkCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "StopWork" , StopWorkCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "QuitJob" , QuitJobCommand , GetStaffFlagValue ( "None" ) );

    return true;

}

// -------------------------------------------------------------------------------------------------

function ShowJobInformationToPlayer ( pPlayer , iJobID ) {
    
    if ( !CanPlayerUseJobs ( pPlayer ) ) {
        
        return false;
        
    }
    
    if ( GetPlayerData ( pPlayer ).iJob == -1 ) {
    
        SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "EnteredJobSiteUnemployed" ) , GetCoreTable ( ).Jobs [ iJobID ].szName ) );
        
        return false;
    
    }
    
    if ( GetPlayerData ( pPlayer ).iJob == iJobID ) {
        
        SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "EnteredJobSiteThisJob" ) , GetCoreTable ( ).Jobs [ iJobID ].szName ) );
        
        return false;
    
    }
    
    if ( GetPlayerData ( pPlayer ).iJob != iJobID ) {
        
        local iPlayersJobID = GetPlayerData ( pPlayer ).iJob;
        
        SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "EnteredJobSiteOtherJob" ) , GetCoreTable ( ).Jobs [ iJobID ].szName , GetCoreTable ( ).Jobs [ iPlayersJobID ].szName ) );
        
        return false;
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateJobPickupsAndBlips ( ) {

    local pPickup = false;
    
    foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
        
        pPickup = CreatePickup ( iv.iPickupModel , iv.pPosition );
    
        if ( pPickup ) {
            
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType = GetCoreTable ( ).Utilities.pPickupDataType.Job;
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID = ii;
        
        }
        
        print ( "[Server.Jobs]: Created Job Pickup (PickupID: " + pPickup.ID + ", JobID: " + ii + ")" );    
        
        iv.pPickup = pPickup;
        iv.pMapBlip = CreateBlip ( BLIP_NONE , iv.pPosition );
        iv.pMapBlip.Size = 1;
        iv.pMapBlip.DisplayType = BLIPTYPE_BLIPONLY;
        iv.pMapBlip.Colour = 1;
        
        pPickup = false;
    
    }
    
    print ( "[Server.Jobs]: Job blips and pickups created" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function TakeJobCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescTakeJob" ) , [ "TakeJob" ] , "" );
        
        return false;
    
    }   
    
    if ( !CanPlayerUseJobs ( pPlayer ) ) {
        
        SendPlayerErrorMessage ( pPlayer , "You cannot use any jobs!" );
        
        return false;
        
    }       
    
    foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
        
        if ( GetDistance ( pPlayer.Pos , iv.pPosition ) <= GetCoreTable ( ).Utilities.fTakeJobRange ) {
            
            if ( !iv.bEnabled ) {
                
                SendPlayerErrorMessage ( pPlayer , "This job is disabled!" );
                
                return false;
                
            }
            
            SetPlayerJob ( pPlayer , ii );
            
            SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "TakeJobSuccessful" ) , iv.szName ) );
            SendPlayerAlertMessage ( pPlayer , "Use '/help job' for information and commands" );
            
            return true;
            
        }
        
    }
    
    SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NotNearJobSite" ) );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function QuitJobCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Quits your job" , [ "QuitJob" ] , "" );
        
        return false;
    
    }
    
    if ( !CanPlayerUseJobs ( pPlayer ) ) {
        
        SendPlayerErrorMessage ( pPlayer , "You cannot use any jobs!" );
        
        return false;
        
    }
    
    SetPlayerJob ( pPlayer , -1 );
    
    if ( GetPlayerData ( pPlayer ).bIsWorking ) {
    
        pPlayer.Skin = GetPlayerData ( pPlayer ).iSkin;
                
        pPlayer.Colour = 0;
                
        GetPlayerData ( pPlayer ).bIsWorking = false;
    
    }
        
    SendPlayerSuccessMessage ( pPlayer ,"You have quit your job" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function StartWorkCommand ( pPlayer , szCommand , szParams, bShowHelpOnly = false ) {
    
    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescStartWork" ) , [ "StartWork" ] , "" );
        
        return false;
    
    }
    
    local pPlayerData = GetPlayerData ( pPlayer );  
    
    if ( !CanPlayerUseJobs ( pPlayer ) ) {
        
        SendPlayerErrorMessage ( pPlayer , "You cannot use any jobs!" );
        
        return false;
        
    }
    
    if ( GetPlayerData ( pPlayer ).iJob == -1 ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CantWorkUnemployed" ) );
    
    }
    
    local iJobID = GetPlayerData ( pPlayer ).iJob;
    
    foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
        
        if ( iv.iJobType == GetJobTypeFromJobID ( iJobID ) ) {
        
            if ( GetDistance ( pPlayer.Pos , iv.pPosition ) <= GetCoreTable ( ).Utilities.fTakeJobRange ) {
                
                pPlayer.Skin = GetCoreTable ( ).Jobs [ iJobID ].iJobSkin;
                
                pPlayer.Colour = GetCoreTable ( ).Jobs [ iJobID ].iJobColour;
                
                pPlayerData.bIsWorking = true;
                
                SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "StartedWorking" ) );
                
                if ( iv.iJobType == GetJobTypeID ( "Police" ) ) {
                
                    pPlayerData.iHealth = pPlayer.Health;
                    pPlayerData.iArmour = pPlayer.Armour;
                
                    pPlayer.ClearWeapons ( );
                    pPlayer.SetWeapon ( 2 , 200 );
                    pPlayer.SetWeapon ( 4 , 15 );
                    pPlayer.Health = 100;
                    pPlayer.Armour = 100;
                
                }
                
                return true;
                
            } else {
            
                SendPlayerErrorMessage ( pPlayer , "You need to be near your job icon!" );
            
            }
        
        }
        
    }

}

// -------------------------------------------------------------------------------------------------

function StopWorkCommand ( pPlayer , szCommand , szParams, bShowHelpOnly = false ) {
    
    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescStopWork" ) , [ "StopWork" ] , "" );
        
        return false;
    
    }
    
    local pPlayerData = GetPlayerData ( pPlayer );      
    
    if ( !CanPlayerUseJobs ( pPlayer ) ) {
        
        SendPlayerErrorMessage ( pPlayer , "You cannot use any jobs!" );
        
        return false;
        
    }   

    if ( !GetPlayerData ( pPlayer ).bIsWorking ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are not working!" );
        
        return true;
        
    }
    
    
    
    pPlayer.Skin = GetPlayerData ( pPlayer ).iSkin;
    
    pPlayer.Colour = 0;
    
    pPlayerData.bIsWorking = false;
    
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "StoppedWorking" ) );
    
    if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetJobTypeID ( "Police" ) ) {
    
        pPlayer.ClearWeapons ( );
        
        RestorePlayerSavedWeapons ( pPlayer );
    
    }
    
    if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetJobTypeID ( "Fire" ) ) {
    
        PlayFireMissionFailed ( pPlayer );
    
    }
    
    if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetJobTypeID ( "Garbage" ) ) {
    
        EndGarbageRoute ( pPlayer );
    
    }   
    
    if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetJobTypeID ( "Bus" ) ) {
    
        EndBusRoute ( pPlayer );
    
    }       
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerJob ( pPlayer , iJobID ) {

    GetPlayerData ( pPlayer ).iJob = iJobID;

    return true;

}

// -------------------------------------------------------------------------------------------------

function GetJobTypeFromJobID ( iJobID ) {

    return GetCoreTable ( ).Jobs [ iJobID ].iJobType;

}

// -------------------------------------------------------------------------------------------------

function GetJobTypeID ( szJobTypeName ) {

    return GetUtilityConfiguration ( ).pJobs [ szJobTypeName ];

}

// -------------------------------------------------------------------------------------------------

function GetJobData ( iJobID , szDataKey = false ) {

    if ( iJobID >= 0 && iJobID < GetCoreTable ( ).Jobs.len ( ) ) {
    
        if ( szDataKey == false ) {
        
            GetCoreTable ( ).Jobs [ iJobID ];
            
        } else {
        
            GetCoreTable ( ).Jobs [ iJobID ] [ szDataKey ];
        
        }
    
    }

    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerJobVehicleTimeout ( pPlayer ) {
    
    if ( GetJobTypeFromJobID ( GetPlayerData ( pPlayer ).iJob ) == GetJobTypeID ( "Fire" ) ) {
    
        if ( !pPlayer.Vehicle ) {
        
            PlayerFireMissionFailed ( pPlayer );
            
            return true;
        
        }
            
        if ( pPlayer.Vehicle.Model != 97 ) {
        
            PlayerFireMissionFailed ( pPlayer );
            
            return true;
        
        }
        
    }

}

// -------------------------------------------------------------------------------------------------

function CanPlayerUseJobs ( pPlayer ) {
    
    if ( !HasBitFlag ( GetPlayerData ( pPlayer , "iModerationFlags" ) , GetModerationFlagValue ( "BlockJobs" ) ) ) {
    
        return true;
    
    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function IsValidJobID ( iJobID ) {

    if ( GetJobData ( iJobID ) != false ) {
    
        return true;
    
    }

    return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------