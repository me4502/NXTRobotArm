% Get the angles the motors are currently at. Requires globals to be
% initialized.
function [angle, distance] = GetCurrentAngles()  
    global last_point;

    [angle, distance] = GetAngleAndDistance(last_point);
end
