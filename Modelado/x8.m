% Script que contiene las caracteristicas tecnicas del Skywalker X8.

global m b c Salar AR cg Ix Iy Iz Ixz e alpha0 coefprop C_L0 C_Lalpha ...
       C_Lq C_Ldelta_e C_D0 C_Dbeta1 C_Dbeta2 C_Dq C_Ddelta_e C_Y0 ...
       C_Ybeta C_Yp C_Yr C_Ydelta_a C_l0 C_lbeta C_lp C_lr C_ldelta_a ...
       C_m0 C_malpha C_mfp C_mq C_mdelta_e C_n0 C_nbeta C_np C_nr ...
       C_ndelta_a gamma gamma1 gamma2 gamma3 gamma4 gamma5 gamma6 ...
       gamma7 gamma8

%% DATOS GENERALES DEL UAV

m      = 3.797;
b      = 2.100;
c      = 0.3571;
Salar  = 0.7500;
AR     = b^2/Salar; % alargamiento (Aspect Ratio)


%% CENTRO DE GRAVEDAD

% Sistemas de coordenadas: X contenido en el plano de simetria, hacia atras
% y con el origen en el morro del UAV; Z, perpendicular y hacia abajo; e Y,
% perpendicular a ambos y en sentido del ala izquierda (sistema levogiro).

cg = [0.4400 0 0];


%% MOMENTOS DE INERCIA

Ix  = 1.2290;
Iy  = 0.1702;
Iz  = 0.8808;
Ixz = 0.9343;


%% DATOS AERODINAMICOS

e      = 0.9935; % coeficiente de Oswald
alpha0 = 0.2670; % alpha de entrada en perdida


%% LEY DE PROPULSION

coefprop = [0.016415 -0.0142726]; % motor_pwm y U^2


%% COEFICIENTES DE ESTABILIDAD

C_L0       = 0.0254;
C_Lalpha   = 4.0191; % rad^-1 
C_Lq       = 3.8954;
C_Ldelta_e = 0.5872;

C_D0       = 0.0102;
C_Dbeta1   = -2.0864e-7;
C_Dbeta2   = 0.0671;
C_Dq       = 0;
C_Ddelta_e = 0.8461;

C_Y0       = 3.2049e-18;
C_Ybeta    = -0.1949;
C_Yp       = -0.1172;
C_Yr       = 0.0959;
C_Ydelta_a = -0.0696;

C_l0       = 1.1518e-18;
C_lbeta    = -0.0765;
C_lp       = -0.4018;
C_lr       = 0.0250;
C_ldelta_a = 0.2987;

C_m0       = 0.0180;
C_malpha   = -0.2524;
C_mfp      = -0.2168;
C_mq       = -1.3047;
C_mdelta_e = -0.4857;

C_n0       = -2.2667e-7;
C_nbeta    = 0.0403;
C_np       = -0.0247;
C_nr       = -0.1252;
C_ndelta_a = 0.0076;


%% GAMMAS

gamma  = Ix*Iz-Ixz^2;
gamma1 = (Ixz*(Ix-Iy+Iz))/gamma;
gamma2 = (Iz*(Iz-Iy)+Ixz^2)/gamma;
gamma3 = Iz/gamma;
gamma4 = Ixz/gamma;
gamma5 = (Iz-Ix)/Iy;
gamma6 = Ixz/Iy;
gamma7 = (Ix*(Ix-Iy)+Ixz^2)/gamma;
gamma8 = Ix/gamma;