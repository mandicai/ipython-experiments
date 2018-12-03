[oxygen_mat time_mark]= xlsread('subj_20/subject20_oxygen.xlsx','E4:H2500'); % VO2 recorded
number = '20';

load('subj_20/subj_20_oxygenspeeds.mat'); % Speeds for 2 oxygen blocks
measurement_length = length(oxygen_mat);

% Convert the time to something readable
time_mark = cell2mat(time_mark);
time_mark = str2num(time_mark(:,4:5))*60+str2num(time_mark(:,7:8));

% Find the indices where the mark was pressed (between two marks is one
% session)
oxygen_mat = [time_mark oxygen_mat];
mark_idx = find(oxygen_mat(:,4)==1);

for nn=1:length(mark_idx)-1
    avg_data(nn,1) = mark_idx(nn+1)-mark_idx(nn); % Find the number of readers between two marks
    avg_data(nn,2) = mean(oxygen_mat(mark_idx(nn):mark_idx(nn+1)-1,3)); % Find the avg energetic mean between marks
    avg_data(nn,4) = std(oxygen_mat(mark_idx(nn):mark_idx(nn+1)-1,3)); % Find the std of the energetic mean between marks
    avg_data(nn,6) = avg_data(nn,4)/sqrt(avg_data(nn,1)); % Find the std error of the energetic mean between marks 
end

% Loop through and take every other row
trials_proc_data = avg_data(1:2:end,:);

% Finding energy efficiency by dividing by the respective speed
for mm = 1:10 
    trials_proc_data(mm,3) = trials_proc_data(mm,2)/oxygen_speeds(mm,2); % Find the avg energetic efficiency between marks
    trials_proc_data(mm,5) = std(oxygen_mat(mark_idx(nn):mark_idx(nn+1)-1,3))/oxygen_speeds(mm,2); % Find the std of the energetic efficiency between marks
    trials_proc_data(mm,7) = trials_proc_data(mm,5)/sqrt(trials_proc_data(mm,1)); % Find the std error of the energetic mean between marks 
end

run graphOxygen_1part.m