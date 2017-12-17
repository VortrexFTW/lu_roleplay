// -------------------------------------------------------------------------------------------------

function InitIRCScript ( ) {
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function EchoEventToIRC ( szEventText , bEchoOverride = false ) {

    CallFunc ( "lilc-irc/Server.nut" , "EchoEventToIRC" , szEventText , bEchoOverride );

    return true;

}

// -------------------------------------------------------------------------------------------------

function IRCOnPlayerConnect ( pPlayer ) {

    EchoEventToIRC ( pPlayer.Name + " has joined the game" , true );

    return true;

}

// -------------------------------------------------------------------------------------------------

function IRCOnPlayerPart ( pPlayer , iReason ) {

    EchoEventToIRC ( pPlayer.Name + " has left the game (" + GetPartReasonText ( iReason ) + ")" , true );

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.IRC]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------