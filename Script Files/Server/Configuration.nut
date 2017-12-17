
// NAME: Configuration.nut
// DESC: Loads and handles all configurations, even if they are for use by another script.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function AddConfigurationCommandHandlers ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveConfigurationCommandHandlers ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function InitConfigurationScript ( ) {

    LoadAllConfigurations ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadAllConfigurations ( ) {

    LoadDatabaseConfiguration ( );
    LoadSecurityConfiguration ( );
    LoadGameConfiguration ( );
    LoadNewAccountConfiguration ( );
    InitIRCEchoConfiguration ( );
    LoadScriptConfiguration ( );

}

// -------------------------------------------------------------------------------------------------

function LoadSecurityConfiguration ( ) {

    GetSecurityConfiguration ( ).iMinUsernameLen                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iMinUsernameLen" );
    GetSecurityConfiguration ( ).iMaxUsernameLen                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iMinUsernameLen" );
    GetSecurityConfiguration ( ).iMinPasswordLen                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iMinUsernameLen" );
    GetSecurityConfiguration ( ).iMaxPasswordLen                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iMinUsernameLen" );
    GetSecurityConfiguration ( ).bForcePasswordCaps                 = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bForcePasswordUppercase" );
    GetSecurityConfiguration ( ).bForcePasswordNumbers              = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bForcePasswordLowercase" );
    GetSecurityConfiguration ( ).bForcePasswordSymbols              = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bForcePasswordSymbols" );
    GetSecurityConfiguration ( ).szEncryptionPepper                 = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "szEncryptionPepper" );
    GetSecurityConfiguration ( ).iMaxLoginAttempts                  = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iMaxLoginAttempts" );
    GetSecurityConfiguration ( ).szHashAlgorithm                    = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "szHashAlgorithm" );
    GetSecurityConfiguration ( ).szSaltPotString                    = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "szSaltPotString" );
    GetSecurityConfiguration ( ).iRaceAttackDelayMS                 = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iRaceAttackDelayMS" );
    GetSecurityConfiguration ( ).iLoginTimeoutMS                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iLoginTimeoutMS" );
    GetSecurityConfiguration ( ).iRegisterTimeoutMS                 = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iRegisterTimeoutMS" );
    GetSecurityConfiguration ( ).iKeyPressSeconds                   = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "iKeyPressSeconds" );
    GetSecurityConfiguration ( ).bMaintenanceMode                   = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bMaintenanceMode" );
    GetSecurityConfiguration ( ).bTestingMode                       = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bTestingMode" );
    
    GetSecurityConfiguration ( ).bUseLUIDVerification               = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bUseLUIDVerification" );
    
    GetSecurityConfiguration ( ).bUseLoginRegisterGUI               = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "ACCOUNT" , "bUseLoginRegisterGUI" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function LoadGameConfiguration ( ) {

    // For real-time. Coming soon, you can use a GMT Offset too with just the integer part (i.e. GMT-1 = -1 and GMT+2 = 2)
    GetUtilityConfiguration ( ).bUseRealTime                        = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bUseRealTime" );
    
    // If bUseRealTime is disabled, a starting time will be used.
    GetUtilityConfiguration ( ).iTimeHour                           = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iStartHour" );
    GetUtilityConfiguration ( ).iTimeMinute                         = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iStartMinute" );
    
    // This is for time changing. You can adjust how many minutes and hours go by each interval (usually 1)
    // Also, you can set the interval time in milliseconds
    GetUtilityConfiguration ( ).iTimeMinuteIncrement                = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iTimeMinuteIncrement" );
    GetUtilityConfiguration ( ).iTimeHourIncrement                  = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iTimeHourIncrement" );
    GetUtilityConfiguration ( ).iTimeUpdateSpeed                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iTimeUpdateInterval" );
    GetUtilityConfiguration ( ).bTimeForward                        = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bTimeForward" );
    
    GetUtilityConfiguration ( ).iCurrentWeather                     = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "iStartWeather" );
    
    // Toggle public police job
    GetUtilityConfiguration ( ).bPoliceJobPublic                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bPublicPoliceJob" );
    
    GetUtilityConfiguration ( ).pGTASpawnCam.Enabled                = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "GAME" , "bUseGTAVSpawnCam" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadTimerConfiguration ( ) {

    GetUtilityConfiguration ( ).iServerSaveInterval                 = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "TIMER" , "iServerSaveInterval" );
    GetUtilityConfiguration ( ).iVehicleDataSyncInterval            = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "TIMER" , "iVehicleDataSyncInterval" );
    GetUtilityConfiguration ( ).iTimeUpdateSpeed                    = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "TIMER" , "iTimeUpdateSpeed" );
    GetUtilityConfiguration ( ).iFuelProcessInterval                = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "TIMER" , "iFuelProcessInterval" );
    GetUtilityConfiguration ( ).iFireJobUpdateInterval              = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "TIMER" , "iFireJobUpdateInterval" );

    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadNewAccountConfiguration ( ) {

    GetNewAccountConfiguration ( ).iCash                = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "iCash" );
    GetNewAccountConfiguration ( ).pPosition            = Vector ( ::ReadIniFloat ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "fSpawnX" ) , ::ReadIniFloat ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "fSpawnY" ) , ::ReadIniFloat ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "fSpawnZ" ) );
    GetNewAccountConfiguration ( ).fAngle               = ::ReadIniFloat ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "fSpawnA" );
    GetNewAccountConfiguration ( ).iSkin                = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "NEW ACCOUNT" , "iSkin" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function InitIRCEchoConfiguration ( ) {

    GetIRCConfiguration ( ).bUseIRC                 = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "bUseIRC" );
    GetIRCConfiguration ( ).bEchoEvents             = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "bEchoEvents" );
    
    GetIRCConfiguration ( ).szBotOne                = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szBotOneName" );
    GetIRCConfiguration ( ).szBotTwo                = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szBotTwoName" );
    GetIRCConfiguration ( ).szBotName               = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szBotUsername" );
    GetIRCConfiguration ( ).szBotPass               = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szBotPassword" );
    GetIRCConfiguration ( ).szServerHost            = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szServerHost" );
    GetIRCConfiguration ( ).iServerPort             = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "iServerPort" );
    GetIRCConfiguration ( ).szChannelName           = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szChannelName" );
    GetIRCConfiguration ( ).szChannelPass           = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "szChannelPass" );
    GetIRCConfiguration ( ).bUseSecondBot           = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "IRC" , "bUseSecondBot" );
    
    return true;
    
} 

// -------------------------------------------------------------------------------------------------

function InitDiscordConfiguration ( ) {

    GetDiscordConfiguration ( ).bUseDiscord             = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "bUseIRC" );
    GetDiscordConfiguration ( ).bEchoEvents             = ::ReadIniBool ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "bEchoEvents" );
    
    GetDiscordConfiguration ( ).szNodeServerHost        = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "szNodeServerHost" );
    GetDiscordConfiguration ( ).iNodeerverPort          = ::ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "iNodeServerPort" );
    GetDiscordConfiguration ( ).szPassphrase            = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "szPassphrase" );
    GetDiscordConfiguration ( ).szChannelName           = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "szChannelName" );
    GetDiscordConfiguration ( ).szAdminRole             = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "szDiscordAdminRole" );
    GetDiscordConfiguration ( ).szModRole               = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "DISCORD" , "szDiscordModRole" );
    
    return true;
    
} 

// -------------------------------------------------------------------------------------------------

function LoadScriptConfiguration ( ) {

    GetUtilityConfiguration ( ).szScriptVersion         = ::ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "GENERAL" , "szScriptVersion" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadDatabaseConfiguration ( ) {
    
    GetDatabaseConfiguration ( ).szHost             = ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "MYSQL" , "szDatabaseHost" );
    GetDatabaseConfiguration ( ).szUser             = ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "MYSQL" , "szDatabaseUser" );
    GetDatabaseConfiguration ( ).szPass             = ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "MYSQL" , "szDatabasePass" );
    GetDatabaseConfiguration ( ).szName             = ReadIniString ( szScriptsPath + "Data/Configuration.ini" , "MYSQL" , "szDatabaseName" );
    GetDatabaseConfiguration ( ).iPort              = ReadIniInteger ( szScriptsPath + "Data/Configuration.ini" , "MYSQL" , "iDatabaseHost" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function GetIRCConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).IRC;
    
    } else {
    
        return GetCoreTable ( ).IRC [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetSecurityConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Security;
    
    } else {
    
        return GetCoreTable ( ).Security [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetUtilityConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Utilities;
    
    } else {
    
        return GetCoreTable ( ).Utilities [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetNewAccountConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Utilities.pNewAccount;
    
    } else {
    
        return GetCoreTable ( ).Utilities.pNewAccount [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetDatabaseConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Database;
    
    } else {
    
        return GetCoreTable ( ).Database [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetAnticheatConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Utilities;
    
    } else {
    
        return GetCoreTable ( ).Utilities [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetClanConfiguration ( szKey = false ) {

    if ( !szKey ) {
    
        return GetCoreTable ( ).Utilities.Clan;
    
    } else {
    
        return GetCoreTable ( ).Utilities.Clan [ szKey ];
    
    }

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Configuration]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------