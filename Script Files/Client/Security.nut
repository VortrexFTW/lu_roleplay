// -------------------------------------------------------------------------------------------------

function ServerRequestingVerification ( ) {

    CallServerFunc ( szServerScript , "SendServerVerification" , FindLocalPlayer ( ) , time ( ) );
    
}

// -------------------------------------------------------------------------------------------------

function ServerRequestingScreenInfo ( ) {

    SendScreenInfoToServer ( );
    
}

// -------------------------------------------------------------------------------------------------