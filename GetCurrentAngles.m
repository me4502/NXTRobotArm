% Get the angles the motors are currently at. Requires globals to be
% initialized.
function [joint1_rotation, joint2_rotation] = GetCurrentAngles()
    global motorA;
    global motorB;
    global offset_theta1;
    global offset_theta2;

    joint1_rotation = motorA.ReadFromNXT().Position + offset_theta1;
    joint2_rotation = motorB.ReadFromNXT().Position + offset_theta2;
end