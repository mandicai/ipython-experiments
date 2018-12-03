cl[oxygen_mat1 time_mark1]= xlsread('subj_13/subject13_oxygen.xlsx','E4:H2500'); % VO2 recorded
[oxygen_mat2 time_mark2]= xlsread('subj_13/subject13_oxygen.xlsx','N4:Q2500'); 
number = '13';

load('subj_13/subj_13_oxygenspeeds1.mat'); % Speeds for 2 oxygen blocks
load('subj_13/subj_13_oxygenspeeds2.mat');
measurement_length1 = length(oxygen_mat1);
measurement_length2 = length(oxygen_mat2);

% Convert the time to something readable
time_mark1 = cell2mat(time_mark1);
time_mark1 = str2num(time_mark1(:,4:5))*60+str2num(time_mark1(:,7:8));

time_mark2 = cell2mat(time_mark2);
time_mark2 = str2num(time_mark2(:,4:5))*60+str2num(time_mark2(:,7:8));

% Find the indices where the mark was pressed (between two marks is one
% session)
oxygen_mat1 = [time_mark1 oxygen_mat1];
mark_idx1 = find(oxygen_mat1(:,4)==1);

oxygen_mat2 = [time_mark2 oxygen_mat2];
mark_idx2 = find(oxygen_mat2(:,4)==1);

for nn=1:length(mark_idx1)-1
    avg_data1(nn,1) = mark_idx1(nn+1)-mark_idx1(nn); % Find the number of readers between two marks
    avg_data1(nn,2) = mean(oxygen_mat1(mark_idx1(nn):mark_idx1(nn+1)-1,3)); % Find the avg energetic mean between marks
    avg_data1(nn,4) = std(oxygen_mat1(mark_idx1(nn):mark_idx1(nn+1)-1,3)); % Find the std of the energetic mean between marks
    avg_data1(nn,6) = avg_data1(nn,4)/sqrt(avg_data1(nn,1)); % Find the std error of the energetic mean between marks 
end

for nn=1:length(mark_idx2)-1
    avg_data2(nn,1) = mark_idx2(nn+1)-mark_idx2(nn); % Find the number of readers between two marks
    avg_data2(nn,2) = mean(oxygen_mat2(mark_idx2(nn):mark_idx2(nn+1)-1,3)); % Find the avg energetic mean between marks
    avg_data2(nn,4) = std(oxygen_mat2(mark_idx2(nn):mark_idx2(nn+1)-1,3)); % Find the std of the energetic mean between marks
    avg_data2(nn,6) = avg_data2(nn,4)/sqrt(avg_data2(nn,1)); % Find the std error of the energetic mean between marks 
end

% Loop through and take every other row
trials_proc_data1 = avg_data1(1:2:end,:);
trials_proc_data2 = avg_data2(1:2:end,:);

% Finding energy efficiency by dividing by the respective speed
for mm = 1:5 % 1:5 for subjects that are split in half
    trials_proc_data1(mm,3) = trials_proc_data1(mm,2)/oxygen_speeds1(mm,2); % Find the avg energetic efficiency between marks
    trials_proc_data1(mm,5) = std(oxygen_mat1(mark_idx1(nn):mark_idx1(nn+1)-1,3))/oxygen_speeds1(mm,2); % Find the std of the energetic efficiency between marks
    trials_proc_data1(mm,7) = trials_proc_data1(mm,5)/sqrt(trials_proc_data1(mm,1)); % Find the std error of the energetic mean between marks 
end

for mm = 1:5 % 1:5 for subjects that are split in half
    trials_proc_data2(mm,3) = trials_proc_data2(mm,2)/oxygen_speeds2(mm,2); % Find the avg energetic efficiency between marks
    trials_proc_data2(mm,5) = std(oxygen_mat2(mark_idx2(nn):mark_idx2(nn+1)-1,3))/oxygen_speeds2(mm,2); % Find the std of the energetic efficiency between marks
    trials_proc_data2(mm,7) = trials_proc_data2(mm,5)/sqrt(trials_proc_data2(mm,1)); % Find the std error of the energetic mean between marks 
end

run graphOxygen_2part.m