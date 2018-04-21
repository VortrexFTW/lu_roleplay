function InitBindKeys ( ) {

    bLeftMouseClickBind <- false;
    bRightMouseClickBind <- false;
    bMiddleMouseClickBind <- false;
    bMouseWheelUpBind <- false;
    bMouseWheelDownBind <- false;
    bLeftMouseReleaseBind <- false;
    bRightMouseReleaseBind <- false;
    bMiddleMouseReleaseBind <- false;   
    
}

// -------------------------------------------------------------------------------------------------

function AddCustomBindKey ( iBindKey ) {

    if ( iBindKey >= 0 ) {
        
        BindKey ( iBindKey , BINDTYPE_UP , UseCustomBindKey , iBindKey );
    
    } else {
    
        switch ( iBindKey.tostring ( ) ) {
        
            case "-1":
                bLeftMouseClickBind <- true;
                break;

            case "-2":
                bRightMouseClickBind <- true;
                break;

            case "-3":
                bMiddleMouseClickBind <- true;
                break;

            case "-4":
                bMouseWheelUpBind <- true;
                break;

            case "-5":
                bMouseWheelDownBind <- true;
                break;
                
            case "-6":
                bLeftMouseReleaseBind <- true;
                break;

            case "-7":
                bRightMouseReleaseBind <- true;
                break;

            case "-8":
                bMiddleMouseReleaseBind <- true;
                break;      
        }
    
    }
    
    print ( "[Client.BindKey]: Added bind key " + iBindKey );

}

// -------------------------------------------------------------------------------------------------

function HandleCustomBindKeyScrollWheel ( bWheelUp ) {

    if ( bWheelUp ) {
    
        if ( bMouseWheelUpBind ) {
        
            UseCustomBindKey ( -4 );
        
        }
    
    } else {

        if ( bMouseWheelDownBind ) {
        
            UseCustomBindKey ( -5 );
        
        }
    
    }

}

// -------------------------------------------------------------------------------------------------

function HandleCustomBindKeyMouseClick ( iButton , bDown ) {

    if ( bDown ) {
    
        switch ( iButton ) {
        
            case 1:
                if ( bLeftMouseClickBind ) {
                
                    UseCustomBindKey ( -1 );
                
                }
                break;
                
            case 2:
                if ( bRightMouseClickBind ) {
                
                    UseCustomBindKey ( -2 );
                
                }
                break;  

            case 3:
                if ( bMiddleMouseClickBind ) {
                
                    UseCustomBindKey ( -3 );
                
                }
                break;          
        
        }
    
    } else {
    
        switch ( iButton ) {
        
            case 1:
                if ( bLeftMouseReleaseBind ) {
                
                    UseCustomBindKey ( -6 );
                
                }
                break;
                
            case 2:
                if ( bRightMouseReleaseBind ) {
                
                    UseCustomBindKey ( -7 );
                
                }
                break;  

            case 3:
                if ( bMiddleMouseReleaseBind ) {
                
                    UseCustomBindKey ( -8 );
                
                }
                break;          
        
        }
    
    }  
    
}

// -------------------------------------------------------------------------------------------------

function UseCustomBindKey ( iBindKey ) {

    print ( "[Client.BindKey]: Using bind key " + iBindKey );

    CallServerFunc ( szServerScript , "UseCustomBindKey" , FindLocalPlayer ( ) , iBindKey );
    
    return true;

}

// -------------------------------------------------------------------------------------------------