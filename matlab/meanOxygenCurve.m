load averages_subj13.mat;
load averages_subj14.mat;
load averages_subj18.mat;
load averages_subj19.mat;
% load averages_subj20.mat;
load averages_subj22.mat;
% load averages_subj23.mat;
load averages_subj24.mat;
load averages_subj26.mat;
load averages_subj28.mat;
% load averages_29.mat;

all_averages = [averages_subj13; averages_subj14; averages_subj18; averages_subj19; averages_subj22; averages_subj24; averages_subj26; averages_subj28];
all_averages = sortrows(all_averages, 1);  

all_mean_oxygen = zeros(5,7);
all_mean_oxygen(1,1) = 0.75;
all_mean_oxygen(2,1) = 0.85;
all_mean_oxygen(3,1) = 1.00;
all_mean_oxygen(4,1) = 1.15;
all_mean_oxygen(5,1) = 1.25;

all_mean_oxygen(1,2:7) = mean(all_averages(1:8,4:9));
all_mean_oxygen(2,2:7) = mean(all_averages(9:16,4:9));
all_mean_oxygen(3,2:7) = mean(all_averages(17:24,4:9));
all_mean_oxygen(4,2:7) = mean(all_averages(25:32,4:9));
all_mean_oxygen(5,2:7) = mean(all_averages(33:40,4:9));

% GRAPHING AVERAGE ENERGETIC MEAN ACROSS SUBJECTS
figure(1)
errorbar(all_mean_oxygen(:,1),all_mean_oxygen(:,2), all_mean_oxygen(:,6), 'r--*');
title(strcat('Average Energetic Mean Across Subjects'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/min/kg)');
% Define the ranges of the y-axis
ylim([((min(all_mean_oxygen(:,2)) + max(all_mean_oxygen(:,2)))/2) - 6, ((min(all_mean_oxygen(:,2)) + max(all_mean_oxygen(:,2)))/2) + 6]);
hold on

% polyfit(x,y,n) finds the coefficients of a polynomial p(x) of degree n that fits the y data by minimizing the sum of the squares of the deviations of the data from the model (least-squares fit)
mean_curve_coefficients = polyfit(all_mean_oxygen(:,1),all_mean_oxygen(:,2),1);
t1 = 0.75:0.05:1.25;

% polyval(p,x) returns the value of a polynomial of degree n that was determined by polyfit, evaluated at x
y1 = polyval(mean_curve_coefficients,t1);
plot(t1,y1,'g');

% GRAPHING AVERAGE ENERGETIC EFFICIENCY ACROSS SUBJECTS
figure(2)
errorbar(all_mean_oxygen(:,1),all_mean_oxygen(:,3), all_mean_oxygen(:,7), 'b--*');
title(strcat('Average Energetic Efficiency Across Subjects'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/m/kg)');
% Define the ranges of the y-axis
ylim([((min(all_mean_oxygen(:,3)) + max(all_mean_oxygen(:,3)))/2) - 0.015, ((min(all_mean_oxygen(:,3)) + max(all_mean_oxygen(:,3)))/2) + 0.015]);
hold on

% polyfit(x,y,n) finds the coefficients of a polynomial p(x) of degree n that fits the y data by minimizing the sum of the squares of the deviations of the data from the model (least-squares fit)
efficiency_curve_coefficients = polyfit(all_mean_oxygen(:,1),all_mean_oxygen(:,3),2);
t2 = 0.75:0.05:1.25;

% polyval(p,x) returns the value of a polynomial of degree n that was determined by polyfit, evaluated at x
y2 = polyval(efficiency_curve_coefficients,t2);
plot(t2,y2,'g');
x_min_efficiency = -efficiency_curve_coefficients(2) / (2 * efficiency_curve_coefficients(1));
y_min_efficiency = efficiency_curve_coefficients(3) - (efficiency_curve_coefficients(2)^2 / (4 * efficiency_curve_coefficients(1)));

% Curve Fitting Toolbox
x_mean = all_mean_oxygen(:,1);
y_mean = all_mean_oxygen(:,2);
x_efficiency = all_mean_oxygen(:,1);
y_efficiency = all_mean_oxygen(:,3);