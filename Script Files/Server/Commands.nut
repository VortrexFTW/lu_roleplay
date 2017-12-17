
// NAME: Commands.nut
// DESC: Manages command handling functions
// NOTE: There are NO command handlers in this file. Only the handler management functions.

// -------------------------------------------------------------------------------------------------

function AddCommandHandler ( szCommand , pListener , iStaffFlags , bRequireLogin = true ) {
    
    if ( typeof szCommand != "string" || typeof pListener != "function" ) {
        
        return false;
        
    }
    
    local pCommandData = { };

    pCommandData.szCommand <- szCommand.tolower ( );
    pCommandData.iStaffFlags <- iStaffFlags;
    pCommandData.bEnabled <- true;
    pCommandData.pListener <- pListener;
    pCommandData.bRequireAuth <- bRequireLogin;
    
    GetCoreTable ( ).Commands.rawset ( szCommand.tolower ( ) , pCommandData );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RemoveCommandHandler ( szCommand ) {
    
    if ( typeof szCommand != "string" ) {
        
        return false;
        
    }
    
    GetCoreTable ( ).Commands.rawdelete ( szCommand );

    return true;    
    
}

// -------------------------------------------------------------------------------------------------

function DoesCommandHandlerExist ( szCommand ) {

    return GetCoreTable ( ).Commands.rawin ( szCommand );

}

// -------------------------------------------------------------------------------------------------

function DisableCommandHandler ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bEnabled = false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function EnableCommandHandler ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bEnabled = true;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function DisableRequireAuthForCommand ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bRequireAuth = false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function EnableRequireAuthForCommand ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bRequireAuth = true;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function IsCommandAllowedBeforeAuthentication ( szCommand ) {
    
    if ( szCommand.tolower ( ) == "login" ) {
    
        return true;
    
    }
    
    if ( szCommand.tolower ( ) == "register" ) {
    
        return true;
    
    }
    
    if ( !GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bRequireAuth ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function DoesCommandAllowEcho ( szCommand ) {

    if ( GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bAllowEcho ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function DisableCommandEcho ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bAllowEcho = false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function EnableCommandEcho ( szCommand ) {

    if ( DoesCommandHandlerExist ( szCommand ) ) {
    
        GetCoreTable ( ).Commands.rawget ( szCommand.tolower ( ) ).bAllowEcho = true;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Commands]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
