function salida = eom(entrada)
% Funcion que calcula las ecuaciones del movimiento del UAV, utilizada para
% hallar el punto de equilibrio del mismo.


%% ENTRADA

U              = entrada(1);
V              = entrada(2);
W              = entrada(3);
P              = entrada(4);
Q              = entrada(5);
R              = entrada(6);
phi            = entrada(7);
theta          = entrada(8);
psi            = entrada(9);
delta_a        = entrada(10);
delta_e        = entrada(11);
delta_t        = entrada(12);


%% DATOS

x8;
rho = 1.225;
g   = 9.807;


%% CALCULO

Uinf  = sqrt(U^2+V^2+W^2);
alpha = atan(W/(U+1e-16));
beta  = asin(V/(Uinf+1e-16));

sigma = sigmoid(alpha);

entrada_x8_aero  = [alpha beta Uinf P Q R delta_a delta_e sigma m b c ...
                    Salar AR e C_L0 C_Lalpha C_Lq C_Ldelta_e C_D0 ...
                    C_Dbeta1 C_Dbeta2 C_Dq C_Ddelta_e C_Y0 C_Ybeta C_Yp ...
                    C_Yr C_Ydelta_a C_l0 C_lbeta C_lp C_lr C_ldelta_a ...
                    C_m0 C_malpha C_mp C_mq C_mdelta_e C_n0 C_nbeta ...
                    C_np C_nr C_ndelta_a];
                          
salida_x8_aero = x8_aero(entrada_x8_aero);

C_L = salida_x8_aero(1);
C_D = salida_x8_aero(2);
C_Y = salida_x8_aero(3);
C_l = salida_x8_aero(4);
C_m = salida_x8_aero(5);
C_n = salida_x8_aero(6);

entrada_fuerzas  = [alpha beta Uinf C_L C_D C_Y phi theta psi delta_t ...
                    rho g m Salar];
entrada_momentos = [Uinf C_l C_m C_n rho b c Salar];
Fuerzas          = fuerzas(entrada_fuerzas);
Momentos         = momentos(entrada_momentos);
FuerzasX         = Fuerzas(1);
FuerzasY         = Fuerzas(2);
FuerzasZ         = Fuerzas(3);
MomentosX        = Momentos(1);
MomentosY        = Momentos(2);
MomentosZ        = Momentos(3);

entrada_aceleraciones_lin = [U V W P Q R FuerzasX FuerzasY FuerzasZ m];
entrada_aceleraciones_ang = [P Q R MomentosX MomentosY MomentosZ Iy ...
                             gamma1 gamma2 gamma3 gamma4 gamma5 gamma6 ...
                             gamma7 gamma8];       
Aceleraciones_lin         = aceleraciones_lin(entrada_aceleraciones_lin);
Aceleraciones_ang         = aceleraciones_ang(entrada_aceleraciones_ang);
                         
entrada_velocidades_lin = [U V W phi theta psi];
entrada_velocidades_ang = [P Q R phi theta];
Velocidades_lin         = velocidades_lin(entrada_velocidades_lin);
Velocidades_ang         = velocidades_ang(entrada_velocidades_ang);

posd_punto  = Velocidades_lin(3);
U_punto     = Aceleraciones_lin(1);
V_punto     = Aceleraciones_lin(2);
W_punto     = Aceleraciones_lin(3);
phi_punto   = Velocidades_ang(1);
theta_punto = Velocidades_ang(2);
psi_punto   = Velocidades_ang(3);
P_punto     = Aceleraciones_ang(1);
Q_punto     = Aceleraciones_ang(2);
R_punto     = Aceleraciones_ang(3);


%% SALIDA

salida = [posd_punto;FuerzasX;FuerzasY;FuerzasZ;MomentosX;MomentosY;...
          MomentosZ;U_punto;V_punto;W_punto;phi_punto;theta_punto;...
          psi_punto^2];