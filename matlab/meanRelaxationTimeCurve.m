load average_relaxation_times_subj13.mat;
load average_relaxation_times_subj14.mat;
load average_relaxation_times_subj19.mat;
load average_relaxation_times_subj20.mat;
load average_relaxation_times_subj22.mat;
load average_relaxation_times_subj24.mat;
load average_relaxation_times_subj29.mat;
% load average_relaxation_times_subj23.mat;

all_averages = [average_relaxation_times_subj13; average_relaxation_times_subj14; average_relaxation_times_subj19; average_relaxation_times_subj20; average_relaxation_times_subj22; average_relaxation_times_subj24; average_relaxation_times_subj29];
all_averages = sortrows(all_averages, 1);

% Putting in the speeds
all_mean_relaxationtimes = zeros(5,8);
all_mean_relaxationtimes(1,1) = 0.75;
all_mean_relaxationtimes(2,1) = 0.85;
all_mean_relaxationtimes(3,1) = 1.00;
all_mean_relaxationtimes(4,1) = 1.15;
all_mean_relaxationtimes(5,1) = 1.25;

% Putting in the all the averages
all_mean_relaxationtimes(1,2:8) = mean(all_averages(1:7,2:8));
all_mean_relaxationtimes(2,2:8) = mean(all_averages(8:14,2:8));
all_mean_relaxationtimes(3,2:8) = mean(all_averages(15:21,2:8));
all_mean_relaxationtimes(4,2:8) = mean(all_averages(22:28,2:8));
all_mean_relaxationtimes(5,2:8) = mean(all_averages(29:35,2:8));

% GRAPHING AVERAGE RELAXATION TIME IN FRAMES ACROSS SUBJECTS
figure(1)
errorbar(all_mean_relaxationtimes(:,1),all_mean_relaxationtimes(:,2), all_mean_relaxationtimes(:,6), 'r--*');
title(strcat('Average Relaxation Time in Frames Across Subjects'));
xlabel('% of PWS');
ylabel('Number of Frames');
% Define the ranges of the y-axis
ylim([((min(all_mean_relaxationtimes(:,2)) + max(all_mean_relaxationtimes(:,2)))/2) - 30, ((min(all_mean_relaxationtimes(:,2)) + max(all_mean_relaxationtimes(:,2)))/2) + 30]);
hold on

% GRAPHING AVERAGE RELAXATION TIME IN % STRIDE ACROSS SUBJECTS
figure(2)
errorbar(all_mean_relaxationtimes(:,1),all_mean_relaxationtimes(:,3), all_mean_relaxationtimes(:,7), 'b--*');
title(strcat('Average Relaxation Time in % Stride Across Subjects'));
xlabel('% of PWS');
ylabel('% Stride');
% Define the ranges of the y-axis
ylim([((min(all_mean_relaxationtimes(:,3)) + max(all_mean_relaxationtimes(:,3)))/2) - 0.4, ((min(all_mean_relaxationtimes(:,3)) + max(all_mean_relaxationtimes(:,3)))/2) + 0.4]);
hold on