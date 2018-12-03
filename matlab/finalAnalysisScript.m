% We want to loop through one subject
% Loop through all 10 trials 
% Generate relaxation times and store them in an Excel
% General graphs with the correct titles 

% Because naming shit is really annoying 
subject = 'subj_20';

% Make this rely on subject 
load(strcat(subject,'/',subject,'struct.mat')); % Load structs with all the filled gaps
load(strcat(subject,'/',subject,'_speeds.mat')); % Load the array of 10 speeds 

pert_Files = storePerturbations(subject); % Put perturbations for all 10 trials into one file 

% Setting up the Excel file 
results = cell(11,5);
results{1,2} = 'Average Relaxation Time in Frames';
results{1,3} = 'Average Relaxation Time in % Strides';
results{1,4} = 'Standard Deviation of Relaxation Times in Frames';
results{1,5} = 'Standard Deviation of Relaxation Times in % Strides';
results{1,6} = 'Standard Error of Relaxation Times in Frames';
results{1,7} = 'Standard Error of Relaxation Times in % Strides';
results{1,8} = 'Number of Frames in a Stride';
results{1,1} = subject;

bork = eval(strcat(subject,'struct')); % Eval takes the string and makes it into a cell
for numtrials = 1:10 
    load(fullfile(strcat('/Users/Mandi/Desktop/GitHub Projects/data_analysis_thesis/', subject, '/'), pert_Files(numtrials).name));
    [avg_relaxation_time, num_strides_relax_time, num_frame_stride, frames_stdev, strides_stdev] = finalAnalysis(bork{numtrials}.data, pertOut.frames, numtrials); % or ans.frames for subj_18
    results{numtrials+1, 1} = speeds(numtrials,1); %[speeds(numtrials,1), speeds(numtrials,2)]
    results{numtrials+1, 2} = avg_relaxation_time;
    results{numtrials+1, 3} = num_strides_relax_time;
    results{numtrials+1, 4} = frames_stdev;
    results{numtrials+1, 5} = strides_stdev;
    results{numtrials+1, 6} = frames_stdev/sqrt(18);
    results{numtrials+1, 7} = strides_stdev/sqrt(18);
    results{numtrials+1, 8} = num_frame_stride;
end

save (strcat(subject,'relaxationtimes'),'results'); % Save as a Matlab file 