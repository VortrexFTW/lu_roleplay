// -------------------------------------------------------------------------------------------------

function onScriptLoad ( ) {

    print ( "------------------------------------------------------------------------------" );
    print ( "[Client.Core]: Initializing client scripts" );

    bSpawned <- false;

    // Whether to allow class change or not
    bClassChange <- true;
    
    pClanManager <- { bEnabled = false , iTopMemberScrollPosition = 0 , iTopRankScrollPosition = 0 , iTopTurfScrollPosition = 0 , szPage = "General" , pClanRanks = [ ] , pClanMembers = [ ] , pClanTurfs = [ ] };
    
    //BindHydraulicKeys ( );
    //BindVehicleKeys ( );
    
    szServerScript <- "lilc/Server.nut";
    
    bSwimmingKeys <- false;
    
    InitGUI ( );
    
    CallServerFunc ( szServerScript , "ClientReady" , FindLocalPlayer ( ) , clock ( ) );

    InitBindKeys ( );
    
}

// -------------------------------------------------------------------------------------------------