function InitAnimationsScript ( ) {

    AddAnimationsCommandHandlers ( );

}

// -------------------------------------------------------------------------------------------------

function AddAnimationsCommandHandlers ( ) {

    AddCommandHandler ( "An"                        , AnimationCommand                  , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Anim"                      , AnimationCommand                  , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Animation"                 , AnimationCommand                  , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "PlayAnim"                  , AnimationCommand                  , GetStaffFlagValue ( "None" ) );
    //AddCommandHandler ( "StopAnim"                , StopAnimationCommand                  , GetStaffFlagValue ( "None" ) );

}

// -------------------------------------------------------------------------------------------------

function RemoveAnimationsCommandHandlers ( ) {

    RemoveCommandHandler ( "An" );
    RemoveCommandHandler ( "Anim" );
    RemoveCommandHandler ( "Animation" );
    RemoveCommandHandler ( "PlayAnim" );
    //RemoveCommandHandler ( "StopAnim" );

}

// -------------------------------------------------------------------------------------------------

function AnimationCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
        
        SendPlayerCommandInfoMessage ( pPlayer , "Plays an animation" , [ "An" , "Anim" , "Animation" , "PlayAnim" ] , "" );
        
        return false;
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Animation ID>" );
        SendPlayerAlertMessage ( pPlayer , "For animation help, use '/Help Anim'" );
        
        return false;
    
    }
    
    local iAnimationID = -1;
    
    if ( !IsNum ( szParams ) ) {
    
        iAnimationID = GetAnimationIDFromName ( szParams );
        
        if ( iAnimationID == -2 ) {
        
            ResetPlayerAnimation ( pPlayer );
            
            return true;
        
        }
        
        if ( iAnimationID == -1 ) {
        
            SendPlayerErrorMessage ( pPlayer , "That animation name doesn't exist, or is disabled!" );
            SendPlayerAlertMessage ( pPlayer , "For animation help, use '/Help Anim'" );
            
            return false;
        
        }
    
    } else {
    
        if ( !IsValidAnimation ( szParams.tointeger ( ) ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "That animation ID doesn't exist, or is disabled!" );
            
            return false;
        
        }
        
        iAnimationID = szParams.tointeger ( );
    
    }
    
    if ( IsPlayerImmobilized ( pPlayer ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "You can't do that right now!" );
        SendPlayerAlertMessage ( pPlayer , "You are immobilized (cuffed, tazed, or knocked out)" );
        
        return false;
    
    }
    
    if ( GetPlayerData ( pPlayer ).pEnteringVehicleNormally != false ) {
    
        SendPlayerErrorMessage ( pPlayer , "You can't use anims when trying to enter/exit a vehicle!" );    
    
        return false;
    
    }   
    
    if ( GetPlayerData ( pPlayer ).pExitingVehicleNormally != false ) {
    
        SendPlayerErrorMessage ( pPlayer , "You can't use anims when trying to exit a vehicle!" );  
    
        return false;
    
    }       
    
    if ( pPlayer.Vehicle ) {
    
        SendPlayerErrorMessage ( pPlayer , "You can't use anims while in a vehicle!" );
    
        return false;
    
    }       
    
    ResetPlayerAnimation ( pPlayer );
    
    NewTimer ( "DelayedSetAnim" , 100 , 1 , pPlayer , iAnimationID );
    
    print ( "[Server.Animations]: " + GetPlayerNameAndIDForConsole ( pPlayer ) + " used animation ID " + iAnimationID );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function DelayedSetAnim ( pPlayer , iAnimationID ) {

    pPlayer.SetAnim ( iAnimationID );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function IsValidAnimation ( iAnimationID ) {

    if ( iAnimationID >= 0 && iAnimationID <= 167 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetAnimationIDFromName ( szAnimName ) {

    // HOLY SHIT, I NEED TO WORK ON THIS .... BAD. VERY BAD.
    switch ( szAnimName.tolower ( ) ) {
    
        case "wave":
            return 12;
            
        case "dive":
            return 156;
            
        case "fall":
            return 16;
            
        case "walk":    
            return 0;
            
        case "run":
            return 1;
            
        case "aimdown":
            return 160;
            
        case "talk":
            return 11;
            
        case "raisegun":
            return 10;
            
        case "tired":
            return 9;
            
        case "headbutt":
            return 70;
            
        case "kick":
            return 71;
            
        case "punch":
            return 69;
            
        case "drop":
            return 162;
            
        case "look1":
            return 7;
            
        case "look2":
            return 158;     
            
        case "scratch":
            return 157;
            
        case "aim":
            return 165;
            
        case "toss":
            return 167;
            
        case "handsup":
            return 167;
            
        case "bow":
            return 126; 
            
        case "stop":
            return -2;
            
        default:
            return -1;
    
    }
    
    return -1;

}