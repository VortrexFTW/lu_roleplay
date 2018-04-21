// -------------------------------------------------------------------------------------------------

function HandleSwimming ( ) {

    if ( bSpawned ) {

        if ( IsClientSwimming ( ) ) {
        
            if ( !bSwimmingKeys ) {
            
                BindSwimmingKeys ( );
            
            }
        
        } else {
        
            if ( bSwimmingKeys ) {
            
                UnbindSwimmingKeys ( );
            
            }
        
        }
        
    }
    
}

// -------------------------------------------------------------------------------------------------

function IsClientSwimming ( ) {

    if ( GetGroundZLevel == 0 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function BindSwimmingKeys ( ) {

    bSwimmingKeys <- true;

}

// -------------------------------------------------------------------------------------------------

function UnbindSwimmingKeys ( ) {

    bSwimmingKeys <- false;

}