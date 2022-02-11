function salida = momentos(entrada)
% Funcion que calcula los momentos ejercidos sobre el UAV en ejes cuerpo.
%
% salida = momentos(entrada)
%
% Siendo:
% 
% Uinf    = entrada(1);
% C_l     = entrada(2);
% C_m     = entrada(3);
% C_n     = entrada(4);
% rho     = entrada(5);
% b       = entrada(6);
% c       = entrada(7);
% Salar   = entrada(8);
%
% L       = salida(1);
% M       = salida(2);
% N       = salida(3);


%% ENTRADA

Uinf    = entrada(1);
C_l     = entrada(2);
C_m     = entrada(3);
C_n     = entrada(4);
rho     = entrada(5);
b       = entrada(6);
c       = entrada(7);
Salar   = entrada(8);


%% MOMENTOS

salida = 0.5*rho*Uinf^2*Salar*[b*C_l;c*C_m;b*C_n];