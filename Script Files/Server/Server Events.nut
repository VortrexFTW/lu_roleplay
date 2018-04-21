
// NAME: Event Hooks.nut
// DESC: Adds and manages handlers for all built-in and custom server events.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function onScriptLoad ( ) {
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function onServerStart ( ) {

    KickAllConnectedPlayers ( );

    return;

}

// -------------------------------------------------------------------------------------------------

function onScriptUnload ( ) {

    print ( "- Script is unloading. Kicking all players" );
	
	
    
	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		ClearChat ( iv );
		
		SendPlayerAlertMessage ( iv , GetPlayerLocaleMessage ( iv , "ScriptReloadingReconnect" ) );
		
	}

    ForceAllPlayersToSpawnScreen ( );
    
    KickAllConnectedPlayers ( );
    
    SaveServerDataToDatabase ( );   
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerConnect ( pPlayer ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        ClientDateVerified [ pPlayer.ID ] = false;
        
    }
    
    GetCoreTable ( ).Players [ pPlayer.ID ] = false;
    
    print ( "- Player '" + pPlayer.Name + "' connected. (ID: " + pPlayer.ID + ", IP: " + pPlayer.IP + ", LUID " + pPlayer.LUID + ")" );
    
    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        if ( pPlayer.ID != iv.ID ) {
        
            if ( pPlayer.IP == iv.IP ) {
            
                KickPlayer ( pPlayer );
                
                return true;
            
            }
            
        }
        
    }
    
    IRCOnPlayerConnect ( pPlayer );
    
    pPlayer.ColouredName = "[#000000]" + pPlayer.Name;
    pPlayer.Colour = 6;
    //pPlayer.NametagColour = Colour ( 0 , 0 , 0 );
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   
    
    if ( pPlayer.Spawned ) {
    
        pPlayer.ForceToSpawnScreen ( );
    
    }
    
    EchoEventToIRC ( pPlayer.Name + " has connected to the server!" , true );
    EchoEventToDiscord ( pPlayer.Name + " has connected to the server!" , true );
    
    PlayerConnectionID [ pPlayer.ID ] = SaveConnectionToDatabase ( pPlayer );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") joined" );
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerPart ( pPlayer , iReason ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        if ( !ClientDateVerified [ pPlayer.ID ] ) {
            
            return false;
            
        }
        
    }
    
    if ( !GetCoreTable ( ).Players [ pPlayer.ID ] ) {
    
        return false;
    
    }
    
    if ( !GetPlayerData ( pPlayer ).bAuthenticated ) {
    
        if ( GetPlayerData ( pPlayer ).pLoginTimeout ) {
            
            GetPlayerData ( pPlayer ).pLoginTimeout.Delete ( );
        
        }
    
    }
    
    SavePlayerToDatabase ( pPlayer );
    
    UpdateConnectionDisconnectInfo ( PlayerConnectionID [ pPlayer.ID ] , time ( ) );
    
    //ResetRentedVehicle ( pPlayer );
    
    EchoEventToIRC ( pPlayer.Name + " has left the server! (" + GetCoreTable ( ).Utilities.szPartReasons [ iReason ] + ")" , true );
    EchoEventToDiscord ( pPlayer.Name + " has left the server! (" + GetCoreTable ( ).Utilities.szPartReasons [ iReason ] + ")" , true );    
    
    IRCOnPlayerPart ( pPlayer , iReason );
	
	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		
		MessagePlayer ( format ( GetPlayerLocaleMessage ( iv , "PlayerDisconnected" ) , pPlayer.Name , GetPlayerGroupedLocaleMessage ( iv , "PartReasons" , iReason ) ) , iv , GetRGBColour ( "White" ) );	
	
	}
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerDeath ( pPlayer , iReason ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }

    if ( GetPlayerData ( pPlayer ).bDeathMode ) {
    
        BanLUID ( pPlayer.LUID );
        BanIP ( pPlayer.IP );
        KickPlayer ( pPlayer );
        
        return true;
        
    }

    pPlayer.VirtualWorld = 2;
    GetPlayerData ( pPlayer ).bDeathMode = true;
    GetPlayerData ( pPlayer ).iDeathTime = time ( );

    //GetPlayerData ( pPlayer ).iDeaths++;
    GetPlayerData ( pPlayer ).bDead = true;
    
    GetPlayerData ( pPlayer ).pPosition = GetClosestHospital ( pPlayer.Pos );
    
    //print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") died. Reason: " + iReason );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerEnteringVehicle ( pPlayer , pVehicle , iSeatID ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    GetPlayerData ( pPlayer ).pEnteringVehicleNormally = pVehicle;
    
    if ( !pVehicle.Driver ) {
    
        if ( !pVehicle.Locked ) {
        
            pVehicle.SetEngineState ( false );
        
        }
    
    }
    
    if ( pVehicle.Locked ) {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleIsLocked" ) );
    
        return false;
    
    }
        
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") is entering vehicle. Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + "), Seat: " + iSeatID );
    
    return 1;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerEnteredVehicle ( pPlayer , pVehicle , iSeatID ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") entered Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") in Seat: " + iSeatID , false );
    EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") entered Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") in Seat: " + iSeatID , false );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") entered vehicle. Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + "), Seat: " + iSeatID );

    local pVehicleData = GetVehicleData ( pVehicle );
    local pPlayerData = GetPlayerData ( pPlayer );

    // -- Let's make sure they didn't just enter a locked vehicle.
    
    if ( pVehicleData.bLocked ) {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleIsLocked" ) );        
        pPlayer.RemoveFromVehicle ( );
        
        EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because it was locked and they got in" , false );
        EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because it was locked and they got in" , false );
        
        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because it was locked and they got in" );
        
        return 0;
        
    }
    
    if ( !pPlayerData.pEnteringVehicleNormally || pPlayerData.pEnteringVehicleNormally.ID != pVehicle.ID ) {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "RemovedFromVehicleWarp" ) );  
        pPlayer.RemoveFromVehicle ( );
        
        if ( ( time ( ) - pPlayerData.iTeleportIntoVehicleTime ) == GetUtilityConfiguration ( ).iTeleportIntoVehicleCheck ) {
        
            pPlayerData.iTeleportIntoVehicleCount++;
            
            if ( pPlayerData.iTeleportIntoVehicleCount >= 3 ) {
            
                BanLUID ( pPlayer.LUID );
                BanIP ( pPlayer.IP );
                KickPlayer ( pPlayer );
                
                return true;
            
            }
            
        } else {
        
            pPlayerData.iTeleportIntoVehicleCount = 1;
        
        }
        
        EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because they teleported directly into the vehicle." , false );
        EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because they teleported directly into the vehicle." , false );
        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because they teleported directly into the vehicle." );       
    
    }
    
    if ( pPlayerData.pDragging != false ) {
    
        SendPlayerAlertMessage ( pPlayer , "You stopped dragging " + pPlayerData.pDragging.Name + " because you got in a vehicle." );
        
        pPlayerData.pDragging = false;
        
        return false;
    
    }
    
    // -- If they entered the driver's seat
    
    if( iSeatID == 0 ) {
        
        if ( pVehicleData.iOwnerType == 1 ) { // Player
            
            if ( pVehicleData.iOwnerID.tointeger ( ) == pPlayerData.iDatabaseID ) {
        
                SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "YouAreVehOwner" ) , GetVehicleName ( pVehicle ) ) );
                
                if ( !pVehicleData.bEngine ) {
                
                    SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "EngineNotRunningHasKeys" ) , "Engine On" ) );
                
                }               
                    
                EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are owner of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" , false );
                EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are owner of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" , false );
                print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are owner of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" );
                
            } else {
            
				
			
                SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "OtherVehOwner" ) , GetVehicleName ( pVehicle ) , LoadAccountFromDatabaseByID ( GetVehicleData ( pVehicle ).iOwnerID ).szName ) );
                
                if ( !pVehicleData.bEngine ) {
                
                    SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "EngineNotRunningNoKeys" ) , "Engine On" )  );
                
                }           
            
            }
        
        }
        
        if ( pVehicleData.iOwnerType == 2 ) { // Clan
        
            SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehOwnedByClan" ) , GetVehicleName ( pVehicle ) , LoadClanFromDatabaseByID ( pVehicleData.iOwnerID ).szName ) );
            
            if ( pPlayerData.iClan != pVehicleData.iOwnerID ) {
            
                SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "NotInClan" ) , LoadClanFromDatabaseByID ( pVehicleData.iOwnerID ).szName ) + " " + GetPlayerLocaleMessage ( pPlayer , "CantDriveVehicle" ) );
            
            } else {
            
                if ( !GetVehicleData ( pVehicle ).bEngine ) {
                
                    SendPlayerAlertMessage ( pPlayer , "The engine is not running. Use '/Engine On' to start it." );
                
                }
            
            }           
        
        }
        
        if ( pVehicleData.iOwnerType == 3 ) { // Job
        
            SendPlayerAlertMessage ( pPlayer , "This " + GetVehicleName ( pVehicle ) + " belongs to the " + GetCoreTable ( ).Jobs [ pVehicleData.iOwnerID ].szName + " job." );
            
            if ( pPlayerData.iJob != -1 ) {
            
                if ( pPlayerData.iJob != pVehicleData.iOwnerID ) {
                
                    SendPlayerAlertMessage ( pPlayer , "You have the " + GetCoreTable ( ).Jobs [ pPlayerData.iJob ].szName + " job. You can't use this vehicle." );
                
                } else {
                
                    if ( !pVehicleData.bEngine ) {
                    
                        SendPlayerAlertMessage ( pPlayer , "The engine is not running. Press 'M' or use '/Engine' to start it." );
                    
                    }
                    
                    // - Firefighter
                    if ( pVehicle.Model == VEH_FIRETRUCK ) {
                        
                        if ( IsPlayerFirefighter ( pPlayer ) ) {

                            if ( pPlayerData.iFireMission == -1 ) {

                                if ( pPlayerData.bIsWorking ) {

                                    BigMessage ( pPlayer , "~r~FIREFIGHTER" , 4000 , 3 );

                                    NewTimer ( "ActivateRandomFireMission" , 5000 , 1 , pPlayer );

                                    pVehicle.RespawnTime = 45000;

                                } else {

                                    SendPlayerAlertMessage ( pPlayer , "You must be working to start a firefighter mission." );
                                    SendPlayerAlertMessage ( pPlayer , "Use /startwork near a fire station to start working." );

                                }

                            }
                        
                        }
                    
                    }
                    
                    // Bus Driver
                    if ( pVehicle.Model == VEH_COACH ) {
                        
                        print ( "COACH" );
                        
                        if ( IsPlayerBusDriver ( pPlayer ) ) {
                            
                            print ( "IS BUS DRIVER" );
                    
                            if ( pPlayerData.iBusRoute == -1 ) {
                                
                                print ( "NO ROUTE" );

                                if ( pPlayerData.bIsWorking ) {
                                    
                                    print ( "IS WORKING" );

                                    BigMessage ( pPlayer , "~g~BUS DRIVER" , 4000 , 3 );

                                    NewTimer ( "ActivateRandomBusRoute" , 5000 , 1 , pPlayer );

                                    pVehicle.RespawnTime = 45000;

                                } else {

                                    SendPlayerAlertMessage ( pPlayer , "You must be working to start driving a bus route." );
                                    SendPlayerAlertMessage ( pPlayer , "Use /startwork near a bus depot to start working." );

                                }                           

                            }
                        
                        }
                        
                    }
                    
                    // Garbage Collector
                    if ( pVehicle.Model == VEH_TRASHMASTER ) {
                        
                        if ( IsPlayerGarbageCollector ( pPlayer ) ) {
                    
                            if ( pPlayerData.iGarbageRoute == -1 ) {

                                if ( pPlayerData.bIsWorking ) {

                                    BigMessage ( pPlayer , "~g~TRASH COLLECTOR" , 4000 , 3 );

                                    NewTimer ( "ActivateRandomGarbageRoute" , 5000 , 1 , pPlayer );

                                    pVehicle.RespawnTime = 45000;

                                } else {

                                    SendPlayerAlertMessage ( pPlayer , "You must be working to start driving a garbage route." );
                                    SendPlayerAlertMessage ( pPlayer , "Use /startwork near a garbage depot to start working." );

                                }                           

                            }
                        }
                        
                    }                   
                
                }
            
            }
        }
        
        // -- If the car can be rented, let the player know.
    
        if ( pVehicleData.iRentPrice > 0 ) {
        
            if (pVehicleData.pRenter ) {
            
                if ( pVehicleData.pRenter.ID == pPlayer.ID ) {
                
                    SendPlayerAlertMessage ( pPlayer , "You are renting this " + GetVehicleName ( pVehicle ) );
                    
                    EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are renter of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" );
                    EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are renter of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" );                  
                    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed they are renter of Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ")" );
                
                }
            
            } else {
            
                pVehicleData.bEngine = false;
                
                MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "VehicleForRent" ) , GetVehicleData ( pVehicle ).iRentPrice ) , pPlayer , GetRGBColour ( "White" ) );
                MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "RentVehToUse" ) , pPlayer , GetRGBColour ( "White" ) );
        
                EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ") is rentable for $" + GetVehicleData ( pVehicle ).iRentPrice , false );
                EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ") is rentable for $" + GetVehicleData ( pVehicle ).iRentPrice , false );     
                print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleName ( pVehicle ) + ") is rentable for $" + GetVehicleData ( pVehicle ).iRentPrice );
                
            }
        
        }
        
        // -- If the car can be bought, let the player know.
        
        if ( GetVehicleData ( pVehicle ).iBuyPrice > 0 ) {
        
            GetVehicleData ( pVehicle ).bEngine = false;
            
            pPlayerData.pBuyVehState = 1;
            pPlayerData.pBuyVehVehicle = pVehicle;
            pPlayerData.pBuyVehPrice = pVehicleData.iBuyPrice;
            pPlayerData.pBuyVehPosition = pVehicle.Pos;
            pPlayerData.pBuyVehAngle = pVehicle.Angle;
        
            MessagePlayer ( format ( GetPlayerLocaleMessage ( pPlayer , "VehicleForSale" ) , GetVehicleData ( pVehicle ).iBuyPrice ) , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "BuyVehToUse" ) , pPlayer , GetRGBColour ( "White" ) );

            EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") is buyable for $" + pVehicleData.iBuyPrice , false );
            EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") is buyable for $" + pVehicleData.iBuyPrice , false );           
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was informed that Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") is buyable for $" + pVehicleData.iBuyPrice );          

        }
        
        // -- Vehicle engines automatically turn on when entering as a driver. If the engine is supposed to be off, use SetEngineState
        
        if ( !pVehicleData.bEngine ) {
        
            pVehicle.SetEngineState ( false );
        
        }
    
    }
    
    GetPlayerData ( pPlayer ).pEnteredVehicleNormally = pVehicle;
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerUpdate ( pPlayer ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( IsPlayerLoggedIn ( pPlayer ) && CanPlayerUseCommands ( pPlayer ) && pPlayer.Spawned ) {
    
        local pPlayerData = GetPlayerData ( pPlayer );
        
        if ( pPlayerData ) {
        
            if ( pPlayer.Vehicle ) {
            
                if ( pPlayerData.pBuyVehState == 2 ) { // Player bought car, waiting to leave the parking space
                
                    if ( GetDistance ( pPlayer.Pos , pPlayerData.pBuyVehPosition ) > 15.0 ) {
                        
                        GetPlayerData ( pPlayer ).pBuyVehState = 0; // Player left parking space, create new dealership car and reset
                        local pVehicle = CreateNewVehicle ( pPlayerData.pBuyVehVehicle.Model , pPlayerData.pBuyVehPosition , pPlayerData.pBuyVehAngle );
                        GetVehicleData ( pVehicle ).iBuyPrice = pPlayerData.pBuyVehPrice;
                        GetVehicleData ( pVehicle ).pColour1 = { r = 255 , g = 255 , b = 255 };
                        GetVehicleData ( pVehicle ).pColour2 = { r = 255 , g = 255 , b = 255 };
                        pVehicle.RGBColour1 = GetRGBColour ( "White" );
                        pVehicle.RGBColour2 = GetRGBColour ( "White" );
                        
                        EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") has driven Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") off the dealership space. Adding a new vehicle to replace it." , false );
                        EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") has driven Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") off the dealership space. Adding a new vehicle to replace it." , false );                      
                        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") has driven Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") off the dealership space. Adding a new vehicle to replace it."  );
                        
                    }
                
                }
            
            }
            
            if ( pPlayerData.bDeathMode ) {
            
                if ( ( time ( ) - pPlayerData.iDeathTime ) >= 10 ) {
                
                    pPlayer.VirtualWorld = 0;
                    pPlayerData.bDeathMode = false;
                
                } else {
                
                    pPlayer.VirtualWorld = 2;
                
                }
            
            }
            
            if ( pPlayerData.pDragging != false ) {
            
                pPlayerData.pDragging.Pos = GetVectorBehindVector ( pPlayer.Pos , pPlayer.Angle , 1.0 );
            
            }
            
            pPlayerData.iLastUpdate = clock ( );
            
        }
    
    }
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerFailedVehicleEntry ( pPlayer , pVehicle , iSeatID ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    GetPlayerData ( pPlayer ).pEnteringVehicleNormally = false;
    GetPlayerData ( pPlayer ).pEnteredVehicleNormally = false;

    return true;

}

// -------------------------------------------------------------------------------------------------

function onPlayerExitedVehicle ( pPlayer , pVehicle ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   
    
    GetPlayerData ( pPlayer ).pExitingVehicleNormally = false;
    
    if ( GetPlayerData ( pPlayer ).pBuyVehState == 2 ) { // Player bought car, but they got out before leaving the lot
        
        pVehicle.Respawn ( );
        
        GetVehicleData ( pVehicle ).iBuyPrice = pVehicleData.iBuyPrice;
        GetVehicleData ( pVehicle ).iOwnerType = 0;
        GetVehicleData ( pVehicle ).iOwnerType = 0;
        GetVehicleData ( pVehicle ).bEngine = false;
        
        GetPlayerData ( pPlayer ).pBuyVehState = 0;
        GetPlayerData ( pPlayer ).pBuyVehVehicle = false;
        GetPlayerData ( pPlayer ).pBuyVehPrice = 0;
        GetPlayerData ( pPlayer ).pBuyVehPosition = GetCoreTable ( ).Utilities.ZeroVector;
        GetPlayerData ( pPlayer ).fBuyVehAngle = 0.0;
        
    }
    
    if ( !GetVehicleData ( pVehicle ).bSpawnLock ) {
        
        GetVehicleData ( pVehicle ).pPosition = pVehicle.Pos;
        GetVehicleData ( pVehicle ).fAngle = pVehicle.Angle;    
        pVehicle.SpawnPos = pVehicle.Pos;
        pVehicle.SpawnAngle = pVehicle.Angle;
        
    }
    
    if ( !pVehicle.Driver ) {
        
        pVehicle.SetEngineState ( false );
    
    }
    
    if ( GetPlayerData ( pPlayer ).iFireMission != -1 ) {
    
        SendPlayerAlertMessage ( pPlayer , "You have 30 seconds to get in a firetruck" );
        GetPlayerData ( pPlayer ).pJobVehicleTimeout = NewTimer ( "PlayerJobVehicleTimeout" , 30000 , 1 , pPlayer );
    
    }
    
    /*
    if ( !pVehicle.Driver && pVehicle.PassengerCount == 0 ) {
    
        pVehicle.SpawnPos = pVehicle.Pos;
        pVehicle.SpawnAngle = pVehicle.Angle;
        pVehicle.Respawn ( );
        pVehicle.SetEngineState ( false );  
    
        if ( GetVehicleData ( pVehicle ).bSpawnLock ) {
            
            pVehicle.SpawnPos = GetVehicleData ( pVehicle ).pPosition;
            pVehicle.SpawnAngle = GetVehicleData ( pVehicle ).fAngle;
        
        }
        
        return true;
    
    }
    */
    
    GetPlayerData ( pPlayer ).pEnteringVehicleNormally = false;
    GetPlayerData ( pPlayer ).pEnteredVehicleNormally = false;
    
    EchoEventToIRC ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") exited Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ")" , false );
    EchoEventToDiscord ( "Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") exited Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ")" , false );
    
    return 1;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerExitingVehicle ( pPlayer , pVehicle ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    GetPlayerData ( pPlayer ).pExitingVehicleNormally = pVehicle;

    if ( pPlayer.VehicleSeat == 0 ) {
    
        //SetVehicleEngineState ( pVehicle , false );
        pVehicle.SetEngineState ( false );
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function onPlayerSpawn ( pPlayer , pSpawnClass ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( pPlayer.Spawned ) {
        
        return false;
        
    }

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bCanSpawn ) {
    
        ClearChat ( pPlayer );
        
        MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "NeedAuthForSpawn" ) , pPlayer , GetRGBColour ( "BrightRed" ) );
        
        pPlayer.ForceToSpawnScreen ( );
        
        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") attempted to spawn with SpawnClass " + pSpawnClass.ID + " but was rejected. Reason: bCanSpawn is false" );
        
        return 0;
    
    }
    
    if ( pPlayerData.bDead ) {
    
        pPlayer.Pos = GetClosestHospital ( pPlayer );
        pPlayerData.bDead = false;
        pPlayer.Skin = pPlayerData.iSkin;
        pPlayer.Cash = pPlayerData.iCash;
        
        RestorePlayerSavedWeapons ( pPlayer );
        
        pPlayer.ColouredName = "[#FFFFFF]" + pPlayer.Name;
        pPlayer.Colour = 0;
        //pPlayer.NametagColour = Colour ( 255 , 255 , 255 );       
    
    }
    
    if ( pPlayerData.bAuthenticated ) {
    
        pPlayer.Pos = pPlayerData.pPosition;
        pPlayer.Angle = pPlayerData.fAngle;
        
        pPlayer.Skin = pPlayerData.iSkin;
        
        pPlayer.Cash = pPlayerData.iCash;
        
        if ( GetUtilityConfiguration ( ).pGTASpawnCam.Enabled ) {
        
            pPlayer.Immune = true;
            pPlayer.Frozen = true;      
            pPlayer.Alpha = 20;
            
            NewTimer ( "SetGTAVSpawnCameraHigh" , 100 , 1 , pPlayer );
            
        } else {
        
            // The player map icons and weapons were having trouble being instantly added on spawn, so a short delay is used.
            NewTimer ( "PlayerSpawnSyncDelay" , 2500 , 1 , pPlayer );
        
        }
        
        pPlayer.ColouredName = "[#FFFFFF]" + pPlayer.Name;
        pPlayer.Colour = 0;
        //pPlayer.NametagColour = Colour ( 255 , 255 , 255 );
        
        //UpdateMapLocations ( pPlayer );
        
        //InformPlayerOfDestroyedVehicles ( pPlayer );
        
        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") attempted to spawn with SpawnClass " + pSpawnClass.ID + " and was successful. Restoring last position and stats." );
    
    }
    
    if ( pPlayerData.bNewlyRegistered ) {
    
        ClearChat ( pPlayer );
        
        local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "NewPlayerReadyToPlay" );
        
        foreach ( ii , iv in pMessages ) {

            MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
        
        }
        
        pPlayer.ColouredName = "[#FFFFFF]" + pPlayer.Name;
        pPlayer.Colour = 0;
        //pPlayer.NametagColour = Colour ( 255 , 255 , 255 );   

        pPlayer.Skin = pSpawnClass.Skin;
        
        print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") attempted to spawn with SpawnClass " + pSpawnClass.ID + " and was successful. Giving them new player information." );
        
    }
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerCommand ( pPlayer , szCommand , szParams ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") tried command. String: /" + szCommand + " " + szParams );

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData ) {
    
        return false;
    
    }
    
    if( !::IsCommandAllowedBeforeAuthentication ( szCommand ) ) {
        
        if ( !GetPlayerData ( pPlayer ).bAuthenticated ) {
        
            ::SendPlayerErrorMessage ( pPlayer , ::GetPlayerLocaleMessage ( pPlayer , "NeedAuthForCommand" ) );
        
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Not authenticated (/" + szCommand + " " + szParams + ")" );
            
            return false;
        
        }
        
        if( !::GetPlayerData ( pPlayer ).bCanUseCommands ) {
        
            ::SendPlayerErrorMessage ( pPlayer , ::GetPlayerLocaleMessage ( pPlayer , "CantUseCommands" ) );
        
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: bCanUseCommands is false (/" + szCommand + " " + szParams + ")" );
            
            return false;
        
        }       
        
    }
    
    if ( ::DoesCommandHandlerExist ( szCommand.tolower ( ) ) ) {

        if ( ::GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags != 0 ) {
            
            if ( !::HasBitFlag ( pPlayerData.iStaffFlags , ::GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).iStaffFlags ) ) {
            
                ::SendPlayerErrorMessage ( pPlayer , ::GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
                
                print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Does not have required staff flags - String: /" + szCommand + " " + szParams );
                
                return true;
            
            }
        
        }
    
        if ( !::GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bEnabled ) {
        
            ::SendPlayerErrorMessage ( pPlayer , ::format ( ::GetPlayerLocaleMessage ( pPlayer , "CommandDisabled" ) , szCommand , szCommand.tolower ( ).szDisableReason ) );
            
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Command is disabled. (/" + szCommand + " " + szParams + ")" );
            
            return true;
        
        }
        
        local pListener = ::GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).pListener;
        
        if ( !pListener ) {
            
            print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Handler doesn't exist (/" + szCommand + " " + szParams + ")" );
            
            SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UnknownCommand" ) + " - /" + szCommand );
            
            return true;
            
        }
        
        return pListener ( pPlayer , szCommand , szParams );
        
    }

    SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "UnknownCommand" ) + " - /" + szCommand );
    
    print ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to use command. Reason: Command doesn't exist - (/" + szCommand + " " + szParams + ")" );

    return false;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerChat ( pPlayer , szText ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }
    
    if ( !FindPlayer ( pPlayer.Name ) ) {
        
        return 0;
        
    }

    if ( GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        if ( !IsClientDateVerified ( pPlayer ) ) {
        
            return 0;
        
        }
    
    }

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bAuthenticated ) {
    
        return 0;
        
    }
    
    if ( !pPlayerData.bCanUseCommands ) {
    
        return 0;
        
    }   
    
    if ( !pPlayerData.bCanSpawn ) {
    
        return 0;
        
    }   
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "YouAreMuted" ) );
        
        return 0;
    
    }
    
    Message ( GetHexColourByType ( "ChatPlayerHeader" ) + "- " + GetHexColourFromContentXML ( pPlayer.Colour ) + pPlayer.Name + ": " + GetHexColour ( "White" ) + szText , GetRGBColour( "White" ) );
    
    CallFunc ( "Scripts/lilc-irc/Server.nut" , "EchoPlayerChat" , pPlayer.Name , szText );
    CallFunc ( "Scripts/lilc-discord/main.nut" , "EchoPlayerChat" , pPlayer.Name , szText );
    
    return 0;
    
}

// -------------------------------------------------------------------------------------------------

function onPlayerAction ( pPlayer , szText ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CantUseMeAction" ) );
        
        return 0;
    
    }
    
    EchoPlayerAction ( pPlayer , szText );
    
    PlayerAreaActionMessage ( pPlayer , szText );

    return 0;
    
}

// -------------------------------------------------------------------------------------------------

function onVehicleRespawn ( pVehicle ) {

    local pVehicleData = GetVehicleData ( pVehicle );
    
    if ( pVehicleData.iOwnerType == GetVehicleOwnerTypeID ( "Job" ) ) {
    
        pVehicleData.bLocked = true;
        pVehicleData.bLightState = false;
        pVehicleData.bEngine = false;
        
    }
    
    pVehicle.RGBColour1 = Colour ( pVehicleData.pColour1.r , pVehicleData.pColour1.g , pVehicleData.pColour1.b );
    pVehicle.RGBColour2 = Colour ( pVehicleData.pColour2.r , pVehicleData.pColour2.g , pVehicleData.pColour2.b );
    
    pVehicle.Locked = pVehicleData.bLocked;
    pVehicle.LightState = GetVehicleLightStateFromBool ( pVehicleData.bLightState );
    pVehicle.SetEngineState ( false );
    
    print ( "- Vehicle '" + pVehicle.ID + "' (" + GetVehicleDisplayName ( pVehicle ) + ") has respawned." );
    
}

// -------------------------------------------------------------------------------------------------

function onPickupPickedUp ( pPlayer , pPickup ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    HandlePickupPickedUp ( pPlayer , pPickup );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onVehicleUpdate ( pVehicle , pPlayer ) {

    if ( pVehicle.Driver ) {
    
        return 1;
    
    }
    
    if ( pVehicle.PassengerCount > 0 ) {
    
        return 1;
    
    }   
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function onPlayerEnterSphere ( pPlayer , pSphere ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   
    
    local pPlayerData = GetPlayerData ( pPlayer );

    if ( !pSphere.Owner || pSphere.Owner == null ) {
    
        foreach ( ii , iv in GetCoreTable ( ).Locations.PayAndSprays ) { 
        
            if ( pSphere.ID == iv.pSphere.ID ) {
            
                MessagePlayer ( "Welcome to the " + iv.szName + " Pay and Spray! Use '/Help PNS' for info" , pPlayer , GetRGBColour ( "Yellow" ) );
                
                pPlayerData.bAtPayAndSpray = true;
                
                print ( "[Server.ServerEvents]: " + pPlayer.Name + " entered public sphere " + pSphere.ID + " (PayAndSpray '" + iv.szName + "')" );
                
                return true;
            
            }
            
        }
        
        foreach ( ii , iv in GetCoreTable ( ).Locations.Ammunations ) { 
        
            if ( pSphere.ID == iv.pSphere.ID ) {
            
                MessagePlayer ( "Welcome to the " + iv.szName + " Ammunation! Use '/Help Ammunation' for info" , pPlayer , GetRGBColour ( "Yellow" ) );
                
                pPlayerData.bAtAmmunation = true;
                
                print ( "[Server.ServerEvents]: " + pPlayer.Name + " entered public sphere " + pSphere.ID + " (Ammunation '" + iv.szName + "')" );
                
                return true;
            
            }
            
        }
        
        foreach ( ii , iv in GetCoreTable ( ).Locations.ClothingStores ) { 
        
            if ( pSphere.ID == iv.pSphere.ID ) {
            
                MessagePlayer ( "Welcome to the " + iv.szName + " Clothing Store! Use '/Help Clothes' for info" , pPlayer , GetRGBColour ( "Yellow" ) );
                
                pPlayerData.bAtClothingStore = true;
                
                print ( "[Server.ServerEvents]: " + pPlayer.Name + " entered public sphere " + pSphere.ID + " (Clothing Store '" + iv.szName + "')" );
                
                return true;
            
            }
            
        }
    
        
    
    }
    
    if ( pSphere.Owner.ID == pPlayer.ID ) {
        
        print ( "[Server.ServerEvents]: " + pPlayer.Name + " entered personal sphere " + pSphere.ID );
        
        if ( pPlayerData.pJobSphere.ID == pSphere.ID ) {
            
            print ( "JOB SPHERE" );
            
            if ( pPlayerData.bIsWorking ) {
                
                print ( "JOB SPHERE 2" );
            
                switch ( GetJobTypeFromJobID ( pPlayerData.iJob ) ) {
                    
                    case 4:
                    
                        print ( "GARBAGE SPHERE" );
                        
                        EnteredGarbageRouteMarker ( pPlayer , pSphere );
                    
                        break;
                        
                    case 7:
                        
                        print ( "BUS SPHERE" );
                        
                        EnteredBusRouteMarker ( pPlayer , pSphere );
                    
                        break;                  
                        
                    default:
                    
                        break;
                    
                }
    
            }
            
        }   
        
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function onPlayerExitSphere ( pPlayer , pSphere ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( GetPlayerData ( pPlayer ).bAtPayAndSpray ) {
    
        GetPlayerData ( pPlayer ).bAtPayAndSpray = false;
    
    }

    if ( GetPlayerData ( pPlayer ).bAtAmmunation ) {
    
        GetPlayerData ( pPlayer ).bAtAmmunation = false;
    
    }
    

    if ( GetPlayerData ( pPlayer ).bAtClothingStore ) {
    
        GetPlayerData ( pPlayer ).bAtClothingStore = false;
    
    }   
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function AddEventHandler ( szEvent , szListener ) {

    if ( typeof szEvent != "string" || typeof szListener != "function" ) {
        
        return false;
        
    }
    
    local pEventData = { };

    pEventData.szEvent <- szEvent.tolower ( );
    pEventData.bEnabled <- true;
    pEventData.pListener <- szListener;
    
    GetCoreTable ( ).Events.rawset ( szEvent.tolower ( ) , pEventData );

    return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveEventHandler ( szEvent ) {
    
    if ( typeof szEvent != "string" ) {
        
        return false;
        
    }
    
    GetCoreTable ( ).Events.rawdelete ( szEvent );

    return true;    
    
}

// -------------------------------------------------------------------------------------------------

function DoesEventHandlerExist ( szEvent ) {

    return GetCoreTable ( ).Events.rawin ( szEvent );

}

// -------------------------------------------------------------------------------------------------

function GetEventHandlers ( szEvent ) {

    local pTempEventTable = [ ];

    foreach ( ii , iv in GetCoreTable ( ).Events ) {
    
        if ( iv.szEvent.tolower ( ) == szEvent.tolower ( ) ) {
        
            pTempEventTable.push ( iv );
        
        }
    
    }
    
    return pTempEventTable;

}

// -------------------------------------------------------------------------------------------------

function onPlayerIslandChange ( pPlayer , iOldIsland , iNewIsland ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( pPlayer.Spawned ) {
        
        UpdateMapLocations ( pPlayer );
    
    }

}

// -------------------------------------------------------------------------------------------------

function OnPlayerWeaponChange ( pPlayer , iOldWeapon , iNewWeapon , iAmmo ) {
    
    if ( !pPlayer ) {
        
        return 0;
        
    }   

    if ( !CanPlayerUseWeapons ( pPlayer ) ) {
    
        pPlayer.ClearWeapons ( );
        
        return false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.ServerEvents]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------