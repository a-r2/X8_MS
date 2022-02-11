function salida = velocidades_ang(entrada)
% Funcion que calcula las velocidades angulares experimentadas por el UAV
% en ejes de navegacion.
%
% salida = velocidades_ang(entrada)
%
% Siendo:
%
% P     = entrada(1);
% Q     = entrada(2);
% R     = entrada(3);
% phi   = entrada(4);
% theta = entrada(5);
%
% W_N   = salida(1);
% W_E   = salida(2);
% W_D   = salida(3);


%% ENTRADA

P     = entrada(1);
Q     = entrada(2);
R     = entrada(3);
phi   = entrada(4);
theta = entrada(5);


%% SALIDA

salida = [1   sin(phi)*tan(theta)   cos(phi)*tan(theta); 
          0        cos(phi)             -sin(phi)      ;
          0   sin(phi)/cos(theta)   cos(phi)/cos(theta)]*[P;Q;R];