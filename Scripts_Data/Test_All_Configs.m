% Copyright 2013 The MathWorks, Inc.
mdl = 'Hydraulic_Lift';
open_system(mdl);
Motor_Conf = {'Custom' 'Standard'};
Valve_Conf = Motor_Conf;
Actuator_Conf = Motor_Conf;
Load_Conf = {'Simple' 'Scissor'};
Solver_Conf = {'Desktop' 'Real Time'};

for i = 1:length(Solver_Conf)
    open_system([bdroot '/' Solver_Conf{i} ' Settings']);
    for j = 1:length(Motor_Conf)
    open_system([bdroot '/Configure/Commands/Use ' Motor_Conf{j} ' Motor']);
    for k = 1:length(Valve_Conf)
    open_system([bdroot '/Configure/Commands/Use ' Valve_Conf{k} ' Valve']);
    for l = 1:length(Actuator_Conf)
    open_system([bdroot '/Configure/Commands/Use ' Actuator_Conf{l} ' Actuator']);
    for m = 1:length(Load_Conf)
    open_system([bdroot '/Configure/Commands/Use ' Load_Conf{m} ' Load']);
    disp([Solver_Conf{i} '; M:' Motor_Conf{j} '; V:' Valve_Conf{k}  '; A:' Actuator_Conf{l} '; L: ' Load_Conf{m} ]);;
    sim(bdroot);
    end
    end
    end
    end
end

    

