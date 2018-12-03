function [ output_args ] = untitled3( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dx=diff(interp_x);
dx=dx(2:end); % Skip the first value because it will throw an error
dy=diff(interp_y);
dy=dy(2:end);
d2x=diff(diff(interp_x));
d2y=diff(diff(interp_y));

% PLOTTING THE CURVATURE VALUES FOR THE TRAJECTORY
% curv=(dx.*d2y-dy.*d2x)./(dx.^2+dy.^2).^(3/2);
% figure;
% plot(curv)

end

