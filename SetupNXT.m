function SetupNXT()
    % Connect to the NXT - Ensuring that it is closed first.
    COM_CloseNXT('all')
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    % Define motors as globals.
    global motorA;
    motorA = NXTMotor('A');
    motorA.ResetPosition();
    
    global motorB;
    motorB = NXTMotor('B');
    motorB.ResetPosition();
    
    global motorC;
    motorC = NXTMotor('C');
    motorC.ResetPosition();
end