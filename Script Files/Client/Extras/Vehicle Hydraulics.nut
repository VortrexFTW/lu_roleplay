
// -------------------------------------------------------------------------------------------------

function HydraulicsDown ( ) {

    CallServerFunc ( szServerScript , "HydraulicsDown" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function HydraulicsUp ( ) {

    CallServerFunc ( szServerScript , "HydraulicsUp" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function HydraulicsLock ( ) {

    CallServerFunc ( szServerScript , "HydraulicsLock" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function BindHydraulicsKeys ( ) {

    BindKey ( 'H' , BINDTYPE_DOWN , HydraulicsUp );
    BindKey ( 'H' , BINDTYPE_UP , HydraulicsDown );

}

// -------------------------------------------------------------------------------------------------

function UnbindHydraulicsKeys ( ) {

    UnbindKey ( 'H' );
    UnbindKey ( 'H' );
    
}