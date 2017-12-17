
// NAME: Database.nut
// DESC: Handles connections, query management, and other MySQL abilities.
// NOTE: No queries are ran in this script. All queries are located in the scripts that needs them.

// -------------------------------------------------------------------------------------------------

function InitDatabaseScript ( ) {

    AddDatabaseCommandHandlers ( );
    
    GetCoreTable ( ).Database.pDatabaseConnection <- mysql_connect ( GetDatabaseConfiguration ( ).szHost , GetDatabaseConfiguration ( ).szUser , GetDatabaseConfiguration ( ).szPass , GetDatabaseConfiguration ( ).szName )
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddDatabaseCommandHandlers ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------

function ConnectToMySQL ( ) {
    
    return GetCoreTable ( ).Database.pDatabaseConnection;
    
}

// -------------------------------------------------------------------------------------------------

function DisconnectFromMySQL ( pDatabaseConnection ) {
    
    return false;

}

// -------------------------------------------------------------------------------------------------

function InitDatabaseCoreTable ( ) {

    local pDatabaseConfigurationTable = { };
    
    pDatabaseConfigurationTable.szHost              <- "";
    pDatabaseConfigurationTable.szUser              <- "";
    pDatabaseConfigurationTable.szPass              <- "";
    pDatabaseConfigurationTable.szName              <- "";
    pDatabaseConfigurationTable.iPort               <- 3306;

    ::print ( "[Server.Database]: Database configuration tables created" );
    
    return pDatabaseConfigurationTable;
    
}

// -------------------------------------------------------------------------------------------------

function GetDatabaseConfiguration ( ) {

    return GetCoreTable ( ).Database;

}

// -------------------------------------------------------------------------------------------------

function EscapeMySQLString ( pDatabaseConnection , szUnsafeString ) {

    local pDatabaseConnection2 = false;

    if ( !pDatabaseConnection ) {
    
        pDatabaseConnection2 = mysql_connect ( GetDatabaseConfiguration ( ).szHost , GetDatabaseConfiguration ( ).szUser , GetDatabaseConfiguration ( ).szPass , GetDatabaseConfiguration ( ).szName );local pDatabaseConnection = mysql_connect ( GetDatabaseConfiguration ( ).szHost , GetDatabaseConfiguration ( ).szUser , GetDatabaseConfiguration ( ).szPass , GetDatabaseConfiguration ( ).szName );
    
    } else {
    
        pDatabaseConnection2 = pDatabaseConnection;
        
    }
    
    if ( !pDatabaseConnection2 ) {
    
        return false;
    
    }
    
    if ( !szUnsafeString || szUnsafeString.len ( ) == 0 ) {
        
        return false;
        
    }
    
    local szSafeString = mysql_escape_string ( pDatabaseConnection2 , szUnsafeString );
    
    if ( !szSafeString ) {
    
        return false;
    
    }
    
    return szSafeString;

}

// -------------------------------------------------------------------------------------------------

function ExecuteMySQLQuery ( pDatabaseConnection , szQueryString ) {

    if ( !pDatabaseConnection ) {
    
        return false;
    
    }
    
    if ( !szQueryString || szQueryString.len ( ) == 0 ) {
        
        return false;
        
    }
    
    local pQuery = mysql_query ( pDatabaseConnection , szQueryString );
    
    if ( !pQuery ) {
    
        return false;
    
    }
    
    return pQuery;

}

// -------------------------------------------------------------------------------------------------

function StandaloneMySQLQuery ( szQuery ) {

    local pDatabaseConnection = ConnectToMySQL ( );
    
    local pQuery = ExecuteMySQLQuery ( pDatabaseConnection , szQuery );
    
    return pQuery;

}

// -------------------------------------------------------------------------------------------------

function StandaloneMySQLEscapeString ( szString ) {

    local pDatabaseConnection = ConnectToMySQL ( );
    
    local szSafeString = EscapeMySQLString ( pDatabaseConnection , szString );
    
    if ( szSafeString ) {
    
        return szSafeString;
    
    } else {
    
        return "";
    
    }

}

// -------------------------------------------------------------------------------------------------

function GetMySQLAssocResult ( pQueryResult ) {

    if ( !pQueryResult ) {
    
        return false;
    
    }

    return mysql_fetch_assoc ( pQueryResult );

}

// -------------------------------------------------------------------------------------------------

function SaveServerDataToDatabase ( ) {

    print ( "[Server.Database]: Beginning server data saving ..." );
    
    SaveAllVehiclesToDatabase ( );
    
    print ( "[Server.Database]: Saved all vehicles to database" );
    
    SaveAllPlayersToDatabase ( );
    
    print ( "[Server.Database]: Saved all players to database" );
    
    SaveAllClansToDatabase ( );
    
    print ( "[Server.Database]: Saved all clans to database" );
    
    SaveAllBusinessesToDatabase ( );
    
    print ( "[Server.Database]: Saved all businesses to database" );    
    
    SaveAllHousesToDatabase ( );
    
    print ( "[Server.Database]: Saved all houses to database" );
    
    return;

}

// -------------------------------------------------------------------------------------------------

function GetAccountNameFromDatabaseID ( iDatabaseID ) {

    local pDatabaseConnection = false;
    local pQuery = false;
    local szQueryString = "";
    local pAssocResult = false;
    local pPlayerData = false;
    
    pDatabaseConnection = ConnectToMySQL ( );
    
}

// -------------------------------------------------------------------------------------------------

function GetAccountDatabaseIDFromName ( szName ) {

    return LoadAccountFromDatabase ( szName ).iDatabaseID;
    
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Database]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------
