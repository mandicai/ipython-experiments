function avgnumframeStride = determineStride(data, perturbation_data)
% This function determines the number of frames that constitute a stride
% Also determines the number of frames that constitute a step (stride/2) 
% A stride will be designated as the number of frames it takes to get from
% HEELSTRIKE TO HEELSTRIKE ON A SINGLE FOOT
% A step will be roughly half of that
% Method to find heelstrike is based on method from Pijnapples, Bobbert,
% and Van Dieen (2001) 

% Filter the toe Z-marker data with a 4th order forward backward
% Butterworth filter
data_filtered = filter_butter_MANDI(60, data);

% Find the number of frames
numFrames = perturbation_data(1)-1;

% Create a matrix to store the vertical velocities from the toe Z-marker 
vertical_veloc_filtered = zeros(numFrames,1);
vertical_veloc = zeros(numFrames,1);

% Find the vertical velocities from the filtered data and unfiltered data
 for i = 1:numFrames
    if i > 2 
       vertical_veloc_filtered(i) = data_filtered(i) - data_filtered(i-1); % Finding the change in angle per frames
       vertical_veloc(i) = data(i) - data(i-1);
    end
 end

 % Find the local minima using extrema function
[garbage,idx_garbage,heel_strike,idx_heelstrike] = extrema(vertical_veloc_filtered);

abs_localminima = zeros(length(heel_strike),1);

% Find all the local minima that are lower than -10 to eliminate the local
% minima you don't want 
for i = 1:length(heel_strike)
    if heel_strike(i) < -10
        abs_localminima(i) = 1; % Store the indices of the -10 values in an array
    end
end

% Keep the indices that correspond to the indices you want to keep, set everything else to zero
heel_strike = heel_strike(abs_localminima ~= 0);
idx_heelstrike = idx_heelstrike(abs_localminima ~= 0); 

% Plot the data with the local minima indicated by green dots 
% Small frame number
% figure
% plot(vertical_veloc_filtered);
% hold on
% plot(idx_heelstrike, heel_strike, 'g*');
% hold on
% plot(vertical_veloc);
% title('Vertical Velocities of the Toe Marker plotted against the Frame Number');
% xlabel('Frame Number');
% ylabel('mm/frame');
% axis([2000 4000 -50 20]);

% Plot the data with the local minima indicated by green dots
% All frames
% figure
% plot(vertical_veloc_filtered);
% hold on
% plot(idx_heelstrike, heel_strike, 'g*');
% hold on
% plot(vertical_veloc);
% title('Vertical Velocities of the Toe Marker plotted against the Frame Number');
% xlabel('Frame Number');
% ylabel('mm/frame');
% axis([0 numFrames -50 20]);

% Sort the indices
idx_heelstrike = sort(idx_heelstrike);

% Find the difference between indices to check how many frames are between
% two heel strikes (a stride)
stride_lengths = diff(idx_heelstrike);

% Just for subject 19, trial 3, block 2 (trial 8)
stride_lengths = stride_lengths(stride_lengths < 500);

% Average the stride lengths
avgnumframeStride = mean(stride_lengths);
 
end