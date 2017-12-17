
// NAME: Item Dropping.nut
// DESC: Provides utility functions, data management, and commands for dropping items.
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitItemDroppingScript ( ) {
	
	AddItemDroppingCommandHandlers ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddItemDroppingCommandHandlers ( ) {

	//AddCommandHandler ( "DropWep" 				, DropWeaponCommand 				, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "PickupWep" 			, PickupWeaponCommand 				, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "GiveWep" 				, GiveWeaponCommand 				, GetStaffFlagValue ( "None" ) );
	
	//AddCommandHandler ( "DropGun" 				, DropWeaponCommand 				, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "PickupGun" 			, PickupWeaponCommand 				, GetStaffFlagValue ( "None" ) );
	//AddCommandHandler ( "GiveGun" 				, GiveWeaponCommand 				, GetStaffFlagValue ( "None" ) );

	return true;

}

// -------------------------------------------------------------------------------------------------

function DropWeapon ( iWeaponID , pPosition , iAmmo ) {

	return true;

}

// -------------------------------------------------------------------------------------------------