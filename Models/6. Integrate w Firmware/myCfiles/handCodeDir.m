function [filepath] = handCodeDir()
    % This returns the folder locaiton of where this file is. 
    % Make sure you co-locate this m file with your handcode

    mFileDirectory = mfilename("fullpath");
    [filepath,~,~] = fileparts(mFileDirectory);
    
end

