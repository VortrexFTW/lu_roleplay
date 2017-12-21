// -------------------------------------------------------------------------------------------------

function HandleFireTruckExtinguishKeyPress ( iOldKeys , iNewKeys ) {

    if ( iNewKeys & KEY_INCAR_FIRE ) {
    
        CallServerFunc ( szServerScript , "FiretruckHoseSprayStart" , FindLocalPlayer ( ) );
        
    }
    
    if ( iOldKeys & KEY_INCAR_FIRE ) {
    
        CallServerFunc ( szServerScript , "FiretruckHoseSprayStop" , FindLocalPlayer ( ) , time ( ) );
    
    }
	
}

// -------------------------------------------------------------------------------------------------