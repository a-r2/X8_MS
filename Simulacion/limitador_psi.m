function salida = limitador_psi(entrada)
% Funcion que procesa el calculo del error en el controlador de psi.
% 
% salida = limitador_psi(entrada)
%
% Siendo:
%
% psi        = entrada(1);
% psi_ref    = entrada(2);
% psi_inicio = entrada(3);
%
% error      = salida;


%% ENTRADA

psi        = entrada(1);
psi_ref    = entrada(2);
psi_inicio = entrada(3);


%% CALCULO

vueltas_psi        = floor(psi/(2*pi));
vueltas_psi_ref    = floor(psi_ref/(2*pi));
vueltas_psi_inicio = floor(psi_inicio/(2*pi));
psi                = psi-2*pi*vueltas_psi;
psi_ref            = psi_ref-2*pi*vueltas_psi_ref;
psi_inicio         = psi_inicio-2*pi*vueltas_psi_inicio;
error              = psi_ref-psi;
error_inicio       = psi_ref-psi_inicio;
signo              = sign(error);
signo_inicio       = sign(error_inicio);
error_abs          = abs(error);
error_inicio_abs   = abs(error_inicio);

if error_inicio_abs>pi
    
    if error_abs>pi
    
        salida = -signo_inicio*abs(error-signo_inicio*2*pi);
        return;
        
    else
        
        salida = error;
        return;
        
    end
    
else
        
    if error_abs>=1.5*pi
        
        salida = -signo*abs(error-signo*2*pi);
        return;
        
    else
        
        salida = error;
        return;
        
    end
    
end