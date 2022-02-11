function salida = aceleraciones_ang(entrada)
% Funcion que calcula las aceleraciones angulares experimentadas por el UAV
% en ejes cuerpo.
%
% salida = aceleraciones_ang(entrada)
%
% Siendo:
%
% P       = entrada(1);
% Q       = entrada(2);
% R       = entrada(3);
% L       = entrada(4);
% M       = entrada(5);
% N       = entrada(6);
% Iy      = entrada(7);
% gamma1  = entrada(8);
% gamma2  = entrada(9);
% gamma3  = entrada(10);
% gamma4  = entrada(11);
% gamma5  = entrada(12);
% gamma6  = entrada(13);
% gamma7  = entrada(14);
% gamma8  = entrada(15);
%
% P_punto = salida(1);
% Q_punto = salida(2);
% R_punto = salida(3);


%% ENTRADA

P      = entrada(1);
Q      = entrada(2);
R      = entrada(3);
L      = entrada(4);
M      = entrada(5);
N      = entrada(6);
Iy     = entrada(7);
gamma1 = entrada(8);
gamma2 = entrada(9);
gamma3 = entrada(10);
gamma4 = entrada(11);
gamma5 = entrada(12);
gamma6 = entrada(13);
gamma7 = entrada(14);
gamma8 = entrada(15);


%% ACELERACIONES ANGULARES

salida = [gamma1*P*Q-gamma2*Q*R; gamma5*P*R-gamma6*(P^2-R^2); ...
          gamma7*P*Q-gamma1*Q*R]+[gamma3*L+gamma4*N; M/Iy; ...
          gamma4*L+gamma8*N];