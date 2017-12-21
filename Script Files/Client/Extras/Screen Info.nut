// -------------------------------------------------------------------------------------------------

function ServerRequestingScreenInfo ( ) {

    SendScreenInfoToServer ( );
    
}

// -------------------------------------------------------------------------------------------------

function SendScreenInfoToServer ( ) {

    CallServerFunc ( szServerScript , "ReceiveScreenInfoFromClient" , FindLocalPlayer ( ) , ScreenWidth , ScreenHeight );

    return true;

}