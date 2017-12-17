
// NAME: Account.nut
// DESC: Provides functions, handlers, and info for accounts.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitAccountScript ( ) {

    AddAccountCommandHandlers ( );

    return true;

}

// -------------------------------------------------------------------------------------------------

function AddAccountCommandHandlers ( ) {
    
    AddCommandHandler ( "Login"                 , LoginCommand                      , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "Register"              , RegisterCommand                   , GetStaffFlagValue ( "None" ) , false );
    //AddCommandHandler ( "LoginHelp"           , LoginHelpCommand                  , GetStaffFlagValue ( "None" ) , false );
       
    AddCommandHandler ( "IPLogin"               , ToggleIPLoginCommand              , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "LUIDLogin"             , ToggleLUIDLoginCommand            , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "ChangePass"            , ChangePasswordCommand             , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "RegionLocale"          , RegionLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "MyLocale"              , RegionLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "MyLang"                , RegionLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "CountryLang"           , RegionLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "CountryLocale"         , RegionLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    
    AddCommandHandler ( "Language"              , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "SetLanguage"           , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "ChangeLanguage"        , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "Lang"                  , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "SetLang"               , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    AddCommandHandler ( "ChangeLang"            , ChangeLocaleCommand               , GetStaffFlagValue ( "None" ) , false );
    
    AddCommandHandler ( "AFK"                   , AwayFromKeyboardCommand           , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Back"                  , BackFromAFKCommand                , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "BindKey"               , BindCustomKeyCommand              , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Key"                   , BindCustomKeyCommand              , GetStaffFlagValue ( "None" ) );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RemoveAccountCommandHandlers ( ) {
    
    RemoveCommandHandler ( "Login" );
    RemoveCommandHandler ( "Register" );
    RemoveCommandHandler ( "LoginHelp" );
       
    RemoveCommandHandler ( "IPLogin" );
    RemoveCommandHandler ( "LUIDLogin" );
    
    RemoveCommandHandler ( "ChangePass" );
    
    // RemoveCommandHandler ( "Language" );
    // RemoveCommandHandler ( "Lang" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SaveAllPlayersToDatabase ( ) {

    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        if ( iv.Spawned ) {
            
            if ( GetPlayerData ( iv , "bAuthenticated" ) ) {
        
                SavePlayerToDatabase ( iv );
            
            }
        
        }
    
    }

}
    
// -------------------------------------------------------------------------------------------------

function IsPlayerAutoLUIDLoginEnabled ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , GetCoreTable ( ).BitFlags.AccountSettings.LUIDLogin ) );
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerAutoIPLoginEnabled ( pPlayer ) {
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , GetCoreTable ( ).BitFlags.AccountSettings.IPLogin ) );
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerTwoStepAuthEnabled ( pPlayer ) {
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    return ( HasBitFlag ( pPlayerData.iAccountSettings , GetCoreTable ( ).BitFlags.AccountSettings.TwoStepAuth ) );

}

// -------------------------------------------------------------------------------------------------

function TogglePlayerAutoIPLogin ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( IsPlayerAutoIPLoginEnabled( pPlayer ) ) {
        
        pPlayerData.iAccountSettings = pPlayerData.iAccountSettings & ~GetCoreTable ( ).BitFlags.AccountSettings.IPLogin;
        
        return false;
    
    } else {
    
        pPlayerData.iAccountSettings = pPlayerData.iAccountSettings | GetCoreTable ( ).BitFlags.AccountSettings.IPLogin;
        
        return true;
        
    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function TogglePlayerAutoLUIDLogin ( pPlayer ) {
    
    local pPlayerData = GetPlayerData ( pPlayer );

    if ( IsPlayerAutoLUIDLoginEnabled ( pPlayer ) ) {
        
        pPlayerData.iAccountSettings = pPlayerData.iAccountSettings & ~GetCoreTable ( ).BitFlags.AccountSettings.LUIDLogin;
        
        return false;
    
    } else {
    
        pPlayerData.iAccountSettings = pPlayerData.iAccountSettings | GetCoreTable ( ).BitFlags.AccountSettings.LUIDLogin;
        
        return true;
        
    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function InitPlayer ( pPlayer ) {

    if ( !pPlayer ) {
    
        return false;
    
    }

    // Hide the player's chat (standard connection messages and such)
    ClearChat ( pPlayer );
    
    // Add them the list of currently connected players
    ConnectedPlayers [ pPlayer.ID ] <- pPlayer; 
    
    // Set their name to white.
    pPlayer.ColouredName = pPlayer.Name;
    pPlayer.Colour = 0; 
    
    // Make them a data instance and add it to a slot on the player data table.
    GetCoreTable ( ).Players [ pPlayer.ID ] = GetCoreTable ( ).Classes.PlayerData ( );
    
    // Load the account delay (prevents race attack)
    NewTimer ( "InitPlayerData" , 1000 , 1 , pPlayer );
    
    //Message ( GetHexColour ( "White" ) + pPlayer.Name + GetHexColour ( "LightGrey" ) + " has connected from " + szCountry + "!" , GetRGBColour ( "White" ) );
    
    ::OpenAllGarages ( );
    
    
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function InitPlayerData ( pPlayer ) {

    if ( !pPlayer ) {
    
        return false;
    
    }
    
    if ( !GetPlayerData ( pPlayer ) ) {
        
        return false;
        
    }
    
    CallLoadPlayerThread ( pPlayer );   
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function InitAuthenticationForPlayer ( pPlayer ) {

    if( IsLoginRegisterGUIEnabled ( ) ) {
    
        if ( GetPlayerData ( pPlayer ).iDatabaseID == 0 ) {
        
            ShowRegistrationForPlayer ( pPlayer );
        
        } else {
        
            ShowLoginForPlayer ( pPlayer );
        
        }
        
        return true;
    
    }
    
    ShowWelcomeMessage ( pPlayer );
    ShowAuthenticationGreeting ( pPlayer );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function CallLoadPlayerThread ( pPlayer ) {
    
    return LoadPlayerFromDatabase ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function CallSavePlayerThread ( pPlayer ) {

    return SavePlayerToDatabase ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function LoadPlayerCrimesFromDatabase ( pPlayerData ) {

    local pPlayerCrimes = [ ];

    return pPlayerCrimes;

}

// -------------------------------------------------------------------------------------------------

function LoadPlayerStaffNotesFromDatabase ( pPlayerData ) {

    local pPlayerStaffNotes = [ ];

    return pPlayerStaffNotes;

}

// -------------------------------------------------------------------------------------------------

function LoginCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescLogin" ) , [ "Login" ] , "" );

        return false;

    }   
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    // -- Let's make sure they aren't already logged in :)
    
    if ( pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AlreadyLoggedIn" ) );
    
        return false;
        
    }
    
    // -- When a player connects, the server attempts to load their account. If no account exists, their iDatabaseID defaults to 0
    // -- So, to check if a player is not registered, see if their iDatabaseID is 0. This prevents having to re-query the database.
    
    if ( pPlayerData.iDatabaseID == 0 ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AccountNotRegistered" ) );
        
        return false;       
    
    }
    
    if ( !szParams ) {
    
        SendPlayerErrorMessage ( pPlayer , "You need to enter a password!" );
        
        return false;       
    
    }
    
    // -- Is the password correct?
    
    if ( pPlayerData.szPassword != SaltAccountPassword ( EscapeMySQLString ( false , szParams ) , pPlayerData.szEmail ) ) {
    
        if ( pPlayerData.iLoginAttemptsRemaining > 0 ) {
        
            pPlayerData.iLoginAttemptsRemaining--;
           
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "LoginFailed" ) , pPlayerData.iLoginAttemptsRemaining ) );
            
            return false;
        
        } else {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "LoginFailedKick" ) ) );
        
            KickPlayer ( pPlayer );
            
            return false;
        
        }
        
    }
    
    // -- Check to see if the account only allows certain IP's or LUID's to use it.
    // -- If so, let's make sure the IP and LUID are allowed to use the account
    
    if ( IsAccountWhitelistEnabled ( pPlayerData.iAccountSettings ) ) {
    
        if ( !IsIPAllowedToUseAccount ( pPlayer.IP ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "AccountIPNotAllowed" ) , pPlayer.IP ) );
            
            SendAccountWhitelistAlert ( pPlayer.Name , pPlayer.IP , pPlayer.LUID );
            
            return false;
        
        }
        
        if ( !IsLUIDAllowedToUseAccount ( pPlayer.IP ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "AccountLUIDNotAllowed" ) , pPlayer.LUID ) );
            
            SendAccountWhitelistAlert ( pPlayer.Name , pPlayer.IP , pPlayer.LUID );
            
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
    
    pPlayerData.pLoginTimeout.Delete ( );
    //pPlayerData.pThisSession = GetCoreTable ( ).Classes.SessionData ( pPlayer );
    
    pPlayer.Spawn ( );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ChangePasswordCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescChangePass" ) , [ "Password" ] , "" );

        return false;

    }   
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are not logged in!" );
    
        return false;
        
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Old Password> <New Password>" );
    
        return false;
    
    }
    
    if ( NumTok ( szParams , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Old Password> <New Password>" );
        
        return false;
    
    }
    
    local szOldPassword = GetTok ( szParams , " " , 1 );
    local szNewPassword = GetTok ( szParams , " " , 2 );
    local szSaltedOldPassword = SaltAccountPassword ( szOldPassword , pPlayerData.szEmail );
    local szSaltedNewPassword = SaltAccountPassword ( szNewPassword , pPlayerData.szEmail );
    
    if ( szSaltedOldPassword != pPlayerData.szPassword ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "ChangePassFailed" ) );
        
        return false;
    
    }
    
    pPlayerData.szPassword = szSaltedNewPassword;
    SavePlayerToDatabase ( pPlayer );
    
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "ChangePassSuccess" ) );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function IsAccountWhitelistEnabled ( iAccountSettings ) {

    if ( HasBitFlag ( iAccountSettings , GetCoreTable ( ).BitFlags.AccountSettings.WhiteList ) ) {
    
        return true
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function IsIPAllowedToUseAccount ( pPlayerData, szIPAddress ) {
    
    if ( pPlayerData.szLastIP == szIPAddress ) {
        
        return true;
        
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function IsLUIDAllowedToUseAccount ( pPlayerData , szLUID ) {

    if ( pPlayerData.szLastLUID == szLUID ) {
        
        return true;
        
    }

}

// -------------------------------------------------------------------------------------------------

// -- Needs finished

function SendAccountWhitelistAlert ( iAccountDatabaseID , szIPAddress , szLUID ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function RegisterCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescRegister" ) , [ "Register" ] , "" );

        return false;

    }
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AlreadyLoggedIn" ) );
        
        return false;
    
    }
    
    if ( LoadAccountFromDatabaseByName ( pPlayer.Name ).iDatabaseID != 0 ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AlreadyRegistered" ) );
        
        return false;
    
    }
    
    if ( !szParams || szParams == null || szParams == "" ) {
        
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Password>" );
        
        return false;
    
    }
    
    if ( ( szParams.len ( ) < GetCoreTable ( ).Security.iMinPasswordLen ) && ( szParams.len ( ) > GetCoreTable ( ).Security.iMaxPasswordLen ) ) {
    
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeBetween" ) , "password" , GetCoreTable ( ).Security.iMinPasswordLen , GetCoreTable ( ).Security.iMaxPasswordLen ) );
        
        return false;
    
    }
    
    if ( GetCoreTable ( ).Security.bForcePasswordCaps ) {
    
        if ( !DoesStringContainCaps ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveCaps" ) , "password" ) );
        
            return false;
        
        }
    
    }
    
    if ( GetCoreTable ( ).Security.bForcePasswordNumbers ) {
    
        if ( !DoesStringContainNumbers ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveNumber" ) , "password" ) );
        
            return false;
        
        }
    
    }

    if ( GetCoreTable ( ).Security.bForcePasswordSymbols ) {
    
        if ( !DoesStringContainSymbols ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustHaveSymbol" ) , "password" ) );
        
            return false;
        
        }
    
    }
    
    pPlayerData.szPassword = szParams;
    pPlayerData.szName = pPlayer.Name;
    
    pPlayerData.szLastIP = pPlayer.IP;
    pPlayerData.szLastLUID = pPlayer.LUID;
    
    pPlayerData.pPosition = GetNewAccountConfiguration ( ).pPosition;
    pPlayerData.fAngle = GetNewAccountConfiguration ( ).fAngle;
    
    pPlayerData.iCash = GetNewAccountConfiguration ( ).iCash;
    
    local pCreateResult = SavePlayerToDatabase ( pPlayer );
    
    if ( !pCreateResult ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AccountNotCreated" ) );
    
        return false;
    
    }
    
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AccountCreated" ) );
    
    NewTimer ( "LoadPlayerAfterRegister" , 2000 , 1 , pPlayer );
    
    pPlayerData.pLoginTimeout.Delete ( );
    
    return;
    
}

// -------------------------------------------------------------------------------------------------

function LoadPlayerAfterRegister ( pPlayer ) {

    LoadPlayerFromDatabase ( pPlayer );
    
    NewTimer ( "PlayerRegistrationComplete" , 2000 , 1 , pPlayer );

}

// -------------------------------------------------------------------------------------------------

function PlayerRegistrationComplete ( pPlayer ) {

    MessagePlayer ( " " , pPlayer );
    MessagePlayer ( GetPlayerLocaleMessage ( pPlayer , "AccountReadyToUse" ) , pPlayer , GetCoreTable ( ).Colours.RGB.White );
    
    GetPlayerData ( pPlayer ) [ "bAuthenticated" ] = true;
    GetPlayerData ( pPlayer ) [ "bCanSpawn" ] = true;
    GetPlayerData ( pPlayer ) [ "bCanUseCommands" ] = true;
    
    GetPlayerData ( pPlayer ) [ "bNewlyRegistered" ] = true;
    
    pPlayer.Spawn ( );

}

// -------------------------------------------------------------------------------------------------

// This salt needs updated. It's not truly unique!
// We need something like an account ID or something tied ONLY to the specific player, as names won't be enough.
// Since no two unique id's in the same field can exist in MySQL tables, maybe `acct_id` would be okay?

function SaltAccountPassword ( szPassword , szName ) {

    if ( szPassword != "" && szName != "" ) {
    
        local cHashFunction = GetHashAlgorithm ( );
        
        return cHashFunction ( "[" + GetSecurityConfiguration ( ).szSaltPotString + "] . " + szName + " . " + szPassword );
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerDatabaseID ( szName ) {

    local iAccountID = GetAccountDatabaseIDFromName ( szName );
    
    if ( !iAccountID ) {
    
        return 0;
    
    }
    
    return iAccountID;
    
}

// -------------------------------------------------------------------------------------------------

function SetPlayerSkin ( pPlayer , iSkinID ) {
    
    GetPlayerData ( pPlayer ) [ "iSkin" ] = iSkinID;
    pPlayer.Skin = GetPlayerData ( pPlayer , "iSkin" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SetPlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    GetPlayerData ( pPlayer ) [ "iCash" ] = iCash;
    pPlayer.Cash = GetPlayerData ( pPlayer , "iCash" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function TakePlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    GetPlayerData ( pPlayer ) [ "iCash" ] = GetPlayerData ( pPlayer , "iCash" ) - iCash;
    pPlayer.Cash = GetPlayerData ( pPlayer , "iCash" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerCash ( pPlayer , iCash ) {

    if ( !iCash.tointeger ( ) ) {
    
        return false;
    
    }

    GetPlayerData ( pPlayer ) [ "iCash" ] = GetPlayerData ( pPlayer , "iCash" ) + iCash;
    pPlayer.Cash = GetPlayerData ( pPlayer , "iCash" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerWeapon ( pPlayer , iWeaponID , iAmmo ) {
    
    pPlayer.SetWeapon ( iWeaponID , iAmmo );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerData ( pPlayer , szDataKey = false ) {
    
    if ( szDataKey != false ) {
        
        return GetCoreTable ( ).Players [ pPlayer.ID ] [ szDataKey ];
        
    }

    return GetCoreTable ( ).Players [ pPlayer.ID ];
    
}

// -------------------------------------------------------------------------------------------------

function ToggleIPLoginCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescIPLogin" ) , [ "IPLogin" ] , GetPlayerLocaleMessage ( pPlayer , "CommandExtraDescIPLogin" ) );

        return false;

    }   
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NeedAuthForCommand" ) );
    
        return false;
        
    }
    
    local bIPLoginState = TogglePlayerAutoIPLogin ( pPlayer );
    
    if ( bIPLoginState ) {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "IPLoginON" ) );
    
    } else {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "IPLoginOFF" ) );
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------


function ToggleLUIDLoginCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescLUIDLogin" ) , [ "LUIDLogin" ] , GetPlayerLocaleMessage ( pPlayer , "CommandExtraDescLUIDLogin" ) );

        return false;

    }   
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bAuthenticated ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NeedAuthForCommand" ) );
    
        return false;
        
    }
    
    local bLUIDLoginState = TogglePlayerAutoLUIDLogin ( pPlayer );
    
    if ( bLUIDLoginState ) {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LUIDLoginON" ) );
    
    } else {
    
        SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LUIDLoginOFF" ) );
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function PlayerRegisterTimeout ( pPlayer ) {

    SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "FailedLoginTimeout" ) );
    SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LoginTimeoutReconnect" ) );
    
    KickPlayer ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function PlayerLoginTimeout ( pPlayer ) {

    SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "FailedLoginTimeout" ) );
    SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LoginTimeoutReconnect" ) );
    
    //SaveAccountToDatabase ( GetPlayerData ( pPlayer ) );
    
    KickPlayer ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function SaveAccountToDatabase ( pPlayerData ) {
    
    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Account " + pPlayerData.szName + " could NOT be saved to database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    local szSafeName = EscapeMySQLString ( pDatabaseConnection , pPlayerData.szName );
    local szSaltedPassword = SaltAccountPassword ( pPlayerData.szPassword ,  pPlayerData.szEmail );
    
    local szSafeStaffTitle = "";
    local szSafeEmail = "";
    
    if ( !szSafeName ) {
    
        ::print ( "[Server.Database]: Account '" + pPlayerData.szName + "' could NOT be saved to database. The name SQL escape failed." );
        
        return false;
    
    }
    
    if ( pPlayerData.szEmail != "" ) {
    
        szSafeEmail = EscapeMySQLString ( pDatabaseConnection , pPlayerData.szEmail );
        
        if ( !szSafeEmail ) {
        
            ::print ( "[Server.Database]: Account '" + pPlayerData.szName + "' could NOT be saved to database. The email SQL escape failed." );
            
            return false;
        
        }       
    
    }
    
    if ( pPlayerData.szStaffTitle != "" ) {
    
        szSafeStaffTitle = EscapeMySQLString ( pDatabaseConnection , pPlayerData.szStaffTitle );
        
        if ( !szSafeStaffTitle ) {
        
            ::print ( "[Server.Database]: Account '" + pPlayerData.szName + "' could NOT be saved to database. The staff title SQL escape failed." );
            
            return false;
        
        }       
    
    }
    
    local szHasWeapon = GetHasWeaponStringFromArray ( pPlayerData.pHasWeapon );
    local szWeaponAmmo = GetWeaponAmmoStringFromArray ( pPlayerData.pWeaponAmmo );
    
    local iThisGameTime = 0;
    local iTotalGameTime = 0;
    
    // Check to see if account is registered. If they are, the iDatabaseID won't be 0.
    // If somebody IS registered and their database id IS zero, Vortrex will murder your neighbor.
    if ( pPlayerData.iDatabaseID == 0 ) {
        
        szQueryString = "INSERT INTO `acct_main` (`acct_name`, `acct_pass`, `acct_email`, `acct_settings`, `acct_staff_flags`, `acct_staff_title`, `acct_job`, `acct_clan`, `acct_clan_rank`, `acct_clan_title`, `acct_last_ip`, `acct_last_luid`, `acct_total_time`, `acct_pos_x`, `acct_pos_y`, `acct_pos_z`, `acct_angle`, `acct_cash`, `acct_bank`, `acct_skin`, `acct_health`, `acct_armour`, `acct_licenses`, `acct_last_session`, `acct_dis_foot`, `acct_dis_car`, `acct_dis_boat`, `acct_dis_plane`, `acct_dis_train`, `acct_when_made`, `acct_when_lastlogin`, `acct_wep_state`, `acct_wep_ammo`) VALUES ('"+szSafeName.tostring()+"', '"+szSaltedPassword.tostring()+"', '"+szSafeEmail.tostring()+"', '0', '0', '', '-1', '0', '0', '', '0', '', '0', '"+pPlayerData.pPosition.x+"', '"+pPlayerData.pPosition.y+"', '"+pPlayerData.pPosition.z+"', '"+pPlayerData.fAngle+"', '"+pPlayerData.iCash+"', '"+pPlayerData.iBank+"', '"+pPlayerData.iSkin+"', '"+pPlayerData.iHealth+"', '"+pPlayerData.iArmour+"', '0', '0', '0', '0', '0', '0', '0', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),'"+szHasWeapon+"','"+szWeaponAmmo+"')";
        
    } else {
    
        szQueryString = "UPDATE `acct_main` SET `acct_name` = '" + szSafeName + "' , `acct_pass` = '" + pPlayerData.szPassword + "' , `acct_email` = '" + szSafeEmail.tostring ( ) + "' , `acct_pos_x` = " + pPlayerData.pPosition.x.tofloat ( ) + " , `acct_pos_y` = " + pPlayerData.pPosition.y.tofloat ( ) + " , `acct_pos_z` = " + pPlayerData.pPosition.z.tofloat ( ) + " , `acct_angle` = " + pPlayerData.fAngle.tofloat ( ) + " , `acct_cash` = " + pPlayerData.iCash.tointeger ( ) + " , `acct_bank` = " + pPlayerData.iBank.tointeger ( ) + " , `acct_staff_flags` = " + pPlayerData.iStaffFlags.tointeger ( ) + " , `acct_staff_title` = '" + szSafeStaffTitle.tostring ( ) + "' , `acct_settings` = " + pPlayerData.iAccountSettings.tointeger ( ) + " , `acct_licenses` = " + pPlayerData.iLicenses.tointeger ( ) + " , `acct_skin` = " + pPlayerData.iSkin.tointeger ( ) + " , `acct_last_ip` = INET_ATON( '" + pPlayerData.szLastIP.tostring ( ) + "' ) , `acct_last_luid` = '" + pPlayerData.szLastLUID.tostring ( ) + "' , `acct_health` = " + pPlayerData.iHealth.tointeger ( ) + " , `acct_armour` = " + pPlayerData.iArmour.tointeger ( ) + " , `acct_total_time` = " + iTotalGameTime.tointeger ( ) + " , `acct_when_lastlogin` = " + pPlayerData.iLastLoginTimestamp.tointeger ( ) + " , `acct_dis_foot` = " + pPlayerData.fDistanceOnFoot.tofloat ( ) + " , `acct_dis_car` = " + pPlayerData.fDistanceCar.tofloat ( ) + " , `acct_dis_boat` = " + pPlayerData.fDistanceBoat.tofloat ( ) + " , `acct_dis_plane` = " + pPlayerData.fDistancePlane.tofloat ( ) + "  , `acct_dis_train` = " + pPlayerData.fDistanceTrain.tofloat ( ) + ",`acct_job` = " + pPlayerData.iJob.tointeger ( ) + ",`acct_wep_state`='"+szHasWeapon+"',`acct_wep_ammo`='"+szWeaponAmmo+"', `acct_mod_flags`='"+pPlayerData.iModerationFlags.tointeger()+"' WHERE `acct_id` = " + pPlayerData.iDatabaseID;
        
    }
    
    if ( !szQueryString ) {
    
        ::print ( "[Server.Database]: Account " + pPlayerData.szName + " could NOT be saved to database. Query string didn't generate!" );
    
        return false;
    
    }
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
    
    SaveCustomBindKeys ( pPlayerData );
    
    /*
    if ( !pQuery ) {
    
        ::print ( "[Server.Database]: Account " + pPlayerData.szName + " could NOT be saved to database. Query didn't execute!" );
        
        return false;
    
    }
    */

    ::print ( "[Server.Database]: Account " + pPlayerData.szName + " was saved to database!" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SaveCustomBindKeys ( pPlayerData ) {

    foreach ( ii , iv in pPlayerData.pCustomBindKeys ) {
    
        SaveCustomBindKey ( pPlayerData , iv );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SaveCustomBindKeys ( pPlayerData , pBindKey ) {

    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Keybinds for " + pPlayerData.szName + " could NOT be saved to database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    local szSafeCommand = EscapeMySQLString ( pDatabaseConnection , pBindKey.szCommand );
    local szSafeParams = EscapeMySQLString ( pDatabaseConnection , pBindKey.szParams );
    
    if ( !szSafeCommand ) {
    
        ::print ( "[Server.Database]: Keybinds for '" + pPlayerData.szName + "' could NOT be saved to database. The command SQL escape failed." );
        
        return false;
    
    }
    
    if ( !szSafeParams ) {
    
        ::print ( "[Server.Database]: Keybinds for '" + pPlayerData.szName + "' could NOT be saved to database. The params SQL escape failed." );
        
        return false;
    
    }
    
    if ( pBindKey.iDatabaseID == 0 ) {
        
        szQueryString = "INSERT INTO `acct_bindkey` (`acct_bindkey_acct`, `acct_bindkey_key`, `acct_bindkey_cmd`, `acct_bindkey_arg` ) VALUES ( "+pPlayerData.iDatabaseID+","+pBindKey.iKeyID+",'"+szSafeCommand+"','"+szSafeParams+"' )";
        
    } else {
    
        szQueryString = "UPDATE `acct_bindkey` SET `acct_bindkey_acct` = "+pPlayerData.iDatabaseID+", `acct_bindkey_key` = "+pBindKey.iKeyID+", `acct_bindkey_cmd='"+szSafeCommand+"', `acct_bindkey_arg`='"+szSafeParams+"', `acct_bindkey_deleted` = "+BoolToInteger(pBindKey.bDeleted)+" WHERE `acct_bindkey_id` = " + pBindKey.iDatabaseID;
        
    }   
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadPlayerFromDatabase ( pPlayer ) { 

    GetCoreTable ( ).Players [ pPlayer.ID ] = LoadAccountFromDatabaseByName ( pPlayer.Name );
    
    InitAuthenticationForPlayer ( pPlayer );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadAccountFromDatabaseByName ( szName ) {

    local pPlayerData = GetCoreTable ( ).Classes.PlayerData ( );
    
    local pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {
    
        return pPlayerData;
    
    }
            
    local szSafeName = EscapeMySQLString ( false , szName );
        
    if ( !szSafeName ) {
    
        return pPlayerData;
    
    }
            
    local szQueryString = format ( "SELECT * , INET_NTOA( `acct_last_ip` ) AS `last_ip` FROM `acct_main` WHERE `acct_name` = '%s' LIMIT 1" , szSafeName );
            
    if ( !szQueryString ) {
            
        return pPlayerData;
    
    }
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
            
    if ( !pQuery ) {
    
        return pPlayerData;
    
    }
                
    local pAssocResult = GetMySQLAssocResult ( pQuery );
                
    if ( !pAssocResult ) {
    
        return pPlayerData;
    
    }
                        
    pPlayerData.iDatabaseID                 = pAssocResult [ "acct_id" ].tointeger ( );
    
    pPlayerData.szName                      = pAssocResult [ "acct_name" ].tostring ( );
    pPlayerData.szPassword                  = pAssocResult [ "acct_pass" ].tostring ( );
    pPlayerData.szEmail                     = pAssocResult [ "acct_email" ].tostring ( );
    
    pPlayerData.iLastSessionID              = pAssocResult [ "acct_last_session" ].tointeger ( );
    pPlayerData.szLastIP                    = pAssocResult [ "last_ip" ].tostring ( ); // Please be careful, this one is selected manually in the query!
    pPlayerData.szLastLUID                  = pAssocResult [ "acct_last_luid" ].tostring ( );
    
    pPlayerData.iRegisteredTimestamp        = pAssocResult [ "acct_when_made" ].tointeger ( );
    pPlayerData.iLastLoginTimestamp         = pAssocResult [ "acct_when_lastlogin" ].tointeger ( );
    
    pPlayerData.iTotalGameTime              = pAssocResult [ "acct_total_time" ].tointeger ( );
    
    pPlayerData.fDistanceOnFoot             = pAssocResult [ "acct_dis_foot" ].tofloat ( );
    pPlayerData.fDistanceCar                = pAssocResult [ "acct_dis_car" ].tofloat ( );
    pPlayerData.fDistanceBoat               = pAssocResult [ "acct_dis_boat" ].tofloat ( );
    pPlayerData.fDistancePlane              = pAssocResult [ "acct_dis_plane" ].tofloat ( );
    pPlayerData.fDistanceTrain              = pAssocResult [ "acct_dis_train" ].tofloat ( );
    
    pPlayerData.iCash                       = pAssocResult [ "acct_cash" ].tointeger ( );;
    pPlayerData.iBank                       = pAssocResult [ "acct_bank" ].tointeger ( );;
    
    pPlayerData.iSkin                       = pAssocResult [ "acct_skin" ].tointeger ( );;
    
    pPlayerData.iHealth                     = pAssocResult [ "acct_health" ].tointeger ( );;
    pPlayerData.iArmour                     = pAssocResult [ "acct_armour" ].tointeger ( );;
    
    pPlayerData.pPosition                   = Vector ( pAssocResult [ "acct_pos_x" ].tofloat ( ) , pAssocResult [ "acct_pos_y" ].tofloat ( ) , pAssocResult [ "acct_pos_z" ].tofloat ( ) );
    pPlayerData.fAngle                      = pAssocResult [ "acct_angle" ].tofloat ( );

    pPlayerData.iAccountSettings            = pAssocResult [ "acct_settings" ].tointeger ( );
    pPlayerData.iLicenses                   = pAssocResult [ "acct_licenses" ].tointeger ( );
    pPlayerData.iStaffFlags                 = pAssocResult [ "acct_staff_flags" ].tointeger ( );
    pPlayerData.iModerationFlags            = pAssocResult [ "acct_mod_flags" ].tointeger ( );
    
    pPlayerData.iJob                        = pAssocResult [ "acct_job" ].tointeger ( );
    
    local szHasWeapon                       = pAssocResult [ "acct_wep_state" ].tostring ( );
    local szWeaponAmmo                      = pAssocResult [ "acct_wep_ammo" ].tostring ( );
    
    pPlayerData.pHasWeapon                  = GetHasWeaponArrayFromString ( szHasWeapon );
    pPlayerData.pWeaponAmmo                 = GetWeaponAmmoArrayFromString ( szWeaponAmmo );

    return pPlayerData;
    
}

// -------------------------------------------------------------------------------------------------

function LoadAccountFromDatabaseByID ( iDatabaseID ) {

    local pPlayerData = GetCoreTable ( ).Classes.PlayerData ( );
    
    local pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {
    
        return pPlayerData;
    
    }
            
    local szQueryString = format ( "SELECT * , INET_NTOA( `acct_last_ip` ) AS `last_ip` FROM `acct_main` WHERE `acct_id` = '%d' LIMIT 1" , iDatabaseID );
        
    if ( !szQueryString ) {
            
        return pPlayerData;
    
    }
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
            
    if ( !pQuery ) {
    
        return pPlayerData;
    
    }
    
    local pAssocResult = GetMySQLAssocResult ( pQuery );
                
    if ( !pAssocResult ) {
    
        return pPlayerData;
    
    }   
    
    pPlayerData = LoadAccountFromDatabaseByName ( pAssocResult [ "acct_name" ] );

    return pPlayerData;
    
}

// -------------------------------------------------------------------------------------------------

function LoadAccountFromDatabaseByEmail ( szEmail ) {

    local pPlayerData = GetCoreTable ( ).Classes.PlayerData ( );
    
    local pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {
    
        return pPlayerData;
    
    }
    
    local szSafeEmail = EscapeMySQLString ( pDatabaseConnection , szEmail );
    
    local szQueryString = format ( "SELECT * FROM `acct_main` WHERE `acct_email` = '%s' LIMIT 1" , szSafeEmail );
    
    if ( !szQueryString ) {
            
        return pPlayerData;
    
    }
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
            
    if ( !pQuery ) {
    
        return pPlayerData;
    
    }
    
    local pAssocResult = GetMySQLAssocResult ( pQuery );
                
    if ( !pAssocResult ) {
    
        return pPlayerData;
    
    }   

    return LoadAccountFromDatabaseByName ( pAssocResult [ "acct_name" ] );
    
}

// -------------------------------------------------------------------------------------------------

function SavePlayerToDatabase ( pPlayer ) {

    // Some pieces of data are only saved IF they are logged in, and/or spawned.
    if ( CanPlayerSpawn ( pPlayer ) && CanPlayerUseCommands ( pPlayer ) ) {
    
        // IP and LUID are only saved if they are logged in. They don't have to be spawned for this.
        // If we didn't make sure they were logged in, anybody could join and disconnect and have autologin for their PC usable.
        // Obviously, that isn't good. So for the sake of all Burger King Whoppers, make sure they're logged in.
        GetPlayerData ( pPlayer ) [ "szLastIP" ] = pPlayer.IP;
        GetPlayerData ( pPlayer ) [ "szLastLUID" ] = pPlayer.LUID;
        
        if ( pPlayer.Spawned ) {
        
            // Now, for saving position, they DO have to be spawned. Duh.
            GetPlayerData ( pPlayer ) [ "pPosition" ] = pPlayer.Pos;
            GetPlayerData ( pPlayer ) [ "fAngle" ] = pPlayer.Angle;
        
        }
        
    }
    
    return SaveAccountToDatabase ( GetPlayerData ( pPlayer ) );

}

// -------------------------------------------------------------------------------------------------

function ChangeLocaleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( "Allows you to change the language used in messages" ) , [ "Lang" , "ChangeLang" , "SetLang" , "Language" , "ChangeLanguage" , "SetLanguage" ] , "Use /languages to find a compatible language" );

        return false;

    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/" + szCommand + " <ID>" );
        
        return false;
    
    }
    
    if ( !IsValidLocaleID ( szParams.tointeger ( ) ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "InvalidLocaleID" ) );
        
        return false;
    
    }
    
    GetPlayerData ( pPlayer ).iLocale = szParams.tointeger ( );
    
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LanguageSet" ) );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function RestorePlayerSavedWeapons ( pPlayer ) {
    
    if ( !CanPlayerUseWeapons ( pPlayer ) ) {
        
        return false;
        
    }

    foreach ( ii , iv in GetPlayerData ( pPlayer , "pHasWeapon" ) ) {
    
        if ( ii != 0 ) {
        
            if ( iv == true ) {
            
                pPlayer.SetWeapon ( ii , GetPlayerWeaponAmmo ( pPlayer , ii ) );
            
            }
        
        }
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function CanPlayerUseWeapons ( pPlayer ) { 

    if ( !HasBitFlag ( GetPlayerData ( pPlayer , "iModerationFlags" ) , GetModerationFlagValue ( "BlockGuns" ) ) ) {
    
        return true;
        
    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function BackFromAFKCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Sets your status as 'away from keyboard'" , [ "AFK" , "BRB" , "Away" ] , "" );

        return false;

    }   
    
    if ( !GetPlayerData ( pPlayer , "bAFK" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "YourAreNotAFK" ) );
    
        return false;
    
    }

    pPlayer.Immune = false;
    pPlayer.Colour = 0;
    pPlayer.NametagColour = GetRGBColour ( "White" );
    pPlayer.ColouredName = "[#FFFFFF]" + pPlayer.Name;
    pPlayer.Frozen = false;
    ResetPlayerAnimation ( pPlayer );
    
    pPlayer.Alpha = 255;
    
    GetPlayerData ( pPlayer ) [ "bAFK" ] = false;
    
    //SendPlayerSuccessMessage ( pPlayer , "You are no longer AFK" );
    
    Message ( "- " + pPlayer.Name + " is no longer AFK!" , GetRGBColour ( "Yellow" ) ); 
    
    EchoEventToIRC ( pPlayer.Name + " is no longer AFK!" , false );
    EchoEventToDiscord ( pPlayer.Name + " is no longer AFK!" , false );     
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function AwayFromKeyboardCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Sets your status as 'away from keyboard'" , [ "AFK" , "BRB" , "Away" ] , "" );

        return false;

    }
    
    if ( GetPlayerData ( pPlayer , "bAFK" ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "YouAreAlreadyAFK" ) );
    
        return false;
    
    }
    
    pPlayer.Alpha = 1;
    pPlayer.Immune = true;
    pPlayer.Colour = 6;
    pPlayer.NametagColour = GetRGBColour ( "Black" );
    pPlayer.ColouredName = "[#000000]" + pPlayer.Name;
    pPlayer.Frozen = true;
    ResetPlayerAnimation ( pPlayer );
    
    pPlayer.Alpha = 0;
    
    GetPlayerData ( pPlayer ) [ "bAFK" ] = true;
    
    //SendPlayerSuccessMessage ( pPlayer , "You are now AFK" );
    Message ( "- " + pPlayer.Name + " is now AFK!" , GetRGBColour ( "Yellow" ) );
    
    EchoEventToIRC ( pPlayer.Name + " is now AFK!" , false );
    EchoEventToDiscord ( pPlayer.Name + " is now AFK!" , false );   
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function BindCustomKeyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Binds a key to a command" , [ "BindKey" , "Bind" , "Key" ] , "" );

        return false;

    }
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !szParams ) {
        
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Key Name> <Command> <Params>" );
        SendPlayerAlertMessage ( pPlayer , "The bind will only use the command if 'Params' is not added" );
        SendPlayerAlertMessage ( pPlayer , "Use '/Help Keys' for a list of available key names" );
        
        return false;
        
    }
    
    if ( NumTok ( szParams , " " ) < 2 ) {
        
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Key Name> <Command> <Params>" );
        SendPlayerAlertMessage ( pPlayer , "The bind will only use the command if 'Params' is not added" );
        SendPlayerAlertMessage ( pPlayer , "Use '/Help Keys' for a list of available key names" );
        
        return false;       
        
    }
    
    local szBindKey = GetTok ( szParams , " " , 1 );
    local szBindCommand = RemoveSlashesFromCommand ( GetTok ( szParams , " " , 2 ) );
    local szBindParams = null;
    
    if ( NumTok ( szParams , " " ) >= 3 ) {
    
        szBindParams = GetTok ( szParams , " " , 3 );
    
    }
    
    local iBindKey = GetKeyCodeFromString ( szBindKey );
    
    if ( iBindKey == 0 ) {
    
        SendPlayerErrorMessage ( pPlayer , "You can't bind that key!" );
        
        return false;
    
    }
    
    if ( DoesPlayerHaveCustomBindKey ( pPlayer , iBindKey ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "That key is already bound to '/" + GetCommandForCustomKeyBind ( pPlayer , iBindKey ) + "'" );
        
        return false;
    
    }
    
    local pCustomBindKey = GetCoreTable ( ).Classes.CustomBindKey ( );
    pCustomBindKey.iKeyID = iBindKey;
    pCustomBindKey.szCommand = szBindCommand;
    pCustomBindKey.szParams = szBindParams;
    pCustomBindKey.bEnabled = true;

    pPlayerData.pCustomBindKeys.push ( pCustomBindKey );
    
    SendPlayerSuccessMessage ( pPlayer , "Key '" + szBindKey + "' is binded to '/" + szBindCommand + "'" );
    
    CallClientFunc ( pPlayer , "lilc/Client.nut" , "AddCustomBindKey" , iBindKey ); 
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RegionLocaleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Uses the language for your country" , [ "RegionLocale" , "MyLocale" , "CountryLang" , "MyLang" ] , "" );

        return false;

    }
    
    local iLocaleID = GetLocaleIDForCountry ( geoip_country_code_by_addr ( pPlayer.IP ) );
    
    GetPlayerData ( pPlayer ).iLocale = iLocaleID;
    
    SendPlayerAlertMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "LanguageSet" ) );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveCustomBindKey ( pPlayer , iBindKey ) {

    foreach ( ii , iv in GetPlayerData ( pPlayer ).pCustomBindKeys ) {
    
        if ( iv.iKeyID == iBindKey ) {
        
            return true;
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetCommandForCustomKeyBind ( pPlayer , iBindKey ) {

    foreach ( ii , iv in GetPlayerData ( pPlayer ).pCustomBindKeys ) {
    
        if ( iv.iKeyID == iBindKey ) {
        
            return iv.szCommand;
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function AuthenticatePlayer ( pPlayer ) {
    
    pPlayerData.bAuthenticated = true;
    pPlayerData.bCanSpawn = true;
    pPlayerData.bCanUseCommands = true; 

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Player]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------