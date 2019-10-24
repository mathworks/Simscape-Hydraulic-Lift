function startup_Hydraulic_Lift
% Copyright 2012-2019 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder);

% FOR CUSTOM ORIFICES
cd('Libraries');
if((exist('+Custom')==7) && ~exist('Custom_lib'))
    disp('Building Custom Simscape Library...');
    ssc_build Custom
    disp('Finished Building Library.');
end
cd(curr_proj.RootFolder);

evalin('base','Scissor_Lift_Model_PARAM');

ssc_hydraulic_lift_sethardstop('adjusted');
ssc_hydraulic_lift
