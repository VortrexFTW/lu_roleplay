// -------------------------------------------------------------------------------------------------

function InitUtilitiesScript ( ) {

    AddUtilitiesCommandHandlers ( );
    
    InitServerTimers ( );

    return true;

}

// -------------------------------------------------------------------------------------------------

function AddUtilitiesCommandHandlers ( ) {

    AddCommandHandler ( "NearPlayers"               , NearbyPlayersCommand              , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "NearVehicles"              , NearbyVehiclesCommand             , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "NearVeh"                   , NearbyVehiclesCommand             , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Near"                      , NearbyPlayersCommand              , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "BuySkin"                   , BuyClothesCommand                 , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "BuyClothes"                , BuyClothesCommand                 , GetStaffFlagValue ( "None" ) );
    
    //AddCommandHandler ( "GiveGun"                 , GiveWeaponCommand                 , GetStaffFlagValue ( "None" ) );
    //AddCommandHandler ( "GiveWeapon"              , GiveWeaponCommand                 , GetStaffFlagValue ( "None" ) );
    
    //AddCommandHandler ( "Location"                , PlayerLocationCommand             , GetStaffFlagValue ( "None" ) );
    //AddCommandHandler ( "Loc"                     , PlayerLocationCommand             , GetStaffFlagValue ( "None" ) );   

}

// -------------------------------------------------------------------------------------------------

function InitUtilitiesCoreTable ( ) {

    local pUtilitiesValuesTable = { };

    pUtilitiesValuesTable.szScriptVersion               <- 0;
    pUtilitiesValuesTable.iStartTimeStamp               <- 0;
    pUtilitiesValuesTable.pZeroVector                   <- Vector ( 0.0 , 0.0 , 0.0 );
    pUtilitiesValuesTable.szPartReasons                 <- [ "Disconnected" , "Timed Out" , "Kicked" , "Banned" , "Crashed" ];
    pUtilitiesValuesTable.iNoWeapon                     <- [ WEP_VEHICLE , WEP_DROWNED , WEP_FALL , WEP_EXPLOSION ];
    pUtilitiesValuesTable.szCardinalDirections          <- [ "North" , "Northeast" , "East" , "Southeast" , "South" , "Southwest" , "West" , "Northwest" , "Unknown" ];
    pUtilitiesValuesTable.pAllowedVehicles              <- [ 90 , 91 , 92 , 93 , 94 , 95 , 96 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 108 , 109 , 111 , 112 , 113 , 114 , 119 , 121 , 127 , 129 , 130 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 144 , 145 , 146 , 149 ];
    pUtilitiesValuesTable.pVehicleOwnerType             <- { None = 0 , Player = 1 , Clan = 2 , Job = 3 , Public = 4 };
    pUtilitiesValuesTable.pPickupDataType               <- { None = 0 , HiddenPackage = 1 , Business = 2 , House = 3 , Job = 4 , HelpInfo = 5 };
    pUtilitiesValuesTable.iMaxHiddenPackages            <- 50;
    pUtilitiesValuesTable.fAreaShoutRange               <- 20.0;
    pUtilitiesValuesTable.fAreaTalkRange                <- 10.0;
    pUtilitiesValuesTable.fArrestRange                  <- 5.0;
    pUtilitiesValuesTable.fHospitalHealRange            <- 10.0;
    pUtilitiesValuesTable.fVehicleLockRange             <- 5.0;
    pUtilitiesValuesTable.fVehicleTrunkRange            <- 5.0;
    pUtilitiesValuesTable.fCuffRange                    <- 3.0;
    pUtilitiesValuesTable.pJobs                         <- { None = 0 , Police = 1 , Fire = 2 , Medical = 3 , Garbage = 4 , Delivery = 5 , Taxi = 6 , Bus = 7 , Drug = 8 , Weapon = 9 };
    pUtilitiesValuesTable.WeekDays                      <- [ "Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" ];
    pUtilitiesValuesTable.Months                        <- [ "January" , "February" , "March" , "April" , "May" , "June" , "July" , "August" , "September" , "October" , "November" , "December" ];
    pUtilitiesValuesTable.iTimeHour                     <- 0;
    pUtilitiesValuesTable.iTimeMinute                   <- 0;
    pUtilitiesValuesTable.iTimeMinuteIncrement          <- 1;
    pUtilitiesValuesTable.iTimeHourIncrement            <- 1;
    pUtilitiesValuesTable.bTimeForward                  <- true;
    pUtilitiesValuesTable.iTimeUpdateSpeed              <- 10;
    pUtilitiesValuesTable.iCurrentWeather               <- 4;
    pUtilitiesValuesTable.bUseRealTime                  <- false;
    pUtilitiesValuesTable.fHydaulicsJumpDistance        <- 0.13;
    pUtilitiesValuesTable.sz3DTextLabelFontNames        <- [ "Tahoma" , "Courier New" , "Arial" ];
    pUtilitiesValuesTable.iBanTypes                     <- { None = 10 , Temp = 1 , IP = 2 , LUID = 3 , Range = 4 , Route = 5 };
    pUtilitiesValuesTable.pNewAccount                   <- { iCash = 0 , pPosition = ::Vector ( 0.0 , 0.0, 0.0 ) , fAngle = 0.0 , iSkin = 0 };
    pUtilitiesValuesTable.fFuelPerSingleUnit            <- 1;
    pUtilitiesValuesTable.iMaxFuel                      <- 100;
    pUtilitiesValuesTable.fTakeJobRange                 <- 10.0;
    pUtilitiesValuesTable.iTeleportIntoVehicleCheck     <- 3;
    pUtilitiesValuesTable.pWeaponModels                 <- [ 0 , 172 , 173 , 178 , 176 , 171 , 180 , 177 , 175 , 181 , 174 , 170 ];
    pUtilitiesValuesTable.pWeaponPrices                 <- [ 0 , 25 , 450 , 4500 , 11500 , 20500 , 30000 , 0 , 0 , 0 , 0 , 0 ];
    pUtilitiesValuesTable.pAmmoPrices                   <- [ 0 , 2 , 5 , 10 , 15 , 15 , 100 , 0 , 0 , 0 , 0 , 0 ];
    pUtilitiesValuesTable.pGTASpawnCam                  <- { Height = { High = 700.0 , Medium = 300.0 , Low = 150.0 } , Enabled = false , Interval = 3000 };
    pUtilitiesValuesTable.bUseLUIDVerification          <- true;
    pUtilitiesValuesTable.bPoliceJobPublic              <- true;
    
    pUtilitiesValuesTable.iServerSaveInterval           <- 600000;
    pUtilitiesValuesTable.iVehicleDataSyncInterval      <- 1000;
    pUtilitiesValuesTable.iTimeUpdateSpeed              <- 1000;
    pUtilitiesValuesTable.iFuelProcessInterval          <- 20000;
    pUtilitiesValuesTable.iFireJobUpdateInterval        <- 500;
    
    // Clan Config
    local pClanValuesTable = { };
    pClanValuesTable.iMinFullNameLength                 <- 3;
    pClanValuesTable.iMaxFullNameLength                 <- 128;
    pClanValuesTable.iMinTagLength                      <- 1;
    pClanValuesTable.iMaxTagLength                      <- 16;
    
    pUtilitiesValuesTable.Clan <- pClanValuesTable;
    
    
    pUtilitiesValuesTable.szBlockedWords                <- [ ];
    
    ::print ( "[Server.Core]: Core utility values table created" );
    
    return pUtilitiesValuesTable;
    
}

// -------------------------------------------------------------------------------------------------

function GetIsland ( pPosition ) {

    if ( pPosition.x > 616 ) {
        
        return 1;
        
    }
    
    if ( pPosition.x < -283 ) {
    
        return 3;
    
    }
    
    return 2;
    
}

// -------------------------------------------------------------------------------------------------

function OpenAllGarages ( ) {

    OpenGarage ( PORTLAND_HIDEOUT_GARAGE );
    OpenGarage ( PORTLAND_IE_GARAGE );
    OpenGarage ( PORTLAND_BOMBSHOP_GARAGE );
    OpenGarage ( PORTLAND_PAYNSPRAY_GARAGE );
    OpenGarage ( SALVATORES_GARAGE );
    OpenGarage ( SECURICAR_GARAGE );
    OpenGarage ( LUIGIS_LOCKUP_GARAGE );
    OpenGarage ( STAUNTON_HIDEOUT_GARAGE );
    OpenGarage ( STAUNTON_BOMSHOP_GARAGE );
    OpenGarage ( STAUNTON_PAYNSPRAY_GARAGE );
    OpenGarage ( RAY_LOCKUP_GARAGE );
    OpenGarage ( WITSEC_HOUSE_GARAGE );
    OpenGarage ( KENJI_LOCKUP_GARAGE );
    OpenGarage ( COLUMBIAN_GARAGE_1 );
    OpenGarage ( COLUMBIAN_GARAGE_2 );
    OpenGarage ( COLUMBIAN_GARAGE_3 );
    OpenGarage ( COLUMBIAN_GARAGE_4 );
    OpenGarage ( COLUMBIAN_GARAGE_5 );
    OpenGarage ( YARDIE_LOCKUP_GARAGE );
    OpenGarage ( SHORESIDE_HIDEOUT_GARAGE );
    OpenGarage ( SSV_PAYNSPRAY_GARAGE );
    OpenGarage ( SSV_BOMBSHOP_GARAGE );
    OpenGarage ( SHORESIDE_IE_GARAGE );
    OpenGarage ( HOODS_DEFUSAL_GARAGE );
    OpenGarage ( PLATINUM_DROPOFF_GARAGE );
    OpenGarage ( DONALD_LOVES_STASH_GARAGE );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function CloseAllGarages ( ) {

    CloseGarage ( PORTLAND_HIDEOUT_GARAGE );
    CloseGarage ( PORTLAND_IE_GARAGE );
    CloseGarage ( PORTLAND_BOMBSHOP_GARAGE );
    CloseGarage ( PORTLAND_PAYNSPRAY_GARAGE );
    CloseGarage ( SALVATORES_GARAGE );
    CloseGarage ( SECURICAR_GARAGE );
    CloseGarage ( LUIGIS_LOCKUP_GARAGE );
    CloseGarage ( STAUNTON_HIDEOUT_GARAGE );
    CloseGarage ( STAUNTON_BOMSHOP_GARAGE );
    CloseGarage ( STAUNTON_PAYNSPRAY_GARAGE );
    CloseGarage ( RAY_LOCKUP_GARAGE );
    CloseGarage ( WITSEC_HOUSE_GARAGE );
    CloseGarage ( KENJI_LOCKUP_GARAGE );
    CloseGarage ( COLUMBIAN_GARAGE_1 );
    CloseGarage ( COLUMBIAN_GARAGE_2 );
    CloseGarage ( COLUMBIAN_GARAGE_3 );
    CloseGarage ( COLUMBIAN_GARAGE_4 );
    CloseGarage ( COLUMBIAN_GARAGE_5 );
    CloseGarage ( YARDIE_LOCKUP_GARAGE );
    CloseGarage ( SHORESIDE_HIDEOUT_GARAGE );
    CloseGarage ( SSV_PAYNSPRAY_GARAGE );
    CloseGarage ( SSV_BOMBSHOP_GARAGE );
    CloseGarage ( SHORESIDE_IE_GARAGE );
    CloseGarage ( HOODS_DEFUSAL_GARAGE );
    CloseGarage ( PLATINUM_DROPOFF_GARAGE );
    CloseGarage ( DONALD_LOVES_STASH_GARAGE );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function KillDeathRatio ( iKills , iDeaths ) {
    
    if ( iDeaths == 0 || iKills == 0 ) {
    
        return 0.0;
        
    }

    local iRatio;
    
    iRatio = ( ( iKills * 100 / iDeaths ) * 0.01 ).tofloat ( );
    
    return iRatio;
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfVector ( pVector = Vector ( 0.0 , 0.0 , 0.0 ) , fAngle = 0.0 , fDistance = 0.0 ) {

    fAngle = fAngle * PI / 180; 
    
    local fX = ( pVector.x + ( ( cos ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
    local fY = ( pVector.y + ( ( sin ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
    
    return Vector ( fX , fY , pVector.z );  
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindVector ( pVector = Vector ( 0.0 , 0.0 , 0.0 ) , fAngle = 0.0 , fDistance = 0.0 ) {

    fAngle = fAngle * PI / 180; 
    
    local fX = ( pVector.x + ( ( cos ( -fAngle + ( PI / 2 ) ) ) * fDistance ) );
    local fY = ( pVector.y + ( ( sin ( -fAngle + ( PI / 2 ) ) ) * fDistance ) );
    
    return Vector ( fX , fY , pVector.z );  
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorFromCenter ( pVector = Vector ( 0.0 , 0.0 , 0.0 ) , fAngle = 0.0 , fDistance = 0.0 ) {

    fAngle = fAngle * PI / 180; 
    
    local fX = ( pVector.x + ( ( cos ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
    local fY = ( pVector.y + ( ( sin ( fAngle + ( PI / 2 ) ) ) * fDistance ) );
    
    return Vector ( fX , fY , pVector.z );    
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfPlayer ( pPlayer , fDistance = 0.0 ) {

    return GetVectorInFrontOfVector ( pPlayer.Pos , pPlayer.Angle , fDistance );
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindPlayer ( pPlayer , fDistance = 0.0 ) {

    return GetVectorBehindVector ( pPlayer.Pos , pPlayer.Angle , fDistance );

}

// -------------------------------------------------------------------------------------------------

function GetVectorInFrontOfVehicle ( pVehicle , fDistance = 0.0 ) {

    return GetVectorInFrontOfVector ( pVehicle.Pos , pVehicle.Angle , fDistance );
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorBehindVehicle ( pVehicle , fDistance = 0.0 ) {

    return GetVectorBehindVector ( pVehicle.Pos , pVehicle.Angle , fDistance );

}

// -------------------------------------------------------------------------------------------------

function GetVectorBelowVector ( pVector , fHeight = 0.0 ) {
    
    return Vector ( pVector.x , pVector.y , pVector.z - fHeight );
    
}

// -------------------------------------------------------------------------------------------------

function GetVectorAboveVector ( pVector , fHeight = 0.0 ) {
    
    return Vector ( pVector.x , pVector.y , pVector.z + fHeight );
    
}

// -------------------------------------------------------------------------------------------------

function GetOffsetFromVector ( pVector , pOffset = Vector( 0.0 , 0.0 , 0.0 ) ) {

    return Vector ( pVector.x + pOffset.x , pVector.y + pOffset.y , pVector.z + pOffset.z );
    
}

// -------------------------------------------------------------------------------------------------

function DegreesToRadians ( iDegrees ) {
    
    return iDegrees * PI / 180;
    
}

// -------------------------------------------------------------------------------------------------

function RadiansToDegrees ( fRadians ) {
    
    return fRadians * 180 / PI;
    
}

// -------------------------------------------------------------------------------------------------

function GetCardinalDirectionText ( iDirection ) {  
    
    return GetCoreTable ( ).Utilities.szCardinalDirections [ iDirection ];
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS NEEDS REDONE
// -- Credit for this goes to Mex, from his VLE scripts he made for VCO.
// -- Edited by Vortrex, for Squirrel compatability.

function GetCardinalDirection ( pVector1 , pVector2 ) {
    
    local a = pVector1.x - pVector2.x;
    local b = pVector1.y - pVector2.y;
    local c = pVector1.z - pVector2.z;
    
    local x = abs ( a );
    local y = abs ( b );
    local z = abs ( c );
    
    local no = 0;
    local ne = 1;
    local ea = 2;
    local se = 3;
    local so = 4;
    local sw = 5;
    local we = 6;
    local nw = 7;
    local na = 8;
    
    if ( b < 0 && a < 0 ) {
       
        if ( x < ( y / 2 ) ) {
            
            return no;
        
        } else if ( y < ( x / 2 ) ) {
            
            return ea;
        
        } else {
            
            return ne;
        }
        
    } else if ( b < 0 && a >= 0 ) {
        
        if( x < ( y / 2 ) ) {
            
            return no;
        
        } else if ( y < ( x / 2 ) ) {
            
            return we;
        
        } else {
            
            return nw;
        
        }
        
    } else if ( b >= 0 && a >= 0 ) {
        
        if ( x < ( y / 2 ) ) {
            
            return so;
        
        } else if ( y < ( x / 2 ) ) {
            
            return we;
        
        } else {
           
            return sw;
            
        }
    
    } else if ( b >= 0 && a < 0 ) {
        
        if ( x < ( y / 2 ) ) {
            
            return so;
       
        } else if ( y < ( x / 2 ) ) {
           
            return ea;
        
        } else {
            
            return se;
        
        }
    
    } else {
        
        return na;
    
    }
    
    return na;
    
}

// --------------------------------------------------------------------------------------------------

function AddPickupToWorld ( pPosition , iModel , iPickupDataType , iPickupDataID ) {

    local pPickup = CreatePickup ( iModel , pPosition );
    
    if ( pPickup ) {
        
        GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType = iPickupDataType;
        GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID = iPickupDataID;
    
    }
    
    print ( "[Server.Utilities]: Created Pickup (ID: " + pPickup.ID + ", DataType: " + iPickupDataType + ", DataID: " + iPickupDataID + ")" );
    
    return pPickup;

}

// --------------------------------------------------------------------------------------------------

function AttemptHiddenPackagePickup ( pPlayer , iHiddenPackageID ) {

    pPlayer.Cash += GetCoreTable ( ).Locations.HiddenPackages [ iHiddenPackageID ].iCashWin;

    return true;
    
}

// --------------------------------------------------------------------------------------------------

function CreateHiddenPackages ( ) {
 
    local iPackageCount = 0;
    local iSpawnedPackages = array ( GetCoreTable ( ).Utilities.iMaxHiddenPackages , { } );
    local iRandomPackageID = -1;
    local pPickup = false;
    
    // -- Keep loop running while there are less than 50 spawned packages
    
    while ( iPackageCount < GetCoreTable ( ).Utilities.iMaxHiddenPackages ) {
        
        // -- Pick a random slot from the hidden packages array
        
        iRandomPackageID = ceil( ( 1.0 * rand ( ) / RAND_MAX ) * ( GetCoreTable ( ).Locations.HiddenPackages.len( ) - 1 ) );
        
        // -- See if the random package slot is already taken. If not, spawn a package and add 1 to the package count
        
        if ( !GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPickup ) {
            
            pPickup = CreatePickup ( 1321 , GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPosition );
            
            GetCoreTable ( ).Locations.HiddenPackages [ iRandomPackageID ].pPickup <- pPickup;
            
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType <- 1;
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID <- iRandomPackageID;
            
            iPackageCount++;
            
        }
        
    }
    
    print ( "[ServerStart]: Hidden packages created" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function Random ( iMin , iMax ) {

    return rand ( ) % ( iMax.tointeger ( ) - iMin.tointeger ( ) );

}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainCaps ( szString ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainNumbers ( szString ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

// -- Need finished.

function DoesStringContainSymbols ( szString ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function GetNearestPoliceStation ( pPosition ) {

    local pClosestStation = GetCoreTable ( ).Locations.PoliceStations [ 0 ];

    foreach ( ii , iv in GetCoreTable ( ).Locations.PoliceStations ) {
    
        if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
        
            pClosestStation = iv;
            
        }
    
    }
    
    return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function GetNearestFireStation ( pPosition ) {

    local pClosestStation = GetCoreTable ( ).Locations.FireStations [ 0 ];

    foreach ( ii , iv in GetCoreTable ( ).Locations.FireStations ) {
    
        if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
        
            pClosestStation = iv;
            
        }
    
    }
    
    return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function GetNearestHospital ( pPosition ) {

    local pClosestHospital = GetCoreTable ( ).Locations.Hospitals [ 0 ];

    foreach ( ii , iv in GetCoreTable ( ).Locations.Hospitals ) {
    
        if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestHospital.pPosition ) ) {
        
            pClosestHospital = iv;
            
        }
    
    }
    
    return pClosestHospital;

}

// -------------------------------------------------------------------------------------------------

function GetRemainingString ( szString , szDelimiter , iStartIndex ) {

    local iTotalIndexes = NumTok ( szString , szDelimiter );
    local szCompleteString = "";
    
    if ( iTotalIndexes > iStartIndex ) {
    
        for ( local i = iStartIndex ; i <= iTotalIndexes ; i++ ) {
        
            if ( szCompleteString.len ( ) == 0 ) {
                
                szCompleteString = GetTok ( szString , szDelimiter , i );
                
            } else {
                
                szCompleteString = szCompleteString + szDelimiter + GetTok ( szString , szDelimiter , i );
            
            }
            
        }
        
    } else {
    
        szCompleteString = GetTok ( szString , szDelimiter , iStartIndex );
    
    }
    
    return szCompleteString;

}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveVehicleKeys ( pPlayer , pVehicle ) {
    
    local pVehicleData = GetVehicleDataFromVehicle ( pVehicle );
    local pPlayerData = GetPlayerData( pPlayer );

    // -- If the player can admin-manage vehicles, they automatically have access to all of them.
    
    if ( DoesPlayerHaveStaffPermission ( pPlayer , "ManageVehicles" ) ) {
    
        return true;
    
    }
    
    // -- If vehicle is personally owned by a player, check to see if the current player is the owner
    
    if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Player && ( pVehicleData.iOwnerID == pPlayerData.iDatabaseID ) ) {
    
        return true;
    
    }
    
    // -- If vehicle is personally owned by a clan, check to see if the current player is in the clan
    
    if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Clan && ( pVehicleData.iOwnerID == pPlayerData.iClan ) ) {
    
        return true;
    
    }
    
    // -- If vehicle is personally owned by a job, check to see if the current player has the job
    
    if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Job && ( GetJobTypeFromJobID ( pVehicleData.iOwnerID ) == GetJobTypeFromJobID ( pPlayerData.iJob ) ) ) {
    
        return true;
    
    }
    
    // -- If vehicle is a public vehicle, let them drive it.
    
    if ( pVehicleData.iOwnerType == GetCoreTable ( ).Utilities.pVehicleOwnerType.Public ) {
    
        return true;
    
    }   
    
    if ( pVehicleData.iRentPrice > 0 ) {
    
        if ( pVehicleData.pRenter != false ) {
        
            if ( pVehicleData.pRenter.ID == pPlayer.ID ) {
            
                return true;
            
            }
        
        }
    
    }
    
        
    // -- Nothing matched, so player does not have the keys.
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveStaffPermission ( pPlayer , szPermission ) {

    local iBitFlag = GetCoreTable ( ).BitFlags.StaffFlags [ szPermission ];
    local pPlayerData = GetPlayerData( pPlayer );
    
    // -- If staff flags are -1, it's automatic override. Pretty much server-god.
    
    if ( pPlayerData.iStaffFlags == -1 ) {
    
        return true;
    
    }
    
    if ( HasBitFlag ( pPlayerData.iStaffFlags , iBitFlag ) ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetPlayerNameAndIDForConsole ( pPlayer ) {

    return pPlayer.Name + " [ID " + pPlayer.ID + "]";

}

// -------------------------------------------------------------------------------------------------

function ParseDateForDisplay ( iTimeStamp ) {

    local pDate = date ( iTimeStamp );
    
    local iWeekDayID = pDate [ "wday" ];
    local szWeekDay = GetCoreTable ( ).Utilities.WeekDays [ iWeekDayID ];

    local iMonthID = pDate [ "month" ];
    local szMonth = GetCoreTable ( ).Utilities.Months [ iMonthID ];
    
    local iHour = pDate [ "hour" ];
    local iMinute = pDate [ "min" ];
    
    local szMeridian = "??";
    
    if ( iHour < 12 && iHour >= 0 ) {
        
        szMeridian = "AM"
        
        if ( iHour == 0 ) {
        
            iHour = 12;
        
        }
        
    } else {
    
        szMeridian = "PM";
        
        local iCalculate = iHour * ( iHour / 12 );
        
    }
    
    local szDateString = szWeekDay + ", " + szMonth + " " + pDate [ "day" ] + ", " + pDate [ "year" ] + " at " + iHour + ":" + iMinute + " " + szMeridian;
    
    return szDateString;
    
}

// -------------------------------------------------------------------------------------------------

function IsValidSkinID ( iSkinID ) {

    if ( iSkinID >= 0 && iSkinID <= 122 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function AddStaffPermission ( pPlayer , szBitFlagName ) {

    if ( DoesPlayerHaveStaffPermission ( pPlayer , szBitFlagName ) ) {
    
        return false;
    
    }
    
    GetPlayerData( pPlayer ).iStaffFlags = GetPlayerData( pPlayer ).iStaffFlags | GetCoreTable ( ).BitFlags.StaffFlags [ szBitFlagName ];
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function RemoveStaffPermission ( pPlayer , szBitFlagName ) {

    if ( !DoesPlayerHaveStaffPermission ( pPlayer , szBitFlagName ) ) {
    
        return false;
    
    }
    
    GetPlayerData( pPlayer ).iStaffFlags = GetPlayerData( pPlayer ).iStaffFlags & ~GetCoreTable ( ).BitFlags.StaffFlags [ szBitFlagName ];
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtPoliceStation ( pPlayer ) {
    
    local pPoliceStation = GetClosestPoliceStation ( pPlayer.Pos );
    
    if ( GetDistance ( pPlayer.Pos , pPoliceStation.pPosition ) <= GetCoreTable ( ).Utilities.fArrestRange ) {
        
       return true;

    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function GetClosestHospital ( pPosition ) {

    return Vector ( 1144.25 , -596.87 , 14.97 );

}

// -------------------------------------------------------------------------------------------------

function GetClosestPoliceStation ( pPosition ) {

    local pClosestStation = GetCoreTable ( ).Locations.PoliceStations [ 0 ];
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.PoliceStations ) {
        
        if ( GetDistance ( pPosition , iv.pPosition ) < GetDistance ( pPosition , pClosestStation.pPosition ) ) {
            
            pClosestStation = iv;
            
        }
        
    }
    
    return pClosestStation;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtHospital ( pPlayer ) {
    
    local pHospital = GetClosestHospital ( pPlayer.Pos );
    
    if ( GetDistance ( pPlayer.Pos , pHospital.pPosition ) <= GetCoreTable ( ).Utilities.fHospitalHealRange ) {
        
       return true;

    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function CreateSafeIniString ( szUnsafeString ) {
    
    local szSafeString = "";
    local pSplitString = [ ];
    
    pSplitString = split ( szUnsafeString , GetCoreTable ( ).Security.szUnsafeCharacters );
    
    foreach ( ii , iv in pSplitString ) {
        
        szSafeString = szSafeString + iv;
        
    }
    
    return szSafeString;
    
}

// -------------------------------------------------------------------------------------------------

function StripWhitespaceFromString ( szOldString ) {
    
    local szSafeString = "";
    local pSplitString = [ ];
    
    pSplitString = split ( szOldString, " " );
    
    foreach ( ii , iv in pSplitString ) {
        
        szSafeString = szSafeString + iv;
        
    }
    
    return szSafeString;
    
}

// -------------------------------------------------------------------------------------------------

function IsPlayerImmobilized ( pPlayer ) {

    if ( GetPlayerData ( pPlayer ).bTazed ) {
    
        return true;
    
    }
    
    if ( GetPlayerData ( pPlayer ).bCuffed ) {
    
        return true;
    
    }   

    if ( GetPlayerData ( pPlayer ).bDead ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerShotByTazer ( pShooter , pShot ) {

    local pShooterData = GetPlayerData ( pShooter );
    local pShotData = GetPlayerData ( pShot );
    
    if ( !pShooterData.bTazerArmed ) {
    
        return false;
    
    }
    
    if ( pShooter.Weapon != 2 ) {
    
        return false;
    
    }
    
    if ( IsPlayerImmobilized ( pShot ) ) {
    
        return false;
    
    }
    
    ResetPlayerAnimation ( pShot );
    pShot.SetAnim ( 18 );
    pShot.Frozen = true;
    
    NewTimer ( "RemoveTazerEffect" , 15000 , 1 , pPlayer );
    
    if ( !GetPlayerData ( pShot ).bMuted ) {
    
        onPlayerAction ( pShot , "gets electrified by " + pShooter.Name + "'s tazer, and falls to the ground" );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ResetPlayerAnimation ( pPlayer ) {

    local iSkin = pPlayer.Skin;

    pPlayer.Skin = iSkin;
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function GetTimeDifferenceDisplay ( iTimeOne , iTimeTwo ) {

    local iTimeDifference = ( iTimeOne - iTimeTwo );
    
    iHours = floor ( iTimeDifference / 3600 );
    iMinutes = floor ( iTimeDifference / 60 );
    
    if ( iHours == 1 ) {
        
        szHours = "1 hour";
        
    } else {
        
        szHours = iHours + " hours";
    
    }
    
    if ( iMinutes == 1 ) {
        
        szMinutes = "1 minute";
        
    } else {
        
        szMinutes = iMinutes + " minute";
    
    }
    
    return szHours + " and " + szMinutes;
    
}

// -------------------------------------------------------------------------------------------------

function NearbyPlayersCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local fDistance = 20.0;
    
    if ( szParams ) {
    
        if ( !IsNum ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "The range must be a number!" );
            
            return false;
        
        }
        
        if ( szParams.tointeger ( ) <= 0 ) {
        
            SendPlayerErrorMessage ( pPlayer , "The range must be more than 0!" );
            
            return false;
        
        }
        
        fDistance = szParams.tointeger ( );
    
    }
    
    local pNearbyPlayers = GetPlayersInRange ( pPlayer.Pos , fDistance );
    
    foreach ( ii , iv in pNearbyPlayers ) {
    
        if ( pPlayer.ID != iv.ID ) {
        
            SendPlayerNormalMessage ( pPlayer , GetHexColour ( "LightGrey" ) + "- " + iv.Name + " (ID " + iv.ID + ") (" + GetDistance ( pPlayer.Pos , iv.Pos ) + " meters " + GetCardinalDirectionText ( GetCardinalDirection ( pPlayer.Pos , iv.Pos ) ) + ")" );
        
        }
    
        
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function NearbyVehiclesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    local fDistance = 10.0;
    
    if ( szParams ) {
    
        if ( !IsNum ( szParams ) ) {
        
            SendPlayerErrorMessage ( pPlayer , "The range must be a number!" );
            
            return false;
        
        }
        
        if ( szParams.tointeger ( ) <= 0 ) {
        
            SendPlayerErrorMessage ( pPlayer , "The range must be more than 0!" );
            
            return false;
        
        }
        
        fDistance = szParams.tofloat ( );
    
    }
    
    local pNearbyVehicles = GetVehiclesInRange ( pPlayer.Pos , fDistance );
    
    foreach ( ii , iv in pNearbyVehicles ) {
    
        SendPlayerNormalMessage ( pPlayer , GetHexColour ( "White" ) + "- " + GetVehicleName ( iv.Model ) + GetHexColour ( "LightGrey" ) + " (ID " + iv.ID + " / DBID: " + GetVehicleData ( iv , "iDatabaseID" ) + ") (" + GetDistance ( pPlayer.Pos , iv.Pos ) + " meters " + GetCardinalDirectionText ( GetCardinalDirection ( pPlayer.Pos , iv.Pos ) ) + ")" );
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function GetVehiclesInRange ( pVector , fDistance ) {

    local pTempVehicles = [ ];

    foreach ( ii , iv in GetCoreTable ( ).Vehicles ) {
    
        if ( iv.pVehicle ) {
        
            if ( GetDistance ( pVector , iv.pVehicle.Pos ) <= fDistance ) {
        
                pTempVehicles.push ( iv.pVehicle );
            
            }
        
        }
    
    }

    return pTempVehicles;

}

// -------------------------------------------------------------------------------------------------

function GetPlayersInRange ( pVector , fDistance ) {

    local pTempPlayers = [ ];

    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        if ( iv.Spawned ) {
        
            if ( GetDistance ( pVector , iv.Pos ) <= fDistance ) {
        
                pTempPlayers.push ( iv );
                
            }
        
        }
    
    }

    return pTempPlayers;

}

// -------------------------------------------------------------------------------------------------

function GetConnectedPlayers ( ) {

    local pTempPlayers = [ ];
    
    for ( local i = 0 ; i < MAX_PLAYERS ; i++ ) {
    
        if ( FindPlayer ( i ) ) {
        
            pTempPlayers.push ( FindPlayer ( i ) );
        
        }
    
    }
    
    return pTempPlayers;

}

// -------------------------------------------------------------------------------------------------

function GetPlayingPlayers ( ) {

    local pTempPlayers = [ ];
    
    for ( local i = 0 ; i < MAX_PLAYERS ; i++ ) {
    
        if ( FindPlayer ( i ) ) {
        
            if ( GetPlayerData ( FindPlayer ( i ) ).bAuthenticated && GetPlayerData ( FindPlayer ( i ) ).bCanSpawn && FindPlayer ( i ).Spawned ) {
            
                pTempPlayers.push ( FindPlayer ( i ) );
            
            }
        
        }
    
    }
    
    return pTempPlayers;

}

// -------------------------------------------------------------------------------------------------

function IsValidRGBValue ( iValue ) {

    if ( iValue >= 0 && iValue <= 255 ) {
    
        return true;
        
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetYesNoBoolText ( bBool ) {

    if ( !bBool ) {
    
        return "No";
    
    }
    
    return "Yes";

}

// -------------------------------------------------------------------------------------------------

function GetOnOffBoolText ( bBool ) {

    if ( !bBool ) {
    
        return "Off";
    
    }
    
    return "On";

}

// -------------------------------------------------------------------------------------------------

function GetVehicleLightStateFromBool ( bLightState ) {

    if ( bLightState ) {
    
        return LIGHTSTATE_ON;
    
    }

    return LIGHTSTATE_OFF;

}

// -------------------------------------------------------------------------------------------------

function PrintEntireCoreTable ( ) {

    PrintTableContents ( GetCoreTable ( ) , "pCoreTable" );

}

// -------------------------------------------------------------------------------------------------

function PrintTableContents ( pTable , szBreadcrumbs ) {
    
    foreach ( ii , iv in pTable ) {
        
        print ( szBreadcrumbs + "." + ii + " : " + iv );
        
        if ( type ( iv ) == "table" || type ( iv ) == "array" ) {
            
            PrintTableContents ( iv , szBreadcrumbs + "." + ii );
            
        }
        
    }

}

// -------------------------------------------------------------------------------------------------

function IsValidVehicleColourIndex ( iVehicleColourIndex ) {

    if ( iVehicleColourIndex == 1 || iVehicleColourIndex == 2 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function IsValidVehicleModel ( iModelID ) {

    if ( iModelID < 90 && iModelID > 150 ) {
    
        return false;
    
    }
    
    if ( iModelID == 140 || iModelID == 147 || iModelID == 141 ) {
    
        return false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ClearChat ( pPlayer ) { 

    for ( local i = 0 ; i < 50 ; i++ ) {
    
        MessagePlayer ( " " , pPlayer );
    
    }

}

// -------------------------------------------------------------------------------------------------

function IsPlayerLoggedIn ( pPlayer ) {

    if ( GetPlayerData ( pPlayer ).bAuthenticated ) {
    
        return true;
    
    }

    return false;
    
}

// -------------------------------------------------------------------------------------------------

function CanPlayerUseCommands ( pPlayer ) {

    if ( GetPlayerData ( pPlayer ).bCanUseCommands ) {
    
        return true;
    
    }

    return false;
    
}

// -------------------------------------------------------------------------------------------------

function CanPlayerSpawn ( pPlayer ) {

    if ( GetPlayerData ( pPlayer ).bCanSpawn ) {
    
        return true;
    
    }

    return false;
    
}

// -------------------------------------------------------------------------------------------------

function HandlePickupPickedUp ( pPlayer , pPickup ) {

    if ( !pPlayer.Spawned ) {
    
        return false;
    
    }
    
    if ( !IsPlayerLoggedIn ( pPlayer ) || !CanPlayerUseCommands ( pPlayer ) || !CanPlayerSpawn ( pPlayer ) ) {
    
        return false;
    
    }
    
    if ( pPlayer.Vehicle ) {
    
        return false;
    
    }

    switch ( GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType ) {
        
        case GetCoreTable ( ).Utilities.pPickupDataType.HiddenPackage: // -- Hidden Package
            
            AttemptHiddenPackagePickup ( pPlayer , GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID );
            
            GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataType <- 0;
            GetCoreTable ( ).Pickups [ pPickup.ID ].GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID <- -1;
            
            pPickup.Remove ( );
            
            break;
            
        case GetCoreTable ( ).Utilities.pPickupDataType.Business: // -- Business
            
            ShowBusinessInformationToPlayer ( pPlayer , GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID );
            
            break;
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.House: // -- House
            
            ShowHouseInformationToPlayer ( pPlayer , GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID );
            
            break;
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.Job: // -- Job
        
            foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
            
                if ( iv.pPickup.ID == pPickup.ID ) {
            
                    ShowJobInformationToPlayer ( pPlayer , ii );
                
                }
            
            }
            
            break;

        case GetCoreTable ( ).Utilities.pPickupDataType.HelpInfo: // -- Help (Just displays info)
            
            ShowHelpInformationToPlayer ( pPlayer , GetCoreTable ( ).Pickups [ pPickup.ID ].iPickupDataID );
            
            break;
            
            
        case GetCoreTable ( ).Utilities.pPickupDataType.None: // -- None (usually because it's not spawned or something fucked up)
        default:
        
            break;
            
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function DoesStaffFlagExist ( szFlagName ) {

    foreach ( ii , iv in GetCoreTable ( ).BitFlags.StaffFlags ) {
    
        if ( ii.tolower ( ) == szFlagName.tolower ( ) ) {
        
            return true;
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function IntegerToBool ( iInteger ) {

    if ( iInteger == 0 ) {
    
        return false;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function BoolToInteger ( bBool ) {

    if ( !bBool ) {
    
        return 0;
    
    }
    
    return 1;

}

// -------------------------------------------------------------------------------------------------

function KickAllConnectedPlayers ( ) {

    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        KickPlayer ( iv );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ForceAllPlayersToSpawnScreen ( ) {

    foreach ( ii , iv in GetConnectedPlayers ( ) ) {
    
        iv.ForceToSpawnScreen ( );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function SaveConnectionToDatabase ( pPlayer ) {

    print ( "[Server.Utilities]: Adding " + pPlayer.Name + "'s connection to the database" );

    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    local pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Player ID " + pPlayer.ID + "'s connection info could NOT be saved to database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    local szQueryString = "INSERT INTO `log_conn` ( `log_conn_ip` , `log_conn_luid` , `log_conn_connected` , `log_conn_name` ) VALUES ( '" + pPlayer.IP + "' , '" + EscapeMySQLString ( pDatabaseConnection , pPlayer.LUID ) + "' , UNIX_TIMESTAMP ( ) , '" + EscapeMySQLString ( pDatabaseConnection , pPlayer.Name ) + "' )";
    
    //print ( szQueryString );
    
    ExecuteMySQLQuery ( pDatabaseConnection , szQueryString );
    
    local iSessionID = mysql_insert_id ( pDatabaseConnection );
    
    print ( "[Server.Utilities]: Saved " + pPlayer.Name + "'s connection as ID " + iSessionID );
    
    return iSessionID;

}

// -------------------------------------------------------------------------------------------------

function UpdateConnectionScreenInfo ( iConnectionID , iWidth , iHeight ) {

    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Player ID " + pPlayer.ID + "'s connection info could NOT be saved to database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    ExecuteMySQLQuery ( pDatabaseConnection , "UPDATE `log_conn` SET `log_conn_screen_width` = " + iWidth + " , `log_conn_screen_height` = " + iHeight + " WHERE `log_conn_id` = " + iConnectionID );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function UpdateConnectionDisconnectInfo ( iConnectionID , iTime ) {

    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Connection ID " + iConnectionID + "'s disconnect info could NOT be updated in database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    ExecuteMySQLQuery ( pDatabaseConnection , "UPDATE `log_conn` SET `log_conn_disconnected` = " + iTime + " WHERE `log_conn_id` = " + iConnectionID );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function UpdateConnectionAccountLogin ( iConnectionID , iAccountID , iTime ) {

    local pQuery = false;
    local pDatabaseConnection = false;
    local szQueryString = "";
    
    pDatabaseConnection = ConnectToMySQL ( );
    
    if ( !pDatabaseConnection ) {

        ::print ( "[Server.Database]: Player ID " + pPlayer.ID + "'s account login info could NOT be updated in database. Couldn't connect to database!" );
    
        return false;
        
    }
    
    ExecuteMySQLQuery ( pDatabaseConnection , "UPDATE `log_conn` SET `log_conn_acct` = " + iAccountID + " WHERE `log_conn_id` = " + iConnectionID );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateStaticMapBlips ( ) {

    // Vehicle dealership
    local pVehicleDealership = CreateBlip ( BLIP_DONALD  , 1219.10 , -101.95 , 14.25 );
    //pVehicleDealership.Size = 5;
    //pVehicleDealership.Colour = 2;
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.PayAndSprays ) {
    
        //iv.pBlip = CreateBlip ( BLIP_PNS  , iv.pPosition );
        iv.pSphere = CreateSphere ( iv.pPosition , 4.0 , GetRGBColour ( "Yellow" ) );
        iv.pSphere.Type = MARKER_TYPE_VEHICLE;
        
    }
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.Ammunations ) {
    
        //iv.pBlip = CreateBlip ( BLIP_AMMU  , iv.pPosition );
        
        iv.pSphere = CreateSphere ( iv.pPosition , 1.0 , GetRGBColour ( "BrightRed" ) );
        iv.pSphere.Type = MARKER_TYPE_PLAYER;
        
    }
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.ClothingStores ) {
    
        //iv.pBlip = CreateBlip ( BLIP_CAT , iv.pPosition );
        
        iv.pSphere = CreateSphere ( iv.pPosition , 1.0 , GetRGBColour ( "Green" ) );
        iv.pSphere.Type = MARKER_TYPE_PLAYER;
        
    }
    
    
    return 1;
}

// -------------------------------------------------------------------------------------------------

function DelayedSpawn ( pPlayer ) {

    pPlayer.Spawn ( );

}

// -------------------------------------------------------------------------------------------------

function DelayedKick ( pPlayer ) {

    KickPlayer ( pPlayer );

}

// -------------------------------------------------------------------------------------------------

function IsVehicleCar ( iModel ) {

    switch ( iModel ) {
    
        case VEH_PREDATOR:
        case VEH_TRAIN:
        case VEH_CHOPPER:
        case VEH_DODO:
        case VEH_RCBANDIT:
        case VEH_AIRTRAIN:
        case VEH_DEADDODO:
        case VEH_SPEEDER:
        case VEH_REEFER:
        
        return false;
        
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function GivePlayerSavedWeapons ( pPlayer ) {

    pPlayer.ClearWeapons ( );
    
    foreach ( ii , iv in GetPlayerData ( pPlayer ).pHasWeapon ) {
    
        if ( iv == true ) {
        
            pPlayer.SetWeapon ( ii , GetPlayerData ( pPlayer ).pWeaponAmmo [ ii ] );
        
        }
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function DoesPlayerHaveAJob ( pPlayer ) {

    if ( GetPlayerData ( pPlayer ).iJob >= 0 ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function SetCameraAbovePlayer ( pPlayer , fDistance , pPosition = false ) {

    if ( !pPosition ) {
    
        pPosition = pPlayer.Pos;
    
    }

    SetCameraMatrix ( pPlayer , Vector ( pPosition.x , pPosition.y , pPosition.z + fDistance ) , pPosition );
    
    return;

}

// -------------------------------------------------------------------------------------------------

function SetGTAVSpawnCameraHigh ( pPlayer ) {

    if ( GetPlayerData ( pPlayer , "bInGTAVSpawnCam" ) ) {
    
        return false;
    
    }

    SetCameraAbovePlayer ( pPlayer , GetUtilityConfiguration ( ).pGTASpawnCam.Height.High );
    
    GetPlayerData ( pPlayer ).bInGTAVSpawnCam = true;
    
    NewTimer ( "SetGTAVSpawnCameraMedium" , GetUtilityConfiguration ( ).pGTASpawnCam.Interval , 1 , pPlayer );
    
}

// -------------------------------------------------------------------------------------------------

function SetGTAVSpawnCameraMedium ( pPlayer ) {

    SetCameraAbovePlayer ( pPlayer , GetUtilityConfiguration ( ).pGTASpawnCam.Height.Medium );
    
    NewTimer ( "SetGTAVSpawnCameraLow" , GetUtilityConfiguration ( ).pGTASpawnCam.Interval , 1 , pPlayer );
    
}

// -------------------------------------------------------------------------------------------------

function SetGTAVSpawnCameraLow ( pPlayer ) {

    SetCameraAbovePlayer ( pPlayer , GetUtilityConfiguration ( ).pGTASpawnCam.Height.Low );
    
    NewTimer ( "SetGTAVSpawnCameraRestore" , GetUtilityConfiguration ( ).pGTASpawnCam.Interval , 1 , pPlayer );
    
}

// -------------------------------------------------------------------------------------------------

function SetGTAVSpawnCameraRestore ( pPlayer ) {

    RestoreCamera ( pPlayer );
    
    pPlayer.Frozen = false;
    pPlayer.Immune = false;
    pPlayer.Alpha = 255;
    
    RestorePlayerSavedWeapons ( pPlayer );
    
    ShowHUDForPlayer ( pPlayer );
    
    UpdateMapLocations ( pPlayer );
    
    //pPlayer.Angle = GetPlayerData ( pPlayer ).fAngle;

}

// -------------------------------------------------------------------------------------------------

function GivePayDayToAllPlayers ( ) {

    return false;
    
    /*
    foreach ( ii , iv in GetPlayingPlayers ( ) ) {
    
        GivePaydayToPlayer ( iv );
    
    }
    */

}

// -------------------------------------------------------------------------------------------------

function GetPayAndSprays ( ) {

    return GetCoreTable ( ).Locations.PayAndSprays;

}

// -------------------------------------------------------------------------------------------------

function GetFuelPumps ( ) {

    return GetCoreTable ( ).Locations.FuelPumps;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtPayAndSpray ( pPlayer ) {

    foreach ( ii , iv in GetPayAndSprays ( ) ) {
    
        if ( GetDistance ( pPlayer.Pos , iv.pPosition ) ) {
            
            return true;
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function IsPlayerAtFuelPump ( pPlayer ) {

    foreach ( ii , iv in GetFuelPumps ( ) ) {
    
        if ( GetDistance ( pPlayer.Pos , iv.pPosition ) <= 15.0 ) {
            
            return true;
        
        }
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function GetWeaponModelID ( iWeaponID ) {

    return GetUtilityConfiguration ( ).pWeaponModels [ iWeaponID ];

}

// -------------------------------------------------------------------------------------------------

function GetHasWeaponStringFromArray ( pArray ) {

    local szHasWeapon = "";
    
    foreach ( ii , iv in pArray ) {
    
        if ( ii != 0 ) {
        
            szHasWeapon += "." + BoolToInteger ( iv ).tostring ( );
            
        } else {
        
            szHasWeapon = BoolToInteger ( iv ).tostring ( );
        
        }
    
    }
    
    return szHasWeapon;

}

// -------------------------------------------------------------------------------------------------

function GetWeaponAmmoStringFromArray ( pArray ) {

    local szWeaponAmmo = "";
    
    foreach ( ii , iv in pArray ) {
            
        if ( ii != 0 ) {
        
            szWeaponAmmo += "." + iv.tostring ( );
            
        } else {
        
            szWeaponAmmo = iv.tostring ( );
        
        }
    
    }
    
    return szWeaponAmmo;

}

// -------------------------------------------------------------------------------------------------

function GetHasWeaponArrayFromString ( szString ) {
    
    local pArray = array ( 12 , false );
    
    foreach ( ii , iv in split ( szString , "." ) ) {
    
        pArray [ ii ] = IntegerToBool( iv.tointeger ( ) );
    
    }
    
    return pArray;

}

// -------------------------------------------------------------------------------------------------

function GetWeaponAmmoArrayFromString ( szString ) {

    local pArray = array ( 12 , false );
    
    foreach ( ii , iv in split ( szString , "." ) ) {
    
        pArray [ ii ] = iv.tointeger ( );
    
    }
    
    return pArray;

}

// -------------------------------------------------------------------------------------------------

function LineSplit ( szString ){
    
    local bFound = true;
    local pStrings = [ ];
    
    do {
    
        bFound = szString.find ( "\r\n" );          
        pStrings.push( szString.slice ( 0 , bFound ) );
        string = string.slice ( bFound , string.len ( ) );
        
    } while ( bFound )  
    
    return pStrings;
    
}

// -------------------------------------------------------------------------------------------------

function BuyClothesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

    if ( bShowHelpOnly ) {
    
        SendPlayerCommandInfoMessage ( pPlayer , "Buys a skin from a clothing store." , [ "BuySkin" , "BuyClothes" ] , "" );
    
        return false;
    
    }
    
    if ( !GetPlayerData ( pPlayer ).bAtClothingStore ) {

        SendPlayerErrorMessage ( pPlayer , "You are not at a clothes store ('C' icon on the map)!" );
        
        return false;   
    
    }
    
    if ( !szParams ) {
    
        SendPlayerSyntaxMessage ( pPlayer , "/BuySkin <Skin ID>" );
    
        return false;
        
    }
    
    if ( !IsNum ( szParams ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "The skin ID must be a number!" );
        
        return false;
    
    }
    
    if ( !IsBuyableSkin ( szParams.tointeger ( ) ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "That skin is either invalid, or you can't buy it!" );
        
        return false;
    
    }

    if ( GetPlayerData ( pPlayer ).iSkin == szParams.tointeger ( ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "You already have that skin!" );
    
        return false;
    
    }
    
    if ( GetPlayerData ( pPlayer ).iCash < 100 ) {
    
        SendPlayerErrorMessage ( pPlayer , "You need $100 to buy a new skin." );
        
        return false;
    
    }
    
    SendPlayerSuccessMessage ( pPlayer , "You bought skin ID " + szParams.tointeger ( ) );
    
    TakePlayerCash ( pPlayer , 100 );
    
    GetPlayerData ( pPlayer ).iSkin = szParams.tointeger ( );
    pPlayer.Skin = GetPlayerData ( pPlayer ).iSkin;
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function EchoIRCConsoleDebug ( szMessage ) {

    CallFunc ( "lilc-irc/Server.nut" , "EchoEventToIRC" , szMessage );

}

// -------------------------------------------------------------------------------------------------

function IsBuyableSkin ( iSkinID ) {

    switch ( iSkinID ) {
    
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 92:
        case 96:
        case 114:
        case 122:
        case 121:
            return false;
            
        default:
            return true;
            
    }

}

// -------------------------------------------------------------------------------------------------

function UpdateAllPlayerMapLocations ( pPlayer ) {
    
    foreach ( ii , iv in GetPlayingPlayers ( ) ) {
    
        UpdateMapLocations ( iv );
        
    }
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function UpdateMapLocations ( pPlayer ) {

    print ( "[Server.Utilities]: Updating map icons for " + pPlayer.Name ); 
    
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !pPlayerData.bBlipsInit ) {
    
        print ( "[Server.Utilities]: Canceled map icon update for " + pPlayer.Name + ". Map icons not initialized" );   
    
        return false;
    
    }
    
    foreach ( ii , iv in pPlayerData.pBlips.PayAndSprays ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated pay and spray map icons for " + pPlayer.Name );    
    
    foreach ( ii , iv in pPlayerData.pBlips.Ammunations ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated ammunation map icons for " + pPlayer.Name );   
    
    foreach ( ii , iv in pPlayerData.pBlips.ClothingStores ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated clothing store map icons for " + pPlayer.Name );       
    
    foreach ( ii , iv in pPlayerData.pBlips.Jobs ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated job map icons for " + pPlayer.Name );  
    
    foreach ( ii , iv in pPlayerData.pBlips.PoliceStations ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated polict station map icons for " + pPlayer.Name );   

    foreach ( ii , iv in pPlayerData.pBlips.FireStations ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated fire station map icons for " + pPlayer.Name ); 
    
    foreach ( ii , iv in pPlayerData.pBlips.Hospitals ) {
    
        if ( GetIsland ( iv.Pos ) != GetIsland ( pPlayer.Pos ) ) {
        
            iv.DisplayType = BLIPTYPE_NONE;
        
        } else {
        
            iv.DisplayType = BLIPTYPE_BLIPONLY;
        
        }
    
    }
    
    print ( "[Server.Utilities]: Updated hospital map icons for " + pPlayer.Name ); 
    
    print ( "[Server.Utilities]: Updated all map icons for " + pPlayer.Name );  
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CreateBlips ( ) {
    
    /*
    foreach ( ii , iv in GetCoreTable ( ).Locations.PoliceStations ) {
    
        iv.pBlip = CreateBlip ( BLIP_BLUEPHONE , iv.pPosition );
    
    }
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.FireStations ) {
    
        iv.pBlip = CreateBlip ( BLIP_REDPHONE , iv.pPosition );
    
    }
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.Hospitals ) {
    
        iv.pBlip = CreateBlip ( BLIP_GREENPHONE , iv.pPosition );
    
    }

    foreach ( ii , iv in GetCoreTable ( ).Locations.ClothingStores ) {
    
        iv.pBlip = CreateBlip ( BLIP_CAT , iv.pPosition );
    
    }

    foreach ( ii , iv in GetCoreTable ( ).Locations.Ammunations ) {
    
        iv.pBlip = CreateBlip ( BLIP_AMMU , iv.pPosition );
    
    }

    foreach ( ii , iv in GetCoreTable ( ).Locations.PayAndSprays ) {
    
        iv.pBlip = CreateBlip ( BLIP_PNS , iv.pPosition );
    
    }
    */
    
}

// -------------------------------------------------------------------------------------------------

function CreatePlayerMapIcons ( pPlayer ) {

    if ( !pPlayer ) {
    
        return false;
    
    }

    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( pPlayerData.bBlipsInit ) {
    
        return false;
    
    }
    
    local pPlayerBlips = pPlayerData.pBlips;
    local pBlip = false;
        
    print ( "[Server.Utilities]: Creating map icons for " + pPlayer.Name );

    foreach ( ii , iv in GetCoreTable ( ).Locations.PoliceStations ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_BLUEPHONE , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.PoliceStations.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created police station map icons for " + pPlayer.Name );
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.FireStations ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_REDPHONE , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.FireStations.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created fire station map icons for " + pPlayer.Name );
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.Hospitals ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_GREENPHONE , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.Hospitals.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created hospital map icons for " + pPlayer.Name );

    foreach ( ii , iv in GetCoreTable ( ).Locations.ClothingStores ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_CAT , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.ClothingStores.push ( pBlip );
    
    }

    print ( "[Server.Utilities]: Created clothing store map icons for " + pPlayer.Name );
    
    foreach ( ii , iv in GetCoreTable ( ).Locations.Ammunations ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_AMMU , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.Ammunations.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created ammunation map icons for " + pPlayer.Name );

    foreach ( ii , iv in GetCoreTable ( ).Locations.PayAndSprays ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_PNS , iv.pPosition );
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.PayAndSprays.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created pay and spray map icons for " + pPlayer.Name );    
    
    foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
    
        pBlip = CreateClientBlip ( pPlayer , BLIP_NONE , iv.pPosition );
        pBlip.Colour = 1;
        pBlip.Size = 2;
        pBlip.DisplayType = BLIPTYPE_NONE;
    
        pPlayerBlips.Jobs.push ( pBlip );
    
    }
    
    print ( "[Server.Utilities]: Created job map icons for " + pPlayer.Name );  
    
    pPlayerData.bBlipsInit = true;
    
    print ( "[Server.Utilities]: Created all map icons for " + pPlayer.Name );  

}

// -------------------------------------------------------------------------------------------------

function IsIPAddressLAN ( szIP ) {

    if ( szIP == "127.0.0.1" ) {
    
        return true;
    
    }
    
    if ( szIP.slice ( 0 , 8 ) == "192.168." ) {
    
        return true;
    
    }
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function PlayerSpawnSyncDelay ( pPlayer ) {
    
    if ( GetPlayerData ( pPlayer ).bSpawnedOnce == true ) {
    
        print ( "ALREADY SPAWNED" );
        
        return false;
        
    }
    
    print ( "TEST" );
    
    RestorePlayerSavedWeapons ( pPlayer );
    
    GetPlayerData ( pPlayer ).bSpawnedOnce = true;
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function GetPartReasonText ( iReason ) {
    
    return GetUtilityConfiguration ( "szPartReasons" ) [ iReason ];
    
}

// -------------------------------------------------------------------------------------------------

function RemoveSlashesFromCommand ( szCommand ) {

    if ( szCommand[0] == 47 ) {
    
        return szCommand.slice ( 1 , szCommand.len ( ) );
    
    }
    
    return szCommand;

}
    
// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Utilities]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------