
// NAME: Client.nut
// DESC: Provides functions for client/server communication
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitClientScript ( ) {

    RegisterRemoteFunctions ( );

}

// -------------------------------------------------------------------------------------------------

function RegisterRemoteFunctions ( ) {

    ::RegisterRemoteFunc ( "SendServerVerification" );
    ::RegisterRemoteFunc ( "CheckTazerShot" );
    ::RegisterRemoteFunc ( "FiretruckHoseSprayStop" );
    ::RegisterRemoteFunc ( "FiretruckHoseSprayStart" );
    ::RegisterRemoteFunc ( "HydraulicsUp" );
    ::RegisterRemoteFunc ( "HydraulicsDown" );
    ::RegisterRemoteFunc ( "VehicleLockKey" );
    ::RegisterRemoteFunc ( "VehicleLightsKey" );
    ::RegisterRemoteFunc ( "VehicleEngineKey" );
    ::RegisterRemoteFunc ( "ReceiveScreenInfoFromClient" );
    ::RegisterRemoteFunc ( "UseCustomBindKey" );
    
    ::RegisterRemoteFunc ( "CheckRegisterFromGUI" );
    ::RegisterRemoteFunc ( "CheckLoginFromGUI" );
    
    ::RegisterRemoteFunc ( "LoadedAllGUI" );
    
    ::RegisterRemoteFunc ( "ClientReady" );
    
    
}

// -------------------------------------------------------------------------------------------------

function SendServerVerification ( pPlayer , iDate ) {

    // Let's make sure LUID verification is enabled first
    
    if ( !GetUtilityConfiguration ( "bUseLUIDVerification" ) ) {
    
        return true;
    
    }

    print ( "[Server.Security]: Checking client date verification for " + pPlayer.Name );

    if ( date ( iDate ).year != date ( ).year ) {
        
        ClientDateVerified [ pPlayer.ID ] = false;
    
        print ( "[Server.Security]: " + pPlayer.Name + " has FAILED client date verification (Year " + date ( iDate ).year + "/" + date ( ).year + ")" );
        
        return false;
    
    }
    
    if ( date ( iDate ).month != date ( ).month ) {
    
        ClientDateVerified [ pPlayer.ID ] = false;
        
        print ( "[Server.Security]: " + pPlayer.Name + " has FAILED client date verification (Month " + date ( iDate ).month + "/" +  date ( ).month + ")" );
        
        return false;
    
    }
    
    print ( "[Server.Security]: " + pPlayer.Name + " has passed client date verification" );
    
    ClientDateVerified [ pPlayer.ID ] = true;
    
    NewTimer ( "InitPlayer" , 500 , 1 , pPlayer );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function CrouchKeyPressed ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( pPlayer.Spawned ) {
    
        if ( time ( ) - pPlayerData.iLastCrouch >= 2 ) { 
            
            if ( !GetPlayerData ( pPlayer ).bIsCrouching ) {
        
                ResetPlayerAnimation ( pPlayer );
                pPlayer.Frozen = true;
                pPlayer.SetAnim ( 163 );
                pPlayerData.iLastCrouch = time ( );
                pPlayerData.bIsCrouching = true;
                
                return true;
                
            } else {
            
                ResetPlayerAnimation ( pPlayer );
                pPlayer.Frozen = false;
                pPlayerData.iLastCrouch = time ( );
                pPlayerData.bIsCrouching = false;
                
                return true;
            
            }
    
        }
        
    }

}

// -------------------------------------------------------------------------------------------------

function FiretruckHoseSprayStop ( pPlayer , iHoldTime = 0 ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( pPlayerData.bFiretruckHoseState ) {
    
        pPlayerData.bFiretruckHoseState = false;
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function FiretruckHoseSprayStart ( pPlayer ) {
    
    if ( pPlayer.Vehicle ) {
    
        if ( pPlayer.Vehicle.Model == 97 ) {
        
            local pPlayerData = GetPlayerData ( pPlayer );
        
            if ( pPlayerData.bIsWorking ) {
            
                if ( pPlayerData.iFireMission != -1 ) {
                
                    pPlayerData.bFiretruckHoseState = true;
                    pPlayerData.iFiretruckHoseStart = time ( );             
        
                    if ( IsFiretruckAimingAtVehicle ( pPlayer.Vehicle , GetFireMissionData ( pPlayerData.iFireMission ).pVehicle ) ) {
                    
                        NewTimer ( "AttemptVehicleFireExtinguish" , 2500 , 1 , pPlayer );
                    
                    }

                }
                
            }
            
        }
        
    }

    return true;

}



// -------------------------------------------------------------------------------------------------

function VehicleLightsKey ( pPlayer ) {

    if ( ( time ( ) - GetPlayerData ( pPlayer ).iLastKeyPress ) <= 2 ) {
    
        return false;
    
    }

    ClientToggleVehicleLights ( pPlayer );
    
    GetPlayerData ( pPlayer ).iLastKeyPress = time ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function VehicleEngineKey ( pPlayer ) {

    if ( ( time ( ) - GetPlayerData ( pPlayer ).iLastKeyPress ) <= 2 ) {
    
        return false;
    
    }

    ClientToggleVehicleEngine ( pPlayer );
    
    GetPlayerData ( pPlayer ).iLastKeyPress = time ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function VehicleLockKey ( pPlayer ) {

    if ( ( time ( ) - GetPlayerData ( pPlayer ).iLastKeyPress ) <= 2 ) {
    
        return false;
    
    }

    ClientToggleVehicleLock ( pPlayer );
    
    GetPlayerData ( pPlayer ).iLastKeyPress = time ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function VehicleSpecialLightKey ( pPlayer ) {

    if ( ( time ( ) - GetPlayerData ( pPlayer ).iLastKeyPress ) <= 2 ) {
    
        return false;
    
    }

    ClientToggleVehicleSpecialLight ( pPlayer );
    
    GetPlayerData ( pPlayer ).iLastKeyPress = time ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ReceiveScreenInfoFromClient ( pPlayer , iWidth , iHeight ) {

    local pPlayerData = GetPlayerData ( pPlayer )
    pPlayerData.pScreenInfo.iWidth = iWidth;
    pPlayerData.pScreenInfo.iHeight = iHeight;
    
    UpdateConnectionScreenInfo ( PlayerConnectionID [ pPlayer.ID ] , iWidth , iHeight );

    return true;

}

// -------------------------------------------------------------------------------------------------

function RequestClientScreenInfo ( pPlayer ) {

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ServerRequestingScreenInfo" );

}

// -------------------------------------------------------------------------------------------------

function GetKeyCodeFromString ( szKey ) {
    
    switch ( szKey.tolower ( ) ) {
        
        case "a":
            return 'a';
        case "b":
            return 'b';
        case "c":
            return 'c';
        case "d":
            return 'd';
        case "e":
            return 'e';
        case "f":
            return 'f';
        case "g":
            return 'g';
        case "h":
            return 'h';
        case "i":
            return 'i';
        case "j":
            return 'j';
        case "k":
            return 'k';
        case "l":
            return 'l';
        case "m":
            return 'm';
        case "n":
            return 'n';
        case "o":
            return 'o';
        case "p":
            return 'p';
        case "q":
            return 'q';
        case "r":
            return 'r';
        case "s":
            return 's';
        case "t":
            return 't';
        case "u":
            return 'u';
        case "v":
            return 'v';
        case "w":
            return 'w';
        case "x":
            return 'x';
        case "y":
            return 'y';
        case "z":
            return 'z';
            
        case "0":
            return '0';
        case "1":
            return '1';
        case "2":
            return '2';
        case "3":
            return '3';
        case "4":
            return '4';
        case "5":
            return '5';
        case "6":
            return '6';
        case "7":
            return '7';
        case "8":
            return '8';
        case "9":
            return '9';
            
        case "left":
            return 37;
        case "up":  
            return 38;
        case "right":       
            return 39;
        case "down":
            return 40;
        case "numpad0":
        case "num0":
            return 96;
        case "numpad1":
        case "num1":    
            return 97;
        case "numpad2":
        case "num2":
            return 98;
        case "numpad3":
        case "num3":    
            return 99;
        case "numpad4":
        case "num4":
            return 100;
        case "numpad5":
        case "num5":    
            return 101;
        case "numpad6":
        case "num6":    
            return 102;
        case "numpad7":
        case "num7":
            return 103;
        case "numpad8":
        case "num8":
            return 104;
        case "numpad9":
        case "num9":    
            return 105;
        case "*":   
            return 106;
        case "+":   
            return 107;
        case "-":   
            return 109;
        case ".":   
            return 110;
        case "/":   
            return 111;
        case "f1":  
            return 112;
        case "f2":  
            return 113;
        case "f3":
            return 114;
        case "f4":  
            return 115;
        case "f5":
            return 116;
        case "f6":  
            return 117;
        case "f7":  
            return 118;
        case "f8":  
            return 119;
        case "f9":  
            return 120;
        case "f10": 
            return 121;
        case "f11": 
            return 122;
        case "f12": 
            return 123;
        case "backspace":
            return 8;
        case "tab": 
            return 9;
        case "return":  
        case "enter":   
            return 13;
        case "shift":   
            return 16;
        case "ctrl":    
        case "control": 
            return 17;
        case "caps":    
        case "capslock":    
            return 20;
        case "pause":   
            return 19;
        case "esc": 
        case "escape":  
            return 27;
        case "space":   
            return 32;
        case "end": 
            return 35;
        case "home":    
            return 36;
        case "lwin":    
        case "win":
        case "leftwin": 
            return 91;
        case "rightwin":    
        case "rwin":    
            return 92;
        case "numlock": 
            return 144;
        case "scrolllock":  
            return 145;
        case "print":   
            return 42;
        case "insert":  
            return 45;
        case "leftclick":
            return -1;
        case "rightclick":
            return -2;
        case "middleclick":
            return -3;
        case "wheelup":
            return -4;
        case "wheeldown":
            return -5;          
        case "leftrelease":
            return -6;
        case "rightrelease":
            return -7;          
        case "middlerelease":
            return -8;
        case "default":
            return 0;

        default:
            return false;
    }
    
}

// -------------------------------------------------------------------------------------------------

function ShowLoginForPlayer ( pPlayer ) {

    print ( "[Server.Client]: Showing login for " + pPlayer.Name );
    
    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ShowLogin" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function ShowRegistrationForPlayer ( pPlayer ) {

    print ( "[Server.Client]: Showing registration for " + pPlayer.Name );

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ShowRegister" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function HideAllGUIForPlayer ( pPlayer ) {

    print ( "[Server.Client]: Hiding all GUI for " + pPlayer.Name );

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "HideAllGUI" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function ShowHUDForPlayer ( pPlayer ) {

    print ( "[Server.Client]: Showing HUD for " + pPlayer.Name );

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ShowHUD" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function HideHUDForPlayer ( pPlayer ) {

    print ( "[Server.Client]: Hiding HUD for " + pPlayer.Name );

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "HideHUD" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function SendClanMembersToPlayer ( pPlayer ) {

    foreach ( ii , iv in GetAllClanMembers ( GetPlayerData ( pPlayer ).iClan ) ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "ReceiveClanMemberFromServer" , iv.szName , iv.iRank , iv.iPermissions , iv.szCustomTitle , iv.szCustomTag , iv.szLastOnlineText );
    
    }

}

// -------------------------------------------------------------------------------------------------

function SendClanRanksToPlayer ( pPlayer ) {

    foreach ( ii , iv in GetClanRanks ( GetPlayerData ( pPlayer ).iClan ) ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "ReceiveClanRankFromServer" , iv.szName , iv.iRank , iv.iPermissions , iv.szCustomTag );
    
    }

}

// -------------------------------------------------------------------------------------------------

function SendClanTurfsToPlayer ( pPlayer ) {

    /*
    foreach ( ii , iv in GetClanRanks ( GetPlayerData ( pPlayer ).iClan ) ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "ReceiveClanTurfFromServer" , iv.szName , iv.iRank , iv.iPermissions , iv.szCustomTag );
    
    }
    */

}

// -------------------------------------------------------------------------------------------------

function ClearClanMembersForPlayer ( pPlayer ) {

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ClearClanMembers" );

}

// -------------------------------------------------------------------------------------------------

function ClearClanRanksForPlayer ( pPlayer ) {

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ClearClanRanks" );

}

// -------------------------------------------------------------------------------------------------

function ClearClanTurfsForPlayer ( pPlayer ) {

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ClearClanTurfs" );

}

// -------------------------------------------------------------------------------------------------

function ToggleClanManagerForPlayer ( pPlayer ) {

    SendClanInfoToPlayer ( pPlayer );
    
    ClearClanMembersForPlayer ( pPlayer );
    ClearClanRanksForPlayer ( pPlayer );
    ClearClanTurfsForPlayer ( pPlayer );
    
    SendClanMembersToPlayer ( pPlayer );
    SendClanRanksToPlayer ( pPlayer );
    SendClanTurfsToPlayer ( pPlayer );

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ToggleClanManager" );

}

// -------------------------------------------------------------------------------------------------

function SendClanInfoToPlayer ( pPlayer ) {

    local pClanData = GetClanFromDatabaseID ( GetPlayerData ( pPlayer ).iClan );
    
    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ReceiveClanInfoFromServer" , pClanData.szName , pClanData.szTag , LoadAccountFromDatabaseByID ( pClanData.iOwner ).szName , pClanData.pMembers.len ( ) , pClanData.pTurfs.len ( ) , pClanData.iBank , ParseDateForDisplay ( pClanData.iWhenCreated ) );

}

// -------------------------------------------------------------------------------------------------

function SendClanDataToPlayer ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.iClan > 0 ) {
    
        SendClanInfoToPlayer ( pPlayer )
        SendClanMembersToPlayer ( pPlayer );
        SendClanRanksToPlayer ( pPlayer );
        SendClanTurfsToPlayer ( pPlayer );
        
    }   

}

// -------------------------------------------------------------------------------------------------

function LoadedAllGUI ( pPlayer ) {

    print ( "[Server.Client]: All GUI loaded for " + pPlayer.Name );

}

// -------------------------------------------------------------------------------------------------

