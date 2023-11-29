clc
close all
clear all

%%
% Parametri del modello
beta = 0.3; % Tasso di trasmissione
gamma = 0.1; % Tasso di recupero
N = 1000; % Popolazione totale
I0 = 1; % Individui infetti iniziali
R0 = 0; % Individui guariti iniziali
S0 = N - I0 - R0; % Individui suscettibili iniziali

% Condizioni iniziali
y0 = [S0; I0; R0];

% Intervallo di tempo
tspan = [0 100];

% Risoluzione del modello
[t, y] = ode45(@(t, y) SIR_equations(t, y, beta, gamma, N), tspan, y0);

% Visualizzazione dei risultati
figure;

% Grafico delle popolazioni S, I, R nel tempo
subplot(2, 1, 1);
set(groot,'defaultAxesTickLabelInterpreter','latex'); 
plot(t, y(:, 1), 'b', 'LineWidth', 2);
grid on
hold on;
set(gca, 'FontSize', 18)
plot(t, y(:, 2), 'r', 'LineWidth', 2);
plot(t, y(:, 3), 'g', 'LineWidth', 2);
title('Modello SIR per un''epidemia', 'fontsize', 24, 'interpreter', 'latex');
xlabel('Tempo', 'fontsize', 22, 'interpreter', 'latex');
ylabel('Popolazione' ,'fontsize', 22, 'interpreter', 'latex');
legend('Suscettibili', 'Infetti', 'Guariti', 'fontsize', 22, 'interpreter', 'latex');
hold off;

% Grafico del tasso di cambio dei casi infetti nel tempo
subplot(2, 1, 2);
dI = diff(y(:, 2));
plot(t(2:end), dI, 'm', 'LineWidth', 2);
grid on
title('Tasso di cambio dei casi infetti', 'fontsize', 24, 'interpreter', 'latex');
xlabel('Tempo', 'fontsize', 22, 'interpreter', 'latex');
ylabel('Variazione dei casi infetti', 'fontsize', 22, 'interpreter', 'latex');
set(gca, 'FontSize', 22)

% Definizione delle equazioni differenziali del modello SIR
function dydt = SIR_equations(~, y, beta, gamma, N)
    dydt = [-beta * y(1) * y(2) / N;
            beta * y(1) * y(2) / N - gamma * y(2);
            gamma * y(2)];
end