function createArtifactFolders()
% This script creates all the artifact holding folders

folderNames = {'DiffReports', 'CheckResults', 'TestResults' , 'CodeGen' , 'Webviews', 'DeployableApps'};

% Get handle to project
    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Generating Folders for Artifacts...')

% Create required folders, if they dont already exist
for i = 1:length(folderNames)
    if  isfolder(fullfile(prj.RootFolder,'GeneratedArtifacts',folderNames{i}))
    else
        mkdir(fullfile(prj.RootFolder,'GeneratedArtifacts',folderNames{i}))
    end
end

disp('Done!')
