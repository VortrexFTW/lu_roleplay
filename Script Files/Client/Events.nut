// -------------------------------------------------------------------------------------------------

function onClientMouseWheel ( bWheelUp ) {

	HandleCustomBindKeyScrollWheel ( bWheelUp );
	
    HandleClanManagerScrolling ( bWheelUp );    
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function onClientRender ( ) {

    HandleSwimming ( );

}

// -------------------------------------------------------------------------------------------------

function onClientSpawn ( pSpawn ) {
    
    bSpawned <- true;

}

// -------------------------------------------------------------------------------------------------

function onClientDeath ( pKiller , iWeapon , iBodyPart ) {

    bSpawned <- false;

}

// -------------------------------------------------------------------------------------------------

function onClientRequestSpawn ( pSpawn )  {

    return 0;

}

// -------------------------------------------------------------------------------------------------

function onClientRequestClass ( pClass ) {

    if ( !bClassChange ) {
    
        return 0;
    
    }

    return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function onPlayerPart ( pPlayer , iReason ) {

    return 0;

}

// -------------------------------------------------------------------------------------------------

function onClientKeyStateChange ( iOldKeys , iNewKeys ) {

	HandleFireTruckExtinguishKeyPress ( iOldKeys , iNewKeys );

}

// -------------------------------------------------------------------------------------------------

function onClientMouseClick ( iButton , bDown , iX , iY ) {

	HandleCustomBindKeysMouseClick ( iButton , bDown );

}

// -------------------------------------------------------------------------------------------------

function onClientShot ( pPlayer , iWeaponID , iBodyPart ) {
    
	HandleTazerShot ( pPlayer , iWeaponID , iBodyPart );
    
    return 1;

}