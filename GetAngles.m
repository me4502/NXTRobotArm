% Function to get the angles required for the joints to point towards the
% point. This does not take gear ratios into account at this stage.
function [theta_1, theta_2] = GetAngles(new)
    global distance_a;
    global distance_b;

    % Grab the `D` value. D = (x_c^2 + y_c^2 - a_1^2 - a_2^2)/(2.a_1.a_2)
    d = (new(1)^2 + new(2)^2 - distance_a^2 - distance_b^2) / (2 * distance_a * distance_b);
    
    % Grab theta 2, which is atan2(d, sqrt(1 - d^2)) - If this returns div
    % by zero, it's not possible to reach that spot.
    theta_2 = atan2(d, sqrt(1 - d^2));
    
    % Multiply the cos and sin of theta 2 by the distance of joint b.
    tx = cos(theta_2) * distance_b;
    ty = sin(theta_2) * distance_b;
    
    theta_1 = atan2(new(1), new(2)) - atan2(distance_a - tx, ty);
end