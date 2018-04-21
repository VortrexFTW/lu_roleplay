// -------------------------------------------------------------------------------------------------

function InitClanGUI ( ) {

    print ( "[Client.GUI]: Clan manager INIT" );

    GUI.Clan <- { };
    
    GUI.Clan.Window <- GUIWindow ( VectorScreen ( ScreenWidth / 2 - 150 , ScreenHeight / 2 - 170 ) , ScreenSize ( 365 , 340 ) , "Clan Manager" );
    GUI.Clan.Window.Colour = Colour ( 0 , 0 , 0 );
    GUI.Clan.Window.Transparent = true;
    GUI.Clan.Window.Alpha = 200;
    
    GUI.Clan.MainMenu <- { };
    
    GUI.Clan.MainMenu.GeneralButton <- GUIButton ( VectorScreen ( 5 , 5 ) , ScreenSize ( 85 , 20 ) , "General" );
    GUI.Clan.MainMenu.GeneralButton.Colour = Colour ( 32 , 32 , 32 );
    GUI.Clan.MainMenu.GeneralButton.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.MainMenu.GeneralButton.FontSize = 8;   
    GUI.Clan.MainMenu.GeneralButton.FontName = "Arial";     
    GUI.Clan.MainMenu.GeneralButton.FontTags = TAG_BOLD;
    GUI.Clan.MainMenu.GeneralButton.SetCallbackFunc ( ShowClanGeneral );
    
    GUI.Clan.MainMenu.MembersButton <- GUIButton ( VectorScreen ( 95 , 5 ) , ScreenSize ( 85 , 20 ) , "Members" );
    GUI.Clan.MainMenu.MembersButton.Colour = Colour ( 32 , 32 , 32 );
    GUI.Clan.MainMenu.MembersButton.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.MainMenu.MembersButton.FontSize = 8;   
    GUI.Clan.MainMenu.MembersButton.FontName = "Arial"; 
    GUI.Clan.MainMenu.MembersButton.FontTags = TAG_BOLD;
    GUI.Clan.MainMenu.MembersButton.SetCallbackFunc ( ShowClanMembers );
    
    GUI.Clan.MainMenu.RanksButton <- GUIButton ( VectorScreen ( 185 , 5 ) , ScreenSize ( 85 , 20 ) , "Ranks" );
    GUI.Clan.MainMenu.RanksButton.Colour = Colour ( 32 , 32 , 32 );
    GUI.Clan.MainMenu.RanksButton.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.MainMenu.RanksButton.FontSize = 8; 
    GUI.Clan.MainMenu.RanksButton.FontName = "Arial";   
    GUI.Clan.MainMenu.RanksButton.FontTags = TAG_BOLD;
    GUI.Clan.MainMenu.RanksButton.SetCallbackFunc ( ShowClanRanks );
    
    GUI.Clan.MainMenu.TurfsButton <- GUIButton ( VectorScreen ( 275 , 5 ) , ScreenSize ( 85 , 20 ) , "Turfs" );
    GUI.Clan.MainMenu.TurfsButton.Colour = Colour ( 32 , 32 , 32 );
    GUI.Clan.MainMenu.TurfsButton.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.MainMenu.TurfsButton.FontSize = 8; 
    GUI.Clan.MainMenu.TurfsButton.FontName = "Arial";   
    GUI.Clan.MainMenu.TurfsButton.FontTags = TAG_BOLD;
    GUI.Clan.MainMenu.TurfsButton.SetCallbackFunc ( ShowClanTurfs );
    
    GUI.Clan.General <- { };
    
    GUI.Clan.General.ClanNameLabel <- GUILabel ( VectorScreen ( 10 , 35 ) , ScreenSize ( 60 , 20 ) , "Clan Name" );
    GUI.Clan.General.ClanNameLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanNameLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanNameLabel.FontSize = 10;
    
    GUI.Clan.General.ClanName <- GUILabel ( VectorScreen ( 10 , 50 ) , ScreenSize ( 120 , 20 ) , "ARSEnic's Secret Society" );
    GUI.Clan.General.ClanName.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanName.FontSize = 9;

    GUI.Clan.General.ClanTagLabel <- GUILabel ( VectorScreen ( 250 , 35 ) , ScreenSize ( 60 , 20 ) , "Tag" );
    GUI.Clan.General.ClanTagLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanTagLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanTagLabel.FontSize = 10;
    
    GUI.Clan.General.ClanTag <- GUILabel ( VectorScreen ( 250 , 50 ) , ScreenSize ( 120 , 20 ) , "[ASS]" );
    GUI.Clan.General.ClanTag.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanTag.FontSize = 9;

    // --------------------

    GUI.Clan.General.ClanCreatedLabel <- GUILabel ( VectorScreen ( 10 , 80 ) , ScreenSize ( 60 , 20 ) , "Created On" );
    GUI.Clan.General.ClanCreatedLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanCreatedLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanCreatedLabel.FontSize = 10;
    
    GUI.Clan.General.ClanCreated <- GUILabel ( VectorScreen ( 10 , 95 ) , ScreenSize ( 120 , 20 ) , "November 30, 2017" );
    GUI.Clan.General.ClanCreated.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanCreated.FontSize = 9;

    GUI.Clan.General.ClanBankLabel <- GUILabel ( VectorScreen ( 250 , 80 ) , ScreenSize ( 60 , 20 ) , "Bank" );
    GUI.Clan.General.ClanBankLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanBankLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanBankLabel.FontSize = 10;
    
    GUI.Clan.General.ClanBank <- GUILabel ( VectorScreen ( 250 , 95 ) , ScreenSize ( 120 , 20 ) , "$ 30,232" );
    GUI.Clan.General.ClanBank.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanBank.FontSize = 9;

    // --------------------
    
    GUI.Clan.General.ClanOwnerLabel <- GUILabel ( VectorScreen ( 10 , 125 ) , ScreenSize ( 60 , 20 ) , "Owner" );
    GUI.Clan.General.ClanOwnerLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanOwnerLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanOwnerLabel.FontSize = 10;

    GUI.Clan.General.ClanOwner <- GUILabel ( VectorScreen ( 10 , 140 ) , ScreenSize ( 120 , 20 ) , "ARSEnic" );
    GUI.Clan.General.ClanOwner.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanOwner.FontSize = 9;    
    
    GUI.Clan.General.ClanTurfCountLabel <- GUILabel ( VectorScreen ( 250 , 125 ) , ScreenSize ( 60 , 20 ) , "Turfs" );
    GUI.Clan.General.ClanTurfCountLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanTurfCountLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanTurfCountLabel.FontSize = 10;
    
    GUI.Clan.General.ClanTurfCount <- GUILabel ( VectorScreen ( 250 , 140 ) , ScreenSize ( 120 , 20 ) , "4/15" );
    GUI.Clan.General.ClanTurfCount.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanTurfCount.FontSize = 9;    
    
    // --------------------
    
    GUI.Clan.General.ClanMemberCountLabel <- GUILabel ( VectorScreen ( 10 , 170 ) , ScreenSize ( 60 , 20 ) , "Members" );
    GUI.Clan.General.ClanMemberCountLabel.FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.General.ClanMemberCountLabel.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanMemberCountLabel.FontSize = 10;
    
    GUI.Clan.General.ClanMemberCount <- GUILabel ( VectorScreen ( 10 , 185 ) , ScreenSize ( 120 , 20 ) , "6" );
    GUI.Clan.General.ClanMemberCount.TextColour = Colour ( 225 , 225 , 225 );
    GUI.Clan.General.ClanMemberCount.FontSize = 9;

    // --------------------
    
    GUI.Clan.Members <- { };
    GUI.Clan.Members.Elements <- { };
    GUI.Clan.Members.HeaderRow <- { };
    GUI.Clan.Members.DataRows <- { };
    
    GUI.Clan.Members.HeaderRow [ 0 ] <- GUILabel ( VectorScreen ( 50 , 50 ) , ScreenSize ( 100 , 15 ) , "Name" );
    GUI.Clan.Members.HeaderRow [ 0 ].FontSize = 9;
    GUI.Clan.Members.HeaderRow [ 0 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Members.HeaderRow [ 0 ].TextAlignment = ALIGN_TOP_CENTER;
    GUI.Clan.Members.HeaderRow [ 0 ].TextColour = Colour ( 225 , 225 , 225 );

    GUI.Clan.Members.HeaderRow [ 1 ] <- GUILabel ( VectorScreen ( 175 , 50 ) , ScreenSize ( 100 , 15 ) , "Rank" );
    GUI.Clan.Members.HeaderRow [ 1 ].FontSize = 9;
    GUI.Clan.Members.HeaderRow [ 1 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Members.HeaderRow [ 1 ].TextAlignment = ALIGN_TOP_CENTER;  
    GUI.Clan.Members.HeaderRow [ 1 ].TextColour = Colour ( 225 , 225 , 225 );
    
    GUI.Clan.Members.HeaderRow [ 2 ] <- GUILabel ( VectorScreen ( 300 , 50 ) , ScreenSize ( 100 , 15 ) , "Last Online" );
    GUI.Clan.Members.HeaderRow [ 2 ].FontSize = 9;
    GUI.Clan.Members.HeaderRow [ 2 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Members.HeaderRow [ 2 ].TextAlignment = ALIGN_TOP_CENTER;  
    GUI.Clan.Members.HeaderRow [ 2 ].TextColour = Colour ( 225 , 225 , 225 );
    
    // --------------
    
    local iTop = 80;
    for( local i = 0 ; i <= 12 ; i++ ) {
    
        GUI.Clan.Members.DataRows [ i ] <- { };
        
        GUI.Clan.Members.DataRows [ i ] [ 0 ] <- GUILabel ( VectorScreen ( 50 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Members.DataRows [ i ] [ 0 ].FontSize = 9;
        GUI.Clan.Members.DataRows [ i ] [ 0 ].TextAlignment = ALIGN_MIDDLE_CENTER;
        GUI.Clan.Members.DataRows [ i ] [ 0 ].TextColour = Colour ( 225 , 225 , 225 );

        GUI.Clan.Members.DataRows [ i ] [ 1 ] <- GUILabel ( VectorScreen ( 175 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Members.DataRows [ i ] [ 1 ].FontSize = 9;
        GUI.Clan.Members.DataRows [ i ] [ 1 ].TextAlignment = ALIGN_MIDDLE_CENTER;  
        GUI.Clan.Members.DataRows [ i ] [ 1 ].TextColour = Colour ( 225 , 225 , 225 );
        
        GUI.Clan.Members.DataRows [ i ] [ 2 ] <- GUILabel ( VectorScreen ( 300 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Members.DataRows [ i ] [ 2 ].FontSize = 9;
        GUI.Clan.Members.DataRows [ i ] [ 2 ].TextAlignment = ALIGN_MIDDLE_CENTER;  
        GUI.Clan.Members.DataRows [ i ] [ 2 ].TextColour = Colour ( 225 , 225 , 225 );  
        
        iTop += 20;
        
    }
    
    GUI.Clan.Ranks <- { };
    GUI.Clan.Ranks.Elements <- { };
    GUI.Clan.Ranks.HeaderRow <- { };
    GUI.Clan.Ranks.DataRows <- { };
    
    GUI.Clan.Ranks.HeaderRow [ 0 ] <- GUILabel ( VectorScreen ( 50 , 50 ) , ScreenSize ( 200 , 15 ) , "Name" );
    GUI.Clan.Ranks.HeaderRow [ 0 ].FontSize = 9;
    GUI.Clan.Ranks.HeaderRow [ 0 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Ranks.HeaderRow [ 0 ].TextAlignment = ALIGN_TOP_CENTER;
    GUI.Clan.Ranks.HeaderRow [ 0 ].TextColour = Colour ( 225 , 225 , 225 );

    GUI.Clan.Ranks.HeaderRow [ 1 ] <- GUILabel ( VectorScreen ( 175 , 50 ) , ScreenSize ( 200 , 15 ) , "Actions" );
    GUI.Clan.Ranks.HeaderRow [ 1 ].FontSize = 9;
    GUI.Clan.Ranks.HeaderRow [ 1 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Ranks.HeaderRow [ 1 ].TextAlignment = ALIGN_TOP_CENTER;    
    GUI.Clan.Ranks.HeaderRow [ 1 ].TextColour = Colour ( 225 , 225 , 225 );
    
    local iTop = 80;
    for( local i = 0 ; i <= 12 ; i++ ) {
        GUI.Clan.Ranks.DataRows [ i ] <- { };
        
        GUI.Clan.Ranks.DataRows [ i ] [ 0 ] <- GUILabel ( VectorScreen ( 50 , iTop ) , ScreenSize ( 200 , 15 ) , "Test" );
        GUI.Clan.Ranks.DataRows [ i ] [ 0 ].FontSize = 9;
        GUI.Clan.Ranks.DataRows [ i ] [ 0 ].TextAlignment = ALIGN_MIDDLE_CENTER;
        GUI.Clan.Ranks.DataRows [ i ] [ 0 ].TextColour = Colour ( 225 , 225 , 225 );
        
        GUI.Clan.Ranks.DataRows [ i ] [ 2 ] <- GUIButton ( VectorScreen ( 300 , iTop ) , ScreenSize ( 100 , 15 ) , "Edit" );
        GUI.Clan.Ranks.DataRows [ i ] [ 2 ].FontSize = 9;
        GUI.Clan.Ranks.DataRows [ i ] [ 2 ].Colour = Colour ( 32 , 32 , 32 );
        GUI.Clan.Ranks.DataRows [ i ] [ 2 ].TextColour = Colour ( 225 , 225 , 225 );    
        
        iTop += 20;
    }   
    
    GUI.Clan.Turfs <- { };
    GUI.Clan.Turfs.Elements <- { };
    GUI.Clan.Turfs.HeaderRow <- { };
    GUI.Clan.Turfs.DataRows <- { };
    
    GUI.Clan.Turfs.HeaderRow [ 0 ] <- GUILabel ( VectorScreen ( 50 , 50 ) , ScreenSize ( 100 , 15 ) , "Name" );
    GUI.Clan.Turfs.HeaderRow [ 0 ].FontSize = 9;
    GUI.Clan.Turfs.HeaderRow [ 0 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Turfs.HeaderRow [ 0 ].TextAlignment = ALIGN_TOP_CENTER;
    GUI.Clan.Turfs.HeaderRow [ 0 ].TextColour = Colour ( 225 , 225 , 225 );

    GUI.Clan.Turfs.HeaderRow [ 1 ] <- GUILabel ( VectorScreen ( 175 , 50 ) , ScreenSize ( 100 , 15 ) , "Owner" );
    GUI.Clan.Turfs.HeaderRow [ 1 ].FontSize = 9;
    GUI.Clan.Turfs.HeaderRow [ 1 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Turfs.HeaderRow [ 1 ].TextAlignment = ALIGN_TOP_CENTER;    
    GUI.Clan.Turfs.HeaderRow [ 1 ].TextColour = Colour ( 225 , 225 , 225 );
    
    GUI.Clan.Turfs.HeaderRow [ 2 ] <- GUILabel ( VectorScreen ( 300 , 50 ) , ScreenSize ( 100 , 15 ) , "Last Turf War" );
    GUI.Clan.Turfs.HeaderRow [ 2 ].FontSize = 9;
    GUI.Clan.Turfs.HeaderRow [ 2 ].FontTags = TAG_BOLD|TAG_UNDERLINE;
    GUI.Clan.Turfs.HeaderRow [ 2 ].TextAlignment = ALIGN_TOP_CENTER;    
    GUI.Clan.Turfs.HeaderRow [ 2 ].TextColour = Colour ( 225 , 225 , 225 ); 
    
    local iTop = 80;
    for( local i = 0 ; i <= 12 ; i++ ) {
    
        GUI.Clan.Turfs.DataRows [ i ] <- { };
        
        GUI.Clan.Turfs.DataRows [ i ] [ 0 ] <- GUILabel ( VectorScreen ( 50 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Turfs.DataRows [ i ] [ 0 ].FontSize = 9;
        GUI.Clan.Turfs.DataRows [ i ] [ 0 ].TextAlignment = ALIGN_MIDDLE_CENTER;
        GUI.Clan.Turfs.DataRows [ i ] [ 0 ].TextColour = Colour ( 225 , 225 , 225 );

        GUI.Clan.Turfs.DataRows [ i ] [ 1 ] <- GUILabel ( VectorScreen ( 175 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Turfs.DataRows [ i ] [ 1 ].FontSize = 9;
        GUI.Clan.Turfs.DataRows [ i ] [ 1 ].TextAlignment = ALIGN_MIDDLE_CENTER;    
        GUI.Clan.Turfs.DataRows [ i ] [ 1 ].TextColour = Colour ( 225 , 225 , 225 );
        
        GUI.Clan.Turfs.DataRows [ i ] [ 2 ] <- GUILabel ( VectorScreen ( 300 , iTop ) , ScreenSize ( 100 , 15 ) , "" );
        GUI.Clan.Turfs.DataRows [ i ] [ 2 ].FontSize = 9;
        GUI.Clan.Turfs.DataRows [ i ] [ 2 ].TextAlignment = ALIGN_MIDDLE_CENTER;    
        GUI.Clan.Turfs.DataRows [ i ] [ 2 ].TextColour = Colour ( 225 , 225 , 225 );    
        
        iTop += 20;
        
    }       
    
    // --------------------
        
    GUI.Clan.Window.Visible = false;
    GUI.Clan.Window.AddChild ( GUI.Clan.MainMenu.GeneralButton );
    GUI.Clan.Window.AddChild ( GUI.Clan.MainMenu.MembersButton );
    GUI.Clan.Window.AddChild ( GUI.Clan.MainMenu.RanksButton );
    GUI.Clan.Window.AddChild ( GUI.Clan.MainMenu.TurfsButton );
    
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanNameLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanName );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanTagLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanTag );  
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanOwnerLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanOwner );    
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanMemberCountLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanMemberCount );  
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanTurfCountLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanTurfCount );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanCreatedLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanCreated );      
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanBankLabel );
    GUI.Clan.Window.AddChild ( GUI.Clan.General.ClanBank );     
    //GUI.Clan.Window.AddChild ( GUI.Clan.General.Logo );

    foreach ( ii , iv in GUI.Clan.Members.HeaderRow ) {
    
        GUI.Clan.Window.AddChild ( iv );
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Ranks.HeaderRow ) {
    
        GUI.Clan.Window.AddChild ( iv );
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Turfs.HeaderRow ) {
    
        GUI.Clan.Window.AddChild ( iv );
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            GUI.Clan.Window.AddChild ( jv );
            jv.Visible = false;
        
        }
        
    }

    foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            GUI.Clan.Window.AddChild ( jv );
            jv.Visible = false;
        
        }
        
    }   
    
    foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            GUI.Clan.Window.AddChild ( jv );
            jv.Visible = false;
        
        }
        
    }   
    
    GUI.Clan.Window.Visible = false;
    
    AddGUILayer ( GUI.Clan.Window );    
    
    print ( "[Client.GUI]: Clan manager DONE" );
    
}

// -------------------------------------------------------------------------------------------------

function ShowClanGUI ( ) {

    print ( "[Client.GUI]: Showing clan manager" );
    
    GUI.Clan.Window.Visible = true;
    ShowClanGeneral ( );    
    
    EnableMouse ( );

}

// -------------------------------------------------------------------------------------------------

function ToggleClanManager ( ) {
    
    if ( !GUI.Clan.Window.Visible ) {
    
        ShowClanGUI ( );
        
    } else {
    
        HideAllGUI ( );
    
    }
    
}

// -------------------------------------------------------------------------------------------------

function ShowClanMembers ( ) {

    print ( "[Client.Clan]: Showing clan members" );

    ClanManager.szPage = "Members";

    HideClanGeneral ( );
    HideClanRanks ( );
    HideClanTurfs ( );

    foreach ( ii , iv in GUI.Clan.Members.HeaderRow ) {
    
        iv.Visible = true;
        
    }
    
    local i = ClanManager.iTopMemberScrollPosition;
    
    foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
        
        iv [ 0 ].Text = ClanManager.pClanMembers [ i ].szName;
        iv [ 1 ].Text = ClanManager.pClanMembers [ i ].szRank;
        iv [ 2 ].Text = ClanManager.pClanMembers [ i ].szLastOnline;
        
        iv [ 0 ].Visible = true;
        iv [ 1 ].Visible = true;
        iv [ 2 ].Visible = true;
        
        i++;
        
    }   

}

// -------------------------------------------------------------------------------------------------

function ShowClanRanks ( ) {

    print ( "[Client.Clan]: Showing clan ranks" );

    ClanManager.szPage = "Ranks";

    HideClanGeneral ( );
    HideClanMembers ( );
    HideClanTurfs ( );

    foreach ( ii , iv in GUI.Clan.Ranks.HeaderRow ) {
    
        iv.Visible = true;
        
    }
    
    local i = ClanManager.iTopRankScrollPosition;
    
    foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
        
        iv [ 0 ].Text = ClanManager.pClanRanks [ i ].szName;
        iv [ 0 ].Visible = true;
        
        if ( i < ClanManager.pClanRanks.len ( ) ) {

            iv [ 1 ].Visible = true;
        
        }
        
        i++;
        
    }   

}

// -------------------------------------------------------------------------------------------------

function ShowClanTurfs ( ) {

    print ( "[Client.Clan]: Showing clan turfs" );

    ClanManager.szPage = "Turfs";

    HideClanGeneral ( );
    HideClanMembers ( );
    HideClanRanks ( );

    foreach ( ii , iv in GUI.Clan.Turfs.HeaderRow ) {
    
        iv.Visible = true;
        
    }
    
    local i = ClanManager.iTopRankScrollPosition;
    
    foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
        
        iv [ 0 ].Text = ClanManager.pClanTurfs [ i ].szName;
        
        iv [ 0 ].Visible = true;
        iv [ 1 ].Visible = true;
        
        i++;
        
    }   

}

// -------------------------------------------------------------------------------------------------

function ShowClanGeneral ( ) {

    ClanManager.szPage = "General";
    ClanManager.iTopMemberScrollPosition = 0;
    
    HideClanMembers ( );
    HideClanRanks ( );  
    HideClanTurfs ( );  
    
    foreach ( ii , iv in GUI.Clan.General ) {
        
        iv.Visible = true;
    
    }
    
}

// -------------------------------------------------------------------------------------------------

function HideClanGeneral ( ) {
    
    foreach ( ii , iv in GUI.Clan.General ) {
        
        iv.Visible = false;
    
    }
    
}

// -------------------------------------------------------------------------------------------------

function HideClanMembers ( ) {
    
    foreach ( ii , iv in GUI.Clan.Members.HeaderRow ) {
    
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            jv.Visible = false;
        
        }
        
    }   

}

// -------------------------------------------------------------------------------------------------

function HideClanRanks ( ) {

    foreach ( ii , iv in GUI.Clan.Ranks.HeaderRow ) {
    
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            jv.Visible = false;
        
        }
        
    }   

}

// -------------------------------------------------------------------------------------------------

function HideClanTurfs ( ) {

    foreach ( ii , iv in GUI.Clan.Turfs.HeaderRow ) {
    
        iv.Visible = false;
        
    }
    
    foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
    
        foreach ( ji , jv in iv ) {
        
            jv.Visible = false;
        
        }
        
    }   

}
// -------------------------------------------------------------------------------------------------

function ScrollClanMembersUp ( ) {
    
    if ( ClanManager.iTopMemberScrollPosition > 0 ) {
        
        ClanManager.iTopMemberScrollPosition--;
        
        local i = ClanManager.iTopMemberScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanMembers [ i ].szName;
            iv [ 1 ].Text = ClanManager.pClanMembers [ i ].szRank;
            iv [ 2 ].Text = ClanManager.pClanMembers [ i ].szLastOnline;
            
            i++;
            
        }
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanMembersDown ( ) {

    if ( ( ClanManager.iTopMemberScrollPosition + 12 ) < ClanManager.pClanMembers.len ( ) ) {
    
        ClanManager.iTopMemberScrollPosition += 1;
        
        local i = ClanManager.iTopMemberScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanMembers [ i ].szName;
            iv [ 1 ].Text = ClanManager.pClanMembers [ i ].szRank;
            iv [ 2 ].Text = ClanManager.pClanMembers [ i ].szLastOnline;
            
            i++;
            
        }
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanTurfsUp ( ) {
    
    if ( ClanManager.iTopTurfScrollPosition > 0 ) {
        
        ClanManager.iTopTurfScrollPosition--;
        
        local i = ClanManager.iTopTurfScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanTurfs [ i ].szName;
            iv [ 2 ].Text = ClanManager.pClanTurfs [ i ].szOwner;
            
            i++;
            
        }
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanTurfsDown ( ) {

    if ( ( ClanManager.iTopTurfScrollPosition + 12 ) < ClanManager.pClanTurfs.len ( ) ) {
    
        ClanManager.iTopTurfScrollPosition += 1;
        
        local i = ClanManager.iTopTurfScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanTurfs [ i ].szName;
            
            i++;
            
        }
    
    }

    return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanRanksUp ( ) {
    
    if ( ClanManager.TopRankScrollPosition > 0 ) {
        
        ClanManager.iTopRankScrollPosition--;
        
        local i = ClanManager.iTopRankScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanRanks [ i ].szName;
            
            i++;
            
        }
    
    }
    
    return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanRanksDown ( ) {

    if ( ( ClanManager.iTopRankScrollPosition + 12 ) < ClanManager.pClanRanks.len ( ) ) {
    
        ClanManager.iTopRankScrollPosition += 1;
        
        local i = ClanManager.iTopRankScrollPosition;
        
        foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
            
            iv [ 0 ].Text = ClanManager.pClanRanks [ i ].szName;
            
            i++;
            
        }
    
    }

    return true;

}

function HandleClanManagerScrolling ( bWheelUp ) {

    if ( ClanManager.Enabled ) {
    
        switch ( ClanManager.Page.tolower ( ) ) {
        
            case "members":
                
                if ( bWheelUp ) {
                    
                    ScrollClanMembersUp ( );
                
                } else {
                    
                    ScrollClanMembersDown ( );
                
                }
                
                break;
                
            case "ranks":
                
                if ( bWheelUp ) {
                    
                    ScrollClanRanksUp ( );
                
                } else {
                    
                    ScrollClanRanksDown ( );
                
                }
                
                break;  

            case "turfs":
                
                if ( bWheelUp ) {
                    
                    ScrollClanTurfsUp ( );
                
                } else {
                    
                    ScrollClanTurfsDown ( );
                
                }
                
                break;                      
                
            default:
                break;
        
        }
    
    }

}