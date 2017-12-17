// -------------------------------------------------------------------------------------------------

function InitClassesScript ( ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function InitClassesCoreTable ( ) {

	local pClassesCoreTable = { };
	
	pClassesCoreTable.PlayerData		<- ::InitPlayerDataClass ( );
	pClassesCoreTable.BusinessData 		<- ::InitBusinessDataClass ( );
	pClassesCoreTable.SessionData 		<- ::InitSessionDataClass ( );
	pClassesCoreTable.HouseData 		<- ::InitHouseDataClass ( );
	pClassesCoreTable.ClanData			<- ::InitClanDataClass ( );
	pClassesCoreTable.CrimeData 		<- ::InitCrimeDataClass ( );
	pClassesCoreTable.SessionData 		<- ::InitFireDataClass ( );
	pClassesCoreTable.VehicleData 		<- ::InitVehicleDataClass ( );
	pClassesCoreTable.FuelPump	 		<- ::InitFuelPumpClass ( );
	pClassesCoreTable.CustomBindKey	 	<- ::InitCustomBindKeyClass ( );

	return pClassesCoreTable;
	
}

// -------------------------------------------------------------------------------------------------

function InitPlayerDataClass ( ) {

	return class {
		
		// The pointer to the player this belongs to
		pPlayer						= false;
		
		// Auth/Spawn
		bAuthenticated				= false;
		bCanSpawn					= false;
		bCanUseCommands				= false;
		bDead						= false;	
		bSpawnedOnce				= false;
		bInGTAVSpawnCam				= false;
		
		// Basic Information
		iHealth						= 0;
		iArmour						= 0;
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		fAngle						= 0.0;
		iSkin						= 0;
		iCash						= 0;			
		
		// Identity
		iDatabaseID					= 0;
		szName						= "";
		szPassword					= "";
		szLastIP 					= "";
		szLastLUID					= "";
		iLocale						= 0;
		szEmail						= "";
		
		// Game Sessions
		pThisSession				= false;
		pLastSession				= false;
		szConnectToken				= 0;
		iThisGameTime				= 0;
		iTotalGameTime				= 0;
		iLongestGameTime			= 0;
		iLastSessionID				= 0;
		iThisSessionID				= 0;
		
		// Timestamps
		iRegisteredTimestamp		= 0;
		iLastLoginTimestamp			= 0;	
		
		// Travel and Distance
		fDistanceOnFoot				= 0.0; 
		fDistanceCar				= 0.0;
		fDistanceBoat				= 0.0;
		fDistancePlane				= 0.0;
		fDistanceTrain				= 0.0;
		
		// Bit Flags
		iAccountSettings			= 0;
		iLicenses					= 0;
		iStaffFlags					= 0;
		iModerationFlags			= 0;		
		
		// Security, Moderation and Anticheat
		iLastUpdate					= 0;
		iPingKickTicks				= 0;
		iLoginAttemptsRemaining		= 3;
		iDeadIsland					= 0;
		iSpawnBug					= 0;
		iLastIdleCheck				= 0;
		iLastSpamWarning			= 0;
		iMuteStart					= 0;
		bMuted						= false;
		bFrozen						= false;
		pAntiCheatPosition			= ::Vector ( 0.0 , 0.0 , 0.0 );
		pEnteredVehicleNormally		= false;
		pEnteringVehicleNormally	= false;
		pExitingVehicleNormally		= false;		
		pLoginTimeout				= false;
		iTeleportIntoVehicleTime    = 0;
		iTeleportIntoVehicleCount   = 0;
		iLastKeyPress				= 0;
		pStaffNotes					= [ ];	
		pIPBlacklist				= [ ];
		pIPWhitelist				= [ ];
		pLUIDBlacklist				= [ ];
		pLUIDWhitelist				= [ ];
		
		// Police
		bTazerArmed					= false;
		bTazed						= false;
		bCuffed						= false;
		pCrimes						= [ ];
		pDragging					= false;		
		
		// Vehicle Purchase Information
		pBuyVehPosition 			= ::Vector ( 0.0 , 0.0 , 0.0 );
		pBuyVehAngle 				= 0.0;
		pBuyVehState	 			= 0;
		pBuyVehVehicle	 			= false;
		pBuyVehPrice	 			= 0;
		
		// Misc
		szStaffTitle				= "";
		i3DTextLabelFont			= 0;
		pRentingVehicle				= false;
		bNewlyRegistered 			= false;
		iBank						= 0;
		iJob						= -1;
		iClan						= 0;
		iDeaths						= 0;
		pWreckedVehicleSphere		= false;
		bAFK						= false;
		pRentingVehicle 			= false;
		pScreenInfo					= { iWidth = 0 , iHeight = 0 };	
		
		// Admin/Developer Duties
		bAdminDuty 					= false;
		bDeveloperDuty				= false;
		
		// Death
		iDeathTime					= 0;
		bDeathMode					= false;
		
		// Fire Job
		iFireMission				= -1;
		iFireMissionIsland			= 0;
		bFiretruckHoseState			= false;
		iFiretruckHoseStart			= 0;
		
		// Bus Job
		iBusRoute					= -1;
		iBusRouteNextStop			= -1;
		iBusRouteStart				= 0;
		iBusRouteLastStopTime		= 0;
		
		// Garbage Job
		iGarbageRoute				= -1;
		iGarbageRouteNextStop		= -1;
		iGarbageRouteStart			= 0;
		iGarbageRouteLastStopTime	= 0;	
		
		// Locations
		bAtPayAndSpray				= false;
		bAtAmmunation				= false;
		bAtClothingStore			= false;
		
		// Job
		pJobVehicleTimeout			= false;
		iDuty						= 0;
		bIsWorking					= false;
		iNextPaydayAmount			= 0;
		pJobBlip 					= false;
		pJobSphere					= false;		
		
		// Weapons
		pHasWeapon					= array ( 12 , false );
		pWeaponAmmo					= array ( 12 , 0 );
		
		// Blip
		bBlipsInit					= false;
		pBlips						= { Jobs = [ ] , Ammunations = [ ] , PayAndSprays = [ ] , Hospitals = [ ] , PoliceStations = [ ] , FireStations = [ ] , ClothingStores = [ ] , FuelPumps = [ ] };
		
		pMessages					= [ ];
		
		pCustomBindKeys				= [ ];
		
		// ------------------------------
		
		constructor ( ) {
			
		}
		
	};
	
}

// -------------------------------------------------------------------------------------------------

function InitSessionDataClass ( ) {
	
	return class {
		
		// Timestamps
		iConnectedTime				= 0;
		iDisconnectedTime			= 0;
		
		
		// Player Information
		szName						= "";
		szLUID						= "";
		szIP						= "";
		pPlayer						= false;
		
		// ------------------------------
		
		constructor ( pPlayer ) {
			
			iConnectedTime			= ::time ( );
			
			szName					= pPlayer.Name;
			szIP					= pPlayer.IP;
			szLUID					= pPlayer.LUID;
			
			pPlayer					= pPlayer;
			
		}
		
	};

	return true;
	
}
	
// -------------------------------------------------------------------------------------------------

function InitCrimeDataClass ( ) {

	return class {

		// Basic Information
		iCrimeID					= 0;
		iSuspectAccountID			= 0;
		
		// Crime Information
		szCrimeName					= "Unknown";
		szCrimeDetails				= "None";
		
		// Information on Adding
		iAddedTimestamp				= 0;
		iAddedWantedLevel			= 0;
		iAddedByAccountID			= 0;
		
		// Sentencing
		bServedSentence				= false;
		iSentenceType				= 0;
		iSentenceValue				= 0;
		
		// ------------------------------
		
		constructor ( ) {
			
		}

	}

	return true;
	
}
	
// -------------------------------------------------------------------------------------------------

function InitClanDataClass ( ) {
	
	return class {

		// Basic Information
		iDatabaseID					= 0;
		szName						= "";
		szTag						= "";
		szMotto						= "";
		iJoinType					= 0;
		iOwner						= 0;
		iBank						= 0;
		iWhenCreated				= 0;
		
		// Arrays of Extra Data
		pAllowedVehicles			= [ ];
		pMembers					= [ ];
		pAlliances					= [ ];
		pTerritories				= [ ];
		pTurfs						= [ ];
		pRanks						= [ ];
		
		// ------------------------------
		
		constructor ( pAssocResult ) {
		
			iDatabaseID = pAssocResult [ "clan_id" ];
			szName = pAssocResult [ "clan_name" ];
			szTag = pAssocResult [ "clan_tag" ];
			iOwner = pAssocResult [ "clan_owner" ];
			iWhenCreated = pAssocResult [ "clan_created" ];
		
		}

	}

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function InitBusinessDataClass ( ) {

	return class {
		
		// Basic Information
		iDatabaseID					= 0;
		szName						= "";
		bLocked						= true;
		iBuyPrice					= 0;
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		
		// Owner Info
		iOwnerType					= 0;
		iOwnerID					= 0;
		
		// Icons and Stuff
		pPickup						= false;
		pMapBlip					= false;
		
		// ------------------------------
		
		constructor ( pMySQLAssoc = false ) {
			
			if ( !pMySQLAssoc ) {
			
				return true;
			
			}
			
			iDatabaseID = pMySQLAssoc [ "biz_id" ].tointeger ( );
			szName = pMySQLAssoc [ "biz_name" ].tostring ( );
			bLocked = ::IntegerToBool ( pMySQLAssoc [ "biz_id" ].tointeger ( ) );
			iBuyPrice = pMySQLAssoc [ "biz_buy_price" ].tointeger ( );
			pPosition = ::Vector ( pMySQLAssoc [ "biz_pos_x" ].tofloat ( ) , pMySQLAssoc [ "biz_pos_y" ].tofloat ( ) ,pMySQLAssoc [ "biz_pos_z" ].tofloat ( ) );
			iOwnerID = pMySQLAssoc [ "biz_owner_id" ].tointeger ( );
			iOwnerType = pMySQLAssoc [ "biz_owner_type" ].tointeger ( );
			
		}
		
	}

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function InitVehicleDataClass ( ) {
	
	return class {
	
		// Basic Information
		iDatabaseID					= 0;
		iModel						= 0;
		pVehicle					= false;
		bSpawnLock					= false;
		pRenter						= false;
		bDeleted					= false;		
		bDestroyed					= false;
		
		// Colours
		// The Colour instances don't work properly, so we'll define the colours manually in a table
		pColour1					= { r = 0 , g = 0 , b = 0 };
		pColour2					= { r = 0 , g = 0 , b = 0 };
		
		// Positioning	
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		pRotation					= ::Vector ( 0.0 , 0.0 , 0.0 );
		fAngle						= 0.0;	
		
		// Owner Information
		iOwnerType					= 0;
		iOwnerID					= 0;
		
		// Pricing
		iBuyPrice					= 0;
		iRentPrice					= 0;	
		
		// Component States
		bEngine						= false;
		bLocked						= false;
		bLightState					= false;
		bSirenLight					= false;
		bTaxiLight					= false;
		bSiren						= false;	

		iRadio						= 1;
		iFuel 						= 100;
		
		// Health
		fHealth						= 0;
		fEngineDamage				= 0;
		
		szOwnerDisplay				= "";
		szModelDisplay				= "";
		
		bSpeedLimiter 				= false;
		
		bTempVehicle 				= false;
		
		pLastFuelCheckPos			= ::Vector ( 0.0 , 0.0 , 0.0 );
		
		bHydraulics					= false;
		iEngineMult					= 0;
		iWheelMult					= 0;
		iBrakeMult					= 0;
		bNOS						= false;
		
		pTires 						= [ ];
		iAverageTireDamage			= 0;
		
		// ------------------------------
		
		constructor ( ) {
		
		}
		
	}
	
	return true;
	
}
	
// -------------------------------------------------------------------------------------------------

function InitHouseDataClass ( ) {

	return class {
		
		iDatabaseID					= 0;
		bLocked						= true;
		
		iBuyPrice					= 0;
		
		iOwnerType					= 0;
		iOwnerID					= 0;
		
		pPickup						= false;
		
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		
		// ------------------------------
		
		constructor ( ) {
			
		}
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InitCustomBindKeyClass ( ) {

	return class {
		
		bEnabled = true;
		
		iKeyID						= 0;
		szCommand					= "";
		szParams					= "";
		
		// ------------------------------
		
		constructor ( ) {
			
		}
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InitFireDataClass ( ) {

   return class {
		
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		pAttached					= false;

		iFireType					= 0;
		iStart						= 0;

		iRadius						= 0;

		pFire						= false;

		// ------------------------------
		
		constructor ( ) {

		}

	}

}

// -------------------------------------------------------------------------------------------------

function InitBanDataClass ( ) {
	
	return class {
		
		// Basic Information
		iDatabaseID 				= 0;
		iWhenAdded					= 0;
		iAddedByAccountID			= 0;
		iBanType					= 0;
		
		// Player Information
		szName						= "";
		szLUID						= "";
		szIP						= "";
		
		// ------------------------------
		
		constructor ( ) {
			
		}
		
	};

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function InitPickupDataClass ( ) {

	return class {
		
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		iModel						= 0;
		
		iPickupDataType				= 0;
		iPickupDataID				= 0;
		
		pPickup						= false;
		
		// ------------------------------
		
		constructor ( ) {
			
		}
		
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function InitFuelPumpClass ( ) {

	return class {
	
		pPosition					= ::Vector ( 0.0 , 0.0 , 0.0 );
		iPricePerLiter				= 1;
		pSphere						= false;
		
		constructor ( pPosition , iPricePerLiter ) {
		
			pPosition = pPosition;
			iPricePerLiter = iPricePerLiter;
		
		}		
	
	}

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Classes]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------


// 