% Copyright 2012-2016 The MathWorks, Inc.

HydrLift_Homedir = pwd;
addpath(pwd);
addpath([pwd '\Images']);
addpath([pwd '\Scripts_Data']);
addpath([pwd '\Libraries']);
addpath([pwd '\Libraries\Images']);
addpath([pwd '\SimResults']);

% FOR CUSTOM ORIFICES
cd('Libraries');
if((exist('+Custom')==7) && ~exist('Custom_lib'))
    disp('Building Custom Simscape Library...');
    ssc_build Custom
    disp('Finished Building Library.');
end
cd ..;

Scissor_Lift_Model_PARAM
ssc_hydraulic_lift_sethardstop('adjusted');
ssc_hydraulic_lift

