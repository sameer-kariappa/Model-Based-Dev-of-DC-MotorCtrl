function genSimpleApp()
% This script is to automate the webview generation of models contained in this project

% List names of all models for which code is being generated
    mdlName = {'ssc_dcmtr_sl'};

% Get handle to project
    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)

% Generate Webview
    for i = 1:length(mdlName)
        disp(['Generating WebApp of ' mdlName{i} '...'])

        mkdir(mdlName{i})
        cd(mdlName{i})

        load_system(mdlName{i})
        simulink.compiler.genapp(mdlName{i}, 'AppName', ['App_' mdlName{i}])
        close_system(mdlName{i})

        cd ..

        movefile(mdlName{i},...
            fullfile(prj.RootFolder,'GeneratedArtifacts','DeployableApps'))
    end

% Cleanup
    disp('App Generation complete.')