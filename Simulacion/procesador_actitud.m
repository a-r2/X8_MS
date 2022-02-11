function salida = procesador_actitud(entrada)
% Funcion que procesa la actitud del UAV con el objetivo de limitar los
% rangos de definicion de los angulos de Euler: phi, theta y psi. De esta
% manera, dichos angulos abarcan [-180º, 180º), [-90º, 90º) y [0º, 359º) 
% respectivamente. 
%
% salida = procesador_actitud(entrada)
%
% Siendo:
%
% phi    = entrada(1);
% theta  = entrada(2);
% psi    = entrada(3);
%
% phi_   = salida(1);
% theta_ = salida(2);
% psi_   = salida(3);


%% ENTRADA

phi   = entrada(1);
theta = entrada(2);
psi   = entrada(3);


%% CALCULO

phi_   = 2*pi*(phi/(2*pi)-floor(0.5+phi/(2*pi)));

theta_ = pi*(theta/pi-floor(0.5+theta/pi));

psi_   = mod(psi,2*pi);


%% SALIDA

salida = [phi_;theta_;psi_];