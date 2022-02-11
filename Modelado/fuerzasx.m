function delta_t = fuerzasx(entrada)
% Funcion que despeja la fuerza propulsiva de la ecuacion de la segunda ley 
% de Newton en la componente longitudinal del UAV.
%
% salida = fuerzasx(entrada)
%
% Siendo:
%
% Ua             = entrada(1);
% Va             = entrada(2);
% Wa             = entrada(3);
% U              = entrada(4);
% V              = entrada(5);
% W              = entrada(6);
% a_x            = entrada(7);
% Q              = entrada(8);
% R              = entrada(9);
% theta          = entrada(10);
% elevadores_pwm = entrada(11);
% rho            = entrada(12);
% altitud        = entrada(13);
% latitud        = entrada(14);
%
% delta_t        = salida;


%% ENTRADA

Ua             = entrada(1);
Va             = entrada(2);
Wa             = entrada(3);
U              = entrada(4);
V              = entrada(5);
W              = entrada(6);
a_x            = entrada(7);
Q              = entrada(8);
R              = entrada(9);
theta          = entrada(10);
elevadores_pwm = entrada(11);
rho            = entrada(12);
altitud        = entrada(13);
latitud        = entrada(14);


%% DATOS

if exist('m')~=1
    
    x8;
    
end


%% COEFICIENTES

Uinf      = sqrt(Ua^2+Va^2+Wa^2);
alpha     = atan(Wa/(Ua+1e-16));
beta      = asin(Va/(Uinf+1e-16));
delta_e   = -((elevadores_pwm-1520)*(30*pi/180))/(2*(2100-1520));
[C_L,C_D] = x8_aerox(alpha,beta,Uinf,Q,delta_e);


%% MODELO GRAVITATORIO

g = gravitywgs84(altitud,latitud);


%% CALCULO DE GRAVEDAD

Gx = -m*g*sin(theta);


%% MATRIZ DE ROTACION DE EJES VIENTO A EJES CUERPO (EJE X)

R_wbx = [cos(alpha)*cos(beta) -cos(alpha)*sin(beta) -sin(alpha)];


%% CALCULO DE FUERZAS AERODINAMICAS

Fx_aero = -0.5*rho*Uinf^2*Salar*R_wbx*[C_D;0;C_L];


%% CALCULO DE FUERZAS TOTALES

delta_t = m*(a_x+[0 -R Q]*[U;V;W])-Fx_aero-Gx;