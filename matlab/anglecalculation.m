function anglesandvelocity = anglecalculation(data)
    numFrames = length(data);
    angles = zeros(numFrames,1);
    
    for i = 1:numFrames
       x1 = data(i,1); % Hip marker
       x2 = data(i,4); % Knee marker
       x3 = data(i,7); 
       
       y1 = data(i,2); % Hip marker
       y2 = data(i,5); % Knee marker
       y3 = data(i,8);
       
       z1 = data(i,3); % Hip marker
       z2 = data(i,6); % Knee marker
       z3 = data(i,9);
       
       % v21 = [x2-x1,y2-y1,z2-z1]; % Upper thigh vector
       % v23 = [0,0,-1]; % The vertical, z-axis or y-axis depending on the Qualysis axes
       
       v21 = [x1-x2,y1-y2,z1-z2]; % Upper thigh vector
       v23 = [x3-x2,y3-y2,z3-z2];
       
       angles(i) = atan2(norm(cross(v21,v23)),dot(v21,v23));
       
       if i > 2
        velocity(i) = angles(i)-angles(i-1); % Finding the change in angle per frames
       end
    
    end
    
    % Create a struct to store the angles and angle rate of change
    anglesandvelocity = struct('angles',angles, 'velocity', velocity, 'numframes', numFrames);
    % Transpose the rate of change to be the same size as angles 
    anglesandvelocity.velocity = (anglesandvelocity.velocity)';
    
end