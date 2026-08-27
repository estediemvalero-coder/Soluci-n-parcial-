clc;
clear;
close all;

%% DATOS OBTENIDOS DE LA FIGURA

f0 = 100e3;       % Frecuencia fundamental [Hz]
V = 1;            % Amplitud del pulso [V]

%% PASO 1: CALCULAR EL PERIODO

T = 1/f0;

%% PASO 2: ANCHO DEL PULSO

% La escala horizontal es 5 us/div
% El pulso ocupa aproximadamente 0.4 divisiones

tau = 0.4 * 5e-6;

%% PASO 3: CICLO UTIL

D = tau/T;

%% PASO 4: COMPONENTE DC

Vdc = V*D;

%% PASO 5: CALCULAR LOS 10 PRIMEROS ARMONICOS

n = 1:10;

% Frecuencia de cada armonico
fn = n*f0;

% Magnitud de cada armonico
An = abs((2*V./(n*pi)).*sin(n*pi*D));

%% MOSTRAR RESULTADOS

fprintf('RESULTADOS DEL PUNTO 2\n\n');

fprintf('Frecuencia fundamental = %.2f kHz\n', f0/1000);
fprintf('Periodo = %.2f us\n', T*1e6);
fprintf('Ancho del pulso = %.2f us\n', tau*1e6);
fprintf('Ciclo util = %.2f %%\n', D*100);
fprintf('Componente DC = %.2f V\n\n', Vdc);

fprintf('ARMONICOS\n');
fprintf('---------------------------------------\n');
fprintf('n    Frecuencia (kHz)    Magnitud (V)\n');
fprintf('---------------------------------------\n');

for i = 1:10
    fprintf('%d       %.2f             %.4f\n', ...
        n(i), fn(i)/1000, An(i));
end

%% CREAR TABLA

tabla = table(n', fn'/1000, An', ...
    'VariableNames', {'Armonico','Frecuencia_kHz','Magnitud_V'});

disp(' ');
disp(tabla);

%% GRAFICA DE LA SEÑAL

Fs = 10e6;
t = 0:1/Fs:5*T;

senal = V*(mod(t,T) < tau);

figure;
plot(t*1e6, senal, 'LineWidth', 1.5);
grid on;

xlabel('Tiempo (\mus)');
ylabel('Voltaje (V)');
title('Tren de pulsos');

%% GRAFICA DE LOS ARMONICOS

figure;
stem(fn/1000, An, 'filled');
grid on;

xlabel('Frecuencia (kHz)');
ylabel('Magnitud (V)');
title('Primeros 10 armonicos');