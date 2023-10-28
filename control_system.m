%% Questo codice analizza la risposta in frequenza di un sistema massa-molla-smorzatore al variare del coefficiente di smorzamento c
%TOOLBOX utilizzato --> CONTROL SYSTEM
%% clc
close all
clear all
%%
% Parametri del sistema
m = 1; % massa
k = 1; % costante della molla
c_values = [0.1, 0.5, 1, 2]; % diversi valori di coefficiente di smorzamento

% Definizione del sistema per diversi valori di c
for i = 1:length(c_values)
    c = c_values(i);
    sys{i} = tf(1, [m, c, k]);
end

% Definizione delle frequenze
w = logspace(-1, 2, 100);

% Calcolo delle risposte in frequenza per diversi valori di c
response_mag = zeros(length(w), length(c_values));
response_phase = zeros(length(w), length(c_values));
for i = 1:length(c_values)
    [response_mag(:, i), response_phase(:, i)] = bode(sys{i}, w);
end

% Tracciamento della risposta in frequenza per ampiezza
figure;
subplot(2, 1, 1);
set(groot,'defaultAxesTickLabelInterpreter','latex');  
semilogx(w, squeeze(response_mag), 'LineWidth', 1.5);
grid on
title('Ampiezza rispetto alla frequenza per diversi valori di smorzamento','fontsize',14,'interpreter','latex');
xlabel('Frequenza','fontsize',14,'interpreter','latex');
ylabel('Ampiezza','fontsize',14,'interpreter','latex');
legend('c = 0.1', 'c = 0.5', 'c = 1', 'c = 2');

% Tracciamento della risposta in frequenza per fase
subplot(2, 1, 2);
semilogx(w, squeeze(response_phase), 'LineWidth', 1.5);
grid on
title('Fase rispetto alla frequenza per diversi valori di smorzamento','fontsize',14,'interpreter','latex');
xlabel('Frequenza','fontsize',14,'interpreter','latex');
ylabel('Fase (radianti)','fontsize',14,'interpreter','latex');
legend('c = 0.1', 'c = 0.5', 'c = 1', 'c = 2');