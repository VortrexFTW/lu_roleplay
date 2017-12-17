// -------------------------------------------------------------------------------------------------

function InitDiscordScript ( ) {
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function EchoEventToDiscord ( szEventText , bOverride = false ) {

	CallFunc ( "Scripts/lilc-discord/main.nut" , "EchoEventToDiscord" , szEventText , bOverride );
	return true;

}

// -------------------------------------------------------------------------------------------------

function EchoChatToDiscord ( szName , szText ) {

	CallFunc ( "Scripts/lilc-discord/main.nut" , "EchoPlayerChat" , szName , szText );
	
	return true;

}

// -------------------------------------------------------------------------------------------------