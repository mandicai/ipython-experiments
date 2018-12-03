function [angles_no_outliers,velocity_no_outliers] = removeOutliers (angles,velocity)
% Function that removes outliers from data if they're out of bounds
% Remember that data passed through needs the .angle or .velocity
% extension to work

x = angles;
y = velocity;

mean_x = mean(x); % Find the mean
mean_y = mean(y);
std_x = std(x); % Find the standard deviation
std_y = std(y);

removed_outliers_x = ~(abs(angles - mean_x) > std_x*4); % Create logical index, remove all values that are more than 4 standard deviations from the mean
removed_outliers_y = ~(abs(velocity - mean_y) > std_y*4);

indices_removed_outliers_x = find(abs(angles - mean_x) > std_x*4); % Find indices of outliers
indices_removed_outliers_y = find(abs(velocity - mean_y) > std_x*4); % To see if removing them affects which frames the perturbations are at

rem_all = bsxfun(@and,removed_outliers_x,removed_outliers_y); % Combines logical indices

angles_no_outliers = x(rem_all); % Removes all outliers from the set of data
velocity_no_outliers = y(rem_all);

end