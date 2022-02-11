function [C_L,C_D] = x8_aerox(alpha,beta,Uinf,Q,delta_e)
% Funcion que calcula el valor de los coeficientes aerodinamicos C_L y C_D.
%
% [C_L,C_D] = x8_modelx(alpha,beta,Uinf,Q,delta_e)
%
% Siendo:
% 
% alpha   = angulo de ataque [rad]
% beta    = angulo de deslizamiento [rad]
% Uinf    = velocidad aerodinamica en el infinito [m/s]
% Q       = momento de las fuerzas alrededor del eje Y (cuerpo) [N·m]
% delta_e = desflexion de los elevadores [rad]
%
% C_L     = coeficiente de sustentacion [-]
% C_D     = coeficiente de resistencia [-]


%% DATOS

if exist('m')~=1
    
    x8;
    
end

sigma = sigmoid(alpha);


%% CALCULO DE COEFICIENTES AERODINAMICOS

C_L = (1-sigma)*(C_L0+C_Lalpha*alpha)+sigma*(2*sign(alpha)*sin(alpha)^2*...
      cos(alpha))+0.5*C_Lq*c*Q/(Uinf+1e-16)+C_Ldelta_e*delta_e;
C_D = C_D0+(1-sigma)*((C_L0+C_Lalpha*alpha)^2/(pi*e*AR))+sigma*(2*...
      sign(alpha)*sin(alpha)^3)+0.5*C_Dq*c*Q/(Uinf+1e-16)+C_Dbeta1*beta+...
      C_Dbeta2*beta^2+C_Ddelta_e*delta_e;