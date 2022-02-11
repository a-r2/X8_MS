function salida = controlador_phi(entrada)
% Funcion que calcula los parametros del controlador de phi.
%
% salida = controlador_phi(entrada)
%
% Siendo:
% 
% Ua         = entrada(1);
% Va         = entrada(2);
% Wa         = entrada(3);
% P          = entrada(4);
% Q          = entrada(5);
% R          = entrada(6);
% phi        = entrada(7);
% theta      = entrada(8);
% rho        = entrada(9);
% b          = entrada(10);
% Salar      = entrada(11);
% gamma1     = entrada(12);
% gamma2     = entrada(13);
% C_p0       = entrada(14);
% C_pbeta    = entrada(15);
% C_pp       = entrada(16);
% C_pr       = entrada(17);
% C_pdelta_a = entrada(18);
%
% a_phi2     = salida(1);
% d_phi1     = salida(2);
% d_phi2_    = salida(3);
% Kp_phi     = salida(4);
% Ki_phi     = salida(5);
% Kd_phi     = salida(6);


%% ENTRADA

Ua         = entrada(1);
Va         = entrada(2);
Wa         = entrada(3);
P          = entrada(4);
Q          = entrada(5);
R          = entrada(6);
phi        = entrada(7);
theta      = entrada(8);
rho        = entrada(9);
b          = entrada(10);
Salar      = entrada(11);
gamma1     = entrada(12);
gamma2     = entrada(13);
C_p0       = entrada(14);
C_pbeta    = entrada(15);
C_pp       = entrada(16);
C_pr       = entrada(17);
C_pdelta_a = entrada(18);


%% COEFICIENTES

Uinf       = sqrt(Ua^2+Va^2+Wa^2);
beta       = asin(Va/(Uinf+1e-16));
delta_amax = 5*pi/180;
e_phimax   = 10*pi/180;
dseta_phi  = 1;


%% CALCULO

a_phi1  = -0.25*rho*Uinf*Salar*b^2*C_pp;
a_phi2  = 0.5*rho*Uinf^2*Salar*b*C_pdelta_a;
d_phi1  = Q*sin(phi)*tan(theta)+R*cos(phi)*tan(theta);
d_phi2_ = gamma1*P*Q-gamma2*Q*R+0.5*rho*Uinf^2*Salar*b*(C_p0+C_pbeta*...
          beta-0.5*C_pp*b*d_phi1/(Uinf+1e-16)+0.5*C_pr*b*R/(Uinf+1e-16));
Kp_phi  = delta_amax*sign(a_phi2)/e_phimax;
Ki_phi  = 0.5;
wn_phi  = sqrt(Kp_phi*a_phi2);
Kd_phi  = (2*dseta_phi*wn_phi-a_phi1)/a_phi2;
      

%% SALIDA

salida = [a_phi2;d_phi1;d_phi2_;Kp_phi;Ki_phi;Kd_phi];