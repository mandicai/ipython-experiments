function [avg_relaxation_time, num_strides_relax_time, num_frame_stride, frames_stdev, strides_stdev] = findRelaxationTime(center_x, center_y, angles_no_outliers, velocity_no_outliers, toe_data, band_width_outer_mat, band_width_inner_mat, perturbation_data)
% Find the relaxation time based on how many frames it takes for the curve
% post-perturbation to get back within the curve after each perturbation

num_frame_stride = determineStride(toe_data, perturbation_data); % Number of frames for a stride 

n_slices = 50; % Define the number of slices (the lower bound of average number of frames per slide)

% Find the mean pre-perturbation curve
grid_step = 2*pi/n_slices; % Define theta index grids
th_grid = 0:grid_step:(2*pi);

out_of_bounds_array = zeros(length(angles_no_outliers),2); % Contains all of the points that are considered out of bound

% Try the data without interpolation 
for relax_idx = 1:length(angles_no_outliers)
    x0 = angles_no_outliers(relax_idx)-center_x;
    y0 = velocity_no_outliers(relax_idx)-center_y;	
	[th0,rho0] = cart2pol(x0,y0); % Transforms cartesian coordinates to theta and rho
    
    if th0 < 0
	    th0 = th0 + 2*pi; % Takes a negative value and converts it 
    end
    
	th_idx = sum(th_grid <= th0); % Find x index
                                  % th_grid=(0:grid_step:(2*pi))'                      
    if th_idx > n_slices
        th_idx = n_slices; % Pull in upper edge to the range
    end	
    
    % Finding points outside of the outer curve and inside the inner curve
    for new_idx = 1:length(band_width_outer_mat)-1
        if th0 > band_width_outer_mat(new_idx,1) && th0 < band_width_outer_mat(new_idx + 1,1) % Within a section of the curve
            if rho0 > min([band_width_outer_mat(new_idx,2) band_width_outer_mat(new_idx + 1,2)]) || rho0 < max([band_width_inner_mat(new_idx,2) band_width_inner_mat(new_idx + 1,2)])% Compare to the max value between the two points that define a slice 
                % display('Oh shit');
                
                out_of_bounds_array(relax_idx,1) = 1; % Converts zero in the array to one if the point is
                out_of_bounds_array(relax_idx,2) = 1; % out of bounds 
            end
        end
    end
end

counter_one = 0; % Keep track of when the band is out of bounds 
counter_zero = 0; % Keep track of when the band comes back into the band
counter_two = 0; % Tells you if the trip worked
counter_relaxation_time = 0;
out_of_bounds = false; % Changed to true when the curve reenters the band

perturbation_data(end+1,1) = perturbation_data(end,1)+10000; % Add an extra value so you don't get indices exceeding the matrix

relaxation_time = zeros(18,1); % Create a matrix to store relaxation times 

% The code below takes the array of zeros and ones, zeros being in bounds
% and ones being out of bounds, and outputs the number of frames it takes
% for the data to go out of bound to in bounds
% Only when a perturbation has occurred 
for i = 1:18
    for j = perturbation_data(i):perturbation_data(i+1)
        for k = j:j+25
            if out_of_bounds_array(k) == 1 && out_of_bounds == false
                counter_two = counter_two + 1;
            end
            
            if counter_two == 5
                out_of_bounds = true;
            end
        end

%         out_of_bounds = true;
%         counter_relaxation_time = counter_relaxation_time + 1;
        
        if out_of_bounds_array(j) == 0 && out_of_bounds == true % Going from out of bound to in bound
            counter_zero = counter_zero + 1; 

            if counter_zero > num_frame_stride/4
                relaxation_time(i) = counter_relaxation_time - num_frame_stride/4;
                out_of_bounds = false; % display ('In bounds');
                counter_zero = 0;
                counter_relaxation_time = 0;
                break
            end
            
        end
        
        if out_of_bounds_array(j) == 1 && counter_zero ~= 0
            counter_one = counter_one + 1;
            if counter_one > num_frame_stride/4
                counter_zero = 0;
                counter_one = 0;
            end
        end
    end
end
          
relaxation_time = relaxation_time(relaxation_time ~= 0); % Discard all zeros, which represent no recovery
indices_test = find(relaxation_time~=0); % Find the indices at which relaxation times were recorded
relaxation_time_instrides = relaxation_time/num_frame_stride; % Individual relaxation times in % of strides

frames_stdev = std(relaxation_time); % Find the standard deviation 
strides_stdev = std(relaxation_time_instrides);

avg_relaxation_time = mean(relaxation_time); % Find the average relaxation time
num_strides_relax_time = avg_relaxation_time/num_frame_stride; % Find the number of strides that it takes

end