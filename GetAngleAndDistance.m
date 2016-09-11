% Function to determine required angle and distance for a point.
function [angle, distance] = GetAngleAndDistance(position)
    % Distance formula
    distance = sqrt((position(2)^2)+(position(1)^2));
    angle = atan2(position(2), position(1));
end