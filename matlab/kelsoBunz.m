function [band_width_outer, band_width_inner] = kelsoBunz(mean_band, amplitudeArray, stdArray)
% Input the mean pre-perturbation data to generate a band via the
% Kelso-Bunz 1991 model

num_data_points = length(mean_band);
bandWidthArray = zeros(51,1);

for avg_idx = 1:num_data_points
    bandWidthArray(avg_idx) = (0.25/(exp(1))) * amplitudeArray(avg_idx) + (.5 * stdArray(avg_idx)); % Add this to the mean pre-perturb curve (polar or cartesian though?)
end

% For organizational purposes, just to designate outer and inner bands 
band_width_outer = mean_band;
band_width_inner = mean_band;

% Adding band widths to the mean pre-perturbation graph 
for idx = 1:num_data_points
    band_width_outer{idx}(2) = mean_band{idx}(2) + bandWidthArray(idx); % Outer band
    band_width_inner{idx}(2) = mean_band{idx}(2) - bandWidthArray(idx); % Inner band
end

end