% Copyright 2012 The MathWorks, Inc.

addpath([pwd '\Images']);
addpath([pwd '\Scripts_Data']);
addpath([pwd '\Libraries']);
addpath([pwd '\Libraries\Images']);

% FOR CUSTOM ORIFICES
cd('Libraries');
if((exist('+Custom')==7) && ~exist('Custom_lib'))
    disp('Building Custom Simscape Library...');
    ssc_build Custom
    disp('Finished Building Library.');
end
cd ..;

Scissor_Lift_Model_PARAM

Hydraulic_Lift

