function salida = controlador_h(entrada)
% Funcion que calcula los parametros del controlador de h.
%
% salida = controlador_h(entrada)
%
% Siendo:
%
% Ua         = entrada(1);
% Va         = entrada(2);
% Wa         = entrada(3);
% theta      = entrada(4);
% theta_ref  = entrada(5);
% rho        = entrada(6);
% c          = entrada(7);
% Salar      = entrada(8);
% Iy         = entrada(9);
% C_malpha   = entrada(10);
% C_mdelta_e = entrada(11);
%
% Kp_h       = salida(1);
% Ki_h       = salida(2);


%% ENTRADA

Ua         = entrada(1);
Va         = entrada(2);
Wa         = entrada(3);
theta      = entrada(4);
theta_ref  = entrada(5);
rho        = entrada(6);
c          = entrada(7);
Salar      = entrada(8);
Iy         = entrada(9);
C_malpha   = entrada(10);
C_mdelta_e = entrada(11);


%% COEFICIENTES

Uinf       = sqrt(Ua^2+Va^2+Wa^2);
delta_emax = 5*pi/180;
e_thetamax = 10*pi/180;
dseta_h    = 1;
s          = 40;

% Singularidad en theta nulo:

if abs(theta)>1
    
    Ktheta_dc = theta/theta_ref;
    
else
    
    Ktheta_dc = 1;
    
end


%% CALCULO

a_theta2 = -0.5*rho*Uinf^2*c*Salar*C_malpha/Iy;
a_theta3 = 0.5*rho*Uinf^2*c*Salar*C_mdelta_e/Iy;
wn_h     = (sqrt(a_theta2+(delta_emax*abs(a_theta3)/e_thetamax)))/s;
Kp_h     = 2*dseta_h*wn_h/(Ktheta_dc*Uinf+1e-16);
Ki_h     = wn_h^2/(Ktheta_dc*Uinf+1e-16);


%% SALIDA

salida = [Kp_h;Ki_h];