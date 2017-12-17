
// NAME: Houses.nut
// DESC: Provides info and commands for houses.
// NOTE: None

// -- COMMANDS -------------------------------------------------------------------------------------

function AddHousesCommandHandlers ( ) {

    return true;

}

// -- SCRIPT INIT ----------------------------------------------------------------------------------

function InitHousesScript ( ) {

    AddHousesCommandHandlers ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function LoadHousesFromDatabase ( ) {
   
    local pHousesData = [ ];
    local pHouseData = { };
    local iHousesCount = 0;
    
    // -- Return the table, even if it's empty. It will show that no houses exist to load.
    
    return pHousesData;
    
}

// -------------------------------------------------------------------------------------------------

function ShowHouseInformationToPlayer ( pPlayer , pHouseData ) {
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateHousePickups ( ) {
    
    local pPickup = false;
    
    print ( "[Server.Houses]: House pickups created" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SaveAllHousesToDatabase ( ) {

    

}

// -------------------------------------------------------------------------------------------------

function GetNumberOfHouses ( ) {

    return 0;

}

// -------------------------------------------------------------------------------------------------

function GotoHouseCommand ( pPlayer , szCommand , szParams ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.House]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------