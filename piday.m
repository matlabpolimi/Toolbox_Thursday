clc
clear all
close all

%% 
% Requires the Symbolic Math toolbox
symExpression = sym(pi); % Symbolic expression; e.g. sym(pi), exp(sym(1)), sym(1/23)
nDecimalPlaces = 10000; % Number of decimal places
decimalChar = char(vpa(mod(abs(symExpression),1),nDecimalPlaces+3));
decvec = decimalChar(3:end-3) - '0'

% Assign each digit an angular coordinate based on its value 0:9
nDecimals = numel(decvec);
theta = ((0:36:324)+(0:36/nDecimals:36)')*pi/180;
ang = theta(sub2ind(size(theta),1:nDecimals,decvec+1));
% Compute the length of each line segment; used to set color
[x,y] = pol2cart(ang,1);
[~,~,d] = uniquetol(hypot(diff(x),diff(y)));
alpha = min(0.85,max(0.006, 1000/nDecimals));
% Plot line segments using the edge property of a single Patch object
fig = figure(Color='k');
fig.Position(3:4) = 600;
movegui(fig)
ax = axes(fig);
p = patch(ax,XData=x,YData=y,FaceColor='none',EdgeAlpha=alpha);
set(p,'FaceVertexCData', [d;nan], 'EdgeColor','Flat')
colormap(ax,jet(10))
axis equal off
% Add pi character
text(0,0.05,'\pi', ...
 HorizontalAlignment='Center', ...
 FontUnits='normalized', ...
 FontSize = 0.2, ...
 Color = 'k');