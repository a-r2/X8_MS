function salida = controlador_psi(entrada)
% Funcion que calcula los parametros del controlador de psi.
%
% salida = controlador_psi(entrada)
%
% Siendo:
%
% Ua         = entrada(1);
% Va         = entrada(2);
% Wa         = entrada(3);
% rho        = entrada(4);
% g          = entrada(5);
% b          = entrada(6);
% Salar      = entrada(7);
% C_pdelta_a = entrada(8);
%
% Kp_psi     = salida(1);
% Ki_psi     = salida(2);


%% ENTRADA

Ua         = entrada(1);
Va         = entrada(2);
Wa         = entrada(3);
rho        = entrada(4);
g          = entrada(5);
b          = entrada(6);
Salar      = entrada(7);
C_pdelta_a = entrada(8);


%% COEFICIENTES

Uinf       = sqrt(Ua^2+Va^2+Wa^2);
delta_amax = 5*pi/180;
e_phimax   = 10*pi/180;
dseta_psi  = 1;   
s          = 40;
    

%% CALCULO

a_phi2 = 0.5*rho*Uinf^2*Salar*b*C_pdelta_a;
Kp_phi = delta_amax*sign(a_phi2)/e_phimax;
wn_psi = sqrt(Kp_phi*a_phi2)/s;
Kp_psi = 2*dseta_psi*wn_psi*Uinf/g;
Ki_psi = wn_psi^2*Uinf/g;


%% SALIDA

salida = [Kp_psi;Ki_psi];