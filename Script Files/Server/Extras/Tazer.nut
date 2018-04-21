// -------------------------------------------------------------------------------------------------

function CheckTazerShot ( pPlayer , pShooter ) {

    local pPlayerData = GetPlayerData ( pPlayer );

    if ( pPlayerData.bTazerArmed ) {
    
        PlayerShotByTazer ( pShooter , pPlayer );
        
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------