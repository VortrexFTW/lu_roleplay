
// NAME: Help.nut
// DESC: Provides info and commands for help and documentation.
// NOTE: None

// -- COMMANDS -------------------------------------------------------------------------------------

function AddHelpCommandHandlers ( ) {

    AddCommandHandler ( "Help" , HelpCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Cmds" , CommonCMDSHelpCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Commands" , CommonCMDSHelpCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Cmd" , CommonCMDSHelpCommand , GetStaffFlagValue ( "None" ) );
    
    AddCommandHandler ( "Veh" , CommonVehHelpCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "Skin" , CommonSkinHelpCommand , GetStaffFlagValue ( "None" ) );
    AddCommandHandler ( "V" , CommonVehHelpCommand , GetStaffFlagValue ( "None" ) );

}

// -- SCRIPT INIT ----------------------------------------------------------------------------------

function InitHelpScript ( ) {
    
    AddHelpCommandHandlers ( );
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function RulesCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Shows server rules" , [ "Help" ] , "" );

        return false;

    }
    
    onPlayerCommand ( pPlayer , "help" , "rules" , false );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function HelpCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
    
    if( bShowHelpOnly ) {

        SendPlayerCommandInfoMessage ( pPlayer , "Shows help information" , [ "Help" ] , "" );

        return false;

    }       
    
    local pPlayerData = GetPlayerData ( pPlayer );
    local szCategory = "";
    
    if ( !szParams ) {
        
        SendPlayerSyntaxMessage ( pPlayer , "/Help <Category>" );
        MessagePlayer ( GetHexColour ( "White" ) + "Help Categories: " + GetHexColour ( "LightGrey" ) + "Account, Command, Vehicle, Job, Chat, Rules, Website, Anim" , pPlayer , GetRGBColour ( "White" ) );
        MessagePlayer ( GetHexColour ( "LightGrey" ) + "PayAndSpray, Ammunation, Skins, TuneUp, Dealership, Map, Colours, Keys" , pPlayer , GetRGBColour ( "White" ) );
        
        return false;
        
    }
    
    szCategory = GetTok ( szParams , " " , 1 );
    
    // == Account Help =============================
    // == Vehicle Help =============================
    // == Job Help =================================
    // == Chat Help ================================
    // == Server Rules =============================
    // == Website ==================================
    // == Animations ===============================
    // == Pay And Spray ============================
    // == Ammunation ===============================
    // == Vehicle Tuneup ===========================
    // == Bindable Keys ============================
    
    switch ( szCategory.tolower ( ) ) {
    
        case "account":
            
            local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "AccountHelp" );
            
            foreach ( ii , iv in pMessages ) {
            
                if ( ii == 0 ) {
                
                    MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
                
                } else {
                    
                    MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
                
                }
            
            }
            
            return true;
        
        case "vehicle":
            
            local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "VehicleHelp" );
            
            foreach ( ii , iv in pMessages ) {
            
                if ( ii == 0 ) {
                
                    MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
                
                } else {
                    
                    MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
                
                }
            
            }
            
            return true;

        case "job":
            
            if ( pPlayerData.iJob == -1 ) {
                
                local pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpUnemployed" );
                
                foreach ( ii , iv in pMessages ) {
                
                    if ( ii == 0 ) {
                    
                        MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
                    
                    } else {
                        
                        MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
                    
                    }
                
                }
                
            } else {
            
                local iJobType = GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType;
                
                local pMessages = [];
            
                switch ( iJobType ) {
                
                    case GetJobTypeID ( "Police" ): // Police
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpPolice" );
                        
                        break;
                        
                    case GetJobTypeID ( "Fire" ): // Firefighter
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpFirefighter" );
                    
                        break;  

                    case GetJobTypeID ( "Medical" ): // Medical
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpMedical" );
                    
                        break;
                        
                    case GetJobTypeID ( "Garbage" ): // Garbage
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpGarbage" );
                    
                        break;      

                    case GetJobTypeID ( "Taxi" ): // Taxi
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpTaxi" );
                    
                        break;
                        
                    case GetJobTypeID ( "Bus" ): // Bus
                        
                        pMessages = GetPlayerLocaleMultiMessage ( pPlayer , "JobHelpBus" );
                    
                        break;                  
                
                }
                
                foreach ( ii , iv in pMessages ) {
                
                    if ( ii == 0 ) {
                    
                        MessagePlayer ( iv , pPlayer , GetRGBColour ( "White" ) );
                    
                    } else {
                        
                        MessagePlayer ( iv , pPlayer , GetRGBColour ( "LightGrey" ) );
                    
                    }
                
                }
                
                MessagePlayer ( "You can quit your job with /quitjob" , pPlayer , GetRGBColour ( "LightGrey" ) );
                
            }
            
            return true;
        
        case "cmd":
        case "command":
        
            if ( NumTok ( szParams , " " ) == 2 ) {
            
                local szCommandParam = RemoveSlashesFromCommand ( GetTok ( szParams , " " , 2 ) );
                
                if ( !DoesCommandHandlerExist ( szCommandParam.tolower ( ) ) ) {
                
                    SendPlayerErrorMessage ( pPlayer , "Command not found!" );
                
                    return false;
              
                }
                
                GetCoreTable ( ).Commands.rawget ( szCommandParam.tolower ( ) ) [ "pListener" ] ( pPlayer , szCommandParam.tolower ( ) , false , true );
            
            } else {
            
                SendPlayerSyntaxMessage ( pPlayer , "/Help Command <Command>" );
                
                return false;
            
            }
            
            return false;
        
        case "site":
        case "website":
        
            MessagePlayer ( "== Website ==================================" , pPlayer , GetRGBColour ( "White" ) );
            
            MessagePlayer ( "- Our website is at: www.lilc.us" , pPlayer , GetRGBColour ( "LightGrey" ) );
        
            return true;
            
        case "map":
        case "blip":
        case "blips":
        case "radar":
        case "mapicons":
        case "legend":
        
            MessagePlayer ( "== Map ======================================" , pPlayer , GetRGBColour ( "White" ) );
            
            MessagePlayer ( "D - Vehicle Dealership" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "C - Clothing Store" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "Red Phone - Fire Station" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "Blue Phone - Police Station" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "Green Icon - Hospital" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "Yellow Dot - Job" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "For info on player colours, use '/Help Colours'" , pPlayer , GetRGBColour ( "LightGrey" ) );
        
            return true;

        case "colour":
        case "colours":
        case "col":
        case "color":
        case "colors":
        
            MessagePlayer ( "== Colours ==================================" , pPlayer , GetRGBColour ( "White" ) );
            
            MessagePlayer ( "[#FFFFFF]Civilian" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#0064FF]Police Officer" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#808080]Garbage Collector" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#90C048]Bus Driver" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#FFFF00]Taxi Driver" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#ED4337]Firefighter" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "[#FF8E9D]Paramedic" , pPlayer , GetRGBColour ( "LightGrey" ) );
        
            return true;                
        
        case "rules":
        
            MessagePlayer ( "== Server Rules =============================" , pPlayer , GetRGBColour ( "White" ) );
            
            MessagePlayer ( "- No hacks, cheats, or exploits of any kind!" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- This is not a deathmatch server. Please don't kill randomly." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- No insulting in main chat. Only local chat with /talk or /Shout" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Respect the staff team. They are here to keep the peace." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- We're all here to have fun! Don't be like Kewun and ruin it!" , pPlayer , GetRGBColour ( "LightGrey" ) );
        
            return true;
        
        case "anim":
        case "animation":
        case "animations":
        case "anims":

            MessagePlayer ( "== Animations ===============================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- Wave, Dive, Fall, Walk, Run, AimDown, TalkAnim" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- RaiseGun, Tired, HeadButt, Kick, Punch, Drop" , pPlayer , GetRGBColour ( "LightGrey" ) );        
            MessagePlayer ( "- Aim, Toss, Scratch, Bow, Look1, Look2" , pPlayer , GetRGBColour ( "LightGrey" ) );       
            MessagePlayer ( "- To play an animation, choose an anim above and use /Anim <Name>!" , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Use '/Anim Stop' to stop the animation." , pPlayer , GetRGBColour ( "LightGrey" ) );
            
            return true;
        
        case "pns":
        case "payandspray":

            MessagePlayer ( "== Pay And Spray ============================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- At the pay and spray, you can repair, recolour, or mod your vehicle." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Use /repair to fix your vehicle" , pPlayer , GetRGBColour ( "LightGrey" ) );     
            MessagePlayer ( "- Use /recolour to change the colour! Remember, it's in RGB!" , pPlayer , GetRGBColour ( "LightGrey" ) );      
            MessagePlayer ( "- Use /tuneup to modify your vehicle. Use '/Help Tuneup' for more info." , pPlayer , GetRGBColour ( "LightGrey" ) );
            
            return true;
        
        case "ammu":
        case "ammunation":

            MessagePlayer ( "== Ammunation ===============================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- You can buy weapons at the ammunation." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Use /buygun to buy a weapon, or /buyammo for ammo." , pPlayer , GetRGBColour ( "LightGrey" ) );      
            MessagePlayer ( "- The /gunprices command will tell you the prices." , pPlayer , GetRGBColour ( "LightGrey" ) );    
            
            return true;
        
        case "clothes":
        case "skin":
        case "skins":

            MessagePlayer ( "== Clothing =================================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- You can buy skins from a clothing store." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- To find a clothing store, look for the 'C' icon on your map." , pPlayer , GetRGBColour ( "LightGrey" ) );        
            MessagePlayer ( "- Use /buyskin to buy a new skin. Each skin costs $100." , pPlayer , GetRGBColour ( "LightGrey" ) );   
            MessagePlayer ( "- You can't buy emergency service or prison skins." , pPlayer , GetRGBColour ( "LightGrey" ) );    
            
            return true;
        
        case "dealership":

            MessagePlayer ( "== Vehicle Dealership =======================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- To find the dealership, look for the 'D' icon on your map." , pPlayer , GetRGBColour ( "LightGrey" ) );      
            MessagePlayer ( "- Get in any of the vehicles on the parking lot to get a price. " , pPlayer , GetRGBColour ( "LightGrey" ) );  
            MessagePlayer ( "- Use /buyvehicle to buy a vehicle, and /engine on to drive it." , pPlayer , GetRGBColour ( "LightGrey" ) );   
            MessagePlayer ( "- Drive your vehicle off the parking lot, or you'll lose it!" , pPlayer , GetRGBColour ( "LightGrey" ) );          
            
            return true;

        case "key":
        case "keys":
        case "keybinds":

            MessagePlayer ( "== Keys =====================================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( "- M: Vehicle Engine, K: Vehicle Lights, L: Vehicle Lock" , pPlayer , GetRGBColour ( "LightGrey" ) );       
            MessagePlayer ( "- H: Hydraulics, N: Nitrous Boost" , pPlayer , GetRGBColour ( "LightGrey" ) ); 
            
            return true;    
        
        case "tuneup":

            
            MessagePlayer ( "- You can mod your vehicle with extra stuff at a pay and spray." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- These mods can be engine, brake, hydraulics, or wheel upgrades." , pPlayer , GetRGBColour ( "LightGrey" ) );     
            MessagePlayer ( "- Engine upgrades make your vehicle go faster. Upgrade name: Engine" , pPlayer , GetRGBColour ( "LightGrey" ) );       
            MessagePlayer ( "- Brake upgrades make your car stop faster." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Wheel upgrades can upgrade the wheel traction." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Hydraulics are used to make your car hop/bounce." , pPlayer , GetRGBColour ( "LightGrey" ) );
            MessagePlayer ( "- Upgrade Names: Engine, Wheels, Brakes, Hydraulics" , pPlayer , GetRGBColour ( "White" ) );
            
            return true;
            
        case "bindkeys":
        case "keys":
        
            MessagePlayer ( "== Bindable Keys ============================" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "LightGrey" ) + "Letters (A-Z), Numbers (0-9), NumPad (1-9, like 'NumPad1'), Function Keys (F1-F12)" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "LightGrey" ) + "Ctrl, Alt, Win, Shift, End, Insert, Home, Delete, PageUp, PageDown" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "LightGrey" ) + "Tab, Enter, Backspace, Pause, NumLock, ScrollLock, CapsLock, Escape" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "LightGrey" ) + "LeftClick, RightClick, MiddleClick, WheelUp, WheelDown , LeftRelease, RightRelease, MiddleRelease" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "White" ) + "Key names are case-insensitive, so RightClick, RIGHTCLICK, rightclick will all work." , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "White" ) + "Example: /BindKey F1 /Engine to bind 'F1' to the /Engine command." , pPlayer , GetRGBColour ( "White" ) );
            
            return true;            
            

            
        default:
            
            SendPlayerSyntaxMessage ( pPlayer , "/Help <Category>" );
            MessagePlayer ( GetHexColour ( "White" ) + "Help Categories: " + GetHexColour ( "LightGrey" ) + "Account, Command, Vehicle, Job, Chat, Rules, Website, Anim" , pPlayer , GetRGBColour ( "White" ) );
            MessagePlayer ( GetHexColour ( "LightGrey" ) + "PayAndSpray, Ammunation, Skins, TuneUp, Dealership" , pPlayer , GetRGBColour ( "White" ) );
            
            return true;

    }

    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function SendPlayerCommandInfoMessage ( pPlayer , szDescription , pAliases , szExtraInfo ) {

    local szAliases = "None";
    local pPlayerData = GetPlayerData ( pPlayer );
    
    if ( !DoesCommandHandlerExist ( szCommand ) ) {
    
        SendPlayerErrorMessage ( pPlayer , "Command not found!" );
        
        return false;
        
    }
    
    local pCommandData = GetCoreTable ( ).Commands [ szCommand.tolower ( ) ];

    MessagePlayer ( "== COMMAND INFO ====================================" , pPlayer , GetRGBColour ( "Lime" ) );
    
    MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandInfoHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szDescription , pPlayer , GetRGBColour ( "White" ) );
    
    if ( pAliases.len ( ) > 0 ) {
    
        szAliases = "";
        
        foreach ( ii , iv in pAliases ) {
        
            if ( szAliases.len ( ) == 0 ) {
            
                szAliases = "/" + iv.tolower ( );
            
            } else {
            
                szAliases = szAliases + ", /" + iv.tolower ( );
            
            }
        
        }
    
    }
    
    MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandAliasesHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szAliases , pPlayer , GetRGBColour ( "White" ) );
    
    if ( szExtraInfo != "" ) {
    
        MessagePlayer ( GetColourByType ( "CommandInfoHeader" ) + GetPlayerLocaleMessage ( pPlayer , "CommandExtraInfoHeader" ) + ": " + GetColourByType ( "CommandInfoMessage" ) + szExtraInfo , pPlayer , GetRGBColour ( "White" ) );
    
    }
    
    if ( pCommandData.iStaffFlags != 0 && !HasBitFlag ( pPlayerData.iStaffFlags , pCommandData.iStaffFlags ) ) {
    
        SendPlayerAlertMessage ( pPlayer , "You can't use this command." );
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function CommonVehHelpCommand ( pPlayer , szCommand , szParams ) {

    SendPlayerAlertMessage ( pPlayer , "To buy a vehicle, visit the dealership in Portland." );
    SendPlayerAlertMessage ( pPlayer , "Look for the 'D' icon on your map to find the dealership." );
    SendPlayerAlertMessage ( pPlayer , "Use '/Help Dealership' for more information." );
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function RulesCommand ( pPlayer , szCommand , szParams ) {

    SendPlayerAlertMessage ( pPlayer , "Use '/Help Rules' for a list of rules." );
    
    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CommonSkinHelpCommand ( pPlayer , szCommand , szParams ) {

    SendPlayerAlertMessage ( pPlayer , "To change your skin, buy one from a clothing store." );
    SendPlayerAlertMessage ( pPlayer , "Use '/Help Skin' for information." );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function CommonCMDSHelpCommand ( pPlayer , szCommand , szParams ) {

    SendPlayerAlertMessage ( pPlayer , "Use '/Help' for information and commands." );

    return true;
    
}

// -------------------------------------------------------------------------------------------------

function ShowHelpInformationToPlayer ( pPlayer , iHelpID ) {

    switch ( iHelpID ) {
    
        case 0: // Dealership Information
        
            SendPlayerNormalMessage ( pPlayer , GetHexColour ( "White" ) + "Welcome to the Liberty City Vehicle Dealership!" );
            SendPlayerNormalMessage ( pPlayer , GetHexColour ( "LightGrey" ) + "Just get into a vehicle as driver, for information." );
            SendPlayerNormalMessage ( pPlayer , GetHexColour ( "LightGrey" ) + "Remember, if you buy a vehicle, drive it out of the dealership!" );
            SendPlayerNormalMessage ( pPlayer , GetHexColour ( "LightGrey" ) + "If you don't, the vehicle will be buyable again and you will lose the money!" );
        
            return true;
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------