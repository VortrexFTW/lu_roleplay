// -------------------------------------------------------------------------------------------------

function InitInvasionScript ( ) {

	pPlayers <- { };
	pVehicles <- { };
	
	bInvasion <- false;

}

// -------------------------------------------------------------------------------------------------

function BeginInvasion ( ) {

	SetGamespeed ( 0.85 );
	SetGravity ( 0.005 );
	
	bInvasion <- true;

	GetAllVehicles ( );
	GetAllPlayers ( );	
	
	PlayCityAlarm ( );

	pInvasionCameraShake <- NewTimer ( "ShakeAllPlayerCameras" , 400 , 0 );
	pInvasionExplosions <- NewTimer ( "RandomInvasionExplosions" , 750 , 0 );
	pInvasionVehicleToss <- NewTimer ( "TossVehiclesForInvasion" , 5000 , 0 );
	
	TossVehiclesForInvasion ( );

}

// -------------------------------------------------------------------------------------------------

function ShakeAllPlayerCameras ( ) {
	
	foreach ( ii , iv in pPlayers ) {
	
		ShakeCamera ( iv , 150 );
	
	}

}

// -------------------------------------------------------------------------------------------------

function TossVehiclesForInvasion ( ) {

	local x;
	local y;
	local z;
	local xNeg;
	local yNeg;
	local zNeg;
	
	foreach ( ii , iv in pVehicles ) {
	
		x = 0.25 * rand ( ) / RAND_MAX;
		y = 0.25 * rand ( ) / RAND_MAX;
		z = 0.15 * rand ( ) / RAND_MAX;
		
		xNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
		yNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
		zNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
		
		x = ( ( xNeg ) ? -x : x );
		y = ( ( yNeg ) ? -y : y );
		z = ( ( zNeg ) ? -z : z );
		
		iv.Position = Vector ( iv.Position.x + x , iv.Position.x + y , iv.Position.x + z );
		iv.Velocity = Vector ( iv.Velocity.x + x , iv.Velocity.x + y , iv.Velocity.x + z );
	
	}

}

// -------------------------------------------------------------------------------------------------

function RandomInvasionExplosions ( ) {

	CreateRandomExplosion ( );	
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );	
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );
	CreateRandomExplosion ( );	

}

// -------------------------------------------------------------------------------------------------

function CreateRandomExplosion ( ) {

	local x;
	local y;
	local z;
	local xNeg;
	local yNeg;
	local zNeg;
	
	x = 1000 * rand ( ) / RAND_MAX;
	y = 1000 * rand ( ) / RAND_MAX;
	z = 20 * rand ( ) / RAND_MAX;
	
	xNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
	yNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
	zNeg = ( ( 1.0 * rand ( ) / RAND_MAX ) < 0.5 );
	
	x = ( ( xNeg ) ? -x : x );
	y = ( ( yNeg ) ? -y : y );
	z = ( ( zNeg ) ? -z : z );
	
	CreateExplosion ( Vector ( x , y , z ) , 2 );
	CreateFire ( Vector ( x , y , z ) );

}

// -------------------------------------------------------------------------------------------------

function PlayCityAlarm ( ) {

	pAlarmSound <- FindSound( "alarm.mp3" );
	
	foreach ( ii , iv in pPlayers ) {
	
		pAlarmSound.Open ( iv );
		pAlarmSound.Play ( iv );
		pAlarmSound.Close ( iv );
	
	}

}

// -------------------------------------------------------------------------------------------------


function GetAllPlayers ( ) {

	for ( local i = 0 ; i < MAX_PLAYERS ; i++ ) {
	
		if ( FindPlayer ( i ) ) {
		
			pPlayers [ i ] <- FindPlayer ( i );
		
		}
	
	}

}

// -------------------------------------------------------------------------------------------------

function GetAllVehicles ( ) {

	for ( local i = 0 ; i < MAX_VEHICLES ; i++ ) {
	
		if ( FindVehicle ( i ) ) {
		
			pVehicles [ i ] <- FindVehicle ( i );
			FindVehicle ( i ).SetEngineState ( true );
			//FindVehicle ( i ).Locked = true;
		
		}
	
	}

}