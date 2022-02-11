function salida = fuerzas(entrada)
% Funcion que calcula las fuerzas ejercidas sobre el UAV en ejes cuerpo.
%
% salida = fuerzas(entrada)
%
% Siendo:
% 
% alpha   = entrada(1);
% beta    = entrada(2);
% Uinf    = entrada(3);
% C_L     = entrada(4);
% C_D     = entrada(5);
% C_Y     = entrada(6);
% phi     = entrada(7);
% theta   = entrada(8);
% psi     = entrada(9);
% delta_t = entrada(10);
% rho     = entrada(11);
% g       = entrada(12);
% m       = entrada(13);
% Salar   = entrada(14);
%
% Fx      = salida(1);
% Fy      = salida(2);
% Fz      = salida(3);


%% ENTRADA

alpha   = entrada(1);
beta    = entrada(2);
Uinf    = entrada(3);
C_L     = entrada(4);
C_D     = entrada(5);
C_Y     = entrada(6);
phi     = entrada(7);
theta   = entrada(8);
psi     = entrada(9);
delta_t = entrada(10);
rho     = entrada(11);
g       = entrada(12);
m       = entrada(13);
Salar   = entrada(14);


%% CALCULO

% Matriz de rotacion de ejes viento a ejes cuerpo:

R_wb = [cos(alpha)*cos(beta) -cos(alpha)*sin(beta) -sin(alpha) ; ...
            sin(beta)               cos(beta)           0      ; ...
        sin(alpha)*cos(beta) -sin(alpha)*sin(beta)  cos(alpha)];
    
% Matriz de rotacion de ejes NED a ejes cuerpo:

R_nb = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
        sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
        sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta); ...
        cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*...
        sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)];

    
%% FUERZAS

salida = -0.5*rho*Uinf^2*Salar*R_wb*[C_D;0;C_L]+0.5*rho*Uinf^2*Salar*...
         [0;C_Y;0]+R_nb*[0;0;m*g]+[delta_t;0;0];