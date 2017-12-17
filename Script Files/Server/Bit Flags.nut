// -------------------------------------------------------------------------------------------------

function InitBitFlagsScript ( ) {

    CreateBitwiseTables ( );

    return true;

}

// -------------------------------------------------------------------------------------------------

function CreateBitwiseTable ( szTableKeys ) {
    
    local iBitVal = 0;
    local pBitTable = { };
    local iIncVal = 1;
    
    foreach ( ii , iv in szTableKeys ) {
    
        pBitTable [ iv ] <- iBitVal;
        iBitVal = 1 << iIncVal;
        iIncVal++;
        
    }

    return pBitTable;
    
}

// -------------------------------------------------------------------------------------------------

function HasBitFlag ( iCheckThis , iCheckFor ) {
    
    if ( iCheckThis & iCheckFor ) {
    
        return true;
        
    }
    
    return false;
    
}

// -------------------------------------------------------------------------------------------------

function CreateBitwiseTables ( ) {
    
    GetCoreTable ( ).BitFlags.AccountSettings           <- CreateBitwiseTable ( [ "None" , "LUIDLogin" , "IPLogin" , "TwoStepAuth" , "WhiteList" , "LoginAlert" ] );
    GetCoreTable ( ).BitFlags.StaffFlags                <- CreateBitwiseTable ( [ "None" , "BasicModeration" , "ManagePlayerStats" , "ManageBans" , "ManageVehicles" , "ManageHouses" , "ManageBusinesses" , "ManageClans" , "Developer" , "ManageServer" , "ManageAdmins" ] );
    GetCoreTable ( ).BitFlags.Licenses                  <- CreateBitwiseTable ( [ "None" , "DrivingLicense" , "BoatingLicense" , "PilotsLicense" , "TaxiLicense" , "WeaponsLicense" ] );    
    GetCoreTable ( ).BitFlags.ClanRankFlags             <- CreateBitwiseTable ( [ "None" , "AddMember" , "RemoveMember" , "ClaimTurf" , "GiveTurf" , "StoreInSafe" , "TakeFromSafe" , "EditTag" , "EditName" , "ManageVehicles" , "ManageTurfs" , "ManageAlliances" , "Owner" ] );
    GetCoreTable ( ).BitFlags.ModerationFlags           <- CreateBitwiseTable ( [ "None" , "Frozen" , "Muted" , "Watchlist" , "Desync" , "Hacker" , "BlockAmmunation" , "BlockGuns" , "BlockJobs" , "BlockReports" , "BlockPM" ] );
    
    print ( "[Server.BitFlags]: Bitwise tables created" );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function GetStaffFlagValue ( szStaffFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "StaffFlags" ].rawin ( szStaffFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "StaffFlags" ] [ szStaffFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function GetModerationFlagValue ( szModerationFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "ModerationFlags" ].rawin ( szModerationFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "ModerationFlags" ] [ szModerationFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function GetLicenseFlagValue ( szLicenseFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "Licenses" ].rawin ( szLicenseFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "Licenses" ] [ szLicenseFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function GetClanRankFlagValue ( szClanRankFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "ClanRankFlags" ].rawin ( szClanRankFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "ClanRankFlags" ] [ szClanRankFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function GetClanFlagValue ( szClanFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "ClanFlags" ].rawin ( szClanFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "ClanFlags" ] [ szClanFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

function GetAccountSettingsFlagValue ( szAccountSettingsFlagName ) {

    if ( GetCoreTable ( ) [ "BitFlags" ] [ "AccountSettings" ].rawin ( szAccountSettingsFlagName ) ) {
        
        return GetCoreTable ( ) [ "BitFlags" ] [ "AccountSettings" ] [ szAccountSettingsFlagName ];
    
    }
    
    return 0;

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.BitFlags]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
