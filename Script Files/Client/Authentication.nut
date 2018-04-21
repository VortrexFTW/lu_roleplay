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