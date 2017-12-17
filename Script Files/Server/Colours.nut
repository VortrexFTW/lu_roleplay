
// NAME: Colours.nut
// DESC: Provides colours
// NOTE: None

// -------------------------------------------------------------------------------------------------

function InitColoursScript ( ) {
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function AddColoursCommandHandlers ( ) {

    return true;

}

// -------------------------------------------------------------------------------------------------
    
function InitColoursCoreTable ( ) {
    
    local pAllColoursTable                      = { };
    
    local pHexColoursTable                      = { };
    local pRGBColoursTable                      = { };
    local pIRCColoursTable                      = { };
    local pByTypeColoursTable                   = { };
    
    pHexColoursTable.White                      <- "[#FFFFFF]";
    pHexColoursTable.Black                      <- "[#000000]";
    pHexColoursTable.LightGrey                  <- "[#CCCCCC]";
    pHexColoursTable.MediumGrey                 <- "[#999999]";
    pHexColoursTable.DarkGrey                   <- "[#666666]";
    pHexColoursTable.BrightRed                  <- "[#FF0000]";
    pHexColoursTable.MediumRed                  <- "[#660000]";
    pHexColoursTable.Maroon                     <- "[#330000]";
    pHexColoursTable.Yellow                     <- "[#FFFF00]";
    pHexColoursTable.Orange                     <- "[#FF6600]";
    pHexColoursTable.Lime                       <- "[#00FF00]";
    pHexColoursTable.Green                      <- "[#006600]";
    pHexColoursTable.RoyalBlue                  <- "[#0000FF]";
    pHexColoursTable.LightBlue                  <- "[#00FFFF]";
    pHexColoursTable.LightPurple                <- "[#A000A0]"; 
    pHexColoursTable.MediumPurple               <- "[#660066]";
    pHexColoursTable.DarkPurple                 <- "[#400040]";
    pHexColoursTable.Pink                       <- "[#FF00FF]"; 
    pHexColoursTable.AdminName                  <- "[#F02311]";
    pHexColoursTable.DeveloperName              <- "[#CFAA17]"; 
    
    pRGBColoursTable.White                      <- Colour ( 255 , 255 , 255 );
    pRGBColoursTable.Black                      <- Colour ( 000 , 000 , 000 );
    pRGBColoursTable.LightGrey                  <- Colour ( 204 , 204 , 204 );
    pRGBColoursTable.MediumGrey                 <- Colour ( 153 , 153 , 153 );
    pRGBColoursTable.DarkGrey                   <- Colour ( 102 , 102 , 102 );
    pRGBColoursTable.BrightRed                  <- Colour ( 255 , 000 , 000 );
    pRGBColoursTable.MediumRed                  <- Colour ( 102 , 000 , 000 );
    pRGBColoursTable.Maroon                     <- Colour ( 051 , 000 , 000 );
    pRGBColoursTable.Yellow                     <- Colour ( 255 , 255 , 000 );
    pRGBColoursTable.Orange                     <- Colour ( 255 , 128 , 0 );
    pRGBColoursTable.Lime                       <- Colour ( 000 , 255 , 000 );
    pRGBColoursTable.Green                      <- Colour ( 000 , 102 , 000 );
    pRGBColoursTable.RoyalBlue                  <- Colour ( 000 , 000 , 255 );
    pRGBColoursTable.LightBlue                  <- Colour ( 000 , 255 , 255 );
    pRGBColoursTable.LightPurple                <- Colour ( 200 , 000 , 200 );
    pRGBColoursTable.MediumPurple               <- Colour ( 102 , 000 , 102 );
    pRGBColoursTable.DarkPurple                 <- Colour ( 064 , 000 , 064 );
    pRGBColoursTable.Pink                       <- Colour ( 255 , 000 , 255 );
    pRGBColoursTable.AdminName                  <- Colour ( 240 , 035 , 017 );      
    pRGBColoursTable.DeveloperName              <- Colour ( 207 , 170 , 023 );
    
    pIRCColoursTable.White                      <- "\x000300";
    pIRCColoursTable.Black                      <- "\x000301";
    pIRCColoursTable.NavyBlue                   <- "\x000302";
    pIRCColoursTable.Green                      <- "\x000303";
    pIRCColoursTable.Red                        <- "\x000304";
    pIRCColoursTable.Brown                      <- "\x000305";
    pIRCColoursTable.Purple                     <- "\x000306";
    pIRCColoursTable.Olive                      <- "\x000307";
    pIRCColoursTable.Yellow                     <- "\x000308";
    pIRCColoursTable.LimeGreen                  <- "\x000309";
    pIRCColoursTable.Teal                       <- "\x000310";
    pIRCColoursTable.AquaLight                  <- "\x000311";
    pIRCColoursTable.RoyalBlue                  <- "\x000312";
    pIRCColoursTable.Pink                       <- "\x000313";
    pIRCColoursTable.DarkGrey                   <- "\x000314";
    pIRCColoursTable.LightGrey                  <- "\x000315";  
    
    pByTypeColoursTable.UnknownCommandMessage   <- pHexColoursTable.White;
    pByTypeColoursTable.UnknownCommandHeader    <- pHexColoursTable.BrightRed;
    pByTypeColoursTable.GeneralAlertMessage     <- pHexColoursTable.White;
    pByTypeColoursTable.GeneralAlertHeader      <- pHexColoursTable.Yellow;
    pByTypeColoursTable.GeneralSuccessMessage   <- pHexColoursTable.White;
    pByTypeColoursTable.GeneralSuccessHeader    <- pHexColoursTable.Lime;
    pByTypeColoursTable.GeneralErrorMessage     <- pHexColoursTable.White;
    pByTypeColoursTable.GeneralErrorHeader      <- pHexColoursTable.BrightRed;
    pByTypeColoursTable.SyntaxErrorMessage      <- pHexColoursTable.White;
    pByTypeColoursTable.SyntaxErrorHeader       <- pHexColoursTable.LightGrey;
    pByTypeColoursTable.ChatMessage             <- pHexColoursTable.LightGrey;
    pByTypeColoursTable.ChatPlayerName          <- pHexColoursTable.White;
    pByTypeColoursTable.ChatPlayerHeader        <- pHexColoursTable.Orange;
    pByTypeColoursTable.AreaTalkHeader          <- pHexColoursTable.LightBlue;
    pByTypeColoursTable.AreaTalkName            <- pHexColoursTable.White;
    pByTypeColoursTable.AreaTalkMessage         <- pHexColoursTable.LightGrey;
    pByTypeColoursTable.AreaShoutHeader         <- pHexColoursTable.LightBlue;
    pByTypeColoursTable.AreaShoutName           <- pHexColoursTable.White;
    pByTypeColoursTable.AreaShoutMessage        <- pHexColoursTable.LightGrey;
    pByTypeColoursTable.AdminAnnounceHeader     <- pHexColoursTable.Orange;
    pByTypeColoursTable.AdminAnnounceMessage    <- pHexColoursTable.White;
    pByTypeColoursTable.InfoMessageMessage      <- pHexColoursTable.White;
    pByTypeColoursTable.InfoMessageHeader       <- pHexColoursTable.LightPurple;
    pByTypeColoursTable.InfoMessageMessage      <- pHexColoursTable.White;
    pByTypeColoursTable.CommandHeader           <- pHexColoursTable.LightPurple;  
    pByTypeColoursTable.CommandInfoHeader       <- pHexColoursTable.LightPurple;    
    pByTypeColoursTable.CommandInfoMessage      <- pHexColoursTable.LightGrey;
        
    pAllColoursTable.Hex                        <- pHexColoursTable;
    pAllColoursTable.RGB                        <- pRGBColoursTable;
    pAllColoursTable.IRC                        <- pIRCColoursTable;
    pAllColoursTable.ByType                     <- pByTypeColoursTable;
    
    ::print ( "[Server.Core]: Core colour tables created" );
    
    return pAllColoursTable;
    
}

// -------------------------------------------------------------------------------------------------

function GetHexColour ( szColourName ) {

    if ( GetCoreTable ( ).Colours.Hex.rawin ( szColourName ) ) {
    
        return GetCoreTable ( ).Colours.Hex [ szColourName ];

    }

    return GetCoreTable ( ).Colours.Hex.White;
    
}

// -------------------------------------------------------------------------------------------------

function GetRGBColour ( szColourName ) {

    if ( GetCoreTable ( ).Colours.RGB.rawin ( szColourName ) ) {
    
        return GetCoreTable ( ).Colours.RGB [ szColourName ];

    }

    return GetCoreTable ( ).Colours.RGB.White;
    
}

// -------------------------------------------------------------------------------------------------

function GetIRCColour ( szColourName ) {

    if ( GetCoreTable ( ).Colours.IRC.rawin ( szColourName ) ) {
    
        return GetCoreTable ( ).Colours.IRC [ szColourName ];

    }

    return GetCoreTable ( ).Colours.IRC.Black;
    
}

// -------------------------------------------------------------------------------------------------

function GetColourByType ( szColourTypeName ) {

    if ( GetCoreTable ( ).Colours.ByType.rawin ( szColourTypeName ) ) {
    
        return GetCoreTable ( ).Colours.ByType [ szColourTypeName ];

    }

    return GetCoreTable ( ).Colours.Hex.White;
    
}

// -------------------------------------------------------------------------------------------------

function GetHexColourByType ( szColourTypeName ) {

    return GetColourByType ( szColourTypeName );

}

function GetHexColourFromContentXML ( iColourID ) {

    switch ( iColourID ) {
    
        case 0: // NORMAL PLAYER -->
            return "[#FFFFFF]";

        case 1: // JOB ICON -->
            return "[#FFFF00]";

        case 2: // GARBAGE JOB -->
            return "[#808080]";

        case 3: // BUS/TAXI DRIVER -->
            return "[#90C048]";

        case 4: // POLICE OFFICER -->
            return "[#0064FF]";

        case 5: // FIREFIGHTER -->
            return "[#ED4337]";

        case 6: // NOT LOGGED IN -->
            return "[#000000]";

        case 7: // MEDIC -->
            return "[#FF8E9D]";
            
        default:
            return "[#FFFFFF]";
        
    }
    
    return "[#FFFFFF]"

}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Colours]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------