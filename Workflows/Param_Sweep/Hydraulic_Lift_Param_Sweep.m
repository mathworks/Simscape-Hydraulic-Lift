%% Script to run ssc_hydraulic_lift in parallel

% Resave model in directory where script lives
cd(fileparts(which(mfilename)));
orig_mdl = 'ssc_hydraulic_lift';
open_system(orig_mdl);
mdl = [orig_mdl '_pct_temp'];
ssc_hydraulic_lift_setdefault(orig_mdl)
ssc_hydraulic_lift_tictoc(orig_mdl,'off')
set_param([orig_mdl '/SLRT Scope'],'Commented','on');
set_param(orig_mdl,'SimscapeLogType','none');
set_param([orig_mdl '/Servo and Controller/Custom/Rotational Damper'],'D_conf','runtime');
save_system(orig_mdl,mdl);

%clear motor_damping;
%motor_damping = 0.01;

%% GENERATE PARAMETER SETS
motordamp_array = [0.01:0.01:0.2]; 

for i=1:length(motordamp_array)
    simInput(i) = Simulink.SimulationInput(mdl);
    simInput(i) = simInput(i).setVariable('motor_damping',motordamp_array(i));
end

%% START PARALLEL POOL
clear simOut
gcp('nocreate');

% Series
simOut  = sim(simInput,'ShowProgress','on','UseFastRestart','on');

%% PLOT RESULTS
if ~exist('h4_ssc_hydraulic_lift_pct', 'var') || ...
        ~isgraphics(h4_ssc_hydraulic_lift_pct, 'figure')
    h4_ssc_hydraulic_lift_pct = figure('Name', 'ssc_hydraulic_lift_pct');
end
figure(h4_ssc_hydraulic_lift_pct)
clf(h4_ssc_hydraulic_lift_pct)

set(gcf,'Position',[15    52   545   355]);

for i=1:length(simOut)
    data = simOut(i).LoadPosition_DATA;
    plot(data.time(:,1),data.signals.values(:,2))
    hold all
end
plot(data.time(:,1),data.signals.values(:,1),'k--','LineWidth',1)
title('Parameter Sweep Results');
xlabel('Time (s)');
ylabel('Load Position');

%% Parallel
set_param(mdl,'SimMechanicsOpenEditorOnUpdate','off');
save_system(mdl)
simOut  = parsim(simInput,'ShowProgress','on','UseFastRestart','on','ShowSimulationManager','on','TransferBaseWorkspaceVariables','on');
set_param(mdl,'SimMechanicsOpenEditorOnUpdate','on');
save_system(mdl)

%% CLOSE PARALLEL POOL
delete(gcp);

%% CLEANUP DIR
bdclose(mdl);
!rmdir slprj /S/Q
delete([mdl '.slx']);

% Copyright 2013-2019 The MathWorks(TM), Inc.

