function [xy_data] = Extr_Data_LinkHoles(L, W, r, num_holes, varargin)
%Extr_Data_LinkHoles Produce extrusion data for a link with an arbitrary
%number of holes and rounded ends.
%   [xy_data] = Extr_Data_LinkHoles(L, W, r, num_holes)
%   This function returns x-y data for a link with half a hole at one end.
%   You can specify:
%       Length      L
%       Width       W
%       Hole radius r
%       # holes 	num_holes
%
%   To see a plot showing parameter values, enter the name
%   of the function with no arguments
%   >> Extr_Data_LinkHoles
%
%   To see a plot created with your parameter values, 
%   add 'plot' as the final argument
%   >> Extr_Data_LinkHoles(10,5,1,3,'plot')

% Copyright 2012-2017 The MathWorks, Inc.

% DEFAULT DATA TO SHOW DIAGRAM
if (nargin == 0)
    L = 15;
    W = 5;
    r = 1;
    num_holes = 4;
end

% CHECK IF PLOT SHOULD BE PRODUCED
if (isempty(varargin))
    showplot = 'n';
else
    showplot = varargin;
end


% Half length and width
hl = L / 2;
hw = W / 2;

% Rounded ends and outer boundary of member
theta = (-89:1:+90)' * pi/180; % CCW
rght_end = repmat([hl 0], 180, 1) + hw * [cos(theta), sin(theta)];
left_end = flipud(rght_end) * diag([-1 1]);
boundary = [rght_end; left_end];

% Circular holes
theta = (270:-1:-90)' * pi/180; % CW
hole = [[0 -hw]; r * [cos(theta), sin(theta)]; [0 -hw]];
holes = kron(linspace(-hl, +hl, num_holes)', repmat([1 0], 363, 1)) ...
    + repmat(hole, num_holes, 1);

xy_data = [boundary; holes];

% PLOT DIAGRAM TO SHOW PARAMETERS AND EXTRUSION
if (nargin == 0 || strcmpi(showplot,'plot'))
    % PLOT EXTRUSION
    plot(xy_data(:,1),xy_data(:,2),'b-o','LineWidth',1.5);
    axis('square');
    axis([-1 1 -1 1]*(L+W)*1.1/2);
    
    % SHOW PARAMETERS
    hold on
    
    plot([-L/2 L/2],[0 0],'r-d','MarkerFaceColor','r');
    text(0,0.5,'{\color{red}L}');
    plot([L/4 L/4],[-W/2 W/2],'g-d','MarkerFaceColor','g');
    text(L/4,W/2+0.5,'{\color{green}W}');
    plot([-L/2 -L/2+r*sin(30*pi/180)],[0 r*cos(30*pi/180)],'k-d','MarkerFaceColor','k');
    text(-L/2+r*sin(30*pi/180)+0.5,1.1*r*cos(30*pi/180)+0.5,'r');
    
    title('[xy\_data] = Extr\_Data\_LinkHoles(L, W, r, num\_holes);');
    
    hold off
    clear xy_data
end


