number = '20';

% For 1-part sessions
% Append the speeds to trials_processed_data
speeds_plus_data = [oxygen_speeds trials_proc_data];
% Sort the matrix based on the speeds 
% Sort the first part and store in a variable
block_1_sorted = sortrows(speeds_plus_data(1:5,:),1);
% Sort the second part and store in a variable 
block_2_sorted = sortrows(speeds_plus_data(6:10,:),1);

% Graphing the oxygen curve
% Block 1 Energetic Mean
figure(1)
% Plot w/ Error Bars
errorbar(block_1_sorted(:,1),block_1_sorted(:,4), block_1_sorted(:,8), 'r--*');
title(strcat('Subject ', number, ',', ' Block 1: Energetic Mean'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/min/kg)');
% Define the ranges of the y-axis
ylim([((min(block_1_sorted(:,4)) + max(block_1_sorted(:,4)))/2) - 6, ((min(block_1_sorted(:,4)) + max(block_1_sorted(:,4)))/2) + 6]);

% Block 1 Energetic Efficiency
figure(2)
% Plot w/ Error Bars
errorbar(block_1_sorted(:,1),block_1_sorted(:,5), block_1_sorted(:,9), 'b--*');
title(strcat('Subject ', number, ',', ' Block 1: Energetic Efficiency'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/m/kg)');
% Define the range of the axes
ylim([((min(block_1_sorted(:,5)) + max(block_1_sorted(:,5)))/2) - 0.04, ((min(block_1_sorted(:,5)) + max(block_1_sorted(:,5)))/2) + 0.04]);

% Block 2 Energetic Mean
figure(3)
% Plot w/ Error Bars
errorbar(block_2_sorted(:,1),block_2_sorted(:,4), block_2_sorted(:,8), 'r--*');
title(strcat('Subject ', number, ',', ' Block 2: Energetic Mean'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/min/kg)');
% Define the range of the axes
ylim([((min(block_2_sorted(:,4)) + max(block_2_sorted(:,4)))/2) - 6, ((min(block_2_sorted(:,4)) + max(block_2_sorted(:,4)))/2) + 6]);

% Block 2 Energetic Efficiency
figure(4)
% Plot w/ Error Bars
errorbar(block_2_sorted(:,1),block_2_sorted(:,5), block_2_sorted(:,9), 'b--*');
title(strcat('Subject ', number, ',', ' Block 2: Energetic Efficiency'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/m/kg)');
% Define the range of the axes
ylim([((min(block_2_sorted(:,5)) + max(block_2_sorted(:,5)))/2) - 0.04, ((min(block_2_sorted(:,5)) + max(block_2_sorted(:,5)))/2) + 0.04]);

averages = zeros(5,9);
averages(:,1:2) = block_1_sorted(:,1:2);
% Averages (Blocks 1 & 2)
for i=1:5
    averages(i,4:9) = (block_1_sorted(i,4:9)+block_2_sorted(i,4:9))/2;
end

% Average Energetic Mean (Blocks 1 & 2)
figure(5)
% Plot w/ Error Bars
errorbar(averages(:,1),averages(:,4), averages(:,8), 'k--*');
title(strcat('Subject ', number, ',', ' Average Energetic Mean'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/min/kg)');
% Define the range of the axes
ylim([((min(averages(:,4)) + max(averages(:,4)))/2) - 6, ((min(averages(:,4)) + max(averages(:,4)))/2) + 6]);

% Average Energetic Efficiency (Blocks 1 & 2)
figure(6)
% Plot w/ Error Bars
errorbar(averages(:,1),averages(:,5), averages(:,9), 'k--*');
title(strcat('Subject ', number, ',', ' Average Energetic Efficiency'));
xlabel('% of PWS');
ylabel('Oxygen Consumption (mL/m/kg)');
% Define the range of the axes
ylim([((min(averages(:,5)) + max(averages(:,5)))/2) - 0.04, ((min(averages(:,5)) + max(averages(:,5)))/2) + 0.04]);