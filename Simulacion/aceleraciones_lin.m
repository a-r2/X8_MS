function salida = aceleraciones_lin(entrada)
% Funcion que calcula las aceleraciones lineales experimentadas por el UAV
% en ejes cuerpo.
%
% salida = aceleraciones_lin(entrada)
%
% Siendo:
%
% U       = entrada(1);
% V       = entrada(2);
% W       = entrada(3);
% P       = entrada(4);
% Q       = entrada(5);
% R       = entrada(6);
% Fx      = entrada(7);
% Fy      = entrada(8);
% Fz      = entrada(9);
% m       = entrada(10);
%
% U_punto = salida(1);
% V_punto = salida(2);
% W_punto = salida(3);


%% ENTRADA

U  = entrada(1);
V  = entrada(2);
W  = entrada(3);
P  = entrada(4);
Q  = entrada(5);
R  = entrada(6);
Fx = entrada(7);
Fy = entrada(8);
Fz = entrada(9);
m  = entrada(10);


%% SALIDA

salida = [R*V-Q*W; P*W-R*U; Q*U-P*V]+[Fx;Fy;Fz]/m;