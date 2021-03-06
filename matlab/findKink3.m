function [angles_no_kink, velocity_no_kink, smoothed_x, smoothed_y] = findKink3(angles_no_outliers, velocity_no_outliers)

intrp_factor = 6;
y_scale = 5; % In order to use polar system, data in y direction should have similar amplitude as x data, this is factor to adjust
numFrames = length(angles_no_outliers); % Use for indexing

interp_x = interp(angles_no_outliers(1:numFrames),intrp_factor); % Apply interpolation to further smooth the data
interp_y = interp(velocity_no_outliers(1:numFrames)*y_scale,intrp_factor);
smoothed_x = interp_x;
smoothed_y = interp_y;

N=20+1;
Nd=500*floor((length(interp_x)/500));

%====================================================================================================
%smooth the curve to get rid of noises
g=ones(N,1)/N;     %rectangular window average
angles_no_kink=conv(interp_x(1:Nd),g);
angles_no_kink=angles_no_kink(N:end-N+1);
velocity_no_kink=conv(interp_y(1:Nd),g);
velocity_no_kink=velocity_no_kink(N:end-N+1);

%shift original data to get the index aligned (because of the edge effect of the smoothing) 
interp_x=interp_x((N+1)/2+1:end);
interp_y=interp_y((N+1)/2+1:end);

Nd=500*floor((length(interp_x)/500));

% figure(1);
% plot(interp_x(1:Nd),interp_y(1:Nd),'r');
% hold on
% plot(angles_no_kink,velocity_no_kink, 'b') % Graphing smoothed interpolated data against interpolated data
% hold off
% 
% figure(2)
% subplot(1,2,1)
% plot(angles_no_kink)
% hold on
% plot(interp_x(1:Nd),'r')
% hold off
% subplot(1,2,2)
% plot(velocity_no_kink)
% hold on
% plot(interp_y(1:Nd),'r');

%====================================================================================================
%=== ANGLE ====
%find the loop beginning point(lowest x)
[p loc]=findpeaks(-angles_no_kink, 'MINPEAKHEIGHT', max(-angles_no_kink)-abs(max(-angles_no_kink)*0.2));   % find the negative peak (valley)
loop_start_loc=loc;
Nloop=length(loop_start_loc)-1;     % number of full loops in the data

for nn=1:Nloop
    %find peaks of x data (angle)
    angles_seg=angles_no_kink(loop_start_loc(nn):loop_start_loc(nn+1));
    [p loc]=findpeaks(angles_seg);  
    x_peak_loc=loc;
    
    %NaN_idx=loop_start_loc(nn)-(N+1)/2+[x_peak_loc(1):x_peak_loc(2)];
    
    % anything between the first and last peak in x will be considered as the
    % small loop and will be taken out
    if (isempty(x_peak_loc) == 1)
        continue;
    else
        NaN_idx=loop_start_loc(nn)+[x_peak_loc(1):(x_peak_loc(end)-1)];
    end
 
    angles_no_kink(NaN_idx)=NaN; % Use extra smoothed data to find indices
    velocity_no_kink(NaN_idx)=NaN;

    interp_x(NaN_idx)=NaN; % But then actually implement kink elimination in the interpolated data because smoothed data is too smooth
    interp_y(NaN_idx)=NaN;
end

% figure(3)
% valid_idx=loop_start_loc(1):loop_start_loc(end);          % the range of clean data
% plot(interp_x(valid_idx),interp_y(valid_idx),'r');        % This is the data we actually want to make the band
% 
% figure(4)
% valid_idx=loop_start_loc(1):loop_start_loc(end);          % the range of clean data
% plot(angles_no_kink(valid_idx),velocity_no_kink(valid_idx),'r');

angles_no_kink = interp_x;
velocity_no_kink = interp_y;
end