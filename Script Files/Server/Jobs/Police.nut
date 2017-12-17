// -------------------------------------------------------------------------------------------------

function InitPoliceJobScript ( ) {

	AddPoliceJobCommandHandlers ( );
	
	print ( "[Server.Jobs.Police]: Script init complete." );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function AddPoliceJobCommandHandlers ( ) {

	AddCommandHandler ( "Arrest" 				, PoliceArrestCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Cuff" 					, PoliceCuffCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Uncuff" 				, PoliceUncuffCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Tazer" 				, PoliceTazerCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Duty" 					, PoliceDutyCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Drag" 					, PoliceDragCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "StopDrag" 				, PoliceStopDragCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Detain" 				, PoliceDetainCommand 				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Uniform" 				, PoliceUniformCommand 				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Equip" 				, PoliceEquipCommand 				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Equipment" 			, PoliceEquipCommand 				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "PoliceRadio" 			, PoliceRadioCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "PR" 					, PoliceRadioCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "R" 					, PoliceRadioCommand				, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "Radio" 				, PoliceRadioCommand 				, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "Megaphone" 			, PoliceMegaphoneCommand			, GetStaffFlagValue ( "None" ) );
	AddCommandHandler ( "M" 					, PoliceMegaphoneCommand			, GetStaffFlagValue ( "None" ) );
	
	AddCommandHandler ( "PublicPolice"			, TogglePublicPoliceJob				, GetStaffFlagValue ( "ManageServer" ) );
	
	print ( "[Server.Jobs.Police]: Command handlers added." );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function PoliceArrestCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Arrest <Player Name/ID>" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , GetPlayerLocaleMessage ( pPlayer , "PlayerNotFound" ) );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't arrest yourself!" );
	
		return false;
	
	}	
	
	if ( !IsPlayerAtPoliceStation ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be at a police station!" );

		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetCoreTable ( ).Utilities.fArrestRange ) {
	
		SendPlayerErrorMessage ( pPlayer , "You must be near the suspect!" );

		return false;
	
	}
	
	ArrestPlayer ( pTarget );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceCuffCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Cuff <Player Name/ID>" );
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "Could not find that player!" );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't cuff yourself!" );
	
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetUtilityConfiguration ( ).fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " is too far away!" );
		
		return false;
	
	}
	
	CuffPlayer ( pTarget );
	
	SendPlayerSuccessMessage ( pPlayer , "You have hand-cuffed " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , "You have been hand-cuffed by " + pPlayer.Name );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceUncuffCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Uncuff <Player Name/ID>" );
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "Could not find that player!" );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't uncuff yourself!" );
	
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetUtilityConfiguration ( ).fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " is too far away!" );
		
		return false;
	
	}
	
	UncuffPlayer ( pTarget );
	
	SendPlayerSuccessMessage ( pPlayer , "You have removed the handcuffs from " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , "Your handcuffs have been removed by " + pPlayer.Name );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceDutyCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceDragCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {
	
	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't drag somebody from inside a vehicle!" );
	
		return false;	
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Drag <Player Name/ID>" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "Could not find that player!" );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't drag yourself!" );
	
		return false;
	
	}
	
	if ( pPlayerData.pDragging != false ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are already dragging somebody!" );
	
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetUtilityConfiguration ( ).fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " is too far away!" );
		
		return false;
	
	}
	
	if ( pTarget.Vehicle ) {
	
		pTarget.RemoveFromVehicle ( );
	
	}
	
	GetPlayerData ( pPlayer ).pDragging = pTarget;
	
	SendPlayerSuccessMessage ( pPlayer , "You are now dragging " + pTarget.Name );
	SendPlayerAlertMessage ( pTarget , "You are being dragged by " + pPlayer.Name );
	
	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceStopDragCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( pPlayer.Vehicle ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this from inside a vehicle!" );
	
		return false;	
	
	}
	
	if ( !pPlayerData.pDragging ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not dragging anybody!" );
		
		return false;
	
	}
	
	SendPlayerSuccessMessage ( pPlayer , "You are no longer dragging " + pPlayerData.pDragging.Name );
	SendPlayerAlertMessage ( pPlayerData.pDragging , "You are no longer being dragged by " + pPlayer.Name );
	
	pPlayerData.pDragging = false;

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceDetainCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Detain <Player Name/ID>" );
		
		return false;
	
	}
	
	local pTarget = FindPlayer ( szParams );
	
	if ( !pTarget ) {
	
		SendPlayerErrorMessage ( pPlayer , "Could not find that player!" );
		
		return false;
	
	}
	
	if ( pPlayer.ID == pTarget.ID ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't detain yourself!" );
	
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , pTarget.Pos ) > GetUtilityConfiguration ( ).fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , pTarget.Name + " is too far away!" );
		
		return false;
	
	}
	
	if ( GetDistance ( pPlayer.Pos , GetClosestVehicle ( pPlayer ).Pos ) > GetUtilityConfiguration ( ).fCuffRange ) {
	
		SendPlayerErrorMessage ( pPlayer , "The vehicle is too far away!" );
		
		return false;
	
	}	
	
	GetPlayerData ( pTarget ).pEnteringVehicleNormally = GetClosestVehicle ( pPlayer );
	pTarget.Vehicle = GetClosestVehicle ( pPlayer );
	pTarget.VehicleSeat = 3;
	pTarget.Frozen = true;
	
	SendPlayerSuccessMessage ( pPlayer , "You have detained " + pTarget.Name + " to your vehicle" );
	SendPlayerAlertMessage ( pTarget , "You have been detained to a vehicle by " + pPlayer.Name );	

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceMegaphoneCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/Megaphone <Message>" );
		
		return false;
	
	}
	
	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	foreach ( ii , iv in GetPlayersInRange ( pPlayer.Pos , 35.0 ) ) {
	
		if ( iv.Spawned ) {
		
			if ( IsPlayerPoliceOfficer ( iv ) ) {
		
				MessagePlayer ( GetHexColour ( "Orange" ) + "[MEGAPHONE] - " + pPlayer.Name + ": " + GetHexColour ( "White" ) + szParams , iv , GetRGBColour( "White" ) );
				
			}
		
		}
		
	}

	return true;

}

// -------------------------------------------------------------------------------------------------

function PoliceRadioCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !szParams ) {
	
		SendPlayerSyntaxMessage ( pPlayer , "/PoliceRadio <Message>" );
		
		return false;
	
	}
	
	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}  

	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	foreach ( ii , iv in GetConnectedPlayers ( ) ) {
	
		if ( iv.Spawned ) {
		
			if ( IsPlayerPoliceOfficer ( iv ) ) {
		
				MessagePlayer ( GetHexColour ( "LightBlue" ) + "[POLICE RADIO] - " + pPlayer.Name + ": " + GetHexColour ( "White" ) + szParams , iv , GetRGBColour( "White" ) );
				
			}
		
		}
		
	}
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function PoliceUniformCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function PoliceEquipCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false  ) {

	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You are not a police officer!" );
		
		return false;
	
	}

	return true;
	
}

// -------------------------------------------------------------------------------------------------

function IsPlayerPoliceOfficer ( pPlayer ) {

	local pPlayerData = GetPlayerData ( pPlayer );
	
	if ( DoesPlayerHaveAJob ( pPlayer ) ) {
	
		if ( GetCoreTable ( ).Jobs [ pPlayerData.iJob ].iJobType == GetUtilityConfiguration ( ).pJobs.Police ) {
		
			return true;
		
		}
		
	}
	
	return false;

}

// -------------------------------------------------------------------------------------------------

function ArrestPlayer ( pPlayer ) {
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function CuffPlayer ( pPlayer ) {
	
	ResetPlayerAnimation ( pPlayer );
	
	pPlayer.SetAnim ( 8 );
	
	pPlayer.Frozen = true;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function UncuffPlayer ( pPlayer ) {
	
	ResetPlayerAnimation ( pPlayer );
	
	pPlayer.Frozen = false;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function RemoveTazerEffect ( pPlayer ) {

	ResetPlayerAnimation ( pPlayer );
	
	pPlayer.Frozen = false;
	
	SendPlayerAlertMessage ( pPlayer , "The tazer's effect starts to wear off ..." );
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function PoliceTazerCommand ( pPlayer , szCommand , szParams , bShowHelpOnly = false ) {
	
	if ( !IsPlayerPoliceOfficer ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You do not have a tazer!" );
		
		return false;
	
	}
	
	if ( IsPlayerImmobilized ( pPlayer ) ) {
	
		SendPlayerErrorMessage ( pPlayer , "You can't do this right now!" );
	
		return false;
	
	}
	
	if ( !GetPlayerData ( pPlayer ).bTazerArmed ) {
	
		pPlayer.ClearWeapons ( );
		pPlayer.SetWeapon ( 2 , 1 );
		GetPlayerData ( pPlayer ).bTazerArmed = true;
		
		SendPlayerSuccessMessage ( pPlayer , "You have taken out a tazer." );
		
	} else {
	
		pPlayer.ClearWeapons ( );
		RestorePlayerSavedWeapons ( pPlayer );
		GetPlayerData ( pPlayer ).bTazerArmed = false;
		
		SendPlayerSuccessMessage ( pPlayer , "You have put away your tazer." );	
	
	}
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function TogglePublicPoliceJob ( pPlayer ) {

	if ( !GetUtilityConfiguration ( "bPoliceJobPublic" ) ) {
	
		GetUtilityConfiguration ( ).bPoliceJobPublic = true;
		
		foreach ( ii , iv in GetCoreTable ( ).Jobs ) {
		
			if ( iv.iJobType == GetJobTypeID ( "Police" ) ) {
			
				iv.bEnabled = true;
				
			}
			
		}
		
		return true;
		
	}
	
	foreach ( ii , iv in GetCoreTable ( ).Jobs ) {

		if ( iv.iJobType == GetJobTypeID ( "Police" ) ) {

			iv.bEnabled = false;

		}

	}	
	
	GetUtilityConfiguration ( ).bPoliceJobPublic = false;
	
	return true;
	
}

// -------------------------------------------------------------------------------------------------

function IsPoliceJobPublic ( ) {

	return GetUtilityConfiguration ( "bPoliceJobPublic" );
	
}

// -------------------------------------------------------------------------------------------------

// -- THIS GOES LAST

print ( "[Server.Jobs.Police]: Script file loaded and ready." );

// -------------------------------------------------------------------------------------------------