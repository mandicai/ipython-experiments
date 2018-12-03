% Executes the function to fill all gaps in the data sets for the subject's folder
subj_29struct = fillGaps('Subj29');
% Saves the entire struct with all 10 filled gap data sets into a Matlab
% file
% Remember to change this based on the participant number!
% i.e. FG_18struct, FG_19struct, etc.
% save(what you want to name your saved file, the variable in the workspace you want save)
save ('subj_29struct', 'subj_29struct');