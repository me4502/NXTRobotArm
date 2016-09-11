% Setup the connection to the NXT. Closes if already opened.
function SetupNXT()
    % Connect to the NXT - Ensuring that it is closed first.
    COM_CloseNXT('all')
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    % Define motors as globals.
    global motorA;
    motorA = NXTMotor('A');
    motorA.ResetPosition();
    motorA.ActionAtTachoLimit = 'BRAKE';
    %motorA.SpeedRegulation = false;
    
    global motorB;
    motorB = NXTMotor('B');
    motorB.ResetPosition();
    motorB.ActionAtTachoLimit = 'BRAKE';
    %motorB.SpeedRegulation = false;
    
    global motorC;
    motorC = NXTMotor('C');
    motorC.ResetPosition();
end