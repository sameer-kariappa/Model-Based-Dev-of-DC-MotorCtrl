% This script is to automate the codeGeneration of models contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Generating C Code...')

% Generate C Code
    mdlName = {'dcmtrCtrl_PID'};
    slbuild(mdlName) 
    % Saved in currentProject().SimulinkCodeGenFolder

% Cleanup
    disp('Code Generation complete.')