
// NAME: Startup.nut
// DESC: Handles all functions for server initialization and loading upon startup
// NOTE: None

// -- COMMANDS -------------------------------------------------------------------------------------

function AddStartupCommandHandlers ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function InitAllScripts ( ) {

	InitConfigurationScript ( );
	InitDatabaseScript ( );

	InitBitFlagsScript ( );
	InitBusinessScript ( );
	InitChatScript ( );
	InitClanScript ( );
	InitClassesScript ( );
	InitClientScript ( );
	InitColoursScript ( );
	InitHelpScript ( );
	InitHousesScript ( );
	InitJobsScript ( );
	InitIRCScript ( );
	InitMessagingScript ( );
	InitModerationScript ( );
	InitAccountScript ( );
	InitDeveloperScript ( );
	InitSecurityScript ( );	
	InitUtilitiesScript ( );
	InitVehicleScript ( );
	InitAnimationsScript ( );
	InitAmmunationScript ( );
	
	InitPoliceJobScript ( );
	InitFireJobScript ( );
	InitMedicJobScript ( );
	InitTaxiJobScript ( );
	InitBusJobScript ( );
	InitGarbageJobScript ( );
	InitDrugsJobScript ( );
	InitWeaponsJobScript ( );
	
	InitVehicleSpeedLimiterScript ( );
	InitVehicleHydraulicsScript ( );
	
	CreateBlips ( );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InitServerTimers ( ) {

	GetCoreTable ( ).Timers.pServerSaveTimer 		= NewTimer ( "SaveServerDataTimerFunction" 		, GetUtilityConfiguration ( ).iServerSaveInterval 				, 0 );
	GetCoreTable ( ).Timers.pVehicleSyncTimer 		= NewTimer ( "SyncAllVehiclesWithData" 			, GetUtilityConfiguration ( ).iVehicleDataSyncInterval 			, 0 );
	GetCoreTable ( ).Timers.pTimeUpdateTimer 		= NewTimer ( "UpdateGameTimeTimerFunction" 		, GetUtilityConfiguration ( ).iTimeUpdateSpeed 					, 0 );
	GetCoreTable ( ).Timers.pVehicleFuelTimer 		= NewTimer ( "ProcessVehicleFuel" 				, GetUtilityConfiguration ( ).iFuelProcessInterval 				, 0 );
	GetCoreTable ( ).Timers.pFireJobUpdateTimer		= NewTimer ( "FireJobTimerFunction" 			, GetUtilityConfiguration ( ).iFireJobUpdateInterval 			, 0 );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Startup]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------