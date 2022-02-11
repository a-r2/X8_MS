function sigma = sigmoid(alpha)
% Funcion que obtiene el valor de sigma (variable de las ecuaciones de
% dinamica del UAV) a partir de alpha.

M       = 50; % ratio de transicion (suaviza la transicion a placa plana)
alpha0  = 0.2670;
alpha   = abs(alpha);
sigma   = (1+exp(-M*(alpha-alpha0))+exp(M*(alpha+alpha0)))/((1+exp(-M*...
          (alpha-alpha0)))*(1+exp(-M*(alpha-alpha0))));

if sigma>=1
    
    sigma = 1;
    
end

if sigma<=0
    
    sigma = 0;
    
end