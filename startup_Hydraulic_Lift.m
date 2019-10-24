% Copyright 2012-2017 The MathWorks, Inc.

HydrLift_Homedir = pwd;
addpath(pwd);
addpath([pwd filesep 'Images']);
addpath([pwd filesep 'Scripts_Data']);
addpath([pwd filesep 'Libraries']);
addpath([pwd filesep 'Libraries' filesep 'Images']);
addpath([pwd filesep 'Supporting_Models']);
addpath([pwd filesep 'SimResults']);

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

