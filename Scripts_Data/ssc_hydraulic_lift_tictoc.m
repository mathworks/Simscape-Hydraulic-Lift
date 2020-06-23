function ssc_hydraulic_lift_tictoc(mdl,enable)
% Copyright 2011-2020 The MathWorks, Inc.

if(strcmpi(enable,'on'))
    set_param(mdl,'StartFcn','tic;');
    set_param(mdl,'StopFcn','Elapsed_Sim_Time = toc; disp([''Elapsed time for '' bdroot '' = '' num2str(Elapsed_Sim_Time)])');
else    
    set_param(mdl,'StartFcn','');
    set_param(mdl,'StopFcn','');
end