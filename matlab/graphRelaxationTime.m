% Graphing Script for Relaxation Times %
subject = 'subj_24';
number = '24';
load(strcat(subject,'/',subject,'relaxationtimes_0.5.mat')); % Load the array of relaxation times for each subject

% Convert from cell to mat
results = cell2mat(results(2:length(results),:));

% Sort by percentage of PWS
block_1_relaxationtimes = sortrows(results(1:5,:),1);
block_2_relaxationtimes = sortrows(results(6:10,:),1);

% Graphing the relaxation times in frames
figure(1)
% Plot w/ Error Bars
errorbar(block_1_relaxationtimes(:,1),block_1_relaxationtimes(:,2), block_1_relaxationtimes(:,6), 'r--*');
title(strcat('Subject ', number, ',', ' Block 1: Relaxation Times (frames)'));
xlabel('% of PWS');
ylabel('Relaxation Time (frames)');
% Define the ranges of the y-axis
ylim([((min(block_1_relaxationtimes(:,2)) + max(block_1_relaxationtimes(:,2)))/2) - 80, ((min(block_1_relaxationtimes(:,2)) + max(block_1_relaxationtimes(:,2)))/2) + 80]);

% Graphing the relaxation times in frames
figure(2)
% Plot w/ Error Bars
errorbar(block_2_relaxationtimes(:,1),block_2_relaxationtimes(:,2), block_2_relaxationtimes(:,6), 'r--*');
title(strcat('Subject ', number, ',', ' Block 2: Relaxation Times (frames)'));
xlabel('% of PWS');
ylabel('Relaxation Time (frames)');
% Define the ranges of the y-axis
ylim([((min(block_2_relaxationtimes(:,2)) + max(block_2_relaxationtimes(:,2)))/2) - 80, ((min(block_2_relaxationtimes(:,2)) + max(block_2_relaxationtimes(:,2)))/2) + 80]);

% Graphing the relaxation times in % stride
figure(3)
% Plot w/ Error Bars
errorbar(block_1_relaxationtimes(:,1),block_1_relaxationtimes(:,3), block_1_relaxationtimes(:,7), 'b--*');
title(strcat('Subject ', number, ',', ' Block 1: Relaxation Times (% stride)'));
xlabel('% of PWS');
ylabel('Relaxation Time (% stride)');
% Define the ranges of the y-axis
ylim([((min(block_1_relaxationtimes(:,3)) + max(block_1_relaxationtimes(:,3)))/2) - 1, ((min(block_1_relaxationtimes(:,3)) + max(block_1_relaxationtimes(:,3)))/2) + 1]);

% Graphing the relaxation times in % stride
figure(4)
% Plot w/ Error Bars
errorbar(block_2_relaxationtimes(:,1),block_2_relaxationtimes(:,3), block_2_relaxationtimes(:,7), 'b--*');
title(strcat('Subject ', number, ',', ' Block 2: Relaxation Times (% stride)'));
xlabel('% of PWS');
ylabel('Relaxation Time (% stride)');
% Define the ranges of the y-axis
ylim([((min(block_2_relaxationtimes(:,3)) + max(block_2_relaxationtimes(:,3)))/2) - 1, ((min(block_2_relaxationtimes(:,3)) + max(block_2_relaxationtimes(:,3)))/2) + 1]);

averages = zeros(5,8);
averages(:,1) = block_1_relaxationtimes(:,1);
% Averages (Blocks 1 & 2)
for i=1:5
    averages(i,2:8) = (block_1_relaxationtimes(i,2:8)+block_2_relaxationtimes(i,2:8))/2;
end

% Average Relaxation Times in Frames (Blocks 1 & 2)
figure(5)
% Plot w/ Error Bars
errorbar(averages(:,1),averages(:,2), averages(:,6), 'k--*');
title(strcat('Subject ', number, ',', ' Average Relaxation Times (frames)'));
xlabel('% of PWS');
ylabel('Relaxation Time (frames)');
% Define the range of the axes
ylim([((min(averages(:,2)) + max(averages(:,2)))/2) - 80, ((min(averages(:,2)) + max(averages(:,2)))/2) + 80]);

% Average Energetic Efficiency (Blocks 1 & 2)
figure(6)
% Plot w/ Error Bars
errorbar(averages(:,1),averages(:,3), averages(:,7), 'k--*');
title(strcat('Subject ', number, ',', ' Average Relaxation Times (% stride)'));
xlabel('% of PWS');
ylabel('Relaxation Time (% stride)');
% Define the range of the axes
ylim([((min(averages(:,3)) + max(averages(:,3)))/2) - 1, ((min(averages(:,3)) + max(averages(:,3)))/2) + 1]);