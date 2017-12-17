function UpdateGameTimeTimerFunction ( ) {

	if ( GetUtilityConfiguration ( ).bUseRealTime ) {
	
		SetTime ( date ( ).hour , date ( ).min );
		
		return true;
	
	}

	if ( !GetUtilityConfiguration ( ).bTimeForward ) {
	
		if ( GetUtilityConfiguration ( ).iTimeMinute > 0 ) { 
		
			GetUtilityConfiguration ( ).iTimeMinute = GetUtilityConfiguration ( ).iTimeMinute - GetUtilityConfiguration ( ).iTimeMinuteIncrement; 
			
			
		} else {
		
			GetUtilityConfiguration ( ).iTimeMinute = 59;
			
			if ( GetUtilityConfiguration ( ).iTimeHour > 0 ) {
			
				GetUtilityConfiguration ( ).iTimeHour = GetUtilityConfiguration ( ).iTimeHour - GetUtilityConfiguration ( ).iTimeHourIncrement;
				
			} else {
			
				GetUtilityConfiguration ( ).iTimeHour = 23;
				
			}
			
		}
	
	} else {
	
		if ( GetUtilityConfiguration ( ).iTimeMinute < 59 ) { 
		
			GetUtilityConfiguration ( ).iTimeMinute = GetUtilityConfiguration ( ).iTimeMinute + GetUtilityConfiguration ( ).iTimeMinuteIncrement; 
			
			
		} else {
		
			GetUtilityConfiguration ( ).iTimeMinute = 0;
			
			if ( GetUtilityConfiguration ( ).iTimeHour < 23 ) {
			
				GetUtilityConfiguration ( ).iTimeHour = GetUtilityConfiguration ( ).iTimeHour + GetUtilityConfiguration ( ).iTimeHourIncrement;
				
			} else {
			
				GetUtilityConfiguration ( ).iTimeHour = 0;
				
			}
			
		}

	}
	
    
    SetTime ( GetUtilityConfiguration ( ).iTimeHour , GetUtilityConfiguration ( ).iTimeMinute );
	
	return true;

}

function ChangeTimeUpdateSpeedCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( bShowHelpOnly ) {
	
		SendPlayerCommandInfoMessage ( pPlayer , "Allows a developer to set the time change speed." , [ "TimeSpeed" ] , "" );
		
		return false;
	
	}
	
	if( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/TimeSpeed <Interval>" );
		
		return false;
	
	}
	
	if( !IsNum ( szParams ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "The interval must be a number!" );
		
		return false;
	
	}
	
	return true;

}

function SetNewTime ( iHour , iMinute ) {

	GetUtilityConfiguration ( ).iTimeHour = iHour;
	GetUtilityConfiguration ( ).iTimeMinute = iTimeMinute;

	return true;

}