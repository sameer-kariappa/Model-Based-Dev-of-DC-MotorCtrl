function [output] = pointCalc()
% Create persistent variables to save the test data, and an index "idx1"
% Persistent variables are created at the start of a sim, and get deleted
% automatically at the end of a sim

 persistent idx1 vehicleData
        
    if isempty(idx1)
        idx1 = 0;
        externalInfo = load('TestData.mat');
        vehicleData = externalInfo.vTrace;
        
        output = 0;
        return
    else
        idx1 = idx1 + 1;
        output = vehicleData(idx1);
    end

end

