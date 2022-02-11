function [delta_t,Ua,altitud,motor_pwm] = funleyprop(vuelo)
% Funcion utilizada a la hora de calcular la ley de propulsion con el 
% objetivo de preprocesar distintas variables.


%% CALCULO

celdatos = datos_telemetria(vuelo);
procesador_datos;

Ua = [];

for k=1:longitud_max
    
    phi = alabeo(k,2); theta = cabeceo(k,2); psi = guinada(k,2);

    % Matriz de rotacion de ejes NED a ejes cuerpo:
    
    R_nb = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
            sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
            sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta); ...
            cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*...
            sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)];
  
    v_tierra_b = R_nb*[v_norte(k,2); v_este(k,2); v_vert(k,2)];
    
    w_total = sqrt(viento_mag_horz(k,2)^2+viento_mag_vert(k,2)^2);
    w_norte = -w_total*cos(viento_dir(k,2));
    w_este  = -w_total*sin(viento_dir(k,2));
    w_vert  = viento_mag_vert(k,2);
    
    v_viento_b = R_nb*[w_norte;w_este;w_vert];
    v_aero_b   = v_tierra_b-v_viento_b;
    
    Ua = [Ua; v_aero_b(1)];
    
    entrada = [v_aero_b(1) v_aero_b(2) v_aero_b(3) v_tierra_b(1) ...
               v_tierra_b(2) v_tierra_b(3) a_x(k,2) w_cabeceo(k,2) ...
               w_guinada(k,2) cabeceo(k,2) elevadores_pwm(k,2) ...
               densidad(k,2) altitud(k,2) latitud(k,2)];

   delta_t(k,1) = fuerzasx(entrada);

end