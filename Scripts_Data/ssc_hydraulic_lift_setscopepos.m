% Copyright 2012-2018 The MathWorks, Inc.
a=find_system(bdroot,'Name','Position');
set_param(a{1},'Open','on');
shh=findall(0,'Tag','SIMULINK_SIMSCOPE_FIGURE');
set(shh,'Position',[913  314.6 350.4  200.8]);
clc;
