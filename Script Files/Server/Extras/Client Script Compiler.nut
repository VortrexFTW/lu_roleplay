function CompileClientScripts ( ) {

    local cClientFile = loadfile ( "Scripts/lilc-client/Client.nut" , true );
    writeclosuretofile ( "Scripts/lilc-client/Client.cnut" , cClientFile );
    
    return true;

}