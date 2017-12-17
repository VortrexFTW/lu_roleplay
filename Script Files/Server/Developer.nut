
// NAME: Developer.nut
// DESC: Handles anything related to script management and manipulation.
// NOTE: This script file provides abilities and commands to modify anything via scripts with unrestricted usage.

// -------------------------------------------------------------------------------------------------

function InitDeveloperScript ( ) {

    AddDeveloperCommandHandlers ( );

    //seterrorhandler ( ErrorHandler );
    
    print ( "[Server.Developer]: Script file initialized." );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddDeveloperCommandHandlers ( ) {

    AddCommandHandler ( "SE"                    , ExecuteCodeCommand                        , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "SR"                    , ExecuteReturnCodeCommand                  , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "FuncAlias"             , AddFunctionAliasCommand                   , GetStaffFlagValue ( "Developer" ) );
    
    AddCommandHandler ( "GetLUID"               , GetPlayerLUIDCommand                      , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "GetIP"                 , GetPlayerIPCommand                        , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "GetPlrNearVeh"         , GetPlayersNearVehicleCommand              , GetStaffFlagValue ( "Developer" ) );
    //AddCommandHandler ( "GetVehNearPlr"       , GetVehicleNearPlayerCommand               , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "GetPlrNearPlr"         , GetPlayersNearPlayerCommand               , GetStaffFlagValue ( "Developer" ) );
    
    AddCommandHandler ( "Bug"                   , SubmitBugCommand                          , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Idea"                  , SubmitIdeaCommand                         , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Position"              , SubmitPositionCommand                     , GetStaffFlagValue ( "None" ) );       
    
    AddCommandHandler ( "ReloadScripts"         , ReloadAllScriptsCommand                   , GetStaffFlagValue ( "Developer" ) );  
    AddCommandHandler ( "ReloadIRC"             , ReloadIRCModuleCommand                    , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "ReloadCommands"        , ReloadAllCommandsCommand                  , GetStaffFlagValue ( "Developer" ) );
    
    AddCommandHandler ( "UseVerifyLUID"         , ToggleUseLUIDVerificationCommand          , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "UseAuthGUI"            , ToggleUseLoginRegisterGUICommand          , GetStaffFlagValue ( "Developer" ) );
    AddCommandHandler ( "UseLoginGUI"           , ToggleUseLoginRegisterGUICommand          , GetStaffFlagValue ( "Developer" ) );

    //AddCommandHandler ( "ReloadDiscord"       , ReloadDiscordModuleCommand                , GetStaffFlagValue ( "Developer" ) );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerLUIDCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Gets a player's LUID" , [ "GetLUID" , "LUID" ] , "" );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
        
        return false;
    
    }
    
    if ( !FindPlayer ( szParams ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
        
        return false;
    
    }

    local pTarget = FindPlayer ( szParams );    
    
    SendPlayerSuccessMessage ( pPlayer , pPlayer.Name + "'s LUID is " + pPlayer.LUID );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerIPCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Gets a player's IP" , [ "GetIP" , "IP" ] , "" );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
        
        return false;
    
    }
    
    if ( !FindPlayer ( szParams ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
        
        return false;
    
    }

    local pTarget = FindPlayer ( szParams );    
    
    SendPlayerSuccessMessage ( pPlayer , pPlayer.Name + "'s IP is " + pPlayer.IP );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayersNearPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Gets players that are nearby a player" , [ "GetPlrNearPlr" , "PlrNearPlr" , "GPNP" ] , "" );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Distance>" );
        
        return false;
    
    }
    
    if ( NumTok ( szParams , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID> <Distance>" );
    
        return false;
    
    }
    
    local szTargetParam = GetTok ( szParams , " " , 1 );
    local szDistanceParam = GetTok ( szParams , " " , 2 );
    
    if ( !FindPlayer ( szTargetParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
        
        return false;
    
    }
    
    if ( IsNum ( szDistanceParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeNumber" ) , "distance" ) );
    
        return false;
    
    }

    local pTarget = FindPlayer ( szParams );
    local szNearbyPlayers = "";
    
    foreach ( ii , iv in GetSpawnedPlayers ( ) ) {
    
        if ( GetDistance ( pTarget.Pos , iv.Pos ) <= fDistanceParam ) {
        
            szNearbyPlayers += iv.Name + " ";
        
        }
    
    }
    
    SendPlayerSuccessMessage ( pPlayer , "Players within " + fDistanceParam + " of " + pPlayer.Name );
    SendPlayerNormalMessage ( pPlayer , szNearbyPlayers );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayersNearVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Gets players that are nearby a vehicle" , [ "GetPlrNearVeh" , "PlrNearVeh" , "GPNV" ] , "" );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/GetPlrNearVeh <Vehicle ID> <Distance>" );
        
        return false;
    
    }
    
    if ( NumTok ( szParams , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/GetPlrNearVeh <Vehicle ID> <Distance>" );
    
        return false;
    
    }
    
    local szVehicleParam = GetTok ( szParams , " " , 1 );
    local szDistanceParam = GetTok ( szParams , " " , 2 );
    
    if ( IsNum ( szVehicleParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeNumber" ) , "vehicle ID" ) );
    
        return false;
    
    }   
    
    if ( !FindVehicle ( szVehicleParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
        
        return false;
    
    }
    
    if ( IsNum ( szDistanceParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeNumber" ) , "distance" ) );
    
        return false;
    
    }

    local pVehicle = FindVehicle ( szVehicleParam );
    local szNearbyVehicles = "";
    
    foreach ( ii , iv in GetSpawnedPlayers ( ) ) {
    
        if ( GetDistance ( pVehicle.Pos , iv.Pos ) <= fDistanceParam ) {
        
            szNearbyVehicles += iv.Name + " ";
        
        }
    
    }
    
    SendPlayerSuccessMessage ( pPlayer , "Players within " + fDistanceParam + " of vehicle " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ")" );
    SendPlayerNormalMessage ( pPlayer , szNearbyVehicles );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehiclesNearPlayerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Gets vehicles that are nearby a player" , [ "GetVehNearPlr" , "VehNearPlr" , "GVNP" ] , "" );
        
        return false;
    
    }
    
    if( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/GetVehNearPlr <Player Name/ID> <Distance>" );
        
        return false;
    
    }
    
    if ( NumTok ( szParams , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/GetVehNearPlr <Player Name/ID> <Distance>" );
    
        return false;
    
    }
    
    local szPlayerParam = GetTok ( szParams , " " , 1 );
    local szDistanceParam = GetTok ( szParams , " " , 2 );
    
    if ( !FindVehicle ( szPlayerParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
        
        return false;
    
    }
    
    if ( IsNum ( szDistanceParam ) ) {
    
        SendPlayerErrorMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "MustBeNumber" ) , "distance" ) );
    
        return false;
    
    }

    local pTarget = FindPlayer ( szTargetParam );
    local szNearbyPlayers = "";
    
    foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
    
        if ( GetDistance ( pTarget.Pos , iv.pVehicle.Pos ) <= fDistanceParam ) {
        
            szNearbyVehicles += GetVehicleName ( iv.pVehicle ) + " ";
        
        }
    
    }
    
    SendPlayerSuccessMessage ( pPlayer , "Players within " + fDistanceParam + " of vehicle " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ")" );
    SendPlayerNormalMessage ( pPlayer , szNearbyVehicles );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ExecuteCodeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Executes custom squirrel code server-side" , [ "SE" , "ServerExecute" ] , "Full script access, including root table." );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/ServerExecute <Code>" );
        
        return false;
    
    }
    
    local cCodeClosure = compilestring ( szParams );
    
    if ( !cCodeClosure ) {
    
        SendPlayerErrorMessage ( pPlayer , "Your code contains an error, and cannot be executed." );
        
        return false;
    
    }

    cCodeClosure ( );
    
    SendConsoleMessageToDevelopers ( " ----------------------------------------" );
    SendConsoleMessageToDevelopers ( pPlayer.Name + " has executed code!" );
    SendConsoleMessageToDevelopers ( "Code: " + szParams );
    
    SendMessageToDevelopers ( pPlayer.Name + " has executed code! Check console for info!" );   
    
    SendPlayerSuccessMessage ( pPlayer , "Your code was executed ( " + szParams + " ) " );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ExecuteReturnCodeCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Executes squirrel code server-side, and returns the result." , [ "SR" , "ServerReturn" ] , "Full script access, including root table." );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/ServerReturn <Code>" );
        
        return false;
    
    }
    
    local cCodeClosure = compilestring ( "return " + szParams );
    
    if ( !cCodeClosure ) {
    
        SendPlayerErrorMessage ( pPlayer , "Your code contains an error, and cannot be executed." );
        
        return false;
    
    }

    local pReturnOutput = cCodeClosure ( );
    
    SendConsoleMessageToDevelopers ( " ----------------------------------------" );
    SendConsoleMessageToDevelopers ( pPlayer.Name + " has executed/returned code!" );
    SendConsoleMessageToDevelopers ( "Code: " + szParams );
    SendConsoleMessageToDevelopers ( "Returns: " + pReturnOutput );
    
    SendMessageToDevelopers ( pPlayer.Name + " has executed/returned code! Check console for info!" );
    
    SendPlayerSuccessMessage ( pPlayer , "Your code was executed, and returned: " + pReturnOutput );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function onConsoleInput ( szCommand , szParams ) {
    
    switch ( szCommand.tolower ( ) ) {
    
        case "se":
        
            if ( !szParams ) {

                print ( "[DEBUG]: You need to enter some code!" );
                
                return;         
            
            }
        
            local pResult = compilestring ( szParams );
            
            if ( !pResult ) {
            
                print ( "[DEBUG]: There was an error in your code!" );
                
                return;
                
            }
            
            pResult( );
            
            print ( "SE: " + szParams );
            
            return;
            
        case "sr":

            if ( !szParams ) {

                print ( "[DEBUG]: You need to enter some code!" );
                
                return;         
            
            }       
        
            local pResult = compilestring ( "return " + szParams );
            
            if ( !pResult ) {
            
                print ( "[DEBUG]: There was an error in your code!" );
                
                return;
                
            }
            
            local pReturns = pResult( );
            
            print ( "SR: " + pReturns + " (" + szParams + ")" );
            
            return; 

        case "luid":
            
            if ( !szParams ) {

                print ( "[DEBUG]: You need to enter a player name or ID!" );
                
                return;         
            
            }
            
            local pTarget = !FindPlayer ( szParams );
            
            if ( !pTarget ) {
            
                print ( "[DEBUG]: Player not found" );
            
            }
            
            print ( "[DEBUG]: " + GetPlayerNameAndIDForConsole ( pTarget ) + " LUID: " + pTarget.LUID );
            
            break;
            
        case "scriptreload":
        
            LoadAllScriptFiles ( );
        
            print ( "[DEBUG]: Script files reloaded!" );
            
            break;
    
    }

}

// -------------------------------------------------------------------------------------------------

function SubmitBugCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescBug" ) , [ "Bug" ] , "" );

        return false;

    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/Bug <Message>" );
        
        return false;
    
    }
    
    local pPlayerData = GetPlayerData ( pPlayer );

    local szSafeMessage = StandaloneMySQLEscapeString ( szParams );
    local szQueryString = "INSERT INTO bug_main (`bug_added_by`,`bug_message`,`bug_timestamp`,`bug_pos_x`,`bug_pos_y`,`bug_pos_z`,`bug_rot`,`bug_session`,`bug_script_ver`,`bug_svr_start`) VALUES ("+pPlayerData.iDatabaseID+",'"+szSafeMessage+"',UNIX_TIMESTAMP(),"+pPlayer.Pos.x+","+pPlayer.Pos.y+","+pPlayer.Pos.z+","+pPlayer.Angle+","+PlayerConnectionID[pPlayer.ID]+",'"+GetUtilityConfiguration("szScriptVersion")+"',"+iServerStart+")";
    
    print ( szQueryString );
    
    StandaloneMySQLQuery ( szQueryString );
    
    local szBugDescMessage = szParams;
    if ( szParams.len ( ) > 32 ) {
    
        szBugDescMessage = szParams.slice ( 0 , 32 ) + " ...";
    
    }
    
    local szMessageToScripters = pPlayer.Name + " added a bug! (" + szBugDescMessage + ")";
    
    SendMessageToDevelopers ( szMessageToScripters );
    SendPlayerSuccessMessage ( pPlayer , "Thank you! Your bug has been sent to the scripters!" );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitIdeaCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescIdea" ) , [ "Idea" ] , "" );

        return false;

    }   

    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/Idea <Message>" );
        
        return false;
    
    }   

    local pPlayerData = GetPlayerData ( pPlayer );
    
    local szSafeMessage = StandaloneMySQLEscapeString ( szParams );
    local szQueryString = "INSERT INTO idea_main (`idea_added_by`,`idea_message`,`idea_timestamp`,`idea_pos_x`,`idea_pos_y`,`idea_pos_z`,`idea_rot`,`idea_session`,`idea_script_ver`,`idea_svr_start`) VALUES ("+pPlayerData.iDatabaseID+",'"+szSafeMessage+"',UNIX_TIMESTAMP(),"+pPlayer.Pos.x+","+pPlayer.Pos.y+","+pPlayer.Pos.z+","+pPlayer.Angle+","+PlayerConnectionID[pPlayer.ID]+",'"+GetUtilityConfiguration("szScriptVersion")+"',"+iServerStart+")";
    
    print ( szQueryString );
    
    StandaloneMySQLQuery ( szQueryString );
    
    local szIdeaDescMessage = szParams;
    if ( szParams.len ( ) > 32 ) {
    
        szIdeaDescMessage = szParams.slice ( 0 , 32 ) + " ...";
    
    }
    
    local szMessageToScripters = pPlayer.Name + " added an idea! (" + szIdeaDescMessage + ")";
    
    SendMessageToDevelopers ( szMessageToScripters );
    SendPlayerSuccessMessage ( pPlayer , "Thank you! Your idea has been sent to the scripters!" );  
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SubmitPositionCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescPosition" ) , [ "Position" ] , "" );

        return false;

    }       
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/Position <Name>" );
        
        return false;
    
    }   

    local pPlayerData = GetPlayerData ( pPlayer );
    
    local szSafeMessage = StandaloneMySQLEscapeString ( szParams );
    
    StandaloneMySQLQuery ( "INSERT INTO idea_main (`idea_added_by`,`idea_message`,`idea_timestamp`,`idea_pos_x`,`idea_pos_y`,`idea_pos_z`,`idea_rot`,`idea_session`,`idea_script_ver`,`idea_svr_start`) VALUES ("+pPlayerData.iDatabaseID+","+szSafeMessage+",UNIX_TIMESTAMP(),"+pPlayer.Pos.x+","+pPlayer.Pos.y+","+pPlayer.Pos.z+","+pPlayer.Angle+","+PlayerConnectionID[pPlayer.ID]+",'"+GetUtilityConfiguration("iServerStart")+"',"+iServerStart+")" );   
    
    if ( szSafeIniString.len ( ) > 32 ) {
    
        szPosDescMessage = szSafeIniString.slice ( 0 , 32 ) + " ..."
    
    }
    
    SendMessageToDevelopers ( pPlayer.Name + " added position #" + iPositionCount + " with name '" + szPosDescMessage + "' at " + GetDistrictName ( pPlayer.Pos.x , pPlayer.Pos.y ) + " (" + szPosition + ")" );
    SendPlayerSuccessMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PositionLogged" ) );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddFunctionAliasCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , szCommand , "Adds a function alias" , [ "FuncAlias" ] , "" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/FuncAlias <Function> <Alias>" );
        
        return false;
    
    }
    
    if ( NumTok ( pPlayer , " " ) != 2 ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/FuncAlias <Function> <Alias>" );
        
        return false;
    
    }
    
    local szFunction = GetTok ( pPlayer , " " , 1 );
    local pFunction = getroottable ( ).rawget ( szFunction );
    local szAlias = GetTok ( pPlayer , " " , 2 );
    
    if ( type ( pFunction ) != "function" ) {
        
        SendPlayerErrorMessage ( pPlayer , "The function " + szFunction + " does not exist!" );
        
        return false;
        
    }
    
    if ( getroottable ( ).rawin ( szAlias ) ) {
        
        SendPlayerErrorMessage ( pPlayer , "The function " + szAlias + " could not be created!" );
        
        return false;
        
    }
    
    getroottable ( ).rawset ( szAlias , pFunction );
    
    SendPlayerSuccessMessage ( pPlayer , "Function alias added! ( " + szFunction + " as " + szAlias + " ) " );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ReloadAllScriptsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Reloads all server scripts" , [ "ReloadScripts" ] , "" );
        
        return false;
    
    }
    
    ::LoadAllScriptFiles ( );
    ::ReloadAllCommandHandlers ( );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ReloadAllCommandsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Reloads all commands and handlers" , [ "ReloadCommands" ] , "" );
        
        return false;
    
    }
    
    ReloadAllCommandHandlers ( );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ReloadAllCommandHandlers ( ) {

    GetCoreTable ( ).rawdelete ( "Commands" );
    GetCoreTable ( ).Commands <- { };
    
    AddStartupCommandHandlers ( );
    AddAccountCommandHandlers ( );
    AddVehicleCommandHandlers ( );
    AddBusinessCommandHandlers ( );
    AddClanCommandHandlers ( );
    AddJobCommandHandlers ( );
    AddBansCommandHandlers ( );
    AddModerationCommandHandlers ( );
    AddDatabaseCommandHandlers ( );
    AddUtilitiesCommandHandlers ( );
    AddDeveloperCommandHandlers ( );
    AddChatCommandHandlers ( );
    AddConfigurationCommandHandlers ( );
    AddAnimationsCommandHandlers ( );
    AddAmmunationCommandHandlers ( );
    AddItemDroppingCommandHandlers ( );
    AddColoursCommandHandlers ( );
    AddHelpCommandHandlers ( );
    AddMiscCommandHandlers ( );
    AddWebsiteCommandHandlers ( );
    
    AddBusJobCommandHandlers ( );
    AddFireJobCommandHandlers ( );
    AddPoliceJobCommandHandlers ( );
    AddTaxiJobCommandHandlers ( );
    AddGarbageJobCommandHandlers ( );
    AddDrugsJobCommandHandlers ( );
    AddWeaponsJobCommandHandlers ( );
    AddMedicJobCommandHandlers ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ReInitAllScriptsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Reinitializes all server scripts" , [ "ReinitScripts" ] , "" );
        
        return false;
    
    }
    
    InitAllScripts ( );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ErrorHandler ( szMessage ) {

    local pErrorStack = getstackinfos ( 2 );
    
    print ( "ERROR: " + pErrorStack.src + ", line " + pErrorStack.line + ". (" + szMessage + ")" );
    
    local szSafeMessage = StandaloneMySQLEscapeString ( szMessage );
    local szSafeFileName = "Unknown";
    
    if ( type ( pErrorStack.src ) == "string" ) {
        szSafeFileName = StandaloneMySQLEscapeString ( pErrorStack.src );
    }
    
    local szLocalsString = "";
    foreach ( ii , iv in getstackinfos ( 1 ).locals ) {
    
        szLocalsString += ii + " : " + iv + " (Type: " + typeof iv + ")\n";
    
    }
    
    
    local szQueryString = "INSERT INTO `error_main` (`error_timestamp`,`error_script_ver`,`error_module`,`error_file`,`error_line`,`error_func`,`error_locals`) VALUES (UNIX_TIMESTAMP(),'"+GetUtilityConfiguration("szScriptVersion")+"',1,'"+pErrorStack.src+"',"+pErrorStack.line+",'"+pErrorStack.func+"','"+szLocalsString+"')";
    print ( szQueryString );
    StandaloneMySQLQuery ( szQueryString );

}

// -------------------------------------------------------------------------------------------------

function ReloadIRCModuleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Reloads IRC Module" , [ "ReloadIRC" ] , "" );
        
        return false;
    
    }
    
    ReloadIRCModule ( );    
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ReloadDiscordModuleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Reloads Discord Module" , [ "ReloadDiscord" ] , "" );
        
        return false;
    
    }
    
    ReloadDiscordModule ( );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

// -- USED FOR IN-GAME SCRIPTING

function p ( pPlayer ) {

    return FindPlayer ( pPlayer );
    
}

// -------------------------------------------------------------------------------------------------

// -- USED FOR IN-GAME SCRIPTING

function v ( pVehicle ) {

    return FindVehicle ( pVehicle );
    
}

// -------------------------------------------------------------------------------------------------

function ReloadDiscordModule ( ) {

    UnloadScript ( "lilc-discord" );
    
    NewTimer ( "LoadScript" , 500 , 1 , "lilc-discord" );

}

// -------------------------------------------------------------------------------------------------

function ReloadIRCModule ( ) {

    UnloadScript ( "lilc-irc" );
    
    NewTimer ( "LoadScript" , 500 , 1 , "lilc-irc" );

}

// -------------------------------------------------------------------------------------------------

function ToggleUseLUIDVerificationCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Turns LUID verification ON/OFF" , [ "UseVerifyLUID" , "UseLUIDCheck" ] , "" );
        
        return false;
    
    }
    
    if ( GetSecurityConfiguration ( "bUseLUIDVerification" ) ) {
    
        GetSecurityConfiguration ( ).bUseLUIDVerification = false;
        WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bUseLUIDVerification" , false );
        SendMessageToDevelopers ( pPlayer.Name + " has turned off LUID verification" );
    
        return true;
    
    } else {

        GetSecurityConfiguration ( ).bUseLUIDVerification = true;
        WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "SECURITY" , "bUseLUIDVerification" , true );
        SendMessageToDevelopers ( pPlayer.Name + " has turned on LUID verification" );
        
        return true;
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ToggleUseLoginRegisterGUICommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Turns the login/register GUI ON/OFF" , [ "UseLoginGUI" , "UseRegisterGUI" , "UseAuthGUI" ] , "" );
        
        return false;
    
    }
    
    if ( GetSecurityConfiguration ( "bUseLoginRegisterGUI" ) ) {
    
        GetSecurityConfiguration ( ).bUseLoginRegisterGUI = false;
        WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "ACCOUNT" , "bUseLoginRegisterGUI" , false );
        Message ( pPlayer.Name + " has disabled the login/register GUI." );
    
        return true;
    
    } else {

        GetSecurityConfiguration ( ).bUseLoginRegisterGUI = true;
        WriteIniBool ( szScriptsPath + "Data/Configuration.ini" , "ACCOUNT" , "bUseLoginRegisterGUI" , true );
        Message ( pPlayer.Name + " has enabled the login/register GUI." );
        
        return true;
    
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Developer]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
