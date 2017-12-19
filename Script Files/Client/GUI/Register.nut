// -------------------------------------------------------------------------------------------------

function InitRegisterGUI ( ) {

    print ( "[Client.GUI]: Registration window INIT" );

    GUI.Register <- { };
    
    pRegisterGUI.Window <- GUIWindow ( VectorScreen ( ScreenWidth / 2 - 150 , ScreenHeight / 2 - 170 ) , ScreenSize ( 300 , 340 ) , "CREATE ACCOUNT" );
    AddGUILayer ( pRegisterGUI.Window );
    pRegisterGUI.Window.Titlebar = false;
    pRegisterGUI.Window.Colour = Colour ( 0 , 0 , 0 );
    pRegisterGUI.Window.Transparent = true;
    pRegisterGUI.Window.Moveable = false;
    pRegisterGUI.Window.Alpha = 200;
    
    pRegisterGUI.TitleLogo <- GUISprite ( "logo1.png" , VectorScreen ( 0 , 0 ) );
    AddGUILayer ( pRegisterGUI.TitleLogo );
    pRegisterGUI.TitleLogo.Visible = false;
    
    pRegisterGUI.TitleLabel <- GUILabel ( VectorScreen ( 150 , 60 ) , ScreenSize ( 260 , 20 ) , "CREATE ACCOUNT" );
    pRegisterGUI.TitleLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
    pRegisterGUI.TitleLabel.TextColour = Colour ( 180 , 180 , 180 );
    pRegisterGUI.TitleLabel.FontTags = TAG_BOLD;
    pRegisterGUI.TitleLabel.FontSize = 14;  
    
    pRegisterGUI.ErrorLabel <- GUILabel ( VectorScreen ( 150 , 85 ) , ScreenSize ( 260 , 20 ) , "TEST" );
    pRegisterGUI.ErrorLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
    pRegisterGUI.ErrorLabel.TextColour = Colour ( 180 , 32 , 32 );
    pRegisterGUI.ErrorLabel.FontTags = TAG_BOLD;
    pRegisterGUI.ErrorLabel.FontSize = 9;
    pRegisterGUI.ErrorLabel.Visible = false;    
    
    pRegisterGUI.EmailLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Email" );
    pRegisterGUI.EmailLabel.TextAlignment = ALIGN_TOP_LEFT;
    pRegisterGUI.EmailLabel.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.EmailLabel.FontSize = 10;

    pRegisterGUI.PasswordLabel <- GUILabel ( VectorScreen ( 20 , 160 ) , ScreenSize ( 260 , 20 ) , "Password" );
    pRegisterGUI.PasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
    pRegisterGUI.PasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.PasswordLabel.FontSize = 10;   
    
    pRegisterGUI.ConfirmPasswordLabel <- GUILabel ( VectorScreen ( 20 , 220 ) , ScreenSize ( 260 , 20 ) , "Confirm Password" );
    pRegisterGUI.ConfirmPasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
    pRegisterGUI.ConfirmPasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.ConfirmPasswordLabel.FontSize = 10;    

    pRegisterGUI.EmailInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
    pRegisterGUI.EmailInput.Colour = Colour ( 64 , 64 , 64 );
    pRegisterGUI.EmailInput.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.EmailInput.FontSize = 10;
    pRegisterGUI.EmailInput.FontName = "Arial";

    pRegisterGUI.PasswordInput <- GUIEditbox ( VectorScreen ( 20 , 180 ) , ScreenSize ( 260 , 25 ) );
    pRegisterGUI.PasswordInput.Colour = Colour ( 64 , 64 , 64 );
    pRegisterGUI.PasswordInput.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.PasswordInput.MaskInput = true;
    pRegisterGUI.PasswordInput.FontSize = 10;   
    pRegisterGUI.PasswordInput.FontName = "Arial";
    
    pRegisterGUI.ConfirmPasswordInput <- GUIEditbox ( VectorScreen ( 20 , 240 ) , ScreenSize ( 260 , 30 ) );
    pRegisterGUI.ConfirmPasswordInput.Colour = Colour ( 64 , 64 , 64 );
    pRegisterGUI.ConfirmPasswordInput.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.ConfirmPasswordInput.MaskInput = true;
    pRegisterGUI.ConfirmPasswordInput.FontSize = 10;    
    pRegisterGUI.ConfirmPasswordInput.FontName = "Arial";       
    
    pRegisterGUI.RegisterButton <- GUIButton ( VectorScreen ( 20 , 285 ) , ScreenSize ( 260 , 30 ) , "Create Account" );
    pRegisterGUI.RegisterButton.Colour = Colour ( 32 , 32 , 32 );
    pRegisterGUI.RegisterButton.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.RegisterButton.FontSize = 10;  
    pRegisterGUI.RegisterButton.FontName = "Arial";
    pRegisterGUI.RegisterButton.FontTags = TAG_BOLD;
    pRegisterGUI.RegisterButton.SetCallbackFunc ( CheckRegister );
    
    pRegisterGUI.AlreadyRegisteredLabel <- GUILabel ( VectorScreen ( 100 , 327 ) , ScreenSize ( 240 , 20 ) , "Already registered?" );
    pRegisterGUI.AlreadyRegisteredLabel.TextAlignment = ALIGN_TOP_LEFT;
    pRegisterGUI.AlreadyRegisteredLabel.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.AlreadyRegisteredLabel.FontSize = 10;
    
    pRegisterGUI.LoginButton <- GUIButton ( VectorScreen ( 220 , 325 ) , ScreenSize ( 60 , 25 ) , "Login" );
    pRegisterGUI.LoginButton.Colour = Colour ( 32 , 32 , 32 );
    pRegisterGUI.LoginButton.TextColour = Colour ( 225 , 225 , 225 );
    pRegisterGUI.LoginButton.FontSize = 9;  
    pRegisterGUI.LoginButton.FontName = "Arial";    
    pRegisterGUI.LoginButton.FontTags = TAG_BOLD;
    pRegisterGUI.LoginButton.SetCallbackFunc ( ShowLogin );

    pRegisterGUI.Window.AddChild ( pRegisterGUI.TitleLogo );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.TitleLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.ErrorLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.EmailLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.PasswordLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.ConfirmPasswordLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.EmailInput );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.PasswordInput );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.ConfirmPasswordInput );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.AlreadyRegisteredLabel );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.LoginButton );
    pRegisterGUI.Window.AddChild ( pRegisterGUI.RegisterButton );

    pRegisterGUI.Window.Visible = false;    
    
    print ( "[Client.GUI]: Registration window DONE" );
	
	return pRegisterGUI;
    
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