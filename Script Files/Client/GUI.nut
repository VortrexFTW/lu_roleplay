// -------------------------------------------------------------------------------------------------

function InitGUI ( ) {

    print ( "[Client.GUI]: Initializing all GUI" );

    GUI <- { };

    GUI.Login <- InitLoginGUI ( );
    GUI.Register <- InitRegisterGUI ( );
    GUI.ClanManager <- InitClanGUI ( );
    
    print ( "[Client.GUI]: All GUI initialized" );
    
    CallServerFunc ( szServerScript , "LoadedAllGUI" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function HideAllGUI ( ) {
    
    print ( "[Client.GUI]: Hiding all GUI" );
    
    // Register
    GUI.Register.Window.Visible = false;
    GUI.Register.TitleLogo.Visible = false;
    
    // Login
    GUI.Login.Window.Visible = false;
    GUI.Login.TitleLogo.Visible = false;
    
    // Clan Manager
    GUI.Clan.Window.Visible = false;
    
    DisableMouse ( );
    
    print ( "[Client.GUI]: All GUI hidden" );

}

// -------------------------------------------------------------------------------------------------