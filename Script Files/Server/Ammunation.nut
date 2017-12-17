function InitAmmunationScript ( ) {

	AddAmmunationCommandHandlers ( );

}

// -------------------------------------------------------------------------------------------------

function AddAmmunationCommandHandlers ( ) {

	AddCommandHandler ( "BuyGun" 					, BuyWeaponCommand	 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyWep" 					, BuyWeaponCommand	 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyWeapon" 				, BuyWeaponCommand	 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyAmmo" 					, BuyAmmoCommand	 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyAmmunition" 			, BuyAmmoCommand	 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "GunPrices" 				, WeaponPricesCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "WepPrices" 				, WeaponPricesCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "WeaponPrices" 				, WeaponPricesCommand				, GetStaffFlagValue ( "None" ) );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetPlayerWeaponAmmo ( pPlayer , iWeaponID ) {

	return GetPlayerData ( pPlayer ).pWeaponAmmo [ iWeaponID ];

}

// -------------------------------------------------------------------------------------------------

function BuyWeaponCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
	
		SendPlayerCommandInfoMessage ( pPlayer , "Buys a weapon from an ammunation." , [ "BuyGun" , "BuyWep" , "BuyWeapon" ] , "" );
	
		return false;
	
	}
	
	if ( !CanPlayerUseAmmunation ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You cannot use any ammunations!" );
		
		return false;
		
	}	
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.bAtAmmunation ) {

		SendPlayerErrorMessage ( pPlayer , "You are not at an ammunation!" );
		
		return false;	
	
	}	
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Weapon ID>" );
	
		return false;
		
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;
	
	}
	
	if ( szParams.tointeger ( ) < 1 || szParams.tointeger ( ) > 9 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 1 and 9" );
		
		return false;
	
	}

	if ( DoesPlayerHaveWeapon ( pPlayer , szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You already have a " + GetWeaponName ( szParams.tointeger ( ) ) );
	
		return false;
	
	}
	
	if ( pPlayerData.iCash < GetWeaponPrice ( szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have enough money for a " + GetWeaponName ( szParams.tointeger ( ) ) );
		SendPlayerAlertMessage ( pPlayer , "Use '/GunPrices' for a list of weapon and ammo prices." );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You bought a " + GetWeaponName ( szParams.tointeger ( ) ) + " and got bonus 100 ammo free!" );
	
	TakePlayerCash ( pPlayer , GetWeaponPrice ( szParams.tointeger ( ) ) );
	
	pPlayerData.pHasWeapon [ szParams.tointeger ( ) ] = true;
	pPlayerData.pWeaponAmmo [ szParams.tointeger ( ) ] += 100;
	
	pPlayer.SetWeapon ( szParams.tointeger ( ) ,pPlayerData.pWeaponAmmo [ szParams.tointeger ( ) ] );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyAmmoCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
	
		SendPlayerCommandInfoMessage ( pPlayer , "Buys ammo from an Ammunation." , [ "BuyAmmo" , "BuyAmmunition" ] , "" );
	
		return false;
	
	}
	
	if ( !CanPlayerUseAmmunation ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You cannot use any ammunations!" );
		
		return false;
		
	}	
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.bAtAmmunation ) {

		SendPlayerErrorMessage ( pPlayer , "You are not at an ammunation!" );
		
		return false;	
	
	}		
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Weapon ID> <Ammo Amount>" );
	
		return false;
		
	}
	
	if ( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Weapon ID> <Ammo Amount>" );
	
		return false;
		
	}	
	
	local iWeaponID = GetTok ( szParams , " " , 1 );
	local iAmmoAmount = GetTok ( szParams , " " , 2 );
	
	if ( !IsNum ( iWeaponID ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;
	
	}
	
	if ( !IsNum ( iAmmoAmount ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;
	
	}	
	
	if ( iWeaponID.tointeger ( ) < 2 || iWeaponID.tointeger ( ) > 9 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 2 and 9" );
		
		return false;
	
	}

	if ( pPlayerData.iCash < GetAmmoPrice ( iWeaponID.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have enough money for " + GetWeaponName ( iWeaponID.tointeger ( ) ) + " ammo." );
		SendPlayerAlertMessage ( pPlayer , "Use '/GunPrices' for a list of weapon and ammo prices." );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You bought " + iAmmoAmount + " ammo for the " + GetWeaponName ( szParams.tointeger ( ) ) );
	
	if ( !DoesPlayerHaveWeapon ( pPlayer , iWeaponID.tointeger ( ) ) ) {
	
		SendPlayerAlertMessage ( pPlayer , "You don't have a " + GetWeaponName ( szParams.tointeger ( ) ) + " but this ammo will be added when you buy one." );
	
	}
	
	TakePlayerCash ( pPlayer , GetAmmoPrice ( szParams.tointeger ( ) ) * iAmmoAmount.tointeger ( ) );
	
	GivePlayerAmmo ( pPlayer , iWeaponID.tointeger ( ) , iAmmoAmount.tointeger ( ) );

}

// -------------------------------------------------------------------------------------------------

function WeaponPricesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
	
		SendPlayerCommandInfoMessage ( pPlayer , "Shows prices for weapons and ammo" , [ "GunPrices" , "WepPrices" ] , "" );
	
		return false;
	
	}
	
	if ( !CanPlayerUseAmmunation ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You cannot use any ammunations!" );
		
		return false;
		
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Weapon ID>" );
	
		return false;
		
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be a number!" );
		
		return false;
	
	}
	
	if ( szParams.tointeger ( ) < 1 || szParams.tointeger ( ) > 9 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The weapon ID must be between 1 and 9" );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "- Weapon: " + GetWeaponName ( szParams.tointeger ( ) ) + ", Weapon Price: " + GetWeaponPrice ( szParams.tointeger ( ) ) + ", Ammo Price (per bullet): " + GetAmmoPrice ( szParams.tointeger ( ) ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveWeapon ( pPlayer , iWeaponID ) {

	if ( GetPlayerData ( pPlayer ).pHasWeapon [ iWeaponID ] ) {
		
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerWeapon ( pPlayer , iWeaponID , iAmmoAmount ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerAmmo ( pPlayer , iWeaponID , iAmmoAmount ) {

	GetPlayerData ( pPlayer ).pWeaponAmmo [ iWeaponID ] += iAmmoAmount;
	
	if ( DoesPlayerHaveWeapon ( pPlayer , iWeaponID ) ) {
		
		pPlayer.SetWeapon ( iWeaponID , iAmmoAmount );
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetWeaponPrice ( iWeaponID ) {

	return GetUtilityConfiguration ( ).pWeaponPrices [ iWeaponID ];

}

// -------------------------------------------------------------------------------------------------

function GetAmmoPrice ( iWeaponID ) {

	return GetUtilityConfiguration ( ).pAmmoPrices [ iWeaponID ];

}

// -------------------------------------------------------------------------------------------------

function CanPlayerUseAmmunation ( pPlayer ) {
	
	if ( !HasBitFlag ( GetPlayerData ( pPlayer , "iModerationFlags" ) , GetModerationFlagValue ( "BlockAmmunation" ) ) ) {
	
		return true;
	
	}
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------