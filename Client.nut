// -------------------------------------------------------------------------------------------------

function onScriptLoad ( ) {

	print ( "------------------------------------------------------------------------------" );
	print ( "[Client.Core]: Initializing client scripts" );

	bSpawned <- false;

	// Whether to allow class change or not
	bClassChange <- true;
	
	pClanManager <- { bEnabled = false , iTopMemberScrollPosition = 0 , iTopRankScrollPosition = 0 , iTopTurfScrollPosition = 0 , szPage = "General" , pClanRanks = [ ] , pClanMembers = [ ] , pClanTurfs = [ ] };
	
	//BindHydraulicKeys ( );
	//BindVehicleKeys ( );
	
	szServerScript <- "lilc/Server.nut";
	
	bSwimmingKeys <- false;
	
	InitGUI ( );
	
	CallServerFunc ( szServerScript , "ClientReady" , FindLocalPlayer ( ) , clock ( ) );
	
	LeftMouseClickBind <- false;
	RightMouseClickBind <- false;
	MiddleMouseClickBind <- false;
	MouseWheelUpBind <- false;
	MouseWheelDownBind <- false;
	LeftMouseReleaseBind <- false;
	RightMouseReleaseBind <- false;
	MiddleMouseReleaseBind <- false;	
	
}

// -------------------------------------------------------------------------------------------------

function AddCustomBindKey ( iBindKey ) {

	if ( iBindKey >= 0 ) {
		
		BindKey ( iBindKey , BINDTYPE_UP , UseCustomBindKey , iBindKey );
	
	} else {
	
		switch ( iBindKey.tostring ( ) ) {
		
			case "-1":
				LeftMouseClickBind <- true;
				break;

			case "-2":
				RightMouseClickBind <- true;
				break;

			case "-3":
				MiddleMouseClickBind <- true;
				break;

			case "-4":
				MouseWheelUpBind <- true;
				break;

			case "-5":
				MouseWheelDownBind <- true;
				break;
				
			case "-6":
				LeftMouseReleaseBind <- true;
				break;

			case "-7":
				RightMouseReleaseBind <- true;
				break;

			case "-8":
				MiddleMouseReleaseBind <- true;
				break;		
		}
	
	}
	
	print ( "[Client.BindKey]: Added bind key " + iBindKey );

}

// -------------------------------------------------------------------------------------------------

function onClientMouseWheel ( bWheelUp ) {

	if ( bWheelUp ) {
	
		if ( MouseWheelUpBind ) {
		
			UseCustomBindKey ( -4 );
		
		}
	
	} else {

		if ( MouseWheelDownBind ) {
		
			UseCustomBindKey ( -5 );
		
		}
	
	}
	
	HandleClanManagerScrolling ( bWheelUp );	
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function onClientRender ( ) {

	HandleSwimming ( );

}

// -------------------------------------------------------------------------------------------------

function onClientSpawn ( pSpawn ) {
	
	bSpawned <- true;

}

// -------------------------------------------------------------------------------------------------

function onClientDeath ( pKiller , iWeapon , iBodyPart ) {

	bSpawned <- false;

}

// -------------------------------------------------------------------------------------------------

function onClientRequestSpawn ( pSpawn )  {

	return 0;

}

// -------------------------------------------------------------------------------------------------

function onClientRequestClass ( pClass ) {

	if ( !bClassChange ) {
	
		return 0;
	
	}

	return 1;

}

// -------------------------------------------------------------------------------------------------

function onPlayerJoin ( pPlayer ) {
	
	return 0;

}

// -------------------------------------------------------------------------------------------------

function onPlayerPart ( pPlayer , iReason ) {

	return 0;

}

// -------------------------------------------------------------------------------------------------

function onClientKeyStateChange ( iOldKeys , iNewKeys ) {

	if ( iNewKeys & KEY_INCAR_FIRE ) {
	
		CallServerFunc ( szServerScript , "FiretruckHoseSprayStart" , FindLocalPlayer ( ) );
		
	}
	
	if ( iOldKeys & KEY_INCAR_FIRE ) {
	
		CallServerFunc ( szServerScript , "FiretruckHoseSprayStop" , FindLocalPlayer ( ) , time ( ) );
	
	}

}

// -------------------------------------------------------------------------------------------------

function onClientMouseClick ( iButton , bDown , iX , iY ) {

	if ( bDown ) {
	
		switch ( iButton ) {
		
			case 1:
				if ( LeftMouseClickBind ) {
				
					UseCustomBindKey ( -1 );
				
				}
				break;
				
			case 2:
				if ( RightMouseClickBind ) {
				
					UseCustomBindKey ( -2 );
				
				}
				break;	

			case 3:
				if ( MiddleMouseClickBind ) {
				
					UseCustomBindKey ( -3 );
				
				}
				break;			
		
		}
	
	} else {
	
		switch ( iButton ) {
		
			case 1:
				if ( LeftMouseReleaseBind ) {
				
					UseCustomBindKey ( -6 );
				
				}
				break;
				
			case 2:
				if ( RightMouseReleaseBind ) {
				
					UseCustomBindKey ( -7 );
				
				}
				break;	

			case 3:
				if ( MiddleMouseReleaseBind ) {
				
					UseCustomBindKey ( -8 );
				
				}
				break;			
		
		}
	
	}	

}

// -------------------------------------------------------------------------------------------------

function onClientShot ( pPlayer , iWeaponID , iBodyPart ) {
	
	if ( iWeaponID == 2 ) {
	
		CheckTazerShot ( pPlayer );
	
	}
	
	return 1;

}

// -------------------------------------------------------------------------------------------------

function ToggleClassChange ( bState ) {

	bClassChange = bState;

}

// -------------------------------------------------------------------------------------------------

function ConsoleMessage ( szMessage ) {
	
	print ( szMessage );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function EnableMouse ( ) {

	while ( !IsMouseCursorShowing ( ) ) {
	
		ShowMouseCursor ( true );
		
	}	
	
}

// -------------------------------------------------------------------------------------------------

function DisableMouse ( ) {

	while ( IsMouseCursorShowing ( ) ) {
	
		ShowMouseCursor ( false );
	
	}	
	
}

// -------------------------------------------------------------------------------------------------

function ShowHUD ( ) {

	SetHUDEnabled ( true );

}

// -------------------------------------------------------------------------------------------------

function HideHUD ( ) {

	SetHUDEnabled ( false );

}

// -------------------------------------------------------------------------------------------------

function InitGUI ( ) {

	print ( "[Client.GUI]: Initializing all GUI" );

	GUI <- { };

	InitLoginGUI ( );
	InitRegisterGUI ( );
	InitClanGUI	( );
	
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

function InitLoginGUI ( ) {
	
	print ( "[Client.GUI]: Login window INIT" );
	
	GUI.Login <- { };
	
	GUI.Login.Window <- GUIWindow ( VectorScreen ( ScreenWidth / 2 - 150 , ScreenHeight / 2 - 115 ) , ScreenSize ( 300 , 230 ) , "LOGIN" );
	AddGUILayer ( GUI.Login.Window );
	
	GUI.Login.Window.Titlebar = false;
	GUI.Login.Window.Colour = Colour ( 0 , 0 , 0 );
	GUI.Login.Window.Transparent = true;
	GUI.Login.Window.Moveable = false;
	GUI.Login.Window.Alpha = 200;
	
	GUI.Login.TitleLogo <- GUISprite ( "logo1.png" , VectorScreen ( 0 , 0 ) );
	AddGUILayer ( GUI.Login.TitleLogo );
	GUI.Login.TitleLogo.Visible = false;	
	
	GUI.Login.TitleLabel <- GUILabel ( VectorScreen ( 150 , 60 ) , ScreenSize ( 260 , 20 ) , "LOGIN" );
	GUI.Login.TitleLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
	GUI.Login.TitleLabel.TextColour = Colour ( 180 , 180 , 180 );
	GUI.Login.TitleLabel.FontTags = TAG_BOLD;
	GUI.Login.TitleLabel.FontSize = 14;	
	
	GUI.Login.ErrorLabel <- GUILabel ( VectorScreen ( 150 , 85 ) , ScreenSize ( 260 , 20 ) , "TEST" );
	GUI.Login.ErrorLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
	GUI.Login.ErrorLabel.TextColour = Colour ( 180 , 32 , 32 );
	GUI.Login.ErrorLabel.FontTags = TAG_BOLD;
	GUI.Login.ErrorLabel.FontSize = 9;
	GUI.Login.ErrorLabel.Visible = false;
	
	//GUI.Login.EmailLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Email" );
	//GUI.Login.EmailLabel.TextAlignment = ALIGN_TOP_LEFT;
	//GUI.Login.EmailLabel.TextColour = Colour ( 225 , 225 , 225 );
	//GUI.Login.EmailLabel.FontSize = 10;

	GUI.Login.PasswordLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Password" );
	GUI.Login.PasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Login.PasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Login.PasswordLabel.FontSize = 10;

	//GUI.Login.EmailInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
	//GUI.Login.EmailInput.Colour = Colour ( 64 , 64 , 64 );
	//GUI.Login.EmailInput.TextColour = Colour ( 225 , 225 , 225 );
	//GUI.Login.EmailInput.FontSize = 10;
	//GUI.Login.EmailInput.FontName = "Arial";

	GUI.Login.PasswordInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
	GUI.Login.PasswordInput.Colour = Colour ( 64 , 64 , 64 );
	GUI.Login.PasswordInput.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Login.PasswordInput.MaskInput = true;
	GUI.Login.PasswordInput.FontSize = 10;	
	GUI.Login.PasswordInput.FontName = "Arial";	
	
	GUI.Login.LoginButton <- GUIButton ( VectorScreen ( 20 , 165 ) , ScreenSize ( 260 , 30 ) , "Login" );
	GUI.Login.LoginButton.Colour = Colour ( 32 , 32 , 32 );
	GUI.Login.LoginButton.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Login.LoginButton.FontSize = 10;	
	GUI.Login.LoginButton.FontName = "Arial";
	GUI.Login.LoginButton.FontTags = TAG_BOLD;
	GUI.Login.LoginButton.SetCallbackFunc ( CheckLogin );
	
	GUI.Login.NotRegisteredLabel <- GUILabel ( VectorScreen ( 70 , 207 ) , ScreenSize ( 185 , 20 ) , "Don't have an account?" );
	GUI.Login.NotRegisteredLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Login.NotRegisteredLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Login.NotRegisteredLabel.FontSize = 10;
	
	GUI.Login.RegisterButton <- GUIButton ( VectorScreen ( 215 , 205 ) , ScreenSize ( 65 , 25 ) , "Register" );
	GUI.Login.RegisterButton.Colour = Colour ( 32 , 32 , 32 );
	GUI.Login.RegisterButton.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Login.RegisterButton.FontSize = 9;	
	GUI.Login.RegisterButton.FontName = "Arial";	
	GUI.Login.RegisterButton.FontTags = TAG_BOLD;
	GUI.Login.RegisterButton.SetCallbackFunc ( ShowRegister );
	
	GUI.Login.Window.AddChild ( GUI.Login.TitleLogo );
	GUI.Login.Window.AddChild ( GUI.Login.TitleLabel );
	GUI.Login.Window.AddChild ( GUI.Login.ErrorLabel );
	//GUI.Login.Window.AddChild ( GUI.Login.EmailLabel );
	GUI.Login.Window.AddChild ( GUI.Login.PasswordLabel );
	//GUI.Login.Window.AddChild ( GUI.Login.EmailInput );
	GUI.Login.Window.AddChild ( GUI.Login.PasswordInput );
	GUI.Login.Window.AddChild ( GUI.Login.NotRegisteredLabel );
	GUI.Login.Window.AddChild ( GUI.Login.LoginButton );
	GUI.Login.Window.AddChild ( GUI.Login.RegisterButton );

	GUI.Login.Window.Visible = false;
	
	print ( "[Client.GUI]: Login window DONE" );

}

// -------------------------------------------------------------------------------------------------

function ShowLogin ( ) {

	HideAllGUI ( );

	print ( "[Client.GUI]: Showing login" );
	
	GUI.Login.Window.Visible = true;
	GUI.Login.TitleLogo.Visible = true;	
	
	EnableMouse ( );

}

// -------------------------------------------------------------------------------------------------

function CheckLogin ( ) {
	
	print ( "[Client.Server]: Checking login" );
	
	CallServerFunc ( szServerScript , "CheckLoginFromGUI" , FindLocalPlayer ( ) , GUI.Login.PasswordInput.Text );
	
}

// -------------------------------------------------------------------------------------------------

function LoginFailed ( szErrorText = "" ) {
	
	HideAllGUI ( );
	
	if ( szErrorText != "" ) {
		
		GUI.Login.ErrorLabel.Text = szErrorText;
		GUI.Login.ErrorLabel.Visible = true;
	
	}
	
	ShowLogin ( );
	
}

// -------------------------------------------------------------------------------------------------

function LoginSuccess ( ) {
	
	HideAllGUI ( );
	
}

// -------------------------------------------------------------------------------------------------

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
	
	EnableMouse ( );

}

// -------------------------------------------------------------------------------------------------

function ToggleClanManager ( ) {
	
	if ( !GUI.Clan.Window.Visible ) {
	
		HideAllGUI ( );
		
		GUI.Clan.Window.Visible = true;
		ShowClanGeneral ( );	

		EnableMouse ( );
		
	} else {
	
		HideAllGUI ( );
	
	}
	
}

// -------------------------------------------------------------------------------------------------

function ShowClanMembers ( ) {

	ClanManager.Page = "Members";

	HideClanGeneral ( );
	HideClanRanks ( );
	HideClanTurfs ( );

	foreach ( ii , iv in GUI.Clan.Members.HeaderRow ) {
	
		iv.Visible = true;
		
	}
	
	local i = ClanManager.TopMemberScrollPosition;
	
	foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
		
		iv [ 0 ].Text = ClanMembers [ i ].szName;
		iv [ 1 ].Text = ClanMembers [ i ].szRank;
		iv [ 2 ].Text = ClanMembers [ i ].szLastOnline;
		
		iv [ 0 ].Visible = true;
		iv [ 1 ].Visible = true;
		iv [ 2 ].Visible = true;
		
		i++;
		
	}	

}

// -------------------------------------------------------------------------------------------------

function ShowClanRanks ( ) {

	ClanManager.Page = "Ranks";

	HideClanGeneral ( );
	HideClanMembers ( );
	HideClanTurfs ( );

	foreach ( ii , iv in GUI.Clan.Ranks.HeaderRow ) {
	
		iv.Visible = true;
		
	}
	
	local i = ClanManager.TopRankScrollPosition;
	
	foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
		
		Message ( "CLAN " + ClanRanks [ i ].szName );
		
		iv [ 0 ].Text = ClanRanks [ i ].szName;
		iv [ 0 ].Visible = true;
		
		if ( i < ClanRanks.len ( ) ) {

			iv [ 1 ].Visible = true;
		
		}
		
		i++;
		
	}	

}

// -------------------------------------------------------------------------------------------------

function ShowClanTurfs ( ) {

	Message ( "TURFS" );
	ClanManager.Page = "Turfs";

	HideClanGeneral ( );
	HideClanMembers ( );
	HideClanRanks ( );

	foreach ( ii , iv in GUI.Clan.Turfs.HeaderRow ) {
	
		iv.Visible = true;
		
	}
	
	local i = ClanManager.TopRankScrollPosition;
	
	foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
		
		iv [ 0 ].Text = ClanTurfs [ i ].szName;
		
		iv [ 0 ].Visible = true;
		iv [ 1 ].Visible = true;
		
		i++;
		
	}	

}

// -------------------------------------------------------------------------------------------------

function ShowClanGeneral ( ) {

	ClanManager.Page = "General";
	ClanManager.TopMemberScrollPosition = 0;
	
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

function HideHUD ( ) {

	SetHUDEnabled ( false );

}

// -------------------------------------------------------------------------------------------------

function ScrollClanMembersUp ( ) {
	
	if ( ClanManager.TopMemberScrollPosition > 0 ) {
		
		ClanManager.TopMemberScrollPosition--;
		
		local i = ClanManager.TopMemberScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
			
			iv [ 0 ].Text = ClanMembers [ i ].szName;
			iv [ 1 ].Text = ClanMembers [ i ].szRank;
			iv [ 2 ].Text = ClanMembers [ i ].szLastOnline;
			
			i++;
			
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanMembersDown ( ) {

	if ( ( ClanManager.TopMemberScrollPosition + 12 ) < ClanMembers.len ( ) ) {
	
		ClanManager.TopMemberScrollPosition += 1;
		
		local i = ClanManager.TopMemberScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Members.DataRows ) {
			
			iv [ 0 ].Text = ClanMembers [ i ].szName;
			iv [ 1 ].Text = ClanMembers [ i ].szRank;
			iv [ 2 ].Text = ClanMembers [ i ].szLastOnline;
			
			i++;
			
		}
	
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanTurfsUp ( ) {
	
	if ( ClanManager.TopTurfScrollPosition > 0 ) {
		
		ClanManager.TopTurfScrollPosition--;
		
		local i = ClanManager.TopTurfScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
			
			iv [ 0 ].Text = ClanTurfs [ i ].szName;
			iv [ 2 ].Text = ClanTurfs [ i ].szOwner;
			
			i++;
			
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanTurfsDown ( ) {

	if ( ( ClanManager.TopTurfScrollPosition + 12 ) < ClanTurfs.len ( ) ) {
	
		ClanManager.TopTurfScrollPosition += 1;
		
		local i = ClanManager.TopTurfScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Turfs.DataRows ) {
			
			iv [ 0 ].Text = ClanTurfs [ i ].szName;
			
			i++;
			
		}
	
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanRanksUp ( ) {
	
	if ( ClanManager.TopRankScrollPosition > 0 ) {
		
		ClanManager.TopRankScrollPosition--;
		
		local i = ClanManager.TopRankScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
			
			iv [ 0 ].Text = ClanRanks [ i ].szName;
			
			i++;
			
		}
	
	}
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function ScrollClanRanksDown ( ) {

	if ( ( ClanManager.TopRankScrollPosition + 12 ) < ClanRanks.len ( ) ) {
	
		ClanManager.TopRankScrollPosition += 1;
		
		local i = ClanManager.TopRankScrollPosition;
		
		foreach ( ii , iv in GUI.Clan.Ranks.DataRows ) {
			
			iv [ 0 ].Text = ClanRanks [ i ].szName;
			
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

// -------------------------------------------------------------------------------------------------

function InitRegisterGUI ( ) {

	print ( "[Client.GUI]: Registration window INIT" );

	GUI.Register <- { };
	
	GUI.Register.Window <- GUIWindow ( VectorScreen ( ScreenWidth / 2 - 150 , ScreenHeight / 2 - 170 ) , ScreenSize ( 300 , 340 ) , "CREATE ACCOUNT" );
	AddGUILayer ( GUI.Register.Window );
	GUI.Register.Window.Titlebar = false;
	GUI.Register.Window.Colour = Colour ( 0 , 0 , 0 );
	GUI.Register.Window.Transparent = true;
	GUI.Register.Window.Moveable = false;
	GUI.Register.Window.Alpha = 200;
	
	GUI.Register.TitleLogo <- GUISprite ( "logo1.png" , VectorScreen ( 0 , 0 ) );
	AddGUILayer ( GUI.Register.TitleLogo );
	GUI.Register.TitleLogo.Visible = false;
	
	GUI.Register.TitleLabel <- GUILabel ( VectorScreen ( 150 , 60 ) , ScreenSize ( 260 , 20 ) , "CREATE ACCOUNT" );
	GUI.Register.TitleLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
	GUI.Register.TitleLabel.TextColour = Colour ( 180 , 180 , 180 );
	GUI.Register.TitleLabel.FontTags = TAG_BOLD;
	GUI.Register.TitleLabel.FontSize = 14;	
	
	GUI.Register.ErrorLabel <- GUILabel ( VectorScreen ( 150 , 85 ) , ScreenSize ( 260 , 20 ) , "TEST" );
	GUI.Register.ErrorLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
	GUI.Register.ErrorLabel.TextColour = Colour ( 180 , 32 , 32 );
	GUI.Register.ErrorLabel.FontTags = TAG_BOLD;
	GUI.Register.ErrorLabel.FontSize = 9;
	GUI.Register.ErrorLabel.Visible = false;	
	
	GUI.Register.EmailLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Email" );
	GUI.Register.EmailLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Register.EmailLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.EmailLabel.FontSize = 10;

	GUI.Register.PasswordLabel <- GUILabel ( VectorScreen ( 20 , 160 ) , ScreenSize ( 260 , 20 ) , "Password" );
	GUI.Register.PasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Register.PasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.PasswordLabel.FontSize = 10;	
	
	GUI.Register.ConfirmPasswordLabel <- GUILabel ( VectorScreen ( 20 , 220 ) , ScreenSize ( 260 , 20 ) , "Confirm Password" );
	GUI.Register.ConfirmPasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Register.ConfirmPasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.ConfirmPasswordLabel.FontSize = 10;	

	GUI.Register.EmailInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
	GUI.Register.EmailInput.Colour = Colour ( 64 , 64 , 64 );
	GUI.Register.EmailInput.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.EmailInput.FontSize = 10;
	GUI.Register.EmailInput.FontName = "Arial";

	GUI.Register.PasswordInput <- GUIEditbox ( VectorScreen ( 20 , 180 ) , ScreenSize ( 260 , 25 ) );
	GUI.Register.PasswordInput.Colour = Colour ( 64 , 64 , 64 );
	GUI.Register.PasswordInput.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.PasswordInput.MaskInput = true;
	GUI.Register.PasswordInput.FontSize = 10;	
	GUI.Register.PasswordInput.FontName = "Arial";
	
	GUI.Register.ConfirmPasswordInput <- GUIEditbox ( VectorScreen ( 20 , 240 ) , ScreenSize ( 260 , 30 ) );
	GUI.Register.ConfirmPasswordInput.Colour = Colour ( 64 , 64 , 64 );
	GUI.Register.ConfirmPasswordInput.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.ConfirmPasswordInput.MaskInput = true;
	GUI.Register.ConfirmPasswordInput.FontSize = 10;	
	GUI.Register.ConfirmPasswordInput.FontName = "Arial";		
	
	GUI.Register.RegisterButton <- GUIButton ( VectorScreen ( 20 , 285 ) , ScreenSize ( 260 , 30 ) , "Create Account" );
	GUI.Register.RegisterButton.Colour = Colour ( 32 , 32 , 32 );
	GUI.Register.RegisterButton.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.RegisterButton.FontSize = 10;	
	GUI.Register.RegisterButton.FontName = "Arial";
	GUI.Register.RegisterButton.FontTags = TAG_BOLD;
	GUI.Register.RegisterButton.SetCallbackFunc ( CheckRegister );
	
	GUI.Register.AlreadyRegisteredLabel <- GUILabel ( VectorScreen ( 100 , 327 ) , ScreenSize ( 240 , 20 ) , "Already registered?" );
	GUI.Register.AlreadyRegisteredLabel.TextAlignment = ALIGN_TOP_LEFT;
	GUI.Register.AlreadyRegisteredLabel.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.AlreadyRegisteredLabel.FontSize = 10;
	
	GUI.Register.LoginButton <- GUIButton ( VectorScreen ( 220 , 325 ) , ScreenSize ( 60 , 25 ) , "Login" );
	GUI.Register.LoginButton.Colour = Colour ( 32 , 32 , 32 );
	GUI.Register.LoginButton.TextColour = Colour ( 225 , 225 , 225 );
	GUI.Register.LoginButton.FontSize = 9;	
	GUI.Register.LoginButton.FontName = "Arial";	
	GUI.Register.LoginButton.FontTags = TAG_BOLD;
	GUI.Register.LoginButton.SetCallbackFunc ( ShowLogin );

	GUI.Register.Window.AddChild ( GUI.Register.TitleLogo );
	GUI.Register.Window.AddChild ( GUI.Register.TitleLabel );
	GUI.Register.Window.AddChild ( GUI.Register.ErrorLabel );
	GUI.Register.Window.AddChild ( GUI.Register.EmailLabel );
	GUI.Register.Window.AddChild ( GUI.Register.PasswordLabel );
	GUI.Register.Window.AddChild ( GUI.Register.ConfirmPasswordLabel );
	GUI.Register.Window.AddChild ( GUI.Register.EmailInput );
	GUI.Register.Window.AddChild ( GUI.Register.PasswordInput );
	GUI.Register.Window.AddChild ( GUI.Register.ConfirmPasswordInput );
	GUI.Register.Window.AddChild ( GUI.Register.AlreadyRegisteredLabel );
	GUI.Register.Window.AddChild ( GUI.Register.LoginButton );
	GUI.Register.Window.AddChild ( GUI.Register.RegisterButton );

	GUI.Register.Window.Visible = false;	
	
	print ( "[Client.GUI]: Registration window DONE" );
	
}

// -------------------------------------------------------------------------------------------------

function RegisterFailed ( szErrorText = "" ) {
	
	HideAllGUI ( );
	
	if ( szErrorText != "" ) {
		
		GUI.Register.ErrorLabel.Text = szErrorText;
		GUI.Register.ErrorLabel.Visible = true;
		
	}
	
	ShowRegister ( );
	
}

// -------------------------------------------------------------------------------------------------

function RegisterSuccess ( ) {
	
	HideAllGUI ( );
	
}

// -------------------------------------------------------------------------------------------------

function CheckRegister ( ) {
	
	print ( "[Client.Server]: Checking registration" );
	
	CallServerFunc ( szServerScript , "CheckRegisterFromGUI" , FindLocalPlayer ( ) , GUI.Register.EmailInput.Text , GUI.Register.PasswordInput.Text , GUI.Register.ConfirmPasswordInput.Text );
	
}

// -------------------------------------------------------------------------------------------------

function ShowRegister ( ) {

	HideAllGUI ( );

	print ( "[Client.GUI]: Showing registration" );
	
	GUI.Register.Window.Visible = true;
	GUI.Register.TitleLogo.Visible = true;
	
	EnableMouse ( );

}

// -------------------------------------------------------------------------------------------------

function ServerRequestingVerification ( ) {

	CallServerFunc ( szServerScript , "SendServerVerification" , FindLocalPlayer ( ) , time ( ) );
	
}

// -------------------------------------------------------------------------------------------------

function ServerRequestingScreenInfo ( ) {

	SendScreenInfoToServer ( );
	
}

// -------------------------------------------------------------------------------------------------

function SendScreenInfoToServer ( ) {

	CallServerFunc ( szServerScript , "ReceiveScreenInfoFromClient" , FindLocalPlayer ( ) , ScreenWidth , ScreenHeight );

	return true;

}

// -------------------------------------------------------------------------------------------------

function HandleSwimming ( ) {

	if ( bSpawned ) {

		if ( IsClientSwimming ( ) ) {
		
			if ( !bSwimmingKeys ) {
			
				BindSwimmingKeys ( );
			
			}
		
		} else {
		
			if ( bSwimmingKeys ) {
			
				UnbindSwimmingKeys ( );
			
			}
		
		}
		
	}
	
}

// -------------------------------------------------------------------------------------------------

function IsClientSwimming ( ) {

	if ( GetGroundZLevel == 0 ) {
	
		return true;
	
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function BindSwimmingKeys ( ) {

	bSwimmingKeys <- true;

}

// -------------------------------------------------------------------------------------------------

function UnbindSwimmingKeys ( ) {

	bSwimmingKeys <- false;

}

// -------------------------------------------------------------------------------------------------

function CheckTazerShot ( pShooter ) {

	CallServerFunc ( szServerScript , "CheckTazerShot" , FindLocalPlayer ( ) , pShooter );

}

// -------------------------------------------------------------------------------------------------

function HydraulicsDown ( ) {

	CallServerFunc ( szServerScript , "HydraulicsDown" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function HydraulicsUp ( ) {

	CallServerFunc ( szServerScript , "HydraulicsUp" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function HydraulicsLock ( ) {

	CallServerFunc ( szServerScript , "HydraulicsLock" , FindLocalPlayer ( ) );

}

// -------------------------------------------------------------------------------------------------

function BindHydraulicsKeys ( ) {

	BindKey ( 'H' , BINDTYPE_DOWN , HydraulicsUp );
	BindKey ( 'H' , BINDTYPE_UP , HydraulicsDown );

}

// -------------------------------------------------------------------------------------------------

function UnbindHydraulicsKeys ( ) {

	UnbindKey ( 'H' );
	UnbindKey ( 'H' );
	
}

// -------------------------------------------------------------------------------------------------

function UseCustomBindKey ( iBindKey ) {

	print ( "[Client.BindKey]: Using bind key " + iBindKey );

	CallServerFunc ( szServerScript , "UseCustomBindKey" , FindLocalPlayer ( ) , iBindKey );
	
	return true;

}