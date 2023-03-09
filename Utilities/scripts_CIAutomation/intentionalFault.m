% This script was created to be run from within the project itself on your
% local MATLAB instance. It intentionally creates a testcase change that
% will fail the test. This allows you to demo CICD workflows.

% Load the Test Harness
    harnessMdl = 'dcmtrCtrl_PID_Harness0';
    load_system(harnessMdl);

% Change the action in the verificaiton block, to look for maxV of 4.75
    blk         = 'dcmtrCtrl_PID_Harness0/Test Assessment';
    stepPath    = 'MONITOR_MAX_VOLT';
    takeAction  = sprintf('verify( abs(V) <= 4.75);');

% Save Changes
    save_system(harnessMdl);
    close_system(harnessMdl);

% Commit changes to git and push
 [~,cmdout] = system('git commit -a -m "Intentionally create fault"');
 disp(cmdout)
 [~,cmdout] = system('git push');
 disp(cmdout)