%% OPEN MODEL
mdl = 'ssc_hydraulic_lift';
open_system(mdl);
ssc_hydraulic_lift_setupRTtest

%% GET REFERENCE RESULTS
ssc_hydraulic_lift_setsolver(mdl,'desktop');
sim(mdl)
t_ref = tout; y_ref = yout(:,2);
clear tout yout

%% CREATE PLOT
figure(1)
temp_colororder = get(gca,'DefaultAxesColorOrder');
set(gcf,'Position',[552    50   472   301]);
plot(t_ref,y_ref,'k','LineWidth',3)
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Results');
legend({'Reference'},'Location','NorthEast')

%% LOAD REAL-TIME SIMULATION SOLVER SETTINGS
ssc_hydraulic_lift_setsolver(mdl,'realtime');
sim(mdl)
t_fs = tout; y_fs = yout(:,2);

%% ADD FIXED-STEP RESULTS TO PLOT
figure(1)
hold on
h2=stairs(t_fs, y_fs,'Color',temp_colororder(2,:),'LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step'},'Location','NorthEast')

%% ENABLE RUN-TIME PARAMETER
tune_bpth = [mdl '/Servo and Controller/Standard/Rotational Damper'];
set_param(tune_bpth,'D_conf','runtime');

% Highlight block
open_system(get_param(tune_bpth,'Parent'),'force')
set_param(tune_bpth,'Selected','on');


%% BUILD AND DOWNLOAD TO REAL-TIME TARGET
slbuild(mdl);

%% SET SIMULATION MODE TO EXTERNAL
set_param(mdl,'SimulationMode','External');

%% CONNECT TO TARGET AND RUN
set_param(mdl, 'SimMechanicsOpenEditorOnUpdate','off')
set_param(mdl, 'SimulationCommand', 'connect')
set_param(mdl, 'SimulationCommand', 'start')

open_system(mdl);
disp('Waiting for SLRT to finish...');
pause(1);
disp(get_param(bdroot,'SimulationStatus'));
while(~strcmp(get_param(bdroot,'SimulationStatus'),'stopped'))
    pause(2);
    disp(get_param(bdroot,'SimulationStatus'));
end
pause(2);

t_rt = tg.TimeLog; y_rt = tg.OutputLog(:,2);

%% PLOT REFERENCE AND REAL-TIME RESULTS
figure(1)
hold on
h3=stairs(t_rt,y_rt,'c:','LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step','Real-Time'},'Location','NorthEast');

%% CHANGE A SIMSCAPE BLOCK PARAMETER
md_ParamId = getparamid(tg,'','motor_damping');
disp(['Damping (current) = ' num2str(getparam(tg,md_ParamId))]);
setparam(tg,md_ParamId,0.2);
disp(['Damping (new) = ' num2str(getparam(tg,md_ParamId))]);

%% RUN SIMULATION ON REAL-TIME HARDWARE
tg.start

disp('Waiting for SLRT to finish...');
pause(1);
disp(tg.Status);
while(~strcmp(tg.Status,'stopped'))
    pause(2);
    disp(tg.Status);
end
pause(2);

t_rt2 = tg.TimeLog; y_rt2 = tg.OutputLog(:,2);

%% PLOT REFERENCE AND REAL-TIME RESULTS
figure(1)
hold on
h4=stairs(t_rt2,y_rt2,'Color',temp_colororder(4,:),'LineWidth',2);
hold off
legend({'Reference','Fixed-Step','Real-Time','Modified'},'Location','NorthEast');

% Copyright 2012-2018 The MathWorks(TM), Inc.
%% CLEAN UP DIRECTORY
cleanup_rt_dir
close(1)
