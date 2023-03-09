% This script is to automate the webview generation of models contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Generating Webview of DC Motor with the PID Controller...')

% Generate Webview
    mdlName = {'dcmtr_testharness'};
    load_system(mdlName);
    mdl_webView = slwebview(mdlName{1}, ...
        'FollowModelReference','on',...
        'PackageName', 'WebExplore_DCMtr_PIDCtrl',...
        'PackageFolder',fullfile(prj.RootFolder,'GeneratedArtifacts','WebViews'));

% Cleanup
    disp('Code Generation complete.')