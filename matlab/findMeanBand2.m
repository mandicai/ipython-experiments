function [center_x, center_y, mean_band, amplitude_array, std_array] = findMeanBand2(angles_no_kink,velocity_no_kink, perturbation_frames)
% Function that graphs the mean pre-perturbation curve and applies the inner
% and outer curves to create a band
% Follows the Kelso-Bunz 1991 model

n_slices = 50; % Define the number of slices, more slices more accuracy

numFrames = length(velocity_no_kink); % Use for indexing

% Find the mean pre-perturbation curve
grid_step = (2*pi)/n_slices; % Define theta index grids
th_grid = 0:grid_step:(2*pi);
mean_band = cell(n_slices,1);

% Finds the rough center of the graph 
center_x = (max(angles_no_kink) + min(angles_no_kink))/2; 
center_y = (max(velocity_no_kink) + min(velocity_no_kink))/2;

last_idx = perturbation_frames(1)-1800; % Gives the frame that begins the last 30 seconds before perturbations start
                                        % 1800 = 60 frames per second times 30 seconds
                                        % or 1000

for frm_idx = last_idx:perturbation_frames(1) % (numFrames-1800):numFrames, this is for the last 30 seconds of the trial (post-perturbations)
    x0 = angles_no_kink(frm_idx)-center_x;    % last_idx:perturbation_frames(1), this is for the seconds before the first perturbation 
    y0 = velocity_no_kink(frm_idx)-center_y;	
	[th0,rho0] = cart2pol(x0,y0); % Transforms cartesian coordinates to theta and rho
    
    if th0 < 0
	    th0 = th0+2*pi; % Takes a negative value and converts it 
    end
    
	th_idx = sum(th_grid <= th0); % Find x index
                                  % th_grid=(0:grid_step:(2*pi))'                      
    if th_idx > n_slices
        th_idx = n_slices; % Pull in upper edge to the range
    end
    
    for idx = 1:n_slices
        if th0 > th_grid(idx) && th0 < th_grid(idx+1)
            mean_band{idx,1} = [mean_band{idx,1};[th0,rho0]]; % Use recursion here
                                                              % Probably slow 
            break
        end
    end
end

% KEEP EVERYTHING IN THE SLICE
% Find the average rho and theta in each slice
% Find the average standard deviation and average amplitude 
amplitude_array = zeros(50,1); % Array that stores amplitudes for each slice
std_array = zeros(50,1); % Array that stores stdevs for each slice

for avg_idx = 1:n_slices
    if isempty(mean_band{avg_idx})
        mean_band{avg_idx} = [];
        continue
    else
        avg_th0 = mean(mean_band{avg_idx}(:,1)); % Find the average th0 for each slice
        avg_rh0 = mean(mean_band{avg_idx}(:,2)); % Find the average rho0 for each slice 
        std_array(avg_idx) = std(mean_band{avg_idx}(:,2)); % Find the standard deviation for each slice 
    end
    amplitude_array(avg_idx) = avg_rh0; % The amplitude is just the mean value
    mean_band{avg_idx} = [avg_th0,avg_rh0]; % Replace each cell with [average th0, average rh0]
end 


% Clear out all of the empty cells
mean_band = mean_band(~cellfun('isempty',mean_band)); 

% Add the first value of the mean_band, amplitude_array, std_array to the
% end in order to close off the band
mean_band{end + 1, 1} = [mean_band{1,1}];
amplitude_array(end+1) = amplitude_array(1);
std_array(end+1) = std_array(1);

end