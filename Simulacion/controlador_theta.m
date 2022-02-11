function salida = controlador_theta(entrada)
% Funcion que calcula los parametros del controlador de theta.
%
% salida = controlador_theta(entrada)
%
% Siendo:
%
% Ua         = entrada(1);
% Va         = entrada(2);
% Wa         = entrada(3);
% rho        = entrada(4);
% c          = entrada(5);
% Salar      = entrada(6);
% Iy         = entrada(7);
% C_malpha   = entrada(8);
% C_mq       = entrada(9);
% C_mdelta_e = entrada(10);
%
% Kp_theta   = salida(1);
% Kd_theta   = salida(2);


%% ENTRADA

Ua         = entrada(1);
Va         = entrada(2);
Wa         = entrada(3);
rho        = entrada(4);
c          = entrada(5);
Salar      = entrada(6);
Iy         = entrada(7);
C_malpha   = entrada(8);
C_mq       = entrada(9);
C_mdelta_e = entrada(10);


%% COEFICIENTES

Uinf        = sqrt(Ua^2+Va^2+Wa^2);
delta_emax  = 5*pi/180;
e_thetamax  = 10*pi/180;
dseta_theta = 1;


%% CALCULO

a_theta1 = -0.25*rho*Uinf*c^2*Salar*C_mq/Iy;
a_theta2 = -0.5*rho*Uinf^2*c*Salar*C_malpha/Iy;
a_theta3 = 0.5*rho*Uinf^2*c*Salar*C_mdelta_e/Iy;
Kp_theta = delta_emax*sign(a_theta3)/e_thetamax;
wn_theta = sqrt(a_theta2+(delta_emax*abs(a_theta3)/e_thetamax));
Kd_theta = (2*dseta_theta*wn_theta-a_theta1)/a_theta3;


%% SALIDA

salida = [Kp_theta;Kd_theta];