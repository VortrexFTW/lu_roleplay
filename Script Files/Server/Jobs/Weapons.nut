// -------------------------------------------------------------------------------------------------

function InitWeaponsJobScript ( ) {

    AddWeaponsJobCommandHandlers ( );
    
    print ( "[Server.Jobs.Weapons]: Script init complete." );

    return true;

}

// -------------------------------------------------------------------------------------------------

function AddWeaponsJobCommandHandlers ( ) {
    
    print ( "[Server.Jobs.Taxi]: Command handlers added." );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerWeaponDealer ( pPlayer ) {

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( DoesPlayerHaveAJob ( pPlayer ) ) {
    
        if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Weapon ) {
        
            return true;
        
        }
        
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Weapons]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------