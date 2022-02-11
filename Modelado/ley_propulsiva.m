% Script que permite calcular la ley propulsiva. Calcula delta_t en Newton 
% a partir de los datos de telemetria de todos los vuelos ademas de
% representar graficas de interes con los resultados.

close all, clear all

%% CALCULO

delta_t        = [];
Ua             = [];
altitud        = [];
motor_pwm      = [];

for vuelo=1:5

    [delta_t2,Ua2,altitud2,motor_pwm2] = funleyprop(vuelo);
    
    delta_t        = [delta_t;delta_t2];
    Ua             = [Ua;Ua2];
    altitud        = [altitud;altitud2];
    motor_pwm      = [motor_pwm;motor_pwm2];
    
end

% Se ajustan los resultados por minimos cuadrados:

A1   = motor_pwm(:,2)-1100;
A2   = Ua.^2;
b    = delta_t;
long = length(A1);
A    = [A1(1) A2(1)];

for k=2:long
    
    A = [A; A1(k) A2(k)];
    
end

coefprop = (A.'*A)\(A.'*b);

% Grafica ajustada:

paso            = 10;
motor_pwm_ajust = 1100:paso:2100;
U_ajust         = 0:0.03*paso:30;
long            = length(motor_pwm_ajust);

for k=1:long
    
    delta_t_ajust(:,k) = (coefprop.'*[(motor_pwm_ajust(k)-1100)...
                          *ones(1,long);U_ajust.^2]).';
    
end

% Segun establece el PFC de Benito Fernandez Rojas, la potencia electrica
% generada en el motor es funcion de delta_t:

P_electrica = 0.0415315*((motor_pwm-1100)./1000).^2;


%% FIGURAS

figure; plot3(motor_pwm(:,2),Ua,delta_t,'.'); grid;
titulo1 = ['Fuerza propulsiva en funcion de la componente ' ...
           'longitudinal de la velocidad y la senal PWM del motor'];
title(titulo1);
xlabel('Canal 3 PWM (motor) [\mus]'); 
ylabel('U [m/s]'); 
zlabel('Delta t [N]');

figure; grid; 
grafica = scatter3(motor_pwm(:,2),Ua,delta_t,18,altitud(:,2),'.', ...
                   'MarkerFaceColor','auto');
grafica.Parent.Position = [0.1 0.1 0.76 0.82];
titulo2 = ['Fuerza propulsiva en funcion de la componente ' ...
           'longitudinal de la velocidad, la senal PWM del motor ' ...
           'y la altitud'];
title(titulo2);
xlabel('Canal 3 PWM (motor) [\mus]'); 
ylabel('U [m/s]'); 
zlabel('Delta t [N]');
barra_colores              = colorbar;
barra_colores.TickLabels   = {'0';'25';'50';'75';'100';'125';'150';...
                              '175';'200'};
barra_colores.Ticks        = [0:25:200];
barra_colores.Position     = [0.9 0.11 0.02 0.8];
barra_colores.Label.String = 'Altitud [m]';
barra_colores.FontSize     = 11;

figure; 
plot3(ones(long,1)*motor_pwm_ajust,U_ajust.'*ones(1,long),...
      delta_t_ajust,'b.'); 
grid;
texto   = ['Fuerza propulsiva ajustada por minimos cuadrados: ' ... 
           'Delta_t = %.6g·Motor_P_W_M%.6g·U^2'];
titulo3 = sprintf(texto,coefprop(1),coefprop(2));
title(titulo3);
xlabel('Canal 3 PWM (motor) [\mus]'); 
ylabel('U [m/s]'); 
zlabel('Delta t [N]');