// -------------------------------------------------------------------------------------------------

function ConsoleMessage ( szMessage ) {
    
    print ( szMessage );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function EnableMouse ( ) {

    while ( !IsMouseCursorShowing ( ) ) {
    
        ShowMouseCursor ( true );
        
    }   
    
}

// -------------------------------------------------------------------------------------------------

function DisableMouse ( ) {

    while ( IsMouseCursorShowing ( ) ) {
    
        ShowMouseCursor ( false );
    
    }   
    
}

// -------------------------------------------------------------------------------------------------

function ShowHUD ( ) {

    SetHUDEnabled ( true );

}

// -------------------------------------------------------------------------------------------------

function HideHUD ( ) {

    SetHUDEnabled ( false );

}

// -------------------------------------------------------------------------------------------------

function ToggleClassChange ( bState ) {

    bClassChange = bState;

}