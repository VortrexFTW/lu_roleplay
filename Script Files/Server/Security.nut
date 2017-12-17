// -------------------------------------------------------------------------------------------------

function InitSecurityScript ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function InitSecurityCoreTable ( ) {
    
    local pSecurityValuesTable = { };

    pSecurityValuesTable.iMinUsernameLen                    <- 3;
    pSecurityValuesTable.iMaxUsernameLen                    <- 32;
    pSecurityValuesTable.iMinPasswordLen                    <- 6;
    pSecurityValuesTable.iMaxPasswordLen                    <- 32;
    pSecurityValuesTable.bForcePasswordCaps                 <- true;
    pSecurityValuesTable.bForcePasswordNumbers              <- true;
    pSecurityValuesTable.bForcePasswordSymbols              <- true;
    pSecurityValuesTable.szAllowedPasswordSymbols           <- "*()[]{}';:!@#$%^&*-=+";
    pSecurityValuesTable.szEncryptionPepper                 <- "1234567890";
    pSecurityValuesTable.iMaxLoginAttempts                  <- 3;
    pSecurityValuesTable.szHashAlgorithm                    <- "WHIRLPOOL";
    pSecurityValuesTable.szSaltPotString                    <- "";
    pSecurityValuesTable.iRaceAttackDelayMS                 <- 1000;
    pSecurityValuesTable.iLoginTimeoutMS                    <- 60000;
    pSecurityValuesTable.iRegisterTimeoutMS                 <- 60000;
    pSecurityValuesTable.iKeyPressSeconds                   <- 1;
    pSecurityValuesTable.bTestingMode                       <- false;
    pSecurityValuesTable.bMaintenanceMode                   <- false;
    pSecurityValuesTable.bUseLUIDVerification               <- false;
    pSecurityValuesTable.bUseLoginRegisterGUI               <- false;

    // -- A string used with the format ( ) function to generate a string from ASCII characters.

    // pSecurityValuesTable.szFormatCharacterMask           <- @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c" + @"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c";
    pSecurityValuesTable.szUnsafeCharacters                 <- "*()[]{}';:@#$%^&*-=+/\\";

    ::print ( "[Server.Core]: Core security values table created" );
    
    return pSecurityValuesTable;
    
}

// -------------------------------------------------------------------------------------------------

function AnticheatCheckPlayers ( ) {

    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        if ( iv.Spawned ) {
        
            // Haven't added anything here yet.
        
        }
    
    }

    return;

}

// -------------------------------------------------------------------------------------------------

function PutPlayerInHackerBox ( pPlayer , szReason ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function GetHashAlgorithm ( ) {

    switch ( GetSecurityConfiguration ( ).szHashAlgorithm.tolower ( ) ) {
    
        case "md5":
        
            return MD5;
            
        case "sha1":
        
            return SHA1;

        case "whirlpool":
        
            return WHIRLPOOL;

        case "sha128":
        
            return SHA128;

        case "sha256":
        
            return SHA256;  

        case "sha512":
        
            return SHA512;
            
        default:
            
            return WHIRLPOOL;
    
    }
    
    return WHIRLPOOL;

}

// -------------------------------------------------------------------------------------------------

function IsClientDateVerified ( pPlayer ) {

    if ( !GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        return true;
    
    }

    if ( !ClientDateVerified [ pPlayer.ID ] ) {
        
        return false;
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RequestClientTimeVerification ( pPlayer ) {

    if ( !GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        return false;
    
    }

    CallClientFunc ( pPlayer , "lilc/Client.nut" , "ServerRequestingVerification" );

}

// -------------------------------------------------------------------------------------------------

function ReconnectDetected ( pPlayer ) {

    CrashPlayer ( pPlayer );

    return true;

}

function CrashPlayer ( pPlayer ) {
    
    SetCameraMatrix ( pPlayer , Vector ( 5000 , 5000 , 5000 ) , Vector ( 5000 , 5000 , 5000 ) );
    
}

// -------------------------------------------------------------------------------------------------

function CheckClientTimeVerification ( pPlayer ) {

    if ( !GetUtilityConfiguration ( "bUseLUIDVerification" ) ) {
    
        NewTimer ( "InitPlayer" , 500 , 1 , pPlayer );  
    
        return true;
    
    }

    if ( !IsClientDateVerified ( pPlayer ) ) {
    
        MessagePlayer ( "Your LUID couldn't not be verified. Please reconnect." , pPlayer , GetRGBColour ( "Yellow" ) );
        
        NewTimer ( "KickPlayer" , 500 , 1 , pPlayer );
    
    }
    
    RequestClientScreenInfo ( pPlayer );
    HideHUDForPlayer ( pPlayer );   
    CreatePlayerMapIcons ( pPlayer );   
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function StripTextOfBlockedWords ( szOldString ) {
    
    local szSafeString = szOldString;
    local pSplitString = [ ];
    
    foreach ( ii , iv in GetCoreTable ( ).Utilities.szBlockedWords ) {
        
        print ( iv );
    
        szSafeString = StripBlockedWords ( szSafeString , iv );
        
    }
    
    return szSafeString;
    
}

// -------------------------------------------------------------------------------------------------

function StripBlockedWords ( szString , szWord ) {
    
    local pSplitString = [ ];
    local szSafeString = "";
    
    while ( szSafeString.find ( szWord ) != false ) {
        
        szSafeString = szSafeString.slice ( 0 , szString.find ( szWord ) ) + szSafeString.slice ( szString.find ( szWord ) );
        
    } 
    
    return szString;
    
}

// -------------------------------------------------------------------------------------------------

function IsLoginRegisterGUIEnabled ( ) {

    return GetSecurityConfiguration ( "bUseLoginRegisterGUI" );

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Security]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------