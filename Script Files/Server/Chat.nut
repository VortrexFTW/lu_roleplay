
// NAME: Chat.nut
// DESC: Adds and manages chat commands and services.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitChatScript ( ) {

    AddChatCommandHandlers ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddChatCommandHandlers ( ) {

    AddCommandHandler ( "Shout"                 , AreaShoutCommand                  , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "S"                     , AreaShoutCommand                  , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "Talk"                  , AreaTalkCommand                   , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Local"                 , AreaTalkCommand                   , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "L"                     , AreaTalkCommand                   , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "PM"                    , PrivateMessageCommand             , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "MSG"                   , PrivateMessageCommand             , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Send"                  , PrivateMessageCommand             , GetStaffFlagValue ( "None" ) );

    return true;    

}

// -------------------------------------------------------------------------------------------------

function RemoveChatCommandHandlers ( ) {

    AddCommandHandler ( "Shout" );
    AddCommandHandler ( "S" );
    
    AddCommandHandler ( "Talk" );
    AddCommandHandler ( "Local" );
    AddCommandHandler ( "L" );
    
    AddCommandHandler ( "PM" );
    AddCommandHandler ( "MSG" );
    AddCommandHandler ( "Send" );

    return true;    

}

// -------------------------------------------------------------------------------------------------

function AreaTalkCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Talks to nearby players." , [ "Talk" , "Local" , "L" ] , "" );

        return false;

    }   

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/talk <message>" );
        
        return false;
    
    }
    
    PlayerAreaTalkMessage ( pPlayer , szParams );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function AreaShoutCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Shouts to nearby players" , [ "Shout" , "S" ] , "" );

        return false;

    }   

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/shout <message>" );
        
        return false;
    
    }

    PlayerAreaShoutMessage ( pPlayer , szParams );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function PrivateMessageCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Sends a private message to another player" , [ "PM" , "MSG" ] , "" );

        return false;

    }   

    local szMessage = "";
    local pReceiver = false;

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bMuted ) {
    
        SendPlayerErrorMessage ( pPlayer , "You are muted, and cannot speak!" );
        
        return false;
    
    }
    
    if ( !szParams || ( szParams == "" ) || ( NumTok ( szParams , " " ) < 2 ) ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/PM <Player Name/ID> <Message>" );
        
        return false;
    
    }
    
    pReceiver = FindPlayer ( GetTok ( szParams , " " , 1 ) );
    
    if ( !pReceiver ) {
    
        SendPlayerErrorMessage ( pPlayer , "That player is not connected!" );
        
        return false;
    
    }
    
    szMessage = GetRemainingString ( szParams , " " , 2 );

    PlayerPrivateMessage ( pPlayer , pReceiver , szMessage );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function PlayerPrivateMessage ( pSender , pReceiver , szMessage ) {

    MessagePlayer ( GetHexColour ( "Yellow" ) + "[PM] From " + pSender.ColouredName + ": " + GetHexColour ( "LightGrey" ) + szMessage , pReceiver , GetRGBColour ( "White" ) );
    MessagePlayer ( GetHexColour ( "Yellow" ) + "[PM] To " + pReceiver.ColouredName + ": " + GetHexColour ( "LightGrey" ) + szMessage , pSender , GetRGBColour ( "White" ) );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaTalkMessage ( pPlayer , szMessage ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
        
    }
    
    foreach ( ii , iv in GetPlayersInRange ( pPlayer.Pos , 20.0 ) ) {
        
        MessagePlayer ( GetHexColourByType ( "AreaTalkHeader" ) + "[NEARBY] " + GetHexColourByType ( "AreaTalkName" ) + pPlayer.Name + ": " + GetHexColourByType ( "AreaTalkMessage" ) + szMessage , iv );
    
    }
    
    //EchoPlayerTalk ( pPlayer , szMessage );
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaShoutMessage ( pPlayer , szMessage ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
        
    }
    
    foreach ( ii , iv in GetPlayersInRange ( pPlayer.Pos , 40.0 ) ) {
        
        MessagePlayer ( GetHexColourByType ( "AreaShoutHeader" ) + "[SHOUT] " + GetHexColourByType ( "AreaShoutName" ) + pPlayer.Name + ": " + GetHexColourByType ( "AreaShoutMessage" ) + szMessage + "!" , iv )
    
    }
    
    //EchoPlayerShout ( pPlayer , szMessage );
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerAreaActionMessage ( pPlayer , szMessage ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
        
    }
    
    foreach ( ii , iv in GetPlayersInRange ( pPlayer.Pos , 30.0 ) ) {
        
        MessagePlayer ( GetHexColour ( "LightPurple" ) + "* " + szName + " " + szMessage + "!" , iv , GetRGBColour ( "White" ) );
    
    }
    
    //EchoPlayerShout ( pPlayer , szMessage );
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Chat]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------