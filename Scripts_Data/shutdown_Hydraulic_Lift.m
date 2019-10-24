function shutdown_Hydraulic_Lift
% Copyright 2012-2019 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder);

% FOR CUSTOM ORIFICES
cd('Libraries');
if(exist('+Custom','dir') && exist('Custom_lib.slx','file'))
    bdclose('Custom_lib')
    ssc_clean Custom
end
cd(curr_proj.RootFolder);

