
// NAME: Vehicles.nut
// DESC: Handles anything related to vehicles and vehicle data.

// -------------------------------------------------------------------------------------------------

function InitVehicleScript ( ) {
	
	AddVehicleCommandHandlers ( );
	
	OpenAllGarages ( );

	GetCoreTable ( ).Vehicles = ::LoadVehiclesFromDatabase ( );
	
	SpawnAllVehicles ( );

}

// -------------------------------------------------------------------------------------------------

function AddVehicleCommandHandlers ( ) {

	AddCommandHandler ( "AddVeh" 			, CreateVehicleCommand 				, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "AddPublicVeh" 		, CreatePublicVehicleCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "DelVeh" 			, DeleteVehicleCommand 				, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RentVehicle" 		, RentVehicleCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "BuyVehicle" 		, BuyVehicleCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "StopRent" 			, StopRentVehicleCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehEngine" 		, VehicleEngineCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Engine" 			, VehicleEngineCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Lock" 				, VehicleLockCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehLock" 			, VehicleLockCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Lights" 			, VehicleLightsCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehLights" 		, VehicleLightsCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Siren" 			, VehicleSirenCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehSiren" 			, VehicleSirenCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "SirenLight" 		, VehicleSirenLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehSirenLight" 	, VehicleSirenLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "TaxiLight" 		, VehicleTaxiLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehTaxiLight" 		, VehicleTaxiLightCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "RentPrice" 		, SetVehicleRentPriceCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "BuyPrice" 			, SetVehicleBuyPriceCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "RespawnAll" 		, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnAllVeh" 	, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnAllVehs" 	, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnCars" 		, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnAllCars" 	, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RAC"				, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RAV"				, RespawnAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "RespawnEmptyVeh" 	, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnEmptyVehs"	, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnEmptyCars"	, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnEmpty"		, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "REC"				, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "REV"				, RespawnEmptyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "RespawnClanVeh" 	, RespawnClanVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnClanVehs" 	, RespawnClanVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnClanCars" 	, RespawnClanVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RCV"			 	, RespawnClanVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RCC"			 	, RespawnClanVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	
	AddCommandHandler ( "RespawnPlayerVeh" 	, RespawnPlayerVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnPlayerVehs" , RespawnPlayerVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnPlayerCars" , RespawnPlayerVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RPV"			 	, RespawnPlayerVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RPC"			 	, RespawnPlayerVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "RespawnJobVeh" 	, RespawnJobVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnJobVehs" 	, RespawnJobVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnJobCars" 	, RespawnJobVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RJV"			 	, RespawnJobVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RJC"			 	, RespawnJobVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );	
	
	AddCommandHandler ( "RespawnPublicVeh" 	, RespawnPublicVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnPublicVehs" , RespawnPublicVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnPublicCars" , RespawnPublicVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );

	AddCommandHandler ( "RespawnNearVeh" 	, RespawnNearbyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "RespawnNearbyVeh" 	, RespawnNearbyVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "RefuelAll" 		, RefuelAllVehiclesCommand 			, GetStaffFlagValue ( "ManageVehicles" ) )
	AddCommandHandler ( "RepairAll" 		, RepairAllVehiclesCommand 			, GetStaffFlagValue ( "ManageVehicles" ) )
	AddCommandHandler ( "ExplodeAll" 		, ExplodeAllVehiclesCommand 		, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "JobVeh" 			, SetJobVehicleCommand 				, GetStaffFlagValue ( "ManageVehicles" ) );
	//AddCommandHandler ( "ClanVeh" 			, SetClanVehicleCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehOwner" 			, SetVehicleOwnerCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehColour" 		, SetVehicleColourCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehHealth" 		, SetVehicleHealthCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "VehSpawnLock" 		, VehicleSpawnLockCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "GotoVeh" 			, GotoVehicleCommand 				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "GetVeh" 			, GetVehicleCommand 				, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "InVeh" 			, GetPlayerVehicleInfoCommand 		, GetStaffFlagValue ( "BasicModeration" ) );
	AddCommandHandler ( "RespawnVeh" 		, RespawnVehicleCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "Recolour" 			, SetVehicleColourCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "TuneUp" 			, VehicleTuneUpCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Respray" 			, SetVehicleColourCommand 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Repair" 			, RepairVehicleCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Fix" 				, RepairVehicleCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "FixVeh" 			, RepairVehicleCommand				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Park" 				, VehicleSpawnLockCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	AddCommandHandler ( "SpawnLock" 		, VehicleSpawnLockCommand 			, GetStaffFlagValue ( "ManageVehicles" ) );
	
	AddCommandHandler ( "Refuel" 			, RefuelVehicleCommand	 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Refill" 			, RefuelVehicleCommand	 			, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Fuel" 				, GetVehicleFuelCommand	 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "GetFuel" 			, GetVehicleFuelCommand	 			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "VehFuel" 			, GetVehicleFuelCommand	 			, GetStaffFlagValue ( "None" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function CallLoadVehicleThread ( iDatabaseID ) {

	return false; //::GetCoreTable( ).Threads.LoadVehicleThread.call ( iDatabaseID );

}

// -------------------------------------------------------------------------------------------------

function SaveAllVehiclesToDatabase ( ) {

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		local iDatabaseID = CallSaveVehicleThread ( iv );
		
		if ( iDatabaseID != 0 ) {
		
			iv.iDatabaseID = iDatabaseID;
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function CallSaveVehicleThread ( pVehicleData ) {
	
	return SaveVehicleDataToDatabase ( pVehicleData ); // ::GetCoreTable( ).Threads.SaveVehicleThread.call ( pVehicleData );

}

// -------------------------------------------------------------------------------------------------

function SaveVehicleToDatabase ( pVehicle ) {

	return SaveVehicleDataToDatabase ( GetVehicleData ( pVehicle ) );

}

// -------------------------------------------------------------------------------------------------

function SaveVehicleDataToDatabase ( pVehicleData ) {

	local pQuery = false;
	local pDatabaseConnection = false;
	local szQueryString = "";
	local bIsNewlyAdded = false;
	
	pDatabaseConnection = ConnectToMySQL ( );
	
	if ( !pDatabaseConnection ) {

		::print ( "[Server.Database]: Vehicle database ID " + pVehicleData.iDatabaseID + " could NOT be saved to database. Couldn't connect to database!" );
	
		return false;
		
	}
	
	if ( pVehicleData.bTempVehicle ) {
	
		return false;
	
	}
	
	if ( pVehicleData.iDatabaseID == 0 ) {		
		
		szQueryString = "INSERT INTO `veh_main` (`veh_id`, `veh_model`, `veh_col1_r`, `veh_col1_g`, `veh_col1_b`, `veh_col2_r`, `veh_col2_g`, `veh_col2_b`, `veh_locked`, `veh_health`, `veh_engine_damage`, `veh_pos_x`, `veh_pos_y`, `veh_pos_z`, `veh_rot_x`, `veh_rot_y`, `veh_rot_z`, `veh_owner_id`, `veh_owner_type`, `veh_engine`, `veh_lights`, `veh_siren`, `veh_sirenlight`, `veh_taxilight`, `veh_radio`, `veh_fuel`, `veh_spawned`, `veh_insured`, `veh_price`, `veh_deleted`, `veh_flags`, `veh_spawn_lock`, `veh_buy_price`, `veh_rent_price`) VALUES (null, "+pVehicleData.iModel+","+pVehicleData.pColour1.r+","+pVehicleData.pColour1.g+","+pVehicleData.pColour1.b+","+pVehicleData.pColour2.r+","+pVehicleData.pColour2.g+","+pVehicleData.pColour2.b+", '0', '1000', '0',"+pVehicleData.pPosition.x+","+pVehicleData.pPosition.y+","+pVehicleData.pPosition.z+",0.0,0.0,"+pVehicleData.fAngle+","+pVehicleData.iOwnerID+","+pVehicleData.iOwnerType+", '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', "+pVehicleData.iBuyPrice+", "+pVehicleData.iRentPrice+")";
		bIsNewlyAdded = true;
	
	} else {
	
		// Vehicle already exists in the database, update it's data.
		
		szQueryString = "UPDATE `veh_main` SET `veh_model` = "+pVehicleData.iModel+", `veh_col1_r` = "+pVehicleData.pColour1.r+", `veh_col1_g` = "+pVehicleData.pColour1.g+", `veh_col1_b` = "+pVehicleData.pColour1.b+", `veh_col2_r` = "+pVehicleData.pColour2.r+", `veh_col2_g` = "+pVehicleData.pColour2.g+", `veh_col2_b` = "+pVehicleData.pColour2.b+", `veh_locked` = "+BoolToInteger(pVehicleData.bLocked)+", `veh_health` = "+pVehicleData.fHealth+", `veh_engine_damage` = "+pVehicleData.fEngineDamage+", `veh_pos_x` = "+pVehicleData.pPosition.x+", `veh_pos_y` = "+pVehicleData.pPosition.y+", `veh_pos_z` = "+pVehicleData.pPosition.z+", `veh_rot_x` = '0', `veh_rot_y` = '0', `veh_rot_z` = "+pVehicleData.fAngle+", `veh_owner_id` = "+pVehicleData.iOwnerID+", `veh_owner_type` = "+pVehicleData.iOwnerType+", `veh_engine` = "+BoolToInteger(pVehicleData.bEngine)+", `veh_lights` = "+BoolToInteger(pVehicleData.bLightState)+", `veh_siren` = "+BoolToInteger(pVehicleData.bSiren)+", `veh_sirenlight` = "+BoolToInteger(pVehicleData.bSirenLight)+", `veh_taxilight` = "+BoolToInteger(pVehicleData.bTaxiLight)+", `veh_radio` = "+pVehicleData.iRadio+", `veh_fuel` = "+pVehicleData.iFuel+", `veh_spawned` = '1', `veh_insured` = '0', `veh_price` = '0', `veh_destroyed` = "+BoolToInteger(pVehicleData.bDestroyed)+", `veh_deleted` = "+BoolToInteger(pVehicleData.bDeleted)+", `veh_flags` = '0', `veh_spawn_lock` = "+BoolToInteger(pVehicleData.bSpawnLock)+",`veh_buy_price` = "+pVehicleData.iBuyPrice.tostring()+", `veh_rent_price` = "+pVehicleData.iRentPrice.tostring()+", `veh_hydraulics` = "+BoolToInteger(pVehicleData.bHydraulics).tostring()+",`veh_enginemult` = "+pVehicleData.iEngineMult.tostring()+",`veh_wheelmult` = "+pVehicleData.iWheelMult.tostring()+",`veh_brakemult` = "+pVehicleData.iBrakeMult.tostring()+" WHERE `veh_id` = "+pVehicleData.iDatabaseID;
		bIsNewlyAdded = false;
		
	}
	
	if ( !szQueryString ) {
	
		::print ( "[Server.Vehicles]: Vehicle database ID " + pVehicleData.iDatabaseID + " could NOT be saved to database. Query string didn't generate!" );
	
		return false;t/sa
	
	}
	
	local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );

	if ( !pVehicleData.pVehicle ) {
	
		::print ( "[Server.Vehicles]: Vehicle database ID " + pVehicleData.iDatabaseID + " (not spawned) saved to database" );
		
	} else {
	
		::print ( "[Server.Vehicles]: Vehicle database ID " + pVehicleData.iDatabaseID + " (spawned as ID " + pVehicleData.pVehicle.ID + ") saved to database" );
	
	}
	
	if ( bIsNewlyAdded ) {
	
		local iDatabaseID = mysql_insert_id ( pDatabaseConnection );
		
		return iDatabaseID;
	
	}
	
	return 0;
	
}

// -------------------------------------------------------------------------------------------------

function LoadVehiclesFromDatabase ( ) {

	local pDatabaseConnection = ::ConnectToMySQL ( );
	local pAssocResult = false;
	local pVehicleData = false;
	local pVehicles = [ ];
		
	local pQuery = ::ExecuteMySQLQuery ( ::ConnectToMySQL ( ) , "SELECT * FROM `veh_main`" );

	if ( pQuery ) {
	
		while ( pAssocResult = ::GetMySQLAssocResult ( pQuery ) ) {
		
			pVehicleData = ::GetCoreTable ( ).Classes.VehicleData ( );

			// Basic Information
			pVehicleData.iDatabaseID				= pAssocResult [ "veh_id" ].tointeger ( );
			pVehicleData.iModel						= pAssocResult [ "veh_model" ].tointeger ( );
			pVehicleData.pVehicle					= false;
			pVehicleData.bSpawnLock					= IntegerToBool ( pAssocResult [ "veh_spawn_lock" ].tointeger ( ) );;
			pVehicleData.pRenter					= false;
			pVehicleData.bDeleted					= IntegerToBool ( pAssocResult [ "veh_deleted" ].tointeger ( ) );
			pVehicleData.bDestroyed					= IntegerToBool ( pAssocResult [ "veh_destroyed" ].tointeger ( ) );
			
			// Colours
			// The Colour instances don't work properly, so we'll define the colours manually in a table
			pVehicleData.pColour1					= { r = pAssocResult [ "veh_col1_r" ].tointeger ( ) , g = pAssocResult [ "veh_col1_g" ].tointeger ( ) , b = pAssocResult [ "veh_col1_b" ].tointeger ( ) };
			pVehicleData.pColour2					= { r = pAssocResult [ "veh_col2_r" ].tointeger ( ) , g = pAssocResult [ "veh_col2_g" ].tointeger ( ) , b = pAssocResult [ "veh_col2_b" ].tointeger ( ) };
			
			// Positioning
			pVehicleData.pPosition					= ::Vector ( pAssocResult [ "veh_pos_x" ].tofloat ( ) , pAssocResult [ "veh_pos_y" ].tofloat ( ) , pAssocResult [ "veh_pos_z" ].tofloat ( ) );
			pVehicleData.pRotation					= ::Vector ( 0.0 , 0.0 , pAssocResult [ "veh_rot_z" ].tofloat ( ) );
			pVehicleData.fAngle						= pAssocResult [ "veh_rot_z" ].tofloat ( );		
			
			pVehicleData.iOwnerType					= pAssocResult [ "veh_owner_type" ].tointeger ( );
			pVehicleData.iOwnerID					= pAssocResult [ "veh_owner_id" ].tointeger ( );
			
			pVehicleData.iBuyPrice					= pAssocResult [ "veh_buy_price" ].tointeger ( );
			pVehicleData.iRentPrice					= pAssocResult [ "veh_rent_price" ].tointeger ( );
			
			pVehicleData.iFuel						= pAssocResult [ "veh_fuel" ].tointeger ( );
			
			pVehicleData.bEngine					= IntegerToBool ( pAssocResult [ "veh_engine" ].tointeger ( ) );
			pVehicleData.bLightState				= IntegerToBool ( pAssocResult [ "veh_lights" ].tointeger ( ) );
			pVehicleData.bLocked					= IntegerToBool ( pAssocResult [ "veh_locked" ].tointeger ( ) );
			pVehicleData.bSirenLight				= IntegerToBool ( pAssocResult [ "veh_sirenlight" ].tointeger ( ) );
			pVehicleData.bTaxiLight					= IntegerToBool ( pAssocResult [ "veh_taxilight" ].tointeger ( ) );
			pVehicleData.bSiren						= IntegerToBool ( pAssocResult [ "veh_siren" ].tointeger ( ) );

			pVehicleData.fHealth					= pAssocResult [ "veh_health" ].tofloat ( );
			pVehicleData.fEngineDamage				= pAssocResult [ "veh_engine_damage" ].tofloat ( );
			
			pVehicleData.bHydraulics				= IntegerToBool ( pAssocResult [ "veh_hydraulics" ].tointeger ( ) );
			pVehicleData.iEngineMult				= pAssocResult [ "veh_enginemult" ].tointeger ( );
			pVehicleData.iWheelMult					= pAssocResult [ "veh_wheelmult" ].tointeger ( );
			pVehicleData.iBrakeMult					= pAssocResult [ "veh_brakemult" ].tointeger ( );
			
			pVehicleData.pTires						= [ pAssocResult [ "veh_tire_fl" ].tointeger ( ) , pAssocResult [ "veh_tire_rl" ].tointeger ( ) , pAssocResult [ "veh_tire_fr" ].tointeger ( ) , pAssocResult [ "veh_tire_rr" ].tointeger ( ) ];
			
			// -----------------------
			
			pVehicleData.iDatabaseID				= pVehicleData.iDatabaseID.tointeger ( );
			pVehicleData.iModel						= pVehicleData.iModel.tointeger ( );
			
			pVehicleData.fAngle						= pVehicleData.fAngle.tofloat ( );		
			
			pVehicleData.iOwnerType					= pVehicleData.iOwnerType.tointeger ( );
			pVehicleData.iOwnerID					= pVehicleData.iOwnerID.tointeger ( );
			
			pVehicleData.iBuyPrice					= pVehicleData.iBuyPrice.tointeger ( );
			pVehicleData.iRentPrice					= pVehicleData.iRentPrice.tointeger ( );
			
			pVehicleData.iFuel						= pVehicleData.iFuel.tointeger ( );
			
			pVehicleData.bHydraulics				= IntegerToBool ( pVehicleData.bHydraulics.tointeger ( ) );
			pVehicleData.iEngineMult				= pVehicleData.iEngineMult.tointeger ( );
			pVehicleData.iWheelMult					= pVehicleData.iWheelMult.tointeger ( );
			pVehicleData.iWheelMult					= pVehicleData.iBrakeMult.tointeger ( );

			pVehicleData.fHealth					= pVehicleData.fHealth.tofloat ( );
			pVehicleData.fEngineDamage				= pVehicleData.fEngineDamage.tofloat ( );
			
			pVehicleData.iAverageTireDamage			= ( ( pVehicleData.pTires [ 0 ] + pVehicleData.pTires [ 1 ] + pVehicleData.pTires [ 2 ] + pVehicleData.pTires [ 3 ] ) / 4 );
			
			pVehicles.push ( pVehicleData );
			
			print ( "[Server.Database]: Vehicle database ID " + pVehicleData.iDatabaseID + " loaded (" + GetVehicleName ( pVehicleData.iModel ) + "/" + pVehicleData.szModelDisplay + ")" );			
		
		}
	
	}
			
	::DisconnectFromMySQL ( pDatabaseConnection );
	
	EchoIRCConsoleDebug ( pVehicles.len ( ) + " vehicles loaded from the database!" );
	
	return pVehicles;

}

// -------------------------------------------------------------------------------------------------

function SpawnAllVehicles ( ) {

	local pVehicle = false;

	if ( GetCoreTable ( ).Vehicles.len ( ) > 0 ) {
	
		foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
		
			if ( !iv.bDeleted ) {
			
				pVehicle = CreateVehicle ( iv.iModel , Vector ( iv.pPosition.x , iv.pPosition.y , iv.pPosition.z ) , iv.fAngle );
				
				if ( pVehicle ) {
				
					pVehicle.RGBColour1 = Colour ( iv.pColour1.r , iv.pColour1.g , iv.pColour1.b );
					pVehicle.RGBColour2 = Colour ( iv.pColour2.r , iv.pColour2.g , iv.pColour2.b );
					
					pVehicle.Locked = iv.bLocked;
					pVehicle.LightState = iv.bLightState;
					pVehicle.Siren = iv.bSiren;
					pVehicle.SirenLight = iv.bSirenLight;
					pVehicle.TaxiLight = iv.bTaxiLight;
					
					pVehicle.SetEngineState ( false );
					
					local fDefaultTractionLoss = pVehicle.GetHandlingData ( HANDLING_TRACTIONLOSS );
					local fHalfTractionLoss = fDefaultTractionLoss / 2;
					
					local fTractionLoss = ( fDefaultTractionLoss - ( fHalfTractionLoss / iv.iAverageTireDamage ) );
					
					pVehicle.SetHandlingData ( HANDLING_TRACTIONLOSS , fTractionLoss );
					
					for( local i = 0 ; i < 4 ; i++ ) {
						
						if ( iv.pTires [ i ] == 0 ) {
							
							pVehicle.SetWheelStatus ( WHEELSTATUS_FLAT );
							
						}
						
						if ( iv.pTires [ i ] == -1 ) {
							
							pVehicle.SetWheelStatus ( WHEELSTATUS_FUCKED );
							
						}
						
					}					
					
					if ( iv.iOwnerType == 1 ) {
					
						if ( iv.iEngineMult > 0 ) {
						
							pVehicle.SetHandlingData ( HANDLING_ENGINEACCELERATION , GetVehicleHandlingData ( pVehicle.Model , HANDLING_ENGINEACCELERATION ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_ENGINEACCELERATION ) * 0.1 ) * iv.iEngineMult ) );
							pVehicle.SetHandlingData ( HANDLING_MAXVELOCITY , GetVehicleHandlingData ( pVehicle.Model , HANDLING_MAXVELOCITY ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_MAXVELOCITY ) * 0.1 ) * iv.iEngineMult ) );
							
						}
						
						if ( iv.iBrakeMult > 0 ) {
						
							pVehicle.SetHandlingData ( HANDLING_BRAKEDECELERATION , GetVehicleHandlingData ( pVehicle.Model , HANDLING_BRAKEDECELERATION ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_BRAKEDECELERATION ) * 0.1 ) * iv.iBrakeMult ) );
						
						}
						
						if ( iv.iWheelMult > 0 ) {
						
							pVehicle.SetHandlingData ( HANDLING_TRACTIONMULTIPLIER , GetVehicleHandlingData ( pVehicle.Model , HANDLING_TRACTIONMULTIPLIER ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_TRACTIONMULTIPLIER ) * 0.1 ) * iv.iWheelMult ) );
						
						}
						
					}
					
					iv.pVehicle = pVehicle;
					
					GetCoreTable ( ).VehicleToData [ pVehicle.ID ] = ii;
					
					print ( "[Server.Vehicles]: Vehicle " + pVehicle.ID + " Spawned (" + GetVehicleDisplayName ( pVehicle ) + " - " + ii + ")" );
				
				}
			
			}
			
		}
	
	}
	
	EchoIRCConsoleDebug ( GetCoreTable ( ).Vehicles.len ( ) + " vehicles spawned" );
	
	return true;
   
}

// -------------------------------------------------------------------------------------------------

function VehicleEngineCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bEngineState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicles engine on or off." , [ "engine" , "vehengine" ] , "You can also use the 'M' key on your keyboard." );
		
		return false;
	
	}

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;
	
	}	
	
	if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pPlayer.Vehicle ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have keys to this vehicle!" );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		bEngineState = !GetVehicleData ( pPlayer.Vehicle , "bEngine" );
	
	} else {
	
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid light state. It must ON or OFF" );
			SendPlayerInfoMessage ( pPlayer , "It is not case-sensitive. Example: OFF, Off, and off will all work." );
			
			return false;
		
		}

		bEngineState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	}	
	
	if ( bEngineState == true ) {
	
		if ( GetVehicleData ( pPlayer.Vehicle ).iFuel <= 0 ) {
	
			SendPlayerErrorMessage ( pPlayer , "This vehicle is out of fuel!" );
			
			return false;
		
		}
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleEngineOn" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleEngineOff" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	}
	
	SetVehicleEngineState ( pPlayer.Vehicle , bEngineState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleLockCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bLockState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Locks or unlocks a vehicle's doors." , [ "Lock" , "VehLock" ] , "You can also use the 'L' key on your keyboard." );
		
		return false;
	
	}	
	
	if ( pPlayer.Vehicle ) {
	
		if ( pPlayer.VehicleSeat > 1 ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
			
			EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + "). Reason: Not in a front seat" );
			
			return false;
		
		}

		if ( !szParams || szParams == "" ) {
		
			bLockState = GetVehicleData ( pPlayer.Vehicle , "bLocked" );
			bLockState = !bLockState;
		
			//SendPlayerSyntaxMessage ( pPlayer , "/Lock <ON/OFF>" );
			
			//EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + "). Reason: No lock state param" );
		
		} else {
		
			if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
			
				SendPlayerErrorMessage ( pPlayer , "You entered an invalid lock state. It must ON or OFF" );
				
				EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + "). Reason: Invalid lock state param" );
				
				return false;
			
			}

			bLockState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
			
		}
		
		if ( bLockState == true ) {
		
			SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleLocked" ) , GetVehicleName ( pPlayer.Vehicle ) ) );
			
			EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully locked vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + ") from front seat" );
		
		} else {
		
			SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleUnlocked" ) , GetVehicleName ( pPlayer.Vehicle ) ) );
			
			EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully unlocked vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + ") from front seat" );
		
		}
		
		SetVehicleDoorLockState ( pPlayer.Vehicle , bLockState );
	
	} else {
		
		local pClosestVehicle = GetClosestVehicle ( pPlayer );
		
		if ( GetDistance ( pPlayer.Pos , pClosestVehicle.Pos ) > 10.0 ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be near a vehicle!" );
			
			EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleDisplayName ( pClosestVehicle ) + "). Reason: Not close enough to vehicle ( " + GetDistance ( pPlayer.Pos , pClosestVehicle.Pos ) + " meters away)" );
			
			return false;
		
		}
		
		if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pClosestVehicle ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You don't have the keys to this vehicle!" );
			
			EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleDisplayName ( pClosestVehicle ) + "). Reason: Doesnt have keys" );
			
			return false;
		
		}

		if ( !szParams ) {
		
			bLockState = GetVehicleData ( pClosestVehicle , "bLocked" );
			bLockState = !bLockState;
		
			//SendPlayerSyntaxMessage ( pPlayer , "/Lock <ON/OFF>" );
			
			//EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pPlayer.Vehicle.ID + " (" + GetVehicleDisplayName ( pPlayer.Vehicle ) + "). Reason: No lock state param" );
		
		} else {
		
			if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
			
				SendPlayerErrorMessage ( pPlayer , "You entered an invalid lock state. It must ON or OFF" );
				SendPlayerSyntaxMessage ( pPlayer , "/Lock <ON/OFF>" );
				SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );			
				
				EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") failed to lock vehicle " + pClosestVehicle.ID + " (" + GetVehicleDisplayName ( pClosestVehicle ) + "). Reason: Invalid lock state param" );
				
				return false;
			
			}
		
			if ( szParams.tolower ( ) == "on" ) {
			
				bLockState = true;
			
				SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleLocked" ) , GetVehicleName ( pClosestVehicle ) ) );
				
				EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully locked vehicle " + pClosestVehicle.ID + " (" + GetVehicleDisplayName ( pClosestVehicle ) + ") from nearby" );
			
			} else {
			
				bLockState = false;
			
				SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleUnlocked" ) , GetVehicleName ( pClosestVehicle ) ) );
				
				EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") successfully unlocked vehicle " + pClosestVehicle.ID + " (" + GetVehicleDisplayName ( pClosestVehicle ) + ") from nearby" );
			
			}
		
		}
		
		SetVehicleDoorLockState ( pClosestVehicle , bLockState );
	
	}
	

	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleLightsCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's main lights on or off." , [ "Lights" , "VehLights" ] , "You can also use the 'N' key on your keyboard." );
		
		return false;
	
	}	
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		bLightState = GetVehicleData ( pPlayer.Vehicle , "bLightState" );
		bLightState = !bLightState;
	
	} else {
	
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid light state. It must ON or OFF" );
			SendPlayerInfoMessage ( pPlayer , "It is not case-sensitive. Example: OFF, Off, and off will all work." );
			
			return false;
		
		}

		bLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	}
	
	if ( bLightState ) {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleLightsOn" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleLightsOff" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	}
	
	SetVehicleLightState ( pPlayer.Vehicle , bLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleSirenLightCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bSirenLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's siren light on or off." , [ "SirenLight" , "VehSirenLight" ] , "You must be in a front seat. Only works on cars with siren lights." );
		
		return false;
	
	}		
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		bSirenLightState = GetVehicleData ( pPlayer.Vehicle , "bSirenLight" );
		bSirenLightState = !bSirenLightState;
	
	} else {
	
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid siren light state. It must ON or OFF" );
			SendPlayerInfoMessage ( pPlayer , "It is not case-sensitive. Example: OFF, Off, and off will all work." );
			
			return false;
		
		}

		bSirenLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	}
	
	if ( bSirenLightState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleSirenLightOn" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleSirenLightOff" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	}
	
	SetVehicleSirenLightState ( pPlayer.Vehicle , bSirenLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleTaxiLightCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bTaxiLightState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's taxi light on or off." , [ "TaxiLight" , "VehTaxiLight" ] , "You must be in a front seat. Only works on cars with siren lights." );
		
		return false;
	
	}		 
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		bTaxiLightState = GetVehicleData ( pPlayer.Vehicle , "bTaxiLight" );
		bTaxiLightState = !bTaxiLightState;
	
	} else {
	
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid taxi light state. It must ON or OFF" );
			
			return false;
		
		}

		bTaxiLightState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	}
	
	if ( bTaxiLightState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleTaxiLightOn" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleTaxiLightOff" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	}
	
	SetVehicleTaxiLightState ( pPlayer.Vehicle , bTaxiLightState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function VehicleSirenCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local bSirenState = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Turns a vehicle's siren on or off." , [ "Siren" , "VehSiren" ] , "You must be in a front seat. Only works on cars with sirens." );
		
		return false;
	
	}			 
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat > 1 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a front seat!" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		bSirenState = GetVehicleData ( pPlayer.Vehicle , "bState" );
		bSirenState = !bSirenState;
	
	} else {
	
		if ( ( szParams.tolower ( ) != "on" ) && ( szParams.tolower ( ) != "off" ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You entered an invalid siren state. It must ON or OFF" );
			SendPlayerInfoMessage ( pPlayer , "Not case-sensitive. Example: OFF, Off, and off will all work." );
			
			return false;
		
		}

		bSirenState = ( ( szParams.tolower ( ) == "on" ) ? true : false );
	
	}
	
	if ( bSirenState == true ) {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleSirenOn" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	} else {
	
		SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleSirenOff" ) , GetVehicleDisplayName ( pPlayer.Vehicle ) ) );
	
	}
	
	SetVehicleSirenState ( pPlayer.Vehicle , bSirenState );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function AdminRepairVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Repairs a vehicle without a pay and spray." , [ "AFixVeh" , "AFix" , "AdminFix" , "AdminRepair" ] , "" );
		
		return false;
	
	}			 

	if ( !szParams ) {
	
		if ( pPlayer.Vehicle ) {
		
			GetVehicleData ( pPlayer.Vehicle ).fHealth = 1000;
			GetVehicleData ( pPlayer.Vehicle ).fEngineDamage = 0;
			
			pPlayer.Vehicle.Fix ( );
	
			SendPlayerSuccessMessage ( pPlayer , "The vehicle was admin-repaired!" );
		
			return true;
		
		}
	
		SendPlayerSyntaxMessage ( pPlayer , "/AFixVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;
	
	}

	if ( !FindVehicle ( szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That vehicle doesn't exist!" );
		
		return false;
	
	}
	
	GetVehicleData ( FindVehicle ( szParams.tointeger ( ) ) ).fHealth = 1000;
	GetVehicleData ( FindVehicle ( szParams.tointeger ( ) ) ).fEngineDamage = 0;
	
	FindVehicle ( szParams.tointeger ).Fix ( );
	
	SendPlayerSuccessMessage ( pPlayer , "Vehicle '" + GetVehicleName ( FindVehicle ( szParams.tointeger ( ) ) ) + "' (ID: " + FindVehicle ( szParams.tointeger ).ID + ") has been repaired!" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleLightState ( pVehicle , bLightState ) {

	local iLightState = bLightState;
	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.LightState = iLightState;
	
	pVehicleData.bLightState = bLightState;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleDoorLockState ( pVehicle , bLockState ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.Locked = bLockState;
	
	pVehicleData.bLocked = bLockState;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleEngineState ( pVehicle , bEngineState ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	local pVehicleData = GetCoreTable( ).Vehicles [ pVehicleDataID ];
	
	pVehicle.SetEngineState ( bEngineState );
	
	pVehicleData.bEngine = bEngineState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleSirenState ( pVehicle , bSirenState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.Siren = bSirenState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleSirenLightState ( pVehicle , bSirenLightState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.SirenLight = bSirenLightState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleTaxiLightState ( pVehicle , bTaxiLightState ) {

	//local pVehicleData = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	pVehicle.TaxiLight = bTaxiLightState;
	
	return;

}

// -------------------------------------------------------------------------------------------------

function GetNumberOfVehicles ( ) {

	return ReadIniInteger ( "Scripts/lu_roleplay/Data/Index.ini" , "General" , "iVehicleAmount" );

}

// -------------------------------------------------------------------------------------------------

function SetVehicleRentPriceCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	local pVehicleData = false;
	local iVehicleDataID = 0;
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}	
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<$ Amount>" );
		SendPlayerInfoMessage ( pPlayer , "The amount will be charged one time, and doesn't change." );
		
		return false;
	
	}

	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be a number!" );
		
		return false;	
	
	}
	
	iVehicleDataID = GetCoreTable( ).VehicleToData [ pPlayer.Vehicle.ID ];
	pVehicleData = GetCoreTable( ).Vehicles [ iVehicleDataID ];
	
	pVehicleData.iRentPrice = szParams.tointeger ( );
	
	SendPlayerSuccessMessage ( pPlayer , "You have set the " + GetVehicleDisplayName ( pPlayer.Vehicle ) + "'s rent price to $" + szParams.tointeger ( ) + " per hour." );
   
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleBuyPriceCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	local pVehicleData = false;
	local iVehicleDataID = 0;
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}	
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<$ Amount>" );
		SendPlayerInfoMessage ( pPlayer , "The amount will be charged one time, and doesn't change." );
		
		return false;
	
	}

	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The amount must be a number!" );
		
		return false;	
	
	}
	
	iVehicleDataID = GetCoreTable( ).VehicleToData [ pPlayer.Vehicle.ID ];
	pVehicleData = GetCoreTable( ).Vehicles [ iVehicleDataID ];
	
	pVehicleData.iBuyPrice = szParams.tointeger ( );
	
	SendPlayerSuccessMessage ( pPlayer , "You have set the " + GetVehicleDisplayName ( pPlayer.Vehicle ) + "'s buy price to $" + szParams.tointeger ( ) + " per hour." );
   
	return true;

}

// -------------------------------------------------------------------------------------------------

function BuyVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	// Added this to fix an issue with the data returning as wrong type. Not sure why.
	local pVehicle = pPlayer.Vehicle;
	local pVehiclePosition = pVehicle.Pos;
	local pVehicleAngle = pVehicle.Angle;
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;	
	
	}
	
	local pVehicleData = GetVehicleData ( pPlayer.Vehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	local iBuyPrice = pVehicleData.iBuyPrice;
	
	if ( pVehicleData.iBuyPrice == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is not for sale!" );
		
		return false;
	
	}	   
	
	if ( pPlayerData.iCash < pVehicleData.iBuyPrice ) {
	
		SendPlayerErrorMessage ( pPlayer , "You don't have enough money to buy this vehicle!" );
		
		return false;
	
	}
	
	TakePlayerCash ( pPlayer , pVehicleData.iBuyPrice );
	
	pVehicleData.iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.Player;
	pVehicleData.iOwnerID = GetPlayerData ( pPlayer ).iDatabaseID;
	pVehicleData.bSpawnLock = false;
	
	pVehicleData.iBuyPrice = 0;
	pVehicleData.iRentPrice = 0;
	
	pPlayerData.pBuyVehPosition = pVehiclePosition;
	pPlayerData.pBuyVehAngle = pVehicleAngle;
	pPlayerData.pBuyVehVehicle = pVehicle;
	pPlayerData.pBuyVehState = 2;
	pPlayerData.pBuyVehPrice = iBuyPrice;
	
	SendPlayerSuccessMessage ( pPlayer , "You now own this vehicle! Use /engine to start it." );
	SendPlayerAlertMessage ( pPlayer , "Please drive this car off the parking space, or you will lose it." );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RentVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
		
		return false;	
	
	}
	
	local pVehicleData = GetVehicleDataFromVehicle ( pPlayer.Vehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( pVehicleData.iRentPrice == 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is not rentable!" );
		
		return false;
	
	}	
	
	if ( pVehicleData.pRenter != false ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle is already being rented!" );
		
		return false;
	
	}	   
	
	if ( pPlayerData.iCash < pVehicleData.iRentPrice ) {
	
		SendPlayerErrorMessage ( pPlayer , "You don't have enough money to rent this vehicle!" );
		
		return false;
	
	}
	
	TakePlayerCash ( pPlayer , pVehicleData.iRentPrice );

	SetVehicleRenter ( pPlayer.Vehicle , pPlayer );
	
	SendPlayerSuccessMessage ( pPlayer , "You are now renting this vehicle! Use /engine to start it." );
	SendPlayerAlertMessage ( pPlayer , "You can use /stoprent to stop renting the vehicle" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function StopRentVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pPlayerData = GetPlayerData ( pPlayer );

	if ( !pPlayerData.pRentingVehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not renting a vehicle!" );
		
		return false;
	
	}
	
	local pRentingVehicleData = GetVehicleDataFromVehicle ( pPlayerData.pRentingVehicle );
	
	TakePlayerCash ( pPlayer , pRentingVehicleData.iRentPrice );
	
	SendPlayerSuccessMessage ( pPlayer , "You have stopped renting the " + GetVehicleDisplayName ( pPlayer.pRentingVehicle ) );
	SendPlayerAlertMessage ( pPlayer , "The vehicle's engine has been disabled. You'll need to rent the vehicle again to drive it." );
	
	ResetRentedVehicle ( pPlayer );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ResetRentedVehicle ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pPlayerData.pRentingVehicle ) {
	
		return false;
	
	}
	
	local pRentingVehicleData = GetVehicleDataFromVehicle ( pPlayerData.pRentingVehicle );
	
	if ( !pRentingVehicleData ) {
	
		return false;
	
	}
	
	if ( pRentingVehicleData.pRenter.ID != pPlayer.ID ) {
	
		return false;
	
	}
	
	pRentingVehicleData.pRenter = false;
	
	
	SetVehicleEngineState ( pPlayerData.pRentingVehicle , false );
	
	pPlayer.pRentingVehicle = false;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleRenter ( pVehicle , pPlayer ) {

	local pVehicleData = GetVehicleDataFromVehicle ( pVehicle );
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !pVehicleData ) {
	
		return false;
	
	}
	
	pVehicleData.pRenter = pPlayer;
	pPlayerData.pRentingVehicle = pVehicle;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleDataFromVehicle ( pVehicle ) {

	local pVehicleDataID = GetCoreTable( ).VehicleToData [ pVehicle.ID ];
	
	if ( pVehicleDataID == -1 ) {
	
		return false;
	
	}	
	
	local pVehicleData = GetVehicleData ( pVehicle )
	
	if ( !pVehicleData ) {
	
		return false;
	
	}
	
	return pVehicleData;

}

// -------------------------------------------------------------------------------------------------

function CreateVehicleCommand ( pPlayer , szVehicle , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Creates a new vehicle" , [ "AddVeh" ] , "" );
		
		return false;
	
	}

	if ( !szParams ) {
		
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Model ID/Name>" );
		
		return false;
		
	}

	local iModelID = 0;
	
	if ( IsNum ( szParams ) ) {
		
		if ( !IsValidVehicleModel ( szParams.tointeger ( ) ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
		iModelID = szParams.tointeger ( ) ;
		
	} else {
		
		local iModelID = GetVehicleIDFromName ( szParams.tostring ( ) );
		
		if ( !IsValidVehicleModel ( iModelID ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
	}
	
	local pVehicle = CreateNewVehicle ( iModelID , GetVectorInFrontOfPlayer ( pPlayer , 10.0 ) , pPlayer.Angle );
	
	SendPlayerSuccessMessage ( pPlayer , "Vehicle created! (ID: " + pVehicle.ID + ", Type: " + GetVehicleName ( pVehicle.Model ) + ")" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CreatePublicVehicleCommand ( pPlayer , szVehicle , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Creates a public vehicle" , [ "AddPublicVeh" ] , "" );
		
		return false;
	
	}

	if ( !szParams ) {
		
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Model ID/Name>" );
		
		return false;
		
	}

	local iModelID = 0;
	
	if ( IsNum ( szParams ) ) {
		
		if ( !IsValidVehicleModel ( szParams.tointeger ( ) ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
		iModelID = szParams.tointeger ( ) ;
		
	} else {
		
		local iModelID = GetVehicleIDFromName ( szParams.tostring ( ) );
		
		if ( !IsValidVehicleModel ( iModelID ) ) {
			
			SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleModelInvalid" ) );
			
			return false;
			
		}
		
	}
	
	local pVehicle = CreateNewVehicle ( iModelID , GetVectorInFrontOfPlayer ( pPlayer , 10.0 ) , pPlayer.Angle );
	
	GetVehicleData ( pVehicle ).iOwnerType = GetVehicleOwnerTypeID ( "Public" );
	
	SendPlayerSuccessMessage ( pPlayer , "Public vehicle created! (ID: " + pVehicle.ID + ", Type: " + GetVehicleName ( pVehicle.Model ) + ")" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CreateNewVehicle ( iModelID , pPosition , fAngle , pColour1 = Colour ( 255 , 255 , 255 ) , pColour2 = Colour ( 255 , 255 , 255 ) ) {

	local pVehicle = CreateVehicle ( iModelID , pPosition , fAngle , pColour1 , pColour2 );
	
	if ( pVehicle ) {
	
		local pVehicleData = GetCoreTable( ).Classes.VehicleData ( );
		pVehicleData.iModel = iModelID;
		pVehicleData.pColour1 = { r = 255 , g = 255 , b = 255 } ,
		pVehicleData.pColour2 = { r = 255 , g = 255 , b = 255 } ,
		pVehicleData.pPosition = pPosition;
		pVehicleData.pRotation = Vector ( 0.0 , 0.0 , fAngle );
		pVehicleData.fAngle = fAngle;
		pVehicleData.pVehicle = pVehicle;
		
		GetCoreTable().Vehicles.push ( pVehicleData );
		
		GetCoreTable ( ).VehicleToData [ pVehicle.ID ] = GetCoreTable().Vehicles.len ( ) - 1;
		
		return pVehicle;
	
	}

}

// -------------------------------------------------------------------------------------------------

function RespawnVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns a vehicle" , [ "RespawnVeh" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle must be a number!" );
		
		return false;
	
	}
	
	if ( !FindVehicle ( szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That vehicle ID doesn't exist!" );
		
		return false;
		
		
	}
	
	FindVehicle ( szParams.tointeger ( ) ).Respawn ( );

	SendPlayerSuccessMessage ( pPlayer , "Vehicle '" + GetVehicleName ( FindVehicle ( szParams.tointeger ( ) ) ) + "' (ID: " + FindVehicle ( szParams.tointeger ( ) ).ID + ") was respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnJobVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all vehicles for a specific job." , [ "RespawnJobVeh" , "RespawnJobVehs" , "RespawnJobCars" , "RJC" , "RJV" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand + "<Job ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The job ID must be a number!" );
		
		return false;
	
	}
	
	if ( !IsValidJobID ( szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That job ID doesn't exist!" );
		SendPlayerAlertMessage ( pPlayer , "Use /Jobs for a list." );
		
		return false;
		
	}
	
	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			if ( GetVehicleData ( iv.pVehicle , "iOwnerType" ) == GetVehicleOwnerTypeID ( "Job" ) && GetVehicleData ( iv.pVehicle , "iOwnerID" ) == szParams.tointeger ( ) ) {

				iv.pVehicle.Respawn ( );

			}
		
		}
	
	}

	EchoIRCConsoleDebug ( pPlayer.Name + " has respawned all vehicles for the '" + GetJobData ( szParams.tointeger ( ) , "szName" ) + "' job!" );
	SendAdminMessageToAll ( "All vehicles for the '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "' job have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles for the '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "' job have been respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnNearbyVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all vehicles near you." , [ "RespawnNearVeh" , "RespawnNearVehs" , "RespawnNearCars" , "RNC" , "RNV" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand + "<Distance>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The distance must be a number!" );
		
		return false;
	
	}
	
	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			if ( GetDistance ( iv.pVehicle.Pos , pPlayer.Pos ) <= szParams.tointeger ( ) ) {

				iv.pVehicle.Respawn ( );

			}
		
		}
	
	}

	EchoIRCConsoleDebug ( pPlayer.Name + " has respawned all vehicles within a " + szParams.tointeger ( ) + " meter radius of current position." );
	//SendAdminMessageToAll ( "All vehicles for the '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "' job have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles within a " + szParams.tointeger ( ) + " meter radius have been respawned!" );

	return true;

}
		
// -------------------------------------------------------------------------------------------------

function RespawnClanVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns vehicles for a specific clan" , [ "RespawnClanVeh" , "RespawnClanVehs" , "RespawnClanCars" , "RCC" , "RCV" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand + "<Clan ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The clan ID must be a number!" );
		
		return false;
	
	}
	
	if ( !IsValidClanID ( szParams.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That clan ID doesn't exist!" );
		SendPlayerAlertMessage ( pPlayer , "Use /Clans for a list." );
		
		return false;
		
	}
	
	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			if ( GetVehicleData ( iv.pVehicle , "iOwnerType" ) == GetVehicleOwnerTypeID ( "Clan" ) && GetVehicleData ( iv.pVehicle , "iOwnerID" ) == szParams.tointeger ( ) ) {

				iv.pVehicle.Respawn ( );

			}
			
		}
	
	}

	EchoIRCConsoleDebug ( pPlayer.Name + " has respawned all vehicles for clan '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "'" );
	SendAdminMessageToAll ( "All vehicles for clan '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "' have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles for clan '" + GetClanData ( szParams.tointeger ( ) , "szName" ) + "' have been respawned!" );

	return true;

}
		
// -------------------------------------------------------------------------------------------------

function RespawnPlayerVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local pVehicle = false;
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns vehicles owned by a specific player" , [ "RespawnPlayerVeh" , "RespawnPlayerVehs" , "RespawnPlayerCars" , "RPC" , "RPV" ] , "" );
		
		return false;
	
	}	

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand + "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is invalid!" );
		
		return false;
	
	}
	
	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			if ( GetVehicleData ( iv.pVehicle , "iOwnerType" ) == GetVehicleOwnerTypeID ( "Player" ) && GetVehicleData ( iv.pVehicle , "iOwnerID" ) == GetPlayerData ( FindPlayer ( szParams ) , "iDatabaseID" ) ) {

				iv.pVehicle.Respawn ( );

			}
			
		}
	
	}

	EchoIRCConsoleDebug ( pPlayer.Name + " has respawned all vehicles owned by '" + FindPlayer ( szParams ).Name + "'" );
	SendAdminMessageToAll ( "All vehicles owned by '" +FindPlayer ( szParams ).Name + "' have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles owned by '" + FindPlayer ( szParams ).Name + "' have been respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all vehicles" , [ "RespawnAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Respawn ( );
		
		}
	
	}
	
	EchoIRCConsoleDebug ( "All vehicles have been respawned by " + pPlayer.Name );
	SendAdminMessageToAll ( "All vehicles have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnEmptyVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all empty vehicles" , [ "RespawEmpty" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Respawn ( );
		
		}
	
	}
	
	EchoIRCConsoleDebug ( "All empty vehicles have been respawned by " + pPlayer.Name );
	SendAdminMessageToAll ( "All empty vehicles have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All empty vehicles have been respawned!" );

	return true;

}
		
// -------------------------------------------------------------------------------------------------

function RespawnPublicVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Respawns all public vehicles" , [ "RespawnPublicVeh" , "RespawnPublicVehs" , "RespawnPublicCars" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			if ( GetVehicleData ( iv.pVehicle , "iOwnerType" ) == GetVehicleOwnerTypeID ( "Public" ) ) {
		
				iv.pVehicle.Respawn ( );
		
			}
		
		}
	
	}
	
	EchoIRCConsoleDebug ( "All empty vehicles have been respawned by " + pPlayer.Name );
	SendAdminMessageToAll ( "All empty vehicles have been respawned by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All empty vehicles have been respawned!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RefuelAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Refuel all vehicles" , [ "RefuelAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.iFuel = 100;
		
		}
	
	}
	
	EchoIRCConsoleDebug ( "All vehicles have been refueled by " + pPlayer.Name );
	SendAdminMessageToAll ( "All vehicles have been refueled by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been refueled!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function RepairAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Repairs all vehicles" , [ "RepairAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Fix ( )
			iv.fHealth = 1000;
			iv.fEngineDamage = 0;
		
		}
	
	}
	
	EchoIRCConsoleDebug ( "All vehicles have been repaired/fixed by " + pPlayer.Name );
	SendAdminMessageToAll ( "All vehicles have been repaired/fixed by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been repaired/fixed!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function ExplodeAllVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Blows up all vehicles" , [ "ExplodeAll" ] , "" );
		
		return false;
	
	}

	foreach ( ii , iv in GetCoreTable( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			iv.pVehicle.Explode ( pPlayer );
		
		}
	
	}
	
	SendAdminMessageToAll ( "All vehicles have been exploded by " + pPlayer.Name );
	SendPlayerSuccessMessage ( pPlayer , "All vehicles have been exploded!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function DeleteVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Deletes a vehicle" , [ "DelVeh" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID> <Player Name/ID>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 1 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/DelVeh <Vehicle ID>" );
		
		return false;
	
	}
	
	local szVehicleParam = GetTok ( szParams , " " , 1 );
	
	if ( !FindVehicle ( szVehicleParam.tointeger ( ) ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szVehicleParam.tointeger ( ) );
	
	GetVehicleData ( pVehicle ).bDeleted = true;
	
	foreach ( ii , iv in ConnectedPlayers ) {
	
		if ( iv.Vehicle ) {
		
			if ( iv.Vehicle.ID == pVehicle.ID ) {
			
				iv.RemoveFromVehicle ( );
				
				SendPlayerAlertMessage ( iv , "The vehicle you were in was deleted." );
			
			}
			
		}
	
	}
		
	GetVehicleData ( pVehicle ).pVehicle = false;
	GetCoreTable ( ).VehicleToData [ pVehicle.ID ] = null;

	local szDisplayName = GetVehicleName ( pVehicle );
	local szDisplayID = pVehicle.ID;
	
	pVehicle.Remove ( );

	SendPlayerSuccessMessage ( pPlayer , "Vehicle '" + szDisplayName + "' (ID " + szDisplayID + ") has been deleted!" );

	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleOwnerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Sets a player as owner of a vehicle" , [ "VehOwner" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID> <Player Name/ID>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID> <Player Name/ID>" );
		
		return false;
	
	}
	
	local szVehicleParam = GetTok ( szParams , " " , 1 );
	local szTargetParam = GetTok ( szParams , " " , 2 );
	
	if ( !FindPlayer ( szTargetParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player was not found!" );
		
		return false;   
	
	}
	
	local pTarget = FindPlayer ( szTargetParam );
	
	if ( !FindVehicle ( szVehicleParam.tointeger ( ) ) ) {
		
		SendPlayerErrorMessage ( pPlayer , "That vehicle does not exist!" );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szVehicleParam.tointeger ( ) );
	
	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.Player;
	GetVehicleData ( pVehicle ).iOwnerID = GetPlayerData ( pTarget ).iDatabaseID;
	
	SendPlayerSuccessMessage ( pPlayer , "The owner for vehicle '" + GetVehicleDisplayName ( pVehicle ) + "' (ID " + pVehicle.ID + ") has been set to " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , pPlayer.Name + " has set you as owner for vehicle '" + GetVehicleDisplayName ( pVehicle ) + "' (ID " + pVehicle.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleColourCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Sets a vehicle colour" , [ "VehColour" , "Recolour" , "Respray" ] , "" );
		
		return false;
	
	}
	
	if( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You need to be in a vehicle!" );
		
		return false;
	
	}	
	
	if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
		
		if ( !IsPlayerAtPayAndSpray ( pPlayer ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be at a pay and spray!" );
			
			return false;
		
		}
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/VehColour <Colour Number> <Red> <Green> <Blue>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 4 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<1/2> <Red> <Green> <Blue>" );
		
		return false;
	
	}
	
	local szColourIDParam = GetTok ( szParams , " " , 1 );
	local szRedParam = GetTok ( szParams , " " , 2 );
	local szGreenParam = GetTok ( szParams , " " , 3 );
	local szBlueParam = GetTok ( szParams , " " , 4 );
	
	if ( !DoesPlayerHaveVehicleKeys ( pPlayer , pPlayer.Vehicle ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CantChangeVehicleColour" ) );
		
		return false;
	
	}
	
	if ( !IsNum ( szColourIDParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "InvalidVehicleColourID" ) );
		
		return false;
	
	}
	
	if ( !IsValidVehicleColourIndex ( szColourIDParam.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "InvalidVehicleColourID" ) );
		
		return false;
	
	}
	
	
	if ( !IsNum ( szRedParam ) || !IsNum ( szGreenParam ) || !IsNum ( szBlueParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "AllVehColoursMustBeNum" ) );
		
		return false;
	
	}	
	
	if ( !IsValidRGBValue ( szRedParam.tointeger ( ) ) || !IsValidRGBValue ( szGreenParam.tointeger ( ) ) || !IsValidRGBValue ( szBlueParam.tointeger ( ) ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The colours must all be between 0 and 255!" );
		
		return false;
	
	}
	
	local pColour = { r = szRedParam.tointeger ( ) , g = szGreenParam.tointeger ( ) , b = szBlueParam.tointeger ( ) };
	
	if ( szColourIDParam.tointeger ( ) == 1 ) {
	
		GetVehicleData ( pPlayer.Vehicle ).pColour1 = pColour;
		pPlayer.Vehicle.RGBColour1 = Colour ( pColour.r , pColour.g , pColour.b );
		
	} else {
	
		GetVehicleData ( pPlayer.Vehicle ).pColour2 = pColour;
		pPlayer.Vehicle.RGBColour2 = Colour ( pColour.r , pColour.g , pColour.b );
		
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You set the colour for vehicle '" + GetVehicleDisplayName ( pPlayer.Vehicle ) + "' (ID " + pPlayer.Vehicle.ID + ") to " + szRedParam + " red, " + szGreenParam + " green, and " + szBlueParam + " blue" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetVehicleHealthCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Sets the health of a vehicle" , [ "SetVehHealth" , "VehHealth" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID> <Health (0-1000)>" );
		
		return false;
	
	}
	
	if( NumTok ( szParams , " " ) != 2 ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID> <Health (0-1000)>" );
		
		return false;
	
	}
	
	local szVehicleParam = GetTok ( szParams , " " , 1 );
	local szHealthParam = GetTok ( szParams , " " , 2 );

	if ( !IsNum ( szVehicleParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "Th vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	if ( !FindVehicle ( szVehicleParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "That vehicle was not found!" );
		
		return false;   
	
	}

	if ( !IsNum ( szHealthParam ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The health must be a number!" );
		
		return false;   
	
	}

	if ( szHealthParam.tointeger ( ) < 0 || szHealthParam.tointeger ( ) > 1000 ) {
	
		SendPlayerErrorMessage ( pPlayer , "The health must be between 0 and 1000!" );
		
		return false;   
	
	}

	FindVehicle ( szVehicleParam ).Health = szHealthParam.tointeger ( );

	return true;

}

// -------------------------------------------------------------------------------------------------

function VehicleTuneUpCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Upgrades a vehicle component." , [ "TuneUp" , "VehTuneUp" ] , "" );
		
		return false;
	
	}
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( !GetPlayerData ( pPlayer ).bAtPayAndSpray ) {

		SendPlayerErrorMessage ( pPlayer , "You are not at a pay and spray!" );
		
		return false;	
	
	}		
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Upgrade Name>" );
		
		return false;
	
	}
	
	if ( GetVehicleData ( pPlayer.Vehicle ).iOwnerType > 2 ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle can't be upgraded!" );
		
		return false;
	
	}
	
	local pVehicle = pPlayer.Vehicle;

	switch ( szParams.tolower ( ) ) {
	
		case "engine":
		
			if ( GetVehicleData ( pVehicle ).iEngineMult >= 3 ) {
			
				SendPlayerErrorMessage ( pPlayer , "Your vehicle's engine is fully upgraded!" );
				
				return false;
				
			}
			
			local iPrice = ( 5000 * GetVehicleData ( pVehicle ).iEngineMult );
			
			if ( GetPlayerData ( pPlayer ).iCash < iPrice ) {
			
				SendPlayerErrorMessage ( pPlayer , "It costs $" + iPrice + " to upgrade your vehicle's engine!" );
				
				return false;
			
			}

			SendPlayerSuccessMessage ( pPlayer , "Your vehicle's engine has been upgraded by 10%" );
			
			TakePlayerCash ( pPlayer , iPrice );
			
			UpgradeVehicleEngine ( pVehicle );
		
			return true; 
			
		case "wheels":
		
			if ( GetVehicleData ( pPlayer.Vehicle ).iWheelMult >= 3 ) {
			
				SendPlayerErrorMessage ( pPlayer , "Your vehicle's wheels are fully upgraded!" );
				
				return false;
				
			}
			
			local iPrice = ( 5000 * GetVehicleData ( pVehicle ).iWheelMult );
			
			if ( GetPlayerData ( pPlayer ).iCash < iPrice ) {
			
				SendPlayerErrorMessage ( pPlayer , "It costs $" + iPrice + " to upgrade your vehicle's wheels!" );
				
				return false;
			
			}			

			SendPlayerSuccessMessage ( pPlayer , "Your vehicle's wheels have been upgraded by 10%" );
			
			TakePlayerCash ( pPlayer , iPrice );
			
			UpgradeVehicleWheels ( pVehicle );
		
			return true; 

		case "brakes":
		
			if ( GetVehicleData ( pPlayer.Vehicle ).iBrakeMult >= 3 ) {
			
				SendPlayerErrorMessage ( pPlayer , "Your vehicle's brakes are fully upgraded!" );
				
				return false;
				
			}
			
			local iPrice = ( 5000 * GetVehicleData ( pVehicle ).iBrakeMult );
			
			if ( GetPlayerData ( pPlayer ).iCash < iPrice ) {
			
				SendPlayerErrorMessage ( pPlayer , "It costs $" + iPrice + " to upgrade your vehicle's brakes!" );
				
				return false;
			
			}			

			SendPlayerSuccessMessage ( pPlayer , "Your vehicle's brakes have been upgraded by 10%" );
			
			TakePlayerCash ( pPlayer , iPrice );
			
			UpgradeVehicleBrakes ( pVehicle );
		
			return true;

		case "hydraulics":
		
			if ( GetVehicleData ( pVehicle ).bHydraulics ) {
			
				SendPlayerErrorMessage ( pPlayer , "Your vehicle already has hydraulics!" );
				
				return false;
				
			}
			
			local iPrice = 5000;
			
			if ( GetPlayerData ( pPlayer ).iCash < iPrice ) {
			
				SendPlayerErrorMessage ( pPlayer , "It costs $" + iPrice + " to give your vehicle hydraulics!" );
				
				return false;
			
			}			

			SendPlayerSuccessMessage ( pPlayer , "Your vehicle has been upgraded with hydraulics. Use H to bounce!" );
			
			TakePlayerCash ( pPlayer , iPrice );
			
			GetVehicleData ( pVehicle ).bHydraulics = true;
			
			pVehicle.SetHandlingData ( HANDLING_SUSPENSIONFORCELEVEL , 0.65 );
		
			return true;

 			
		case "nitrous":
		case "nos":
		
			SendPlayerErrorMessage ( pPlayer , "We're all out of NOS tanks! Come back soon!" );
			
			return true;
		
			if ( GetVehicleData ( pVehicle ).bHydraulics ) {
			
				SendPlayerErrorMessage ( pPlayer , "Your vehicle already has NOS!" );
				
				return false;
				
			}
			
			local iPrice = 5000;
			
			if ( GetPlayerData ( pPlayer ).iCash < iPrice ) {
			
				SendPlayerErrorMessage ( pPlayer , "It costs $" + iPrice + " to give your vehicle hydraulics!" );
				
				return false;
			
			}			

			SendPlayerSuccessMessage ( pPlayer , "Your vehicle has been upgraded with NOS. Use N to boost your speed!" );
			
			TakePlayerCash ( pPlayer , iPrice );
			
			GetVehicleData ( pVehicle ).bNOS = true;
			
			pVehicle.SetHandlingData ( HANDLING_SUSPENSIONFORCELEVEL , 0.65 );
		
			return true;

		default:
			
			SendPlayerErrorMessage ( pPlayer , "Invalid upgrade name. Use '/Help Tuneup' for info." );
				
			return false;
			
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleModelIDCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	local iModelID = 0;
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Name>" );
		
		return false;
	
	}
	
	iModelID = GetVehicleIDFromName ( szParams );
	
	SendPlayerSuccessMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleModelID" ) , szModelID ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleData ( pVehicle , szDataKey = false ) {

	local iVehicleDataIndex = GetCoreTable ( ).VehicleToData [ pVehicle.ID ];
	
	if ( iVehicleDataIndex != -1 ) {
	
		if ( !szDataKey ) {
		
			return GetCoreTable ( ).Vehicles [ iVehicleDataIndex ];
		
		} else {
		
			return GetCoreTable ( ).Vehicles [ iVehicleDataIndex ] [ szDataKey ];
		
		}
	
	} else {
	
		return false;
	
	}

}

// -------------------------------------------------------------------------------------------------

function SetVehicleOwner ( pVehicle , pPlayer ) {

	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.Player;
	GetVehicleData ( pVehicle ).iOwnerID = GetPlayerData ( pPlayer ).iDatabaseID;
	
	GetVehicleData ( pVehicle ).iBuyPrice = 0;
	GetVehicleData ( pVehicle ).iRentPrice = 0;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function SetVehicleUnowned ( pVehicle ) {

	GetVehicleData ( pVehicle ).iOwnerType = GetCoreTable ( ).Utilities.pVehicleOwnerType.None;
	GetVehicleData ( pVehicle ).iOwnerID = 0;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetVehicleDataSlotByDatabaseID ( iDatabaseID ) {

	foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
	
		if ( iv.iDatabaseID == iDatabaseID ) {
		
			return ii;
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function VehicleSpawnLockCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Toggles a vehicle spawn lock on or off" , [ "VehSpawnLock" ] , "" );
		
		return false;
	
	}
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be in a vehicle!" );
		
		return false;
	
	}
	
	if ( GetVehicleData ( pPlayer.Vehicle ).bSpawnLock ) {
	
		GetVehicleData ( pPlayer.Vehicle ).bSpawnLock = false;
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleDisplayName ( pPlayer.Vehicle ) + " is not locked in the old spawn position anymore." );
	
	} else {
	
		GetVehicleData ( pPlayer.Vehicle ).bSpawnLock = true;
		SendPlayerSuccessMessage ( pPlayer , "The " + GetVehicleDisplayName ( pPlayer.Vehicle ) + " is now locked in this position for respawn." );	
		
		GetVehicleData ( pPlayer.Vehicle ).pPosition = pPlayer.Vehicle.Pos;
		GetVehicleData ( pPlayer.Vehicle ).fAngle = pPlayer.Vehicle.Angle;
		
		pPlayer.Vehicle.SpawnPos = pPlayer.Vehicle.Pos;
		pPlayer.Vehicle.SpawnAngle = pPlayer.Vehicle.Angle;
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GotoVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGotoVeh" ) , [ "GotoVeh" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szParams );
	
	pPlayer.Pos = GetVectorAboveVector ( pVehicle.Pos , 3.0 );
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported to vehicle '" + GetVehicleDisplayName ( pVehicle ) + "' (ID " + pVehicle.ID + ")" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleDatabaseIDCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescVehDBID" ) , [ "VehDBID" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
		
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "The database ID for '" + GetVehicleDisplayName ( pVehicle ) + "' (ID " + pVehicle.ID + ") is " + GetVehicleData ( pVehicle ).iDatabaseID );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function RespawnVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescRespawnVeh" ) , [ "RespawnVeh" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
		
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
	
	}
	
	if ( !GetVehicleData ( FindVehicle ( szParams ) ).bSpawnLock ) {
	
		FindVehicle ( szParams ).SpawnPos = FindVehicle ( szParams ).Pos;
		FindVehicle ( szParams ).SpawnAngle = FindVehicle ( szParams ).Angle;
	
	}
	
	FindVehicle ( szParams ).Respawn ( );
	
	SendPlayerSuccessMessage ( pPlayer , "The '" + GetVehicleName ( FindVehicle ( szParams ) ) + "' (ID " + FindVehicle ( szParams ).ID + ") has been respawned!" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function SetJobVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Make a vehicle owned by a job" , [ "JobVeh" , "JobVehicle" , "VehJob" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
		
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
	
	}
	
	if ( !GetVehicleData ( FindVehicle ( szParams ) ).bSpawnLock ) {
	
		FindVehicle ( szParams ).SpawnPos = FindVehicle ( szParams ).Pos;
		FindVehicle ( szParams ).SpawnAngle = FindVehicle ( szParams ).Angle;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "The '" + GetVehicleName ( FindVehicle ( szParams ) ) + "' (ID " + FindVehicle ( szParams ).ID + ") now belongs to the '" + GetCoreTables ( ).Jobs [ szParams.tointeger ( ) ].szName "' job" );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGetVeh" ) , [ "GetVeh" ] , "You can provide offset X, Y, and Z." );
		
		return false;
	
	}

	if( !DoesPlayerHaveStaffPermission ( pPlayer , "BasicModeration" ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NoCommandPermission" ) );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Vehicle ID>" );
		
		return false;
	
	}
	
	if ( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle ID must be a number!" );
		
		return false;   
	
	}
	
	szParams = szParams.tointeger ( );
	
	if ( !FindVehicle ( szParams ) ) {
	
		
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "VehicleNotFound" ) );
		
		return false;
	
	}
	
	local pVehicle = FindVehicle ( szParams );
	
	pVehicle.Pos = GetVectorInFrontOfPlayer ( pPlayer , 10.0 );
	pVehicle.Angle = pPlayer.Angle;
	
	SendPlayerSuccessMessage ( pPlayer , "You have been teleported vehicle '" + GetVehicleDisplayName ( pVehicle ) + "' (ID " + pVehicle.ID + ") to you." );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerVehicleInfoCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescInVeh" ) , [ "InVeh" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , szCommand , "<Player Name/ID>" );
		
		return false;
	
	}
	
	if ( !FindPlayer ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "That player is not in a vehicle!" );
		
		return false;
	
	}
	
	local szOwnerInfo = "None";
	
	if ( GetVehicleData ( pTarget.Vehicle ).iOwnerType != 0 ) {
	
		szOwnerInfo = GetVehicleOwnerName ( pTarget.Vehicle ) + " (" + GetVehicleOwnerTypeName ( pTarget.Vehicle ) + ")";
	
	}
	
	MessagePlayer ( "== VEHICLE INFO ======================" );
	MessagePlayer ( GetHexColour ( "White" ) + "-Owner: " + GetHexColour ( "LightGrey" ) + szOwnerInfo + GetHexColour ( "White" ) + "  -Seat: " + pTarget.VehicleSeat + GetHexColour ( "White" ) + "  -Vehicle ID: " + GetHexColour ( "LightGrey" ) + pTarget.Vehicle.ID , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( GetHexColour ( "White" ) + "-Locked: " + GetHexColour ( "LightGrey" ) + GetYesNoBoolText ( GetVehicleData ( pTarget.Vehicle ).bLocked ) + GetHexColour ( "White" ) + "  -Engine: " + GetHexColour ( "LightGrey" ) + GetOnOffBoolText ( GetVehicleData ( pTarget.Vehicle ).bEngine ) , pPlayer , GetRGBColour ( "White" ) );
	MessagePlayer ( GetHexColour ( "White" ) + "-Database ID: " + GetHexColour ( "LightGrey" ) + GetVehicleData ( pTarget.Vehicle ).iDatabaseID + GetHexColour ( "White" ) + "  -Type: " + GetHexColour ( "LightGrey" ) + GetVehicleName ( pTarget.Vehicle ) , pPlayer , GetRGBColour ( "White" ) );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehicleOwnerName ( pVehicle ) {

	switch ( GetVehicleData ( pVehicle ).iOwnerType ) {
	
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.None:
			return "None";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Player:
			return LoadAccountFromDatabaseByID ( GetVehicleData ( pVehicle ).iOwnerID.tointeger ( ) ).szName;
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan:
			return GetClanDataByDatabaseID ( GetVehicleData ( pVehicle ).iOwnerID ).szName;
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Job:
			return GetCoreTable ( ).Jobs [ GetVehicleData ( pVehicle ).iOwnerID ].szName;
			
		default:
			return "Unknown";
	}

}

// -------------------------------------------------------------------------------------------------

function GetVehicleOwnerTypeName ( pVehicle ) {

	switch ( GetVehicleData ( pVehicle ).iOwnerType ) {
	
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.None:
			return "None";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Player:
			return "Player";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan:
			return "Clan";
			
		case GetCoreTable ( ).Utilities.pVehicleOwnerType.Job:
			return "Job";
			
		default:
			return "Unknown";
	}
	
	return "Unknown";

}

// -------------------------------------------------------------------------------------------------

function SyncVehicleWithData ( pVehicle ) {

	local iVehicleDataID = GetCoreTable ( ).VehicleToData [ pVehicle.ID ];
	
	if ( iVehicleDataID == -1 ) {
	
		return false;
	
	}
	
	local pVehicleData = GetCoreTable ( ).Vehicles [ iVehicleDataID ];
	
	pVehicle.Locked = pVehicleData.bLocked;
	pVehicle.SetEngineState ( pVehicleData.bEngine );
	pVehicle.LightState = GetVehicleLightStateFromBool ( pVehicleData.bLightState );
	pVehicle.RGBColour1 = Colour ( pVehicleData.pColour1.r , pVehicleData.pColour1.g , pVehicleData.pColour1.b );
	pVehicle.RGBColour2 = Colour ( pVehicleData.pColour2.r , pVehicleData.pColour2.g , pVehicleData.pColour2.b );

}

// -------------------------------------------------------------------------------------------------

function SyncAllVehiclesWithData ( ) {

	foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
	
		if ( iv.pVehicle ) {
		
			::SyncVehicleWithData ( iv.pVehicle );
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function GetVehicleDisplayName ( pVehicle ) {

	return GetVehicleName ( pVehicle.Model );
	
}

// -------------------------------------------------------------------------------------------------

function PlayerEnteredVehicleOwnerInfo ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerEnteredVehicleRentInfo ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerEnteredVehicleBuyInfo ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerEnteredVehicleHelpInfo ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PlayerEnteredVehicleCheckLock ( ) {

	if ( GetVehicleData ( pVehicle ).bLocked ) {
	
		SendPlayerAlertMessage ( pPlayer , format ( GetPlayerLocaleMessage ( pPlayer , "VehicleIsLocked" ) , GetVehicleDisplayName ( pVehicle ) ) );		
		RemovePlayerFromVehicle ( pPlayer );
		
		EchoIRCConsoleDebug ( "- Player '" + pPlayer.Name + "' (ID " + pPlayer.ID + ") was removed from Vehicle: " + pVehicle.ID + " (" + GetVehicleDisplayName ( pVehicle ) + ") from Seat: " + iSeatID + " because it was locked and they got in" );
		
		return 0;
		
	}

	return 1;

}

// -------------------------------------------------------------------------------------------------

function ProcessVehicleFuel ( ) {

	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( iv && iv.Vehicle ) {
		
			if ( IsVehicleCar ( iv.Vehicle.Model ) ) {
			
				if ( GetVehicleData ( iv.Vehicle ).iOwnerType == GetUtilityConfiguration ( ).pVehicleOwnerType.Player ) {
				
					if ( GetVehicleData ( iv.Vehicle ).iFuel > 0 ) {
					
						if ( iv.Vehicle.Driver.ID == iv.ID ) {
						
							GetVehicleData ( iv.Vehicle ).iFuel--;
							
						}
						
					} else {
					
						if ( IsVehicleEngineRunning ( iv.Vehicle ) ) {
							
							SetVehicleEngineState ( iv.Vehicle , false );
							
						}
						
					}
					
				}
			
			}
			
		}

	}
	
}

// -------------------------------------------------------------------------------------------------

function RepairVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , "Repairs a vehicle" , [ "Repair" , "Fix" , "FixVeh" ] , "" );
		
		return false;
	
	}
	
	local pVehicle = pPlayer.Vehicle;
	
	if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
	
		if ( !GetPlayerData ( pPlayer ).bAtPayAndSpray ) {
		
			SendPlayerErrorMessage ( pPlayer , "You are not at a pay and spray!" );
			
			return false;
		
		}
		
	}
	
	if ( !pVehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
	
		if ( pVehicle.Driver.ID != pPlayer.ID ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
			
			return false;
		
		}
	
	}
	
	if ( GetPlayerData ( pPlayer , "iCash" ) < 250 ) {
		
		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
			
			SendPlayerErrorMessage ( pPlayer , "You don't have $250 to repair this vehicle!" );
			
			return false;
			
		}
		
	}
	
	pVehicle.Health = 1000;
	pVehicle.EngineDamage = 0;
	pVehicle.Fix ( );
	
	GetVehicleData ( pVehicle ).fHealth = 1000;
	GetVehicleData ( pVehicle ).fEngineDamage = 0;
	
	TakePlayerCash ( pPlayer , 250 );
	
	SendPlayerSuccessMessage ( pPlayer , "The vehicle has been repaired!" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function RefuelVehicleCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescRefuelVeh" ) , [ "Refuel" , "Refill" , "Fuel" ] , "" );
		
		return false;
	
	}
	
	local pVehicle = pPlayer.Vehicle;
	local pVehicleData = GetVehicleData ( pVehicle );
	
	if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
	
		if ( !IsPlayerAtFuelPump ( pPlayer ) ) {
		
			SendPlayerErrorMessage ( pPlayer , "You are not at a fuel pump!" );
			
			return false;
		
		}
		
	}
	
	if ( !pVehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not in a vehicle!" );
		
		return false;
	
	}
	
	if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
	
		if ( pVehicle.Driver.ID != pPlayer.ID ) {
		
			SendPlayerErrorMessage ( pPlayer , "You must be the driver!" );
			
			return false;
		
		}
	
	}
	
	if ( pVehicleData.iFuel >= GetUtilityConfiguration ( ).iMaxFuel ) {
	
		SendPlayerErrorMessage ( pPlayer , "This vehicle doesn't need any fuel" );
	
		return false;
	
	}
	
	if ( GetPlayerData ( pPlayer , "iCash" ) < 50 ) {
		
		if ( !DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
			
			SendPlayerErrorMessage ( pPlayer , "You don't have $50 to refuel this vehicle!" );
			
			return false;
			
		}
		
	}	
	
	pVehicleData.iFuel = GetUtilityConfiguration ( ).iMaxFuel;
	
	SendPlayerSuccessMessage ( pPlayer , "The vehicle has been refueled!" );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function GetVehicleFuelCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( bShowHelpOnly ) {
		
		SendPlayerCommandInfoMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "CommandUsageDescGetFuel" ) , [ "Fuel" , "GetFuel" , "VehFuel" ] , "" );
		
		return false;
	
	}
	
	if ( !pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "NotInVehicle" ) );
		
		return false;
	
	}
	
	if ( pPlayer.VehicleSeat != 0 ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "MustBeDriver" ) );
		
		return false;
		
	}
	
	SendPlayerSuccessMessage ( pPlayer , "Your vehicle's fuel is at " + GetVehicleData ( pPlayer.Vehicle ).iFuel + "%" );

}

// -------------------------------------------------------------------------------------------------

function IsVehicleEngineRunning ( pVehicle ) {

	if ( GetVehicleData ( pVehicle ).bEngine ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function IsVehicleOwnerOnline ( pVehicle ) {

	foreach ( ii , iv in GetPlayingPlayers ( ) ) {
	
		if ( GetVehicleData ( pVehicle ).iOwnerID == GetPlayerData ( iv ).iDatabaseID ) {
		
			return true;
		
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function UpgradeVehicleEngine ( pVehicle ) {

	GetVehicleData ( pVehicle ).iEngineMult++;
	pVehicle.SetHandlingData ( HANDLING_ENGINEACCELERATION , GetVehicleHandlingData ( pVehicle.Model , HANDLING_ENGINEACCELERATION ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_ENGINEACCELERATION ) * 0.1 ) * GetVehicleData ( pVehicle ).iEngineMult ) );
	pVehicle.SetHandlingData ( HANDLING_MAXVELOCITY , GetVehicleHandlingData ( pVehicle.Model , HANDLING_MAXVELOCITY ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_MAXVELOCITY ) * 0.1 ) * GetVehicleData ( pVehicle ).iEngineMult ) );

}

// -------------------------------------------------------------------------------------------------

function UpgradeVehicleBrakes ( pVehicle ) {

	GetVehicleData ( pVehicle ).iBrakeMult++;
	pVehicle.SetHandlingData ( HANDLING_BRAKEDECELERATION , GetVehicleHandlingData ( pVehicle.Model , HANDLING_BRAKEDECELERATION ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_BRAKEDECELERATION ) * 0.1 ) * GetVehicleData ( pVehicle ).iBrakeMult ) );
	
}

// -------------------------------------------------------------------------------------------------

function UpgradeVehicleWheels ( pVehicle ) {

	GetVehicleData ( pVehicle ).iWheelMult++;
	pVehicle.SetHandlingData ( HANDLING_TRACTIONMULTIPLIER , GetVehicleHandlingData ( pVehicle.Model , HANDLING_TRACTIONMULTIPLIER ) + ( ( GetVehicleHandlingData ( pVehicle.Model , HANDLING_TRACTIONMULTIPLIER ) * 0.1 ) * GetVehicleData ( pVehicle ).iWheelMult ) );
	
}

// -------------------------------------------------------------------------------------------------

function GetOnlineVehicleOwner ( pVehicle ) {

	foreach ( ii , iv in GetPlayingPlayers ( ) ) {
	
		if ( GetVehicleData ( pVehicle ).iOwnerID == GetPlayerData ( iv ).iDatabaseID ) {
		
			return iv;
		
		}
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function ClientToggleVehicleLock ( pPlayer ) {

	if ( pPlayer.Vehicle ) {
	
		if ( GetVehicleData ( pPlayer.Vehicle ).bLocked ) {
		
			VehicleLockCommand ( pPlayer , "Lock" , "Off" );
			
		} else {
		
			VehicleLockCommand ( pPlayer , "Lock" , "On" );
		
		}
		
		return true;
	
	}
	
	if ( GetClosestVehicle ( pPlayer ) ) {
	
		if ( GetDistance ( pPlayer.Pos , GetClosestVehicle ( pPlayer ).Pos ) <= 5.0 ) {
		
			if ( GetVehicleData ( GetClosestVehicle ( pPlayer ) ).bLocked ) {
			
				VehicleLockCommand ( pPlayer , "Lock" , "Off" );
				
			} else {
			
				VehicleLockCommand ( pPlayer , "Lock" , "On" );
			
			}
		
		}
		
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function ClientToggleVehicleEngine ( pPlayer ) {

	if ( pPlayer.Vehicle ) {
	
		if ( GetVehicleData ( pPlayer.Vehicle ).bEngine ) {
		
			VehicleEngineCommand ( pPlayer , "Engine" , "Off" );
			
		} else {
		
			VehicleEngineCommand ( pPlayer , "Engine" , "On" );
		
		}
		
		return true;
	
	}
	
	return false;
	
}

// -------------------------------------------------------------------------------------------------

function ClientToggleVehicleLights ( pPlayer ) {

	if ( pPlayer.Vehicle ) {
	
		if ( GetVehicleData ( pPlayer.Vehicle ).bLightState ) {
		
			VehicleLightsCommand ( pPlayer , "Lights" , "Off" );
			
		} else {
		
			VehicleLightsCommand ( pPlayer , "Lights" , "On" );
		
		}
		
		return true;
	
	}
	
	return false;
	
}
		
// -------------------------------------------------------------------------------------------------
		
function GetVehicleOwnerTypeID ( szOwnerTypeName ) {

	if ( GetUtilityConfiguration ( "pVehicleOwnerType" ).rawin ( szOwnerTypeName ) ) {
	
		return GetUtilityConfiguration ( "pVehicleOwnerType" ) [ szOwnerTypeName ];
		
	}
		
	return 0;
		
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Vehicle]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
