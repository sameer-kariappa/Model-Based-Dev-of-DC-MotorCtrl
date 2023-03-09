% Load the Test Harness
    harnessMdl = 'dcmtrCtrl_PID_Harness0';
    load_system(harnessMdl);

% Change the action in the verificaiton block, to look for maxV of 4.75
    blk         = 'dcmtrCtrl_PID_Harness0/Test Assessment';
    stepPath    = 'MONITOR_MAX_VOLT';
    takeAction = sprintf('verify( abs(V) <= 4.75);');

% Save Changes
    save_system(harnessMdl);
    close_system(harnessMdl);

system('git commit -m "Intentionally create fault"')
system('git push')