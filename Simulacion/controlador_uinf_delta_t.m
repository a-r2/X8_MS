function salida = controlador_uinf_delta_t(entrada)
% Funcion que calcula los parametros del controlador de Uinf (delta t).
%
% salida = controlador_uinf_delta_t(entrada)
%
% Siendo:
%
% Uinf_ref       = entrada(1);
% alpha_trim     = entrada(2);
% beta_trim      = entrada(3);
% delta_e_trim   = entrada(4);
% rho            = entrada(5);
% C_Dalpha       = entrada(6);
% m              = entrada(7);
% Salar          = entrada(8);
% coefprop_motor = entrada(9);
% coefprop_U     = entrada(10);
% C_D0           = entrada(11);
% C_Ddelta_e     = entrada(12);
%
% Kp_v           = salida(1);
% Ki_v           = salida(2);


%% ENTRADA

Uinf_ref       = entrada(1);
alpha_trim     = entrada(2);
beta_trim      = entrada(3);
delta_e_trim   = entrada(4);
rho            = entrada(5);
C_Dalpha       = entrada(6);
m              = entrada(7);
Salar          = entrada(8);
coefprop_motor = entrada(9);
coefprop_U     = entrada(10);
C_D0           = entrada(11);
C_Ddelta_e     = entrada(12);


%% COEFICIENTES

dseta_v    = 1;
wn_v       = 0.8;


%% CALCULO

a_v1 = rho*Uinf_ref*Salar*(C_D0+(C_Dalpha-C_D0)*alpha_trim+C_Ddelta_e*...
       delta_e_trim)/m-2*coefprop_U*cos(alpha_trim)*cos(beta_trim)*...
       Uinf_ref/m;
a_v2 = coefprop_motor; 
Kp_v = (2*dseta_v*wn_v-a_v1)/a_v2;
Ki_v = wn_v^2/a_v2;


%% SALIDA

salida = [Kp_v;Ki_v];