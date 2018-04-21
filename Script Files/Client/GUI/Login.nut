// -------------------------------------------------------------------------------------------------

function InitLoginGUI ( ) {
    
    print ( "[Client.GUI]: Login window INIT" );
    
    local pLoginGUI <- { };
    
    pLoginGUI.Window <- GUIWindow ( VectorScreen ( ScreenWidth / 2 - 150 , ScreenHeight / 2 - 115 ) , ScreenSize ( 300 , 230 ) , "LOGIN" );
    AddGUILayer ( pLoginGUI.Window );
    
    pLoginGUI.Window.Titlebar = false;
    pLoginGUI.Window.Colour = Colour ( 0 , 0 , 0 );
    pLoginGUI.Window.Transparent = true;
    pLoginGUI.Window.Moveable = false;
    pLoginGUI.Window.Alpha = 200;
    
    pLoginGUI.TitleLogo <- GUISprite ( "logo1.png" , VectorScreen ( 0 , 0 ) );
    AddGUILayer ( pLoginGUI.TitleLogo );
    pLoginGUI.TitleLogo.Visible = false;    
    
    pLoginGUI.TitleLabel <- GUILabel ( VectorScreen ( 150 , 60 ) , ScreenSize ( 260 , 20 ) , "LOGIN" );
    pLoginGUI.TitleLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
    pLoginGUI.TitleLabel.TextColour = Colour ( 180 , 180 , 180 );
    pLoginGUI.TitleLabel.FontTags = TAG_BOLD;
    pLoginGUI.TitleLabel.FontSize = 14; 
    
    pLoginGUI.ErrorLabel <- GUILabel ( VectorScreen ( 150 , 85 ) , ScreenSize ( 260 , 20 ) , "TEST" );
    pLoginGUI.ErrorLabel.TextAlignment = ALIGN_MIDDLE_CENTER;
    pLoginGUI.ErrorLabel.TextColour = Colour ( 180 , 32 , 32 );
    pLoginGUI.ErrorLabel.FontTags = TAG_BOLD;
    pLoginGUI.ErrorLabel.FontSize = 9;
    pLoginGUI.ErrorLabel.Visible = false;
    
    //pLoginGUI.EmailLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Email" );
    //pLoginGUI.EmailLabel.TextAlignment = ALIGN_TOP_LEFT;
    //pLoginGUI.EmailLabel.TextColour = Colour ( 225 , 225 , 225 );
    //pLoginGUI.EmailLabel.FontSize = 10;

    pLoginGUI.PasswordLabel <- GUILabel ( VectorScreen ( 20 , 100 ) , ScreenSize ( 260 , 20 ) , "Password" );
    pLoginGUI.PasswordLabel.TextAlignment = ALIGN_TOP_LEFT;
    pLoginGUI.PasswordLabel.TextColour = Colour ( 225 , 225 , 225 );
    pLoginGUI.PasswordLabel.FontSize = 10;

    //pLoginGUI.EmailInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
    //pLoginGUI.EmailInput.Colour = Colour ( 64 , 64 , 64 );
    //pLoginGUI.EmailInput.TextColour = Colour ( 225 , 225 , 225 );
    //pLoginGUI.EmailInput.FontSize = 10;
    //pLoginGUI.EmailInput.FontName = "Arial";

    pLoginGUI.PasswordInput <- GUIEditbox ( VectorScreen ( 20 , 120 ) , ScreenSize ( 260 , 25 ) );
    pLoginGUI.PasswordInput.Colour = Colour ( 64 , 64 , 64 );
    pLoginGUI.PasswordInput.TextColour = Colour ( 225 , 225 , 225 );
    pLoginGUI.PasswordInput.MaskInput = true;
    pLoginGUI.PasswordInput.FontSize = 10;  
    pLoginGUI.PasswordInput.FontName = "Arial"; 
    
    pLoginGUI.LoginButton <- GUIButton ( VectorScreen ( 20 , 165 ) , ScreenSize ( 260 , 30 ) , "Login" );
    pLoginGUI.LoginButton.Colour = Colour ( 32 , 32 , 32 );
    pLoginGUI.LoginButton.TextColour = Colour ( 225 , 225 , 225 );
    pLoginGUI.LoginButton.FontSize = 10;    
    pLoginGUI.LoginButton.FontName = "Arial";
    pLoginGUI.LoginButton.FontTags = TAG_BOLD;
    pLoginGUI.LoginButton.SetCallbackFunc ( CheckLogin );
    
    pLoginGUI.NotRegisteredLabel <- GUILabel ( VectorScreen ( 70 , 207 ) , ScreenSize ( 185 , 20 ) , "Don't have an account?" );
    pLoginGUI.NotRegisteredLabel.TextAlignment = ALIGN_TOP_LEFT;
    pLoginGUI.NotRegisteredLabel.TextColour = Colour ( 225 , 225 , 225 );
    pLoginGUI.NotRegisteredLabel.FontSize = 10;
    
    pLoginGUI.RegisterButton <- GUIButton ( VectorScreen ( 215 , 205 ) , ScreenSize ( 65 , 25 ) , "Register" );
    pLoginGUI.RegisterButton.Colour = Colour ( 32 , 32 , 32 );
    pLoginGUI.RegisterButton.TextColour = Colour ( 225 , 225 , 225 );
    pLoginGUI.RegisterButton.FontSize = 9;  
    pLoginGUI.RegisterButton.FontName = "Arial";    
    pLoginGUI.RegisterButton.FontTags = TAG_BOLD;
    pLoginGUI.RegisterButton.SetCallbackFunc ( ShowRegister );
    
    pLoginGUI.Window.AddChild ( pLoginGUI.TitleLogo );
    pLoginGUI.Window.AddChild ( pLoginGUI.TitleLabel );
    pLoginGUI.Window.AddChild ( pLoginGUI.ErrorLabel );
    //pLoginGUI.Window.AddChild ( pLoginGUI.EmailLabel );
    pLoginGUI.Window.AddChild ( pLoginGUI.PasswordLabel );
    //pLoginGUI.Window.AddChild ( pLoginGUI.EmailInput );
    pLoginGUI.Window.AddChild ( pLoginGUI.PasswordInput );
    pLoginGUI.Window.AddChild ( pLoginGUI.NotRegisteredLabel );
    pLoginGUI.Window.AddChild ( pLoginGUI.LoginButton );
    pLoginGUI.Window.AddChild ( pLoginGUI.RegisterButton );

    pLoginGUI.Window.Visible = false;
    
    print ( "[Client.GUI]: Login window DONE" );
    
    return pLoginGUI;

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