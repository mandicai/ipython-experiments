load input
N=20+1;
Nd=500*3;

%====================================================================================================
%smooth the curve to get rid of noises
g=ones(N,1)/N;     %rectangular window average
x_smooth=conv(interp_x(1:Nd),g);
x_smooth=x_smooth(N:end-N+1);
y_smooth=conv(interp_y(1:Nd),g);
y_smooth=y_smooth(N:end-N+1);

%shift original data to get the index aligned (because of the edge effect of the smoothing) 
interp_x=interp_x((N+1)/2+1:end);
interp_y=interp_y((N+1)/2+1:end);

figure(1);
plot(interp_x(1:Nd),interp_y(1:Nd),'r');
hold on
plot(x_smooth,y_smooth)
hold off

figure(2)
subplot(1,2,1)
plot(x_smooth)
hold on
plot(interp_x(1:Nd),'r')
hold off
subplot(1,2,2)
plot(y_smooth)
hold on
plot(interp_y(1:Nd),'r')
hold off

%====================================================================================================
%find the loop beginning point(lowest x)
[p loc]=findpeaks(-x_smooth, 'MINPEAKHEIGHT', max(-x_smooth)-abs(max(-x_smooth)*0.2));   % find the negative peak (valley)
loop_start_loc=loc;
Nloop=length(loop_start_loc)-1;     % number of full loops in the data

for nn=1:Nloop
    %find peaks of x data (angle)
    x_seg=x_smooth(loop_start_loc(nn):loop_start_loc(nn+1));
    [p loc]=findpeaks(x_seg);  
    x_peak_loc=loc;
    
    %NaN_idx=loop_start_loc(nn)-(N+1)/2+[x_peak_loc(1):x_peak_loc(2)];
    
    % anything between the first and last peak in x will be considered as the
    % small loop and will be taken out
    NaN_idx=loop_start_loc(nn)+[x_peak_loc(1):(x_peak_loc(end)-1)];
    x_smooth(NaN_idx)=NaN;
    y_smooth(NaN_idx)=NaN;

    interp_x(NaN_idx)=NaN;
    interp_y(NaN_idx)=NaN;
    
end

if 1
figure(3)
valid_idx=loop_start_loc(1):loop_start_loc(end);          % the range of clean data
plot(interp_x(valid_idx),interp_y(valid_idx),'r');


figure(4)
valid_idx=loop_start_loc(1):loop_start_loc(end);          % the range of clean data
plot(x_smooth(valid_idx),y_smooth(valid_idx),'r');
end








