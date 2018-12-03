function [heelstrike_trip_frames] = determineheelStrike(data, perturbation_data)
% The purpose of this function is to find the local minimums (which denote heelstrike) 
% from the ankle marker Z-values, then catalogue the heelstrikes that occur after a
% perturbation is administered. By plotting the heelstrike after a
% perturbation on a phase plane, we can compare that heelstrike with
% heelstrikes during normal cycles of walking.

ankle_z = data(:,9); % Grab the ankle marker Z-value data

ankle_z_filtered = filter_butter_MANDI(60, ankle_z); % Smooth the data out a bit

[garbage,idx_garbage,heel_strike,idx_heelstrike] = extrema(ankle_z_filtered); % Find the local minima and indices at which they occur

abs_localminima_anklez = zeros(length(heel_strike),1);

for i = 1:length(heel_strike) % Take out the local minima that don't indicate heelstrike
    if heel_strike(i) < 95
        abs_localminima_anklez(i) = 1; % Store the indices of the < 95 values in an array
    end
end

heel_strike = heel_strike(abs_localminima_anklez ~= 0); % Take out the irrelevant local minima
idx_heelstrike = idx_heelstrike(abs_localminima_anklez ~= 0); % Take out the irrelevant local minima

value_index = [idx_heelstrike, heel_strike]; % Combine the local minima and their indices into one matrix

heelstrike_trip_frames = zeros(18,2); % Make a matrix to store the specific frames at which heelstrike after a perturbation occurs

for i = 1:length(perturbation_data)
    post_trip = ankle_z_filtered(perturbation_data(i):perturbation_data(i)+50); % Take the 50 frames AFTER a perturbation
    [min_value, index] = min(post_trip); % Find the minimum value within those 50 frames
    heelstrike_trip_frames(i,2) = min_value; 
    heelstrike_trip_frames(i,1) = perturbation_data(i)+(index-1);
end

% Plot the data with the local minima indicated by green dots 
% Red dots indicate the frame at which a perturbation is administered
% Blue dots indicate the heelstrike directly after a perturbation 
% figure(2)
% plot(ankle_z_filtered);
% hold on
% plot(idx_heelstrike, heel_strike, 'g*');
% hold on
% plot(perturbation_data(:,1), ankle_z_filtered(perturbation_data(:,1)),'r*');
% hold on 
% plot(heelstrike_trip_frames(:,1),heelstrike_trip_frames(:,2),'b*');
% xlabel('Frame Number');
% ylabel('mm/frame');

end