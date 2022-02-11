function salida = x8_aero(entrada)
% Funcion que calcula los coeficientes aerodinamicos: C_L, C_D, C_Y, C_l,
% C_m y C_n.
%
% salida = x8_aero(entrada)
%
% Siendo:
%
% alpha      = entrada(1);
% beta       = entrada(2);
% Uinf       = entrada(3);
% P          = entrada(4);
% Q          = entrada(5);
% R          = entrada(6);
% delta_a    = entrada(7);
% delta_e    = entrada(8);
% sigma      = entrada(9);
% m          = entrada(10);
% b          = entrada(11);
% c          = entrada(12);
% Salar      = entrada(13);
% AR         = entrada(14);
% C_L0       = entrada(15);
% C_Lalpha   = entrada(16);
% C_Lq       = entrada(17);
% C_Ldelta_e = entrada(18);
% C_D0       = entrada(19);
% C_Dbeta1   = entrada(20);
% C_Dbeta2   = entrada(21);
% C_Dq       = entrada(22);
% C_Ddelta_e = entrada(23);
% C_Y0       = entrada(24);
% C_Ybeta    = entrada(25);
% C_Yp       = entrada(26);
% C_Yr       = entrada(27);
% C_Ydelta_a = entrada(28);
% C_l0       = entrada(29);
% C_lbeta    = entrada(30);
% C_lp       = entrada(31);
% C_lr       = entrada(32);
% C_ldelta_a = entrada(33);
% C_m0       = entrada(34);
% C_malpha   = entrada(35);
% C_mp       = entrada(36);
% C_mq       = entrada(37);
% C_mdelta_e = entrada(38);
% C_n0       = entrada(39);
% C_nbeta    = entrada(40);
% C_np       = entrada(41);
% C_nr       = entrada(42);
% C_ndelta_a = entrada(43);
%
% C_L        = salida(1);
% C_D        = salida(2);
% C_Y        = salida(3);
% C_l        = salida(4);
% C_m        = salida(5);
% C_n        = salida(6);


%% ENTRADA

alpha      = entrada(1);
beta       = entrada(2);
Uinf       = entrada(3);
P          = entrada(4);
Q          = entrada(5);
R          = entrada(6);
delta_a    = entrada(7);
delta_e    = entrada(8);
sigma      = entrada(9);
m          = entrada(10);
b          = entrada(11);
c          = entrada(12);
Salar      = entrada(13);
AR         = entrada(14);
e          = entrada(15);
C_L0       = entrada(16);
C_Lalpha   = entrada(17);
C_Lq       = entrada(18);
C_Ldelta_e = entrada(19);
C_D0       = entrada(20);
C_Dbeta1   = entrada(21);
C_Dbeta2   = entrada(22);
C_Dq       = entrada(23);
C_Ddelta_e = entrada(24);
C_Y0       = entrada(25);
C_Ybeta    = entrada(26);
C_Yp       = entrada(27);
C_Yr       = entrada(28);
C_Ydelta_a = entrada(29);
C_l0       = entrada(30);
C_lbeta    = entrada(31);
C_lp       = entrada(32);
C_lr       = entrada(33);
C_ldelta_a = entrada(34);
C_m0       = entrada(35);
C_malpha   = entrada(36);
C_mp       = entrada(37);
C_mq       = entrada(38);
C_mdelta_e = entrada(39);
C_n0       = entrada(40);
C_nbeta    = entrada(41);
C_np       = entrada(42);
C_nr       = entrada(43);
C_ndelta_a = entrada(44);


%% CALCULO

C_L = (1-sigma)*(C_L0+C_Lalpha*alpha)+sigma*(2*sign(alpha)*...
      sin(alpha)^2*cos(alpha))+0.5*C_Lq*c*Q/(Uinf+1e-16)+...
      C_Ldelta_e*delta_e;
C_D = C_D0+(1-sigma)*((C_L0+C_Lalpha*alpha)^2/(pi*e*AR))+sigma*(2*...
      sign(alpha)*sin(alpha)^3)+0.5*C_Dq*c*Q/(Uinf+1e-16)+C_Dbeta1*beta+...
      C_Dbeta2*beta^2+C_Ddelta_e*delta_e;
C_Y = C_Y0+C_Ybeta*beta+0.5*C_Yp*b*P/(Uinf+1e-16)+0.5*C_Yr*b*R/(Uinf+...
      1e-16)+C_Ydelta_a*delta_a;
C_l = C_l0+C_lbeta*beta+0.5*C_lp*b*P/(Uinf+1e-16)+0.5*C_lr*b*R/(Uinf+...
      1e-16)+C_ldelta_a*delta_a;
C_m = (1-sigma)*(C_m0+C_malpha*alpha)+sigma*(C_mp*sign(alpha)*...
      sin(alpha)^2)+0.5*C_mq*b*Q/(Uinf+1e-16)+C_mdelta_e*delta_e;
C_n = C_n0+C_nbeta*beta+0.5*C_np*b*P/(Uinf+1e-16)+0.5*C_nr*b*R/(Uinf+...
      1e-16)+C_ndelta_a*delta_a;
  
  
%% SALIDA

salida = [C_L;C_D;C_Y;C_l;C_m;C_n];