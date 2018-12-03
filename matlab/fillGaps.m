% This is a function that fills all of the data gaps that occurred due to
% marker occlusion. It takes loops through all 10 Qualisys files from a subject's
% folder, converts them to a MoCap data structure, applies the MoCap mcfillgaps function
% and stores them in a cell.

function filled_Gaps = fillGaps(folder)
    % This takes the folder and store all the .mat files names in an array
    fileNames = dir(fullfile(folder, '*.mat'));
    % Gives the number of files
    numFiles = length(fileNames);
    % Creates a cell to store everything
    filled_Gaps = cell(1, numFiles); % pre allocate (good practice)
    
    % Starts to loop through all files
    for ii = 1:numFiles
       % You need the full file to be able to load it! Must include the
       % folder name and file name
       hello = fullfile(folder,fileNames(ii).name);
       load(hello);
       % Convert to a MoCap structure
       mcStruct = mcread(hello);
       % Fills the gaps and stores it into the cell
       filled_Gaps{ii} = mcfillgaps(mcStruct);
    end
end