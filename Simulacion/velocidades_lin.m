function salida = velocidades_lin(entrada)
% Funcion que calcula las velocidades lineales experimentadas por el UAV
% en ejes de navegacion.
%
% salida = velocidades_lin(entrada)
%
% Siendo:
%
% U     = entrada(1);
% V     = entrada(2);
% W     = entrada(3);
% phi   = entrada(4);
% theta = entrada(5);
% psi   = entrada(6);
%
% V_N   = salida(1);
% V_E   = salida(2);
% V_D   = salida(3);


%% ENTRADA

U     = entrada(1);
V     = entrada(2);
W     = entrada(3);
phi   = entrada(4);
theta = entrada(5);
psi   = entrada(6);


%% CALCULO

% Matriz de rotacion de ejes cuerpo a ejes NED:  

R_bn = [cos(theta)*cos(psi) sin(phi)*sin(theta)*cos(psi)-cos(phi)*...
        sin(psi) cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
        cos(theta)*sin(psi) sin(phi)*sin(theta)*sin(psi)+cos(phi)*...
        cos(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
        -sin(theta) sin(phi)*cos(theta) cos(phi)*cos(theta)];

    
%% SALIDA

salida = R_bn*[U;V;W];