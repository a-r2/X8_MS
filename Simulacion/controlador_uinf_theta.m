function salida = controlador_uinf_theta(entrada)
% Funcion que calcula los parametros del controlador de Uinf (theta).
%
% salida = controlador_uinf_theta(entrada)
%
% Siendo:
%
% Ua           = entrada(1);
% Va           = entrada(2);
% Wa           = entrada(3);
% Uinf_ref     = entrada(4);
% alpha_trim   = entrada(5);
% beta_trim    = entrada(6);
% delta_e_trim = entrada(7);
% theta        = entrada(8);
% theta_ref    = entrada(9);
% rho          = entrada(10);
% g            = entrada(11);
% C_Dalpha     = entrada(12);
% m            = entrada(13);
% c            = entrada(14);
% Salar        = entrada(15);
% Iy           = entrada(16);
% coefprop_U   = entrada(17);
% C_D0         = entrada(18);
% C_Ddelta_e   = entrada(19);
% C_malpha     = entrada(20);
% C_mdelta_e   = entrada(21);
%
% Kp_v2        = salida(1);
% Ki_v2        = salida(2);


%% ENTRADA

Ua           = entrada(1);
Va           = entrada(2);
Wa           = entrada(3);
Uinf_ref     = entrada(4);
alpha_trim   = entrada(5);
beta_trim    = entrada(6);
delta_e_trim = entrada(7);
theta        = entrada(8);
theta_ref    = entrada(9);
rho          = entrada(10);
g            = entrada(11);
C_Dalpha     = entrada(12);
m            = entrada(13);
c            = entrada(14);
Salar        = entrada(15);
Iy           = entrada(16);
coefprop_U   = entrada(17);
C_D0         = entrada(18);
C_Ddelta_e   = entrada(19);
C_malpha     = entrada(20);
C_mdelta_e   = entrada(21);


%% COEFICIENTES

Uinf       = sqrt(Ua^2+Va^2+Wa^2);
delta_emax = 30*pi/180;
e_thetamax = 30*pi/180;
dseta_v2   = 1;
s          = 20;

% Singularidad en theta nulo:

if abs(theta)>1
    
    Ktheta_dc = theta/theta_ref;
    
else
    
    Ktheta_dc = 1;
    
end


%% CALCULO

a_v1     = rho*Uinf_ref*Salar*(C_D0+(C_Dalpha-C_D0)*alpha_trim+...
           C_Ddelta_e*delta_e_trim)/m-2*coefprop_U*cos(alpha_trim)*...
           cos(beta_trim)*Uinf_ref/m;
a_theta2 = -0.5*rho*Uinf^2*c*Salar*C_malpha/Iy;
a_theta3 = 0.5*rho*Uinf^2*c*Salar*C_mdelta_e/Iy;
wn_theta = sqrt(a_theta2+(delta_emax*abs(a_theta3)/e_thetamax));
wn_v2    = wn_theta/s;   
Kp_v2    = (a_v1-2*dseta_v2*wn_v2)/(Ktheta_dc*g);
Ki_v2    = -wn_v2^2/(Ktheta_dc*g);


%% SALIDA

salida = [Kp_v2;Ki_v2];