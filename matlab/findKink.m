function [angles_no_kink, velocity_no_kink] = findKink(angles_no_outliers,velocity_no_outliers) % Take the angle and velocities before the first perturbation
% Find the frames at which the little knee angle kink occurs by finding the 
% clusters of sign changes that occur in the angle velocity. Then,
% eliminate it when you are trying to create the band. 

sign_change = find(diff(sign(velocity_no_outliers)) ~= 0);

velocity_no_outliers(sign_change,2) = 1;

% Within a given small interval, see if the one's sum up to 3
counter_1 = 0;
counter_2 = 0;
kink_indices_counter = [];
kink_indices = [];

for i = 1:length(velocity_no_outliers)
    counter_2 = counter_2 + 1;
    
    if (velocity_no_outliers(i,2) == 1)
        kink_indices_counter = [kink_indices_counter;i];
        counter_1 = counter_1 + velocity_no_outliers(i,2);
    end
     
    if (counter_2 == 15) % This counter is the range that the sign changes should be clustered in 
        counter_2 = 0;
        counter_1 = 0;
    end
    
    if (counter_1 >= 3) % This counter is the number of sign changes that need to happen within the range
        kink_indices = [kink_indices; kink_indices_counter(1);kink_indices_counter(3)];
        counter_1 = 0;
        kink_indices_counter = [];
    end
end

angles_no_kink = angles_no_outliers(:,1);
velocity_no_kink = velocity_no_outliers(:,1);

angles_and_velocity_no_kink = [angles_no_kink, velocity_no_kink];

for i = 1:2:length(kink_indices)-1
    for j = kink_indices(i):kink_indices(i+1)
        if (angles_and_velocity_no_kink(j,1) > 2.6) % If the angle is above 2.6, then we have greater confidence that the values are within the kink
            angles_and_velocity_no_kink(j,:) = 100;
        end
    end
end

angles_no_kink = angles_and_velocity_no_kink(:,1);
angles_no_kink = angles_no_kink(angles_no_kink ~= 100); % Take out the kink

velocity_no_kink = angles_and_velocity_no_kink(:,2);
velocity_no_kink = velocity_no_kink(velocity_no_kink ~= 100); % Take out the kink 

end