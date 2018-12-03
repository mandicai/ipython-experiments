function [avg_relaxation_time, num_strides_relax_time, num_frame_stride, frames_stdev, strides_stdev] = finalAnalysis(data, perturbation_data, numtrials)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% FINAL ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create the x and y values for graphing
anglesandvelocity = anglecalculation(data);

% Remove outliers 
[angles_no_outliers, velocity_no_outliers] = removeOutliers(anglesandvelocity.angles, anglesandvelocity.velocity);

% Find the mean pre-perturbation band
% [center_x, center_y, interp_x, interp_y, mean_band, amplitude_array, std_array] = findMeanBand(angles_no_outliers,velocity_no_outliers, perturbation_data);

% Remove the kink
[angles_no_kink, velocity_no_kink, smoothed_x, smoothed_y] = findKink3(angles_no_outliers, velocity_no_outliers);

velocity_no_outliers_expanded = velocity_no_outliers * 5;

% Find the mean pre-perturbation band
[center_x, center_y, mean_band, amplitude_array, std_array] = findMeanBand2(angles_no_kink, velocity_no_kink, perturbation_data);

% Kelso-Bunz equation to find the band
[band_width_outer, band_width_inner] = kelsoBunz(mean_band, amplitude_array, std_array);

% Frames when heelstrike occurred post-trip
% [heelstrike_trip_frames] = determineheelStrike(data, perturbation_data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% GRAPHING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plotting the original data pre-trips
figure
plot(angles_no_kink, velocity_no_kink);
hold on
plot(angles_no_kink, velocity_no_kink)
grid
hold on
xlabel('Angle');
ylabel('Angular Rate of Change');
title('Kelso-Bunz Band');
set(gca,'FontSize',15);
hold on;
                                           
% Mean pre-perturbation plot
mean_band_mat = cell2mat(mean_band);
[x0, y0] = pol2cart(mean_band_mat(:,1),mean_band_mat(:,2));
x0 = x0 + center_x;
y0 = y0 + center_y;
plot(x0,y0,'r', 'LineWidth', 5);
hold on

% Inner band
band_width_inner_mat = cell2mat(band_width_inner);
[x1, y1] = pol2cart(band_width_inner_mat(:,1),band_width_inner_mat(:,2));
x1 = x1 + center_x;
y1 = y1 + center_y;
plot(x1,y1,'b', 'LineWidth', 5);
hold on

% Outer band
band_width_outer_mat = cell2mat(band_width_outer);
[x2, y2] = pol2cart(band_width_outer_mat(:,1),band_width_outer_mat(:,2));
x2 = x2 + center_x;
y2 = y2 + center_y;
plot(x2,y2,'b', 'LineWidth', 5);
hold on

% Plot each perturbation
figure
for i = 1:18
   subplot(3,6,i);
   plot(angles_no_kink,velocity_no_kink,'x');
   hold on
   plot(x0,y0,'r');
   hold on
   plot(x1,y1,'b');
   hold on
   plot(x2,y2,'b');
   hold on
   plot(angles_no_outliers(perturbation_data(i):perturbation_data(i)+75),velocity_no_outliers_expanded(perturbation_data(i):perturbation_data(i)+75),'r', 'LineWidth', 1.5);
end

% Let's first plot the steps before the first perturbation
% figure
% plot(angles_no_outliers(1:2811), velocity_no_outliers(1:2811),'r')
% hold on
% % Now let's plot the step after the first perturbation 
% plot(anglesNoOutliers{1}(2812:3153), velocityNoOutliers{1}(2812:3153),'b')
% axis([1.5 3.5 -0.1 0.1]);
% title('Before & After the First Trip')
% xlabel('Angle');
% ylabel('Angle rate of change');

% Trying to figure out what one step looks like
% figure
% plot(anglesNoOutliers(2811:2846), velocityNoOutliers(2811:2846),'b')
% axis([1.5 3.5 -0.1 0.1]);
% title('Before & After the First Trip')
% xlabel('Angle');
% ylabel('Angle rate of change');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% RELAXATION TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find the relaxation time (number of frames and number of strides)
[avg_relaxation_time, num_strides_relax_time, num_frame_stride, frames_stdev, strides_stdev] = findRelaxationTime(center_x, center_y, angles_no_outliers, velocity_no_outliers_expanded, data(:,12), band_width_outer_mat, band_width_inner_mat, perturbation_data);

end