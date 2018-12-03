function [pert_Files] = storePerturbations(folder)
    pert_Files = dir(fullfile(folder, '*.mat'));
end

