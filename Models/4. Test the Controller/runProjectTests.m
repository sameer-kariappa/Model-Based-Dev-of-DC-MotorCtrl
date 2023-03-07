% This script is to automate the tests contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Running Model Tests...')

% Run the tests
    testSuite = sltest.testmanager.load('dcmtrCTRL_PID_Tests.mldatx');
    result = run(testSuite)
    
% Generate C Code
    % mdlName = {'dcmtrCtrl_PID','dcmtrCtrl_PID_send2Ardu',...
    %           'dcmtrCtrl_PID_wHandCode'};
    % slbuild(mdlName) 
    % % Saved in currentProject().SimulinkCodeGenFolder

% Save test results
    disp('Saving test results...')
    sltest.testmanager.exportResults(result,...
        fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults','Test Results.mldatx'))

% Publish testing report
    sltest.testmanager.report(result, ...
        fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults','testingReport.zip'),...
        'IncludeTestResults',0,'IncludeComparisonSignalPlots',true,...
        'IncludeSimulationSignalPlots',true,'NumPlotRowsPerPage',3);

% Cleanup
    disp('Tests complete.')
    sltest.testmanager.clearResults
    sltest.testmanager.clear