// -------------------------------------------------------------------------------------------------

pRootTable <- getroottable ( );
szScriptsPath <- "Scripts/lilc/";
pCoreTable <- { };

iServerStart <- 0;

// -------------------------------------------------------------------------------------------------

function GetCoreTable ( ) {

    return ::pCoreTable;

}

// -------------------------------------------------------------------------------------------------

function LoadAllScriptFiles ( ) {

    dofile ( szScriptsPath + "Script Files/Server/Account.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Ammunation.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Animations.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Core Table.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Bans.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Bit Flags.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Businesses.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Chat.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Clans.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Classes.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Client.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Colours.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Commands.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Configuration.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Database.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Developer.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Discord.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Help.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Houses.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/IRC.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Item Dropping.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Locale.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Messaging.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Misc.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Moderation.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Security.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Server Events.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Startup.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Utilities.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Vehicles.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Website.nut" , true );
    
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Police.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Fire.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Medic.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Taxi.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Bus.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Weapons.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Drugs.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Jobs/Garbage.nut" , true );
    
    dofile ( szScriptsPath + "Script Files/Server/Extras/Vehicle Hydraulics.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Extras/Time Update Speed.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Extras/Client Script Compiler.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Extras/Debug Log.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Extras/Vehicle Speed Limiter.nut" , true );
    dofile ( szScriptsPath + "Script Files/Server/Extras/Weapon Damage.nut" , true );
    //dofile ( szScriptsPath + "Script Files/Server/Extras/Invasion.nut" , true );
    
}

// -------------------------------------------------------------------------------------------------

function onScriptLoad ( ) {

    ::ClientDateVerified <- array ( MAX_PLAYERS , false );
    
    ::LoadAllScriptFiles ( );
    ::InitServerModules ( );
    
    pCoreTable <- ::InitCoreTable ( );
    
    NewTimer ( "InitAllScripts" , 500 , 1 );
    
    ::InitGameEntities ( );
    
    ::OpenAllGarages ( );
        
    ConnectedPlayers <- { };
    PlayerConnectionID <- array ( MAX_PLAYERS , 0 );
    
    iServerStart <- time ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function BothHydraulicsUp ( pPlayer ) {
    
    UseHydraulicsUp ( pPlayer );    

}

// -------------------------------------------------------------------------------------------------

function BothHydraulicsDown ( pPlayer ) {

    UseHydraulicsDown ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function CheckTazerShot ( pPlayer , pShooter ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( pPlayerData.bTazerArmed ) {
    
        PlayerShotByTazer ( pShooter , pPlayer );
        
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function UseCustomBindKey ( pPlayer , iKey ) {
    
    if ( DoesPlayerHaveCustomBindKey ( pPlayer , iKey ) ) {
    
        foreach ( ii , iv in GetPlayerData ( pPlayer ).pCustomBindKeys ) {
            
            if ( iv.bEnabled ) {
            
                if ( iv.iKeyID == iKey ) {
                    
                    onPlayerCommand ( pPlayer , iv.szCommand , iv.szParams );
                    
                }
            
            }
            
        }
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CheckLoginFromGUI ( pPlayer , szPassword ) {
    
    if ( !szPassword ) {
    
        //SendPlayerErrorMessage ( pPlayer , "Please enter a password!" );
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "LoginFailed" , "You need to enter a password!" );
        
        return false;
    
    }    
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.iDatabaseID == 0 ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "LoginFailed" , "The name '" + pPlayer.Name + "' is not registered!" );
        
        return false;
    
    }
    
    local szSaltedPassword = SaltAccountPassword ( szPassword , pPlayer.Name );

    if ( pPlayerData.szPassword != szSaltedPassword ) {
    
        if ( pPlayerData.iLoginAttemptsRemaining >= 1 ) {
        
            pPlayerData.iLoginAttemptsRemaining--;
           
            CallClientFunc ( pPlayer , "lilc/Client.nut" , "LoginFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "LoginFailed" ) , pPlayerData.iLoginAttemptsRemaining ) );
            
            return false;
        
        } else {
        
            CallClientFunc ( pPlayer , "lilc/Client.nut" , "LoginFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "LoginFailedKick" ) ) );
        
            KickPlayer ( pPlayer );
            
            return false;
        
        }
        
    }   
    
    // -- Everything seems to be in order. I'm going to go across the street and get you some orange shebert.
    // -- Oh, and the player can have some gum :D ---- Austin Powers, for those who don't get it.
    
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LoginSuccessful" ) );
    
    pPlayerData.bAuthenticated = true;
    pPlayerData.bCanSpawn = true;
    pPlayerData.bCanUseCommands = true;
    
    UpdateConnectionAccountLogin ( PlayerConnectionID [ pPlayer.ID ] , pPlayerData.iDatabaseID , time ( ) );
    
    // pPlayerData.pLoginTimeout.Delete ( );
    // pPlayerData.pThisSession = GetCoreTable ( ).Classes.SessionData ( pPlayer );
    
    CallClientFunc ( pPlayer , "lilc/Client.nut" , "LoginSuccess" );
    
    pPlayer.Spawn ( );  

    return true;

}

// -------------------------------------------------------------------------------------------------

function CheckRegisterFromGUI ( pPlayer , szEmail , szPassword , szConfirmPassword ) {
    
    if ( !szPassword ) {
    
        //SendPlayerErrorMessage ( pPlayer , "Please enter a password!" );
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , "You need to enter a password!" );
        
        return false;
    
    }    
    
    if ( !szConfirmPassword ) {
    
        //SendPlayerErrorMessage ( pPlayer , "Please confirm your password!" );
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , "You need to confirm the password!" );
        
        return false;
    
    }
    
    if ( szPassword != szConfirmPassword ) {
    
        SendPlayerErrorMessage ( pPlayer , "The passwords must match" );
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , "The passwords don't match!" );
        
        return false;
    
    }
    
    local pPlayerData = GetPlayerData ( pPlayer );  
    
    if ( pPlayerData.iDatabaseID != 0 ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , "The name '" + pPlayer.Name + "' is already registered!" );
        
        return false;
    
    }
    
    if ( ( szPassword.len ( ) < GetCoreTable ( ).Security.iMinPasswordLen ) && ( szPassword.len ( ) > GetCoreTable ( ).Security.iMaxPasswordLen ) ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeBetween" ) , "password" , GetCoreTable ( ).Security.iMinPasswordLen , GetCoreTable ( ).Security.iMaxPasswordLen ) );
        
        return false;
    
    }
    
    if ( GetCoreTable ( ).Security.bForcePasswordCaps ) {
    
        if ( !DoesStringContainCaps ( szPassword ) ) {
        
            CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveCaps" ) , "password" ) );
        
            return false;
        
        }
    
    }
    
    if ( GetCoreTable ( ).Security.bForcePasswordNumbers ) {
    
        if ( !DoesStringContainNumbers ( szPassword ) ) {
        
            CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveNumber" ) , "password" ) );
        
            return false;
        
        }
    
    }

    if ( GetCoreTable ( ).Security.bForcePasswordSymbols ) {
    
        if ( !DoesStringContainSymbols ( szPassword ) ) {
        
            CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveSymbol" ) , "password" ) );
        
            return false;
        
        }
    
    }

    pPlayerData.szPassword = szPassword;
    pPlayerData.szName = pPlayer.Name;
    pPlayerData.szEmail = szEmail;
    
    pPlayerData.szLastIP = pPlayer.IP;
    pPlayerData.szLastLUID = pPlayer.LUID;
    
    pPlayerData.pPosition = GetNewAccountConfiguration ( ).pPosition;
    pPlayerData.fAngle = GetNewAccountConfiguration ( ).fAngle;
    
    pPlayerData.iCash = GetNewAccountConfiguration ( ).iCash;
    
    local pCreateResult = SavePlayerToDatabase ( pPlayer );
    
    if ( !pCreateResult ) {
    
        CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterFailed" , GetPlayerLocaleMessage ( pPlayer , "AccountNotCreated" ) );
    
        return false;
    
    }
    
    CallClientFunc ( pPlayer , "lilc/Client.nut" , "RegisterSuccess" );
    
    NewTimer ( "LoadPlayerAfterRegister" , 1000 , 1 , pPlayer );
    
    //pPlayerData.pLoginTimeout.Delete ( ); 

    return true;

}

// -------------------------------------------------------------------------------------------------

function ClientReady ( pPlayer , iTime ) {

    print ( "[Server.Client]: Client scripts loaded and ready. Took " + iTime + " ms" );
    
    if ( GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        RequestClientTimeVerification ( pPlayer );
        
        NewTimer ( "CheckClientTimeVerification" , 2000 , 1 , pPlayer );
        
    } else {
    
        NewTimer ( "InitPlayer" , 500 , 1 , pPlayer );
        RequestClientScreenInfo ( pPlayer );
        HideHUDForPlayer ( pPlayer );   
        CreatePlayerMapIcons ( pPlayer );       
    
    }

}

// -------------------------------------------------------------------------------------------------