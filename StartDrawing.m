% Lowers the drawing arm if applicable. Requires the globals to be setup.
function StartDrawing
    global is_down
    global motorC;
    global joint_c_gear_ratio;
    % Don't put the pen down if it's already drawing.
    if (is_down)
        return;
    else
        % Move the pen up.
        motorC.TachoLimit = round(90 * joint_c_gear_ratio);
        motorC.Power = -10;
        motorC.SendToNXT();
        motorC.WaitFor();
        is_down = true;
    end
end