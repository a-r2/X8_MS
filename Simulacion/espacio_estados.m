% Script que construye los espacios de estados lateral y longitudinal del 
% UAV para un punto de equilibrio en vuelo de crucero horizontal.


%% DATOS:

x8;
rho = 1.225;
g   = 9.807;


%% PUNTO DE EQUILIBRIO (CRUZERO HORIZONTAL):

U_equilibrio       = 16.8564;
V_equilibrio       = 9.0706e-5;
W_equilibrio       = 1.28956;
P_equilibrio       = -5.79480e-24;
Q_equilibrio       = -4.12155e-25;
R_equilibrio       = -4.50637e-29;
phi_equilibrio     = 4.28704e-6; 
theta_equilibrio   = 0.0763539;
psi_equilibrio     = 0;
delta_a_equilibrio = 1.37414e-6;
delta_e_equilibrio = -0.00261517;
delta_t_equilibrio = 1.74251;

Uinf_equilibrio  = sqrt(U_equilibrio^2+V_equilibrio^2+W_equilibrio^2);
alpha_equilibrio = atan(W_equilibrio/U_equilibrio);
beta_equilibrio  = asin(V_equilibrio/Uinf_equilibrio);


%% COEFICIENTES AERODINAMICOS CRUZADOS:

% Matriz de rotacion de ejes viento a ejes cuerpo:

R_wb_equilibrio = [cos(theta_equilibrio)   0   -sin(theta_equilibrio); ...
                           0               1              0          ; ...
                   sin(theta_equilibrio)   0    cos(theta_equilibrio)];
         
sigma = sigmoid(alpha_equilibrio);
         
entrada_x8_aero  = [0 Uinf_equilibrio 0 0 0 0 0 ...
                    sigma m b c Salar AR e C_L0 C_Lalpha C_Lq ...
                    C_Ldelta_e C_D0 C_Dbeta1 C_Dbeta2 C_Dq C_Ddelta_e ...
                    C_Y0 C_Ybeta C_Yp C_Yr C_Ydelta_a C_l0 C_lbeta C_lp ...
                    C_lr C_ldelta_a C_m0 C_malpha C_mp C_mq C_mdelta_e ...
                    C_n0 C_nbeta C_np C_nr C_ndelta_a];

salida1 = x8_aero([0 entrada_x8_aero]);               
C_F0    = -R_wb_equilibrio*[salida1(2);0;salida1(1)];
C_X0    = C_F0(1); 
C_Z0    = C_F0(3);
C_m0ss  = salida1(5);

salida2    = x8_aero([alpha_equilibrio entrada_x8_aero]);
C_Falpha   = -R_wb_equilibrio*[salida2(2);0;salida2(1)];
C_Xalpha   = C_Falpha(1); 
C_Zalpha   = C_Falpha(3);
C_malphass = salida2(5);

C_Fq = -R_wb_equilibrio*[C_Dq;0;C_Lq];
C_Xq = C_Fq(1); 
C_Zq = C_Fq(3);

C_Fdelta_e = -R_wb_equilibrio*[C_Ddelta_e;0;C_Ldelta_e];
C_Xdelta_e = C_Fdelta_e(1); 
C_Zdelta_e = C_Fdelta_e(3);

    
%% COEFICIENTES DEL ESPACIO DE ESTADOS LATERAL:

Yv       = rho*Salar*b*V_equilibrio*(C_Yp*P_equilibrio+C_Yr*...
           R_equilibrio)/4*m*Uinf_equilibrio+rho*Salar*V_equilibrio*...
           (C_Y0+C_Ybeta*beta_equilibrio+C_Ydelta_a*delta_a_equilibrio)...
           /m+rho*Salar*C_Ybeta*sqrt(U_equilibrio^2+W_equilibrio^2)/2*m;
Yp       = W_equilibrio+rho*Uinf_equilibrio*Salar*b*C_Yp/4*m;
Yr       = -U_equilibrio+rho*Uinf_equilibrio*Salar*b*C_Yr/4*m;
Ydelta_a = rho*Uinf_equilibrio^2*Salar*C_Ydelta_a/2*m;

Lv       = rho*Salar*b^2*V_equilibrio*(C_pp*P_equilibrio+C_pr*...
           R_equilibrio)/4*Uinf_equilibrio+rho*Salar*b*V_equilibrio*...
           (C_p0+C_pbeta*beta_equilibrio+C_pdelta_a*delta_a_equilibrio)...
           +rho*Salar*b*C_pbeta*sqrt(U_equilibrio^2+W_equilibrio^2)/2;
Lp       = gamma1*Q_equilibrio+rho*Uinf_equilibrio*Salar*b^2*C_pp/4;
Lr       = -gamma2*Q_equilibrio+rho*Uinf_equilibrio*Salar*b^2*C_pr/4;
Ldelta_a = rho*Uinf_equilibrio^2*Salar*b*C_pdelta_a/2;

Nv       = rho*Salar*b^2*V_equilibrio*(C_rp*P_equilibrio+C_rr*...
           R_equilibrio)/4*Uinf_equilibrio+rho*Salar*b*V_equilibrio*...
           (C_r0+C_rbeta*beta_equilibrio+C_rdelta_a*delta_a_equilibrio)...
           +rho*Salar*b*C_rbeta*sqrt(U_equilibrio^2+W_equilibrio^2)/2;
Np       = gamma7*Q_equilibrio+rho*Uinf_equilibrio*Salar*b^2*C_rp/4;
Nr       = -gamma1*Q_equilibrio+rho*Uinf_equilibrio*Salar*b^2*C_rr/4;
Ndelta_a = rho*Uinf_equilibrio^2*Salar*b*C_rdelta_a/2;


%% COEFICIENTES DEL ESPACIO DE ESTADOS LONGITUDINAL:

Xu       = U_equilibrio*rho*Salar*(C_X0+C_Xalpha*alpha_equilibrio+...
           C_Xdelta_e*delta_e_equilibrio)/m-rho*Salar*W_equilibrio*...
           C_Xalpha/2*m+rho*Salar*c*C_Xq*U_equilibrio*Q_equilibrio/...
           4*m*Uinf_equilibrio+2*coefprop(2)*U_equilibrio/m;
Xw       = -Q_equilibrio+W_equilibrio*rho*Salar*(C_X0+C_Xalpha*...
           alpha_equilibrio+C_Xdelta_e*delta_e_equilibrio)/m+rho*Salar*...
           c*C_Xq*W_equilibrio*Q_equilibrio/4*m*Uinf_equilibrio+rho*...
           Salar*U_equilibrio*C_Xalpha/2*m;
Xq       = -W_equilibrio+rho*Uinf_equilibrio*Salar*C_Xq*c/4*m;
Xdelta_e = rho*Uinf_equilibrio^2*Salar*C_Xdelta_e/2*m;
Xdelta_t = 1/m;

Zu       = Q_equilibrio+U_equilibrio*rho*Salar*(C_Z0+C_Zalpha*...
           alpha_equilibrio+C_Zdelta_e*delta_e_equilibrio)/m-rho*Salar*...
           C_Zalpha*W_equilibrio/2*m+U_equilibrio*rho*Salar*C_Zq*c*...
           Q_equilibrio/4*m*Uinf_equilibrio;
Zw       = W_equilibrio*rho*Salar*(C_Z0+C_Zalpha*alpha_equilibrio+...
           C_Zdelta_e*delta_e_equilibrio)/m+rho*Salar*C_Zalpha*...
           U_equilibrio/2*m+rho*W_equilibrio*Salar*c*C_Zq*Q_equilibrio/...
           4*m*Uinf_equilibrio;
Zq       = U_equilibrio+rho*Uinf_equilibrio*Salar*C_Zq*c/4*m;
Zdelta_e = rho*Uinf_equilibrio^2*Salar*C_Zdelta_e/2*m;

Mu       = U_equilibrio*rho*Salar*c*(C_m0ss+C_malphass*...
           alpha_equilibrio+C_mdelta_e*delta_e_equilibrio)/Iy-rho*Salar*...
           c*C_malphass*W_equilibrio/2*Iy+rho*Salar*c^2*C_mq*...
           Q_equilibrio*U_equilibrio/4*Iy*Uinf_equilibrio;
Mw       = W_equilibrio*rho*Salar*c*(C_m0ss+C_malphass*...
           alpha_equilibrio+C_mdelta_e*delta_e_equilibrio)/Iy+rho*Salar*...
           c*C_malphass*U_equilibrio/2*Iy+rho*Salar*c^2*C_mq*...
           Q_equilibrio*W_equilibrio/4*Iy*Uinf_equilibrio;
Mq       = rho*Uinf_equilibrio*Salar*c^2*C_mq/4*Iy;
Mdelta_e = rho*Uinf_equilibrio^2*Salar*c*C_mdelta_e/2*Iy;


%% ESPACIO DE ESTADOS LATERAL:

A_lat = [Yv Yp Yr g*cos(theta_equilibrio) 0; Lv Lp Lr 0 0; Nv Np Nr 0 ...
         0; 0 1 cos(phi_equilibrio)*tan(theta_equilibrio) Q_equilibrio*...
         cos(phi_equilibrio)*tan(theta_equilibrio)-R_equilibrio*...
         sin(phi_equilibrio)*tan(theta_equilibrio) 0; 0 0 ...
         cos(phi_equilibrio)*sec(theta_equilibrio) P_equilibrio*...
         cos(phi_equilibrio)*sec(theta_equilibrio)-R_equilibrio*...
         sin(phi_equilibrio)*sec(theta_equilibrio) 0];
B_lat = [Ydelta_a; Ldelta_a; Ndelta_a; 0; 0];


%% ESPACIO DE ESTADOS LONGITUDINAL:

A_long = [Xu Xw Xq -g*cos(theta_equilibrio) 0; Zu Zw Zq ...
          -g*sin(theta_equilibrio) 0; Mu Mw Mq 0 0; 0 0 1 0 0; ...
          sin(theta_equilibrio) -cos(theta_equilibrio) 0 U_equilibrio*...
          cos(theta_equilibrio)+W_equilibrio*sin(theta_equilibrio) 0];
B_long = [Xdelta_e Xdelta_t; Zdelta_e 0; Mdelta_e 0; 0 0; 0 0];


%% ESPACIO DE ESTADOS:

estado_lat    = {'V' 'P' 'R' 'phi' 'psi'};
actuador_lat  = {'delta_a'};
respuesta_lat = {'V punto' 'P punto' 'R punto' 'phi punto' 'psi punto'};
sys_lat       = ss(A_lat,B_lat,eye(5),zeros(5,1),'statename',estado_lat,...
                   'inputname',actuador_lat,'outputname',respuesta_lat);

Polos    = eig(A_long);
Polos(3) = -Polos(3);
Polos(4) = -Polos(4);
K        = place(A_long,B_long,Polos);

estado_long    = {'U' 'W' 'Q' 'theta' 'h'};
actuador_long  = {'delta_e' 'delta_t'};
respuesta_long = {'U punto' 'W punto' 'Q punto' 'theta punto' 'h punto'};
sys_long       = ss(A_long-B_long*K,B_long,eye(5),zeros(5,2),...
                    'statename',estado_long,'inputname',actuador_long,...
                    'outputname',respuesta_long);