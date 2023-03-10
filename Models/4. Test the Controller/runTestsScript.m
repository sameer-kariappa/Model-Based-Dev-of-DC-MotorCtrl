% This script is to automate the tests contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Running Model Tests...')

% Load test file
    testSuite = sltest.testmanager.load('dcmtrCTRL_PID_Tests.mldatx');

% Run the tests
    result = run(testSuite)

% Save results
    sltest.testmanager.exportResults(result,...
        fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults','Test Results.mldatx'))

% Generate C Code
    % mdlName = {'dcmtrCtrl_PID','dcmtrCtrl_PID_send2Ardu',...
    %           'dcmtrCtrl_PID_wHandCode'};
    % slbuild(mdlName) 
    % % Saved in currentProject().SimulinkCodeGenFolder

% Cleanup
    disp('Tests complete.')
    sltest.testmanager.clearResults
    sltest.testmanager.clear