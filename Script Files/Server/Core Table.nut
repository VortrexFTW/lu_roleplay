// -------------------------------------------------------------------------------------------------

function InitCoreTable ( ) {
    
    local pTempCoreTable                                    = { };
    
    pTempCoreTable.Players                                  <- array ( MAX_PLAYERS , false );
    pTempCoreTable.Vehicles                                 <- [ ];
    pTempCoreTable.Houses                                   <- [ ];
    pTempCoreTable.Businesses                               <- [ ];
    pTempCoreTable.Fires                                    <- [ ];
    pTempCoreTable.Commands                                 <- { };
    pTempCoreTable.Pickups                                  <- ::array ( MAX_PICKUPS , { pPickup = false , iPickupDataType = 0 , iPickupDataID = -1 } );
    pTempCoreTable.Locations                                <- ::InitLocationsCoreTable ( );
    pTempCoreTable.Colours                                  <- ::InitColoursCoreTable ( );
    pTempCoreTable.Utilities                                <- ::InitUtilitiesCoreTable ( );
    pTempCoreTable.Database                                 <- ::InitDatabaseCoreTable ( );
    pTempCoreTable.Weapons                                  <- ::InitWeaponDataCoreTable ( );
    pTempCoreTable.BitFlags                                 <- ::InitBitFlagCoreTable ( );
    pTempCoreTable.Security                                 <- ::InitSecurityCoreTable ( );
    pTempCoreTable.Classes                                  <- ::InitClassesCoreTable ( );
    pTempCoreTable.Locale                                   <- ::InitLocaleGlobalTable ( );
    pTempCoreTable.Clans                                    <- [ ];
    pTempCoreTable.Threads                                  <- ::InitServerProcessingThreads ( );
    pTempCoreTable.Jobs                                     <- ::InitJobsCoreTable ( );
    pTempCoreTable.Timers                                   <- ::InitTimersCoreTable ( );
    pTempCoreTable.IRC                                      <- ::InitIRCCoreTable ( );
    pTempCoreTable.Events                                   <- { };
    pTempCoreTable.Discord                                  <- ::InitDiscordCoreTable ( );
    //pTempCoreTable.FuelPumps                              <- ::InitFuelPumpsCoreTable ( );
    
    pTempCoreTable.VehicleToData                            <- ::array ( MAX_VEHICLES , -1 );
    
    print ( "[Server.Core]: Core table data initialized" );
    
    return pTempCoreTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitEntityToDataCoreTables ( ) {
    
    local pVehicleToData = array ( MAX_VEHICLES , -1 );

    return pVehicleToData;
    
}

// -------------------------------------------------------------------------------------------------

function InitWeaponDataCoreTable ( ) {

    local pWeaponDataTable = { };

    pWeaponDataTable [ WEP_FIST ]                   <- { iWeaponID = 0      , szName = "Unarmed"            , iDamage = 20      , szKillerMessage = "%s killed %s with fists of steel."                                 };
    pWeaponDataTable [ WEP_BAT ]                    <- { iWeaponID = 1      , szName = "Baseball Bat"       , iDamage = 30      , szKillerMessage = "%s beat the shit out of %s with a Baseball Bat."                   };
    pWeaponDataTable [ WEP_COLT45 ]                 <- { iWeaponID = 2      , szName = "Colt .45"           , iDamage = 10      , szKillerMessage = "%s killed %s in cold blood with a Colt .45"                        };
    pWeaponDataTable [ WEP_UZI ]                    <- { iWeaponID = 3      , szName = "UZI"                , iDamage = 10      , szKillerMessage = "%s hosed %s down with an UZI"                                      };
    pWeaponDataTable [ WEP_SHOTGUN ]                <- { iWeaponID = 4      , szName = "Shotgun"            , iDamage = 100     , szKillerMessage = "%s knocked %s on their ass with a Shotgun"                         };
    pWeaponDataTable [ WEP_AK47 ]                   <- { iWeaponID = 5      , szName = "AK-47"              , iDamage = 10      , szKillerMessage = "%s killed %s with an AK-47"                                        };
    pWeaponDataTable [ WEP_M16 ]                    <- { iWeaponID = 6      , szName = "M-16"               , iDamage = 2       , szKillerMessage = "%s shredded %s's body apart with an M-16"                          };
    pWeaponDataTable [ WEP_SNIPER ]                 <- { iWeaponID = 7      , szName = "Sniper Rifle"       , iDamage = 200     , szKillerMessage = "%s killed %s with a Sniper Rifle."                                 };
    pWeaponDataTable [ WEP_ROCKETLAUNCHER ]         <- { iWeaponID = 8      , szName = "Rocket Launcher"    , iDamage = 200     , szKillerMessage = "%s's Rocket Launcher made sure there was nothing left of %s."      };
    pWeaponDataTable [ WEP_FLAMETHROWER ]           <- { iWeaponID = 9      , szName = "Flamethrower"       , iDamage = 0       , szKillerMessage = "%s set %s on fire with a Flamethrower."                            };
    pWeaponDataTable [ WEP_MOLOTOV ]                <- { iWeaponID = 10     , szName = "Molotov"            , iDamage = 0       , szKillerMessage = "%s lit up %s with a Molotov."                                      };
    pWeaponDataTable [ WEP_GRENADE ]                <- { iWeaponID = 11     , szName = "Grenade"            , iDamage = 0       , szKillerMessage = "%s blew up %s with a Grenade."                                     };

    ::print ( "[Server.Core]: Core weapon data table created" );
    
    return pWeaponDataTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitBitFlagCoreTable ( ) {

    local pBitFlagsTable = { };

    pBitFlagsTable.AccountSettings                  <- { };
    pBitFlagsTable.Licenses                         <- { };
    pBitFlagsTable.StaffFlags                       <- { };
    
    ::print ( "[Server.Core]: Core bit flag tables created" );
    
    return pBitFlagsTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitLocationsCoreTable ( ) {
    
    local pLocationsTable = { };
    
    pLocationsTable.Hospitals <- [ 
        
        {   pPosition = Vector ( 1144.25 , -596.875 , 14.97 )       , fAngle = 90.0     , pBlip = false     , szName = "Portland"               } , 
        {   pPosition = Vector ( 183.5 , -17.75 , 16.21 )           , fAngle = 180.0    , pBlip = false     , szName = "Staunton Island"        } , 
        {   pPosition = Vector ( -1259.5 , -44.5 , 58.89 )          , fAngle = 90.0     , pBlip = false     , szName = "Shoreside Vale"         }
        
    ];

    pLocationsTable.PoliceStations <- [ 
        
        {   pPosition = Vector ( 1143.875 , -675.1875 , 14.97 )     , fAngle = 90.0     , pBlip = false     , szName = "Portland"               } , 
        {   pPosition = Vector ( 340.25 , -1123.375 , 25.98 )       , fAngle = 180.0    , pBlip = false     , szName = "Staunton Island"        } , 
        {   pPosition = Vector ( -1253.0 , -138.1875 , 58.75 )      , fAngle = 90.0     , pBlip = false     , szName = "Shoreside Vale"         }
        
    ];
    
    pLocationsTable.FireStations <- [ 
        
        {   pPosition = Vector ( 1103.70 , -52.45 , 7.49 )          , fAngle = 90.0     , pBlip = false     , szName = "Portland"               } , 
        {   pPosition = Vector ( -78.48 , -436.80 , 16.17 )         , fAngle = 180.0    , pBlip = false     , szName = "Staunton Island"        } , 
        {   pPosition = Vector ( -1202.10 , -14.67 , 53.20 )        , fAngle = 180.0    , pBlip = false     , szName = "Shoreside Vale"         }
        
    ];  
    
    pLocationsTable.PayAndSprays <- [
        
        {   pPosition = Vector ( 925.4 , -360.3 , 10.83 )           , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Portland"           } , 
        {   pPosition = Vector ( 381.8 , -493.8 , 25.95 )           , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Staunton Island"        } , 
        {   pPosition = Vector ( -1142.4 , 35.01 , 58.61 )          , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Shoreside Vale"         }
        
    ];
    
    pLocationsTable.Ammunations <- [
        
        {   pPosition = Vector ( 1068.3 , -400.9 , 15.24 )          , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Portland"           } , 
        {   pPosition = Vector ( 348.2 , -717.9 , 26.43 )           , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Staunton Island"    }
        
    ];  
    
    pLocationsTable.ClothingStores <- [
        
        {   pPosition = Vector ( 1063.5 , -419.2 , 14.97 )          , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Zip"                }
        //{   pPosition = Vector ( 1202.8 , -466 , 25.07 )          , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Binco"              }
        // {   pPosition = Vector ( 925.4 , -360.3 , 10.83 )        , fAngle = 180.0    , pSphere = false   , pBlip = false     , szName = "Shoreside Vale"     }
        
    ];
    
    pLocationsTable.FuelPumps <- [
        
        {   pPosition = Vector ( 1161.9 , -76.73 , 7.27 )           , fAngle = 180.0    , pBlip = false     , szName = "Portland"           }
        // {   pPosition = Vector ( 925.4 , -360.3 , 10.83 )        , fAngle = 180.0    , pBlip = false     , szName = "Staunton Island"    } , 
        // {   pPosition = Vector ( 925.4 , -360.3 , 10.83 )        , fAngle = 180.0    , pBlip = false     , szName = "Shoreside Vale"     }
        
    ];
    
    pLocationsTable.GarbageRoutes <- [ 
    
        // PORTLAND ISLAND ROUTE 1
        
        { 
        
            szName = "Portland #1" , 
            iIsland = 1 , 
            pPositions = [
        
                Vector ( 1169.8 , -45.54 , 10.4 ) ,
                Vector ( 928 , -59.1 , 8.61 ) ,
                Vector ( 935.4 , -262.45 , 5.52 ) ,
                Vector ( 935.4 , -262.45 , 5.52 ) ,
                Vector ( 1042.5 , -375.9 , 15.4 ) ,
                Vector ( 987 , -450.5 , 15.39 ) ,
                Vector ( 871.3 , -277.07 , 5.4 ) ,
                Vector ( 1119.4 , -766.7 , 15.4 ) ,
                Vector ( 1082.3 , -990.8 , 15.4 ) ,
                Vector ( 1166.9 , -1046.8 , 15.41 ) ,
                Vector ( 1310.1 , -980.4 , 15.46 ) ,
                Vector ( 1129.5 , -645.3 , 15.4 ) ,
                Vector ( 1128.9 , -446.1 , 20.41 ) ,
                Vector ( 1226.5 , -52.41 , 10.42 )      
            ] 
            
        } , 
        
        // STAUNTON ISLAND ROUTE 1
        { 
        
            szName = "Staunton #1" , 
            iIsland = 2 , 
            pPositions = [
        
                Vector ( 49.85 , -1539.9 , 26.6 ) , 
                Vector ( 49.71 , -1458.1 , 26.6 ) , 
                Vector ( 170.78 , -1403.8 , 26.59 ) , 
                Vector ( 183.48 , -1485.9 , 26.6 ) , 
                Vector ( 320.43 , -1452.4 , 26.6 ) , 
                Vector ( 310.13 , -1311.8 , 26.6 ) , 
                Vector ( 134.76 , -1097.7 , 26.6 ) , 
                Vector ( 55.63 , -1058.6 , 26.6 ) , 
                Vector ( -0.02 , -790.9 , 26.64 )
            
            ]
        
        }
    
    ];
    
    pLocationsTable.BusRoutes <- [ 
    
        // PORTLAND ROUTE 1
        {   
            
            szName = "Red Line" , 
            iIsland = 1 , 
            pBusColour = Colour ( 120 , 0 , 0 ) ,
            pPositions = [
        
                Vector ( 1269 , -1056.4 , 14.75 ) ,
                Vector ( 1088.7 , -968.8 , 14.91 ) ,
                Vector ( 1059.1 , -870.9 , 14.91 ) ,
                Vector ( 917.6 , -815.9 , 14.91 ) ,
                Vector ( 851.1 , -766.1 , 14.91 ) ,
                Vector ( 838.8 , -598.7 , 14.91 ) ,
                Vector ( 959.3 , -581.6 , 14.91 ) ,
                Vector ( 853.1 , -485.9 , 14.91 ) ,
                Vector ( 838.8 , -312.68 , 6.8 ) ,
                Vector ( 913.9 , -177.4 , 4.91 ) ,
                Vector ( 1123.3 , -67.74 , 7.41 ) ,
                Vector ( 1043.6 , -191.63 , 4.91 ) ,
                Vector ( 1213.2 , -281.3 , 25.76 ) ,
                Vector ( 1193.3 , -474.3 , 24.98 ) ,
                Vector ( 1335.4 , -499.7 , 45.28 ) ,
                Vector ( 1220.3 , -341.4 , 26.38 ) ,
                Vector ( 1122.6 , -475.6 , 19.91 ) ,
                Vector ( 1309.2 , -642.4 , 12.3 ) ,
                Vector ( 1350.5 , -845 , 14.91 ) ,
                Vector ( 1322.2 , -1025.3 , 14.76 ) 
        
            ]
            
        } , 
        
        // STAUNTON ISLAND ROUTE 1
        {   
            
            szName = "Red Line" , 
            iIsland = 2 , 
            pBusColour = Colour ( 120 , 0 , 0 ) ,
            pPositions = [
            
                Vector ( -1.11 , -388.4 , 16.11 ) ,
                Vector ( -15.75 , -735.3 , 26.15 ) ,
                Vector ( 33.63 , -1029.4 , 26.11 ) ,
                Vector ( -53.92 , -1233.4 , 26.11 ) ,
                Vector ( 126.58 , -1323.7 , 26.11 ) ,
                Vector ( 189.39 , -1285.6 , 26.11 ) ,
                Vector ( 266.9 , -1179.1 , 26.11 ) ,
                Vector ( 283.93 , -1370.2 , 26.11 ) ,
                Vector ( 144.44 , -1455.5 , 26.11 ) ,
                Vector ( 34.5 , -1511.7 , 26.11 ) ,
                Vector ( 325.31 , -1579 , 26.03 ) ,
                Vector ( 302.33 , -1417.7 , 26.11 ) ,
                Vector ( 309.76 , -1290 , 26.11 ) ,
                Vector ( 378.5 , -1235.1 , 26.11 ) ,
                Vector ( 404 , -1376.3 , 26.11 ) ,
                Vector ( 189.07 , -1159.3 , 26.11 ) ,
                Vector ( 189.44 , -956.9 , 26.11 ) ,
                Vector ( 254.18 , -722.3 , 26.11 ) ,
                Vector ( 383.4 , -704.2 , 26.11 ) ,
                Vector ( 429.3 , -420.6 , 22.04 ) ,
                Vector ( 570.9 , -336.4 , 19.71 ) ,
                Vector ( 267.46 , 91.12 , 15.96 ) ,
                Vector ( 99.13 , -31.96 , 16.11 ) ,
                Vector ( 243.94 , -187.01 , 21.31 ) ,
                Vector ( 99.17 , -263.44 , 16.11 ) ,
                Vector ( -26.92 , -283.73 , 16.11 )
                
            ]
        
        }
    
    ];  
    
    pLocationsTable.FireJobVehicles <- [

        // PORTLAND 
        {   pPosition = Vector ( 1196.4 , -393.4 , 24.71 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1366.3 , -437.1 , 49.72 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1362.8 , -284.86 , 49.62 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1220.5 , -47.6 , 9.74 )            , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1053.9 , 1.66 , 1.98 )             , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 932.8 , -39.08 , 7.12 )            , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 910.6 , -230.03 , 4.62 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1001.2 , -423.3 , 14.62 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 835.8 , -519.6 , 14.62 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 815.8 , -726.7 , 14.72 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 850.9 , -1015 , 4.57 )             , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1109.5 , -1098.8 , 11.5 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1274.7 , -1058.1 , 14.46 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1252.6 , -885.9 , 14.62 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1125.4 , -719.8 , 14.62 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1366.1 , -273.52 , 49.62 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1195.4 , -270.53 , 24.62 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1130.7 , -424.1 , 19.62 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1195.2 , -469.5 , 24.71 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        
        // STAUNTON     
        {   pPosition = Vector ( 200.69 , -454.8 , 25.81 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 105.4 , -406.8 , 15.82 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 105.54 , -262.78 , 15.82 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 1.82 , -363.3 , 15.81 )            , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 169.42 , -206.52 , 17.05 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 343.2 , -170.26 , 20.87 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 451.4 , -316.41 , 21.03 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 415.4 , -502.2 , 25.95 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 331 , -696.9 , 25.79 )             , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 227.5 , -759.7 , 25.79 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 154.07 , -928.8 , 25.87 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 146.46 , -1357.8 , 25.79 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 147.32 , -1104 , 25.8 )            , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 104.31 , -1471.3 , 25.8 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( 41.9 , -1551.5 , 25.79 )           , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -58.53 , -1587.5 , 25.67 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -182.21 , -1456.6 , 25.64 )        , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -153.37 , -1195.8 , 15.63 )        , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -79.41 , -867.7 , 15.73 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -102.82 , -495.4 , 15.8 )          , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false } , 
        {   pPosition = Vector ( -167.69 , -143.1 , 15.79 )         , pBlip = false     , pVehicle = false      , pPlayer = false   , iStart = 0 , bActive = false }        
        
    
    ];
    
    pLocationsTable.HiddenPackages <- [
        
        {   pPosition = Vector ( 1105.25 , -1020 , 25.0625 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 877.562 , -788 , 27.5625 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1254 , -611.188 , 22.75 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1045.75 , -967.062 , 16 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 942.062 , -793.375 , 14.875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 934 , -718.875 , 14.75 )           , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 898.062 , -414.688 , 26.5 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 846.875 , -442.5 , 23.1875 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 927.062 , -404.375 , 29.0625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 864.25 , -171.5 , 3.5 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1538.25 , -174.375 , 19.1875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1213.06 , -127.062 , 15.0625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 753.562 , 137 , 3.5 )              , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1162 , -101.75 , 12 )              , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1155.56 , -191.5 , 14.375 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1285.5 , -247.5 , 42.375 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1007.19 , -219.562 , 6.6875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1138.19 , -250 , 24.25 )           , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1023.56 , -423.688 , 14.875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1237.5 , -854.062 , 20.5625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1478.25 , -1150.69 , 12 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1018.88 , -56.75 , 21 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1465.69 , -166.5 , 55.5 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1120.19 , -926.188 , 16 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1206.5 , -821.5 , 15 )             , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 940.188 , -199.875 , 5 )           , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 979.25 , -1143.06 , 13.0625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1195.5 , -908.75 , 14.875 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1470.38 , -811.375 , 22.375 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1320.5 , -365.5 , 15.1875 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 932.562 , -477.25 , -10.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 1305.88 , -380.875 , 39.5 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 938.188 , -1258.25 , 3.5 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 36.75 , -530.188 , 26 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 414.375 , -279.25 , 23.5625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 203.5 , -1252.56 , 59.25 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 77.6875 , -352.25 , 16.0625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 120.875 , 243.688 , 11.375 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 49.375 , 36.25 , 16.6875 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 68.0625 , -773.25 , 22.75 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -4 , -1129.06 , 26 )               , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -134.688 , -1386.88 , 26.1875 )    , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -23.5 , -1472.38 , 19.6875 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 112.062 , -1227.56 , 26 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 218.25 , -1237.75 , 20.375 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 308 , -1533.38 , 23.5625 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 468.562 , -1457.19 , 44.25 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 355.062 , -1085.69 , 25.875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 312.375 , -483.75 , 29 )           , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 322.25 , -447.062 , 23.375 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 586.688 , -795 , 1.5625 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 504.25 , -1027.75 , 1.6875 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 174.062 , -1259.5 , 32.0625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 248.75 , -958.25 , 26 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 54.75 , -566.5 , 26.0625 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -77 , -1490.06 , 26 )              , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 556 , -231.375 , 22.75 )           , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -38.1875 , -1434.25 , 31.75 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 194.75 , -0.5 , 19.75 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 223.062 , -272.188 , 16.0625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -18.0625 , -222.25 , 29.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -69.25 , -469.188 , 16.0625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -270.688 , -631.562 , 72.25 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -59.1875 , -579.75 , 15.875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 392.75 , -1135.56 , 15.875 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 145 , -1584 , 30.6875 )            , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 428.062 , -340.375 , 16.1875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( 351.062 , -980.5 , 33.0625 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -221.75 , -1487.56 , 5.75 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1193.06 , -75.75 , 47.375 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1090.5 , 131.688 , 58.6875 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1015.5 , -13 , 49.0625 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -821.75 , -184.875 , 33.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -849.062 , -209.375 , 41.75 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -736.375 , 304.688 , 54.0625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -678.062 , 308.562 , 59.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -609.188 , 286.688 , 65.0625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -329.562 , 320.062 , 60.6875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1221.06 , 562.75 , 68.5625 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1131.88 , 605.375 , 68.5625 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1098.38 , 471.25 , 35.5 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1208.06 , 325.188 , 3.375 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1216.19 , 347.875 , 30.375 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1211.88 , -166.875 , 58.6875 )    , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1195.19 , -7.6875 , 59.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -206.875 , 328.75 , 3.375 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -753.188 , 142 , 10.0625 )         , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -697.875 , -182.062 , 9.1875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -748.375 , -807 , -13.5625 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -489.875 , -44.875 , 3.75 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -632.875 , 67.5625 , 18.75 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -546.75 , 10.6875 , 3.875 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1032.56 , -573.375 , 10.875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -542 , -1046.56 , 3.375 )          , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1556.38 , -905.75 , 14.5 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1327 , -624.688 , 11.0625 )       , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -737.375 , -745.375 , 9.6875 )     , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1278.69 , -776 , 11.0625 )        , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -1494.69 , -1097.25 , 3.375 )      , pPickup = false       , iCashWin = 1000       } ,  
        {   pPosition = Vector ( -837.75 , -469.188 , 10.75 )       , pPickup = false       , iCashWin = 1000       }
        
    ];
    
    ::print ( "[Server.Core]: Core standard locations tables created" );
    
    return pLocationsTable;

}

// -------------------------------------------------------------------------------------------------

function InitTimersCoreTable ( ) {

    local pTimersTable = { };
    
    pTimersTable.pServerSaveTimer       <- false;
    pTimersTable.pVehicleSyncTimer      <- false;
    pTimersTable.pTimeUpdateTimer       <- false;
    pTimersTable.pVehicleFuelTimer      <- false;
    pTimersTable.pFireJobUpdateTimer    <- false;
    
    return pTimersTable;

}

// -------------------------------------------------------------------------------------------------

function InitJobsCoreTable ( ) {

    local pJobsTable = [
        
        {   szName = "Police Officer"           , pPosition = ::Vector ( 1143.87 , -675.18 , 14.97 )            , pPickup = false , iPickupModel = 1383 , pMapBlip = false , iJobType = 1 , iJobSkin = 1 , iJobColour = 4 , bEnabled = true } , 
        {   szName = "Paramedic"                , pPosition = ::Vector ( 1144.25 , -596.87 , 14.97 )            , pPickup = false , iPickupModel = 1362 , pMapBlip = false , iJobType = 3 , iJobSkin = 5 , iJobColour = 7 , bEnabled = true } , 
        {   szName = "Firefighter"              , pPosition = ::Vector ( 1103.70 , -52.45 , 7.49 )              , pPickup = false , iPickupModel = 1364 , pMapBlip = false , iJobType = 2 , iJobSkin = 6 , iJobColour = 5 , bEnabled = true } , 
        {   szName = "Trash Collector"          , pPosition = ::Vector ( 1121.8 , 27.8 , 1.99 )                 , pPickup = false , iPickupModel = 1351 , pMapBlip = false , iJobType = 4 , iJobSkin = 53 , iJobColour = 2 , bEnabled = true } , 
        {   szName = "Trash Collector"          , pPosition = ::Vector ( -66.83 , -932.2 , 16.47 )              , pPickup = false , iPickupModel = 1351 , pMapBlip = false , iJobType = 4 , iJobSkin = 53 , iJobColour = 2 , bEnabled = true } , 
        {   szName = "Taxi Driver"              , pPosition = ::Vector ( 1229.2 , -740.1 , 15.17 )              , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 5 , iJobSkin = 8 , iJobColour = 3 , bEnabled = true } , 
        {   szName = "Bus Driver"               , pPosition = ::Vector ( 1310.20 , -1016.30 , 14.88 )           , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 7 , iJobSkin = 121 , iJobColour = 3 , bEnabled = true } ,   
        {   szName = "Police Officer"           , pPosition = ::Vector ( 340.25 , -1123.37 , 25.98 )            , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 1 , iJobSkin = 1 , iJobColour = 4 , bEnabled = true } , 
        {   szName = "Police Officer"           , pPosition = ::Vector ( -1253.0 , -138.18 , 58.75 )            , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 1 , iJobSkin = 1 , iJobColour = 4 , bEnabled = true } , 
        {   szName = "Paramedic"                , pPosition = ::Vector ( 183.5 , -17.75 , 16.21 )               , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 3 , iJobSkin = 5 , iJobColour = 7 , bEnabled = true  } , 
        {   szName = "Paramedic"                , pPosition = ::Vector ( -1259.5 , -44.5 , 58.89 )              , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 3 , iJobSkin = 5 , iJobColour = 7 , bEnabled = true  } ,
        {   szName = "Firefighter"              , pPosition = ::Vector ( -78.48 , -436.80 , 16.17 )             , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 2 , iJobSkin = 6 , iJobColour = 5 , bEnabled = true  } , 
        {   szName = "Firefighter"              , pPosition = ::Vector ( -1202.10 , -14.67 , 53.20 )            , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 2 , iJobSkin = 6 , iJobColour = 5 , bEnabled = true  } ,        
        {   szName = "Taxi Driver"              , pPosition = ::Vector ( 1229.2 , -740.1 , 15.17 )              , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 5 , iJobSkin = 8 , iJobColour = 3 , bEnabled = true } ,         
        {   szName = "Bus Driver"               , pPosition = ::Vector ( -57.1661 , -334.266 , 16.9324 )        , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 7 , iJobSkin = 121 , iJobColour = 3 , bEnabled = true } ,   
        
        
        //{   szName = "Postal Worker"          , pPosition = Vector ( )                                        , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 7 } , 
        //{   szName = "Delivery Worker"        , pPosition = Vector ( )                                        , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 8 } , 
        //{   szName = "Mechanic"               , pPosition = Vector ( )                                        , pPickup = false , iPickupModel = 1361 , pMapBlip = false , iJobType = 9 } , 
        
    ];
    
    ::print ( "[Server.Core]: Core job tables created" );
 
    return pJobsTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitServerModules ( ) {

    print ( "[Server.Core]: Initializing module 'lu_hashing' ... Result: " + LoadModule ( "lu_hashing" ) );
    print ( "[Server.Core]: Initializing module 'lu_ini' ... Result: " + LoadModule ( "lu_ini" ) );
    print ( "[Server.Core]: Initializing module 'lu_mysql' ... Result: " + LoadModule ( "lu_mysql" ) );
    print ( "[Server.Core]: Initializing module 'sq_geoip' ... Result: " + LoadModule ( "sq_geoip" ) );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function InitServerProcessingThreads ( ) {

    print ( "[Server.Core]: Initiating server processing threads ... " );

    local pThreadTable = { };
    
    //pThreadTable.LoadVehicleThread            <- ::newthread ( LoadVehicleFromDatabase );
    //pThreadTable.SaveVehicleThread            <- ::newthread ( SaveVehicleToDatabase );
    //pThreadTable.LoadPlayerThread             <- ::newthread ( LoadPlayerFromDatabase );
    //pThreadTable.SavePlayerThread             <- ::newthread ( SavePlayerToDatabase );    

    return pThreadTable;
    
}

// -------------------------------------------------------------------------------------------------

function InitIRCCoreTable ( ) {

    local pIRCCoreTable = { };
    
    pIRCCoreTable.bUseIRC               <- false;
    pIRCCoreTable.bEchoEvents           <- false;
    pIRCCoreTable.szBotOne              <- "";
    pIRCCoreTable.szBotTwo              <- "";
    pIRCCoreTable.szBotName             <- "";
    pIRCCoreTable.szBotPass             <- "";
    pIRCCoreTable.szServerHost          <- "";
    pIRCCoreTable.iServerPort           <- 0;
    pIRCCoreTable.szChannelName         <- "";
    pIRCCoreTable.szChannelPass         <- "";
    pIRCCoreTable.bUseSecondBot         <- false;
    pIRCCoreTable.iBotTurn              <- 1;
    pIRCCoreTable.bIRCInit              <- false;
    
    pIRCCoreTable.pMainBot              <- false;
    pIRCCoreTable.pSlaveBot             <- false;

    return pIRCCoreTable;

}

// -------------------------------------------------------------------------------------------------

function InitDiscordCoreTable ( ) {

    local pDiscordCoreTable = { };
    
    pDiscordCoreTable.bUseDiscord           <- false;
    pDiscordCoreTable.bEchoEvents           <- false;
    
    pDiscordCoreTable.szNodeServerHost      <- "";
    pDiscordCoreTable.iNodeerverPort        <- 0;
    pDiscordCoreTable.szPassphrase          <- "";
    pDiscordCoreTable.szChannelName         <- "";
    pDiscordCoreTable.szAdminRole           <- "";
    pDiscordCoreTable.szModRole             <- "";
    
    pDiscordCoreTable.pSocket               <- false;
    
    pDiscordCoreTable.pEvents               <- { };
    pDiscordCoreTable.pCommands             <- { };

    return pDiscordCoreTable;

}

// -------------------------------------------------------------------------------------------------

function InitFuelPumpsCoreTable ( ) {

    
    local pFuelPumpsCoreTable = [
        ::GetCoreTable ( ).Classes.FuelPump ( ::Vector ( 1155.50 , -74.10 , 7.47 ) , 1 ) , 
        ::GetCoreTable ( ).Classes.FuelPump ( ::Vector ( 1163.50 , -74.31 , 7.47 ) , 1 ) , 
        ::GetCoreTable ( ).Classes.FuelPump ( ::Vector ( 1171.50 , -74.40 , 7.47 ) , 1 ) , 
    
    ];
    
    return pFuelPumpsCoreTable;

}

// -------------------------------------------------------------------------------------------------

function InitGameEntities ( ) {

    ::print ( "[Server.Core]: Initiating game entities ... " );
    
    ::CreateStaticMapBlips ( );
    
    //InitTimeUpdateSpeedControl ( );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

::print ( "[Server.Core]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------