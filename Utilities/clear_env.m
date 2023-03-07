function clear_env()

closeNoPrompt(matlab.desktop.editor.getAll);

sltest.testmanager.clearResults
sltest.testmanager.close

slLibraryBrowser
slLibraryBrowser('close')   % Close Simulink Library Browser

proj = currentProject;
cd(proj.RootFolder)

clear proj

% Clear up MATLAB to start the next run
close all                   % Close figures
bdclose all                 % Close models
evalin('base','clear')      % Clean up workspace
clc                         % Clean up command window


