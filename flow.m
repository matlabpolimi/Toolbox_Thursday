clc
close all
clear all
%%
% Definizione delle costanti comuni
L = 1; % Lunghezza del condotto
h = 0.1; % Altezza del condotto

% Definizione della griglia per entrambi i flussi
x = linspace(0, L, 100);
y = linspace(0, h, 20);
[X, Y] = meshgrid(x, y);

% Definizione delle costanti specifiche per Couette
tau = 0.01; % Forza viscosa per unità di lunghezza

% Definizione delle costanti specifiche per Poiseuille
nu = 0.005; % Viscosità del fluido
deltaP = 0.2; % Differenza di pressione

% Calcolo del flusso di Couette normalizzato
U_couette = (tau / h) * Y / (tau / h * h);

% Calcolo del flusso di Poiseuille normalizzato
U_poiseuille = (deltaP / (2 * nu * h)) * (h^2 / 4 - (Y - h/2) .* (Y - h/2)) / (deltaP / (2 * nu * h) * (h^2 / 4));

% Plot del flusso di Couette
figure;
subplot(2, 2, 1);
contourf(X, Y, U_couette, 20, 'LineColor', 'none');
ax = gca; % current axes
ax.FontSize = 18;
xlabel('Channel length','fontsize',20)%'interpreter', 'latex');
ylabel('Channel height','fontsize',20)%,'interpreter', 'latex');
title('Couette flow','fontsize',24)%'interpreter', 'latex');

% Plot del flusso di Poiseuille
subplot(2, 2, 2);
contourf(X, Y, U_poiseuille, 20, 'LineColor', 'none');
ax = gca; % current axes
ax.FontSize = 18;
colorbar;
caxis([0 max(U_poiseuille, [], 'all')]);
xlabel('Channel length','fontsize',20);
ylabel('Channel height','fontsize',20);
title('Poiseuille flow','fontsize',24);
hold on;
quiver(X, Y, zeros(size(X)), -gradient(U_poiseuille), 1, 'k');

% Plot dei profili di velocità
subplot(2, 2, 3);
plot(U_couette(:, round(numel(y) / 2)), y, 'LineWidth', 2);
ax = gca; % current axes
ax.FontSize = 18;
xlabel('Normalized velocity','fontsize', 20)
ylabel('Channel height','fontsize', 20);
title('Couette velocity profile','fontsize',24)

subplot(2, 2, 4);
plot(U_poiseuille(:, round(numel(y) / 2)), y, 'LineWidth', 2);
ax = gca; % current axes
ax.FontSize = 18;
xlabel('Normalized velocity', 'fontsize', 20);
ylabel('Channel height','fontsize',20);
title('Poiseuille velocity profile','fontsize',24);