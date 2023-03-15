function diff_pullrequest(modifiedFiles)
% Function to produce the diff reports as DOC files between the latest version
% of the master branch, and the HEAD of the merging branch. 
% This function takes the names of SLX files identified when running git diff.

% To run This function, you should first run a git diff
% $diffM= git diff --name-only --diff-filter=M $mergingBranch $latestMaster -- **/*.slx


    proj = currentProject;

    % List out names of all SLX files within Repo that were modified
    if isempty(modifiedFiles)
        disp('No modified models to compare.')
        return
    else
        modifiedFiles = split(modifiedFiles,[" ","\","/"]);
        idx = contains(modifiedFiles,".slx");
        modifiedFiles = modifiedFiles(idx);

        disp('List of Modified SLX Files:')
        disp(modifiedFiles)
    end
    
    % Create a temporary folder to store the ancestors of the modified models
    % If you have models with the same name in different folders, consider
    % creating multiple folders to prevent overwriting temporary models
    disp('Creating a copy of the existing master for diff')
    tempdir = fullfile(proj.RootFolder, "modelscopy");
    mkdir(tempdir)
    
    % Generate a comparison report for every modified model file
    for i = 1:numel(modifiedFiles)
        filePath = which(modifiedFiles{i});
        filePath = erase(filePath,fullfile(proj.RootFolder,'/'));
        disp(['Creating report for ' filePath])
        report = diffToAncestor(tempdir,string(filePath));
    end
    
    % Delete the temporary folder
    rmdir modelscopy s

    disp('ReportGen Complete!')



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function report = diffToAncestor(tempdir,fileName)
    
        ancestor = getAncestor(tempdir,fileName);
    
        % Compare models and publish results in a printable report
        % Specify the format using 'pdf', 'html', or 'doc'
            load_system(fileName)
            load_system(ancestor)
        
            comp= visdiff(ancestor, fileName);
            filter(comp, 'unfiltered');
            options = struct('Format','doc',...
                    'OutputFolder',fullfile(proj.RootFolder,'GeneratedArtifacts','DiffReports'));
            report = publish(comp,options);
        
            close_system(fileName)
            close_system(ancestor)

        function ancestor = getAncestor(tempdir,fileName)
            
            [relpath, name, ext] = fileparts(fileName);
            ancestor = fullfile(tempdir, name);
            
            % Replace seperators to work with Git and create ancestor file name
            fileName = strrep(fileName, '\', '/');
            ancestor = strrep(sprintf('%s%s%s',ancestor, "_ancestor", ext), '\', '/');
            
            % Build git command to get ancestor from main
            % git show refs/remotes/origin/main:models/modelname.slx > modelscopy/modelname_ancestor.slx
            gitCommand = sprintf('git show refs/remotes/origin/master:"%s" > "%s"', fileName, ancestor);
            
            [status, result] = system(gitCommand);
            assert(status==0, result);
        
        end
    end
end

%   Copyright 2022 The MathWorks, Inc.
