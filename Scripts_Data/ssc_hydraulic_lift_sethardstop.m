function ssc_hydraulic_lift_sethardstop(paramset)

if strcmpi(paramset,'initial')
    evalin('base','actuator_hs_k = 1e8;')
    evalin('base','actuator_hs_b = 1500;')
else
    evalin('base','actuator_hs_k = 1e6;')
    evalin('base','actuator_hs_b = 1500;')
end
