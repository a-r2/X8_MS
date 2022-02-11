% Script que permite seleccionar y cargar un intervalo concreto de la 
% telemetria de uno de los vuelos para ser utilizado como entrada en 
% "Simulador_Telemetria".

clear all, close all

flag1 = 0;
flag2 = 0;
flag3 = 0;

while flag1==0

    texto1   = ['Pulse un numero entre 1 y 5 para seleccionar la ' ...
                'telemetria del vuelo correspondiente. A ' ...
                'continuacion, presione la tecla ENTER.\n'];
    entrada1 = input(texto1);
    
    if entrada1<1 || entrada1>5
    
        error1 = ['Debe pulsar una tecla entre 1 y 5 (1,2,3,4 o 5). ' ...
                  'Por favor, intentelo de nuevo.'];
        disp(error1);
        
    else
        
        flag1 = 1;
         
    end
    
end

while flag2==0

    texto2   = ['Inserte el numero de segundos que define la longitud ' ...
                'del tramo. A continuacion, presione la tecla ENTER.\n'];
    entrada2 = input(texto2);
    
    if entrada2<=0
    
        error2 = ['Debe insertar un numero mayor que 0. Por favor, ' ...
                  'intentelo de nuevo.'];
        disp(error2);
        
    else
        
        flag2 = 1;
         
    end
    
end

while flag3==0

    texto3   = ['Inserte el percentil que define el inicio del tramo ' ...
                'de telemetria a simular. A continuacion, presione la ' ...
                'tecla ENTER.\n'];
    entrada3 = input(texto3);
    
    if entrada3<0 || entrada3>=100
    
        error3 = ['Debe insertar un numero mayor o igual que 0 y ' ...
                  'menor que 100. Por favor, intentelo de nuevo.'];
        disp(error3);
        
    else
        
        flag3 = 1;
         
    end
    
end

celdatos = datos_telemetria(entrada1);
procesador_datos;

aux_gnss       = find(latitud(:,1)<=round(entrada3*latitud(end,1)...
                 /100,1),1,'last'); 
intervalo_gnss = [aux_gnss:find(latitud(:,1)*1e-3<=latitud(aux_gnss,1)...
                  *1e-3+entrada2,1,'last')]; 
              
aux_velocidades_ned       = find(v_norte(:,1)<=round(entrada3*...
                            v_norte(end,1)/100,1),1,'last'); 
intervalo_velocidades_ned = [aux_velocidades_ned:find(v_norte(:,1)*1e-3...
                             <=v_norte(aux_velocidades_ned,1)*1e-3+...
                             entrada2,1,'last')];
                       
aux_actitud       = find(alabeo(:,1)<=round(entrada3*alabeo(end,1)...
                    /100,1),1,'last');
intervalo_actitud = [aux_actitud:find(alabeo(:,1)*1e-3<=alabeo...
                     (aux_actitud ,1)*1e-3+entrada2,1,'last')];  
                       
aux_velocidades_ang       = find(w_alabeo(:,1)<=round(entrada3*...
                            w_alabeo(end,1)/100,1),1,'last'); 
intervalo_velocidades_ang = [aux_velocidades_ang:find(w_alabeo(:,1)*...
                             1e-3<=w_alabeo(aux_velocidades_ang,1)*1e-3...
                             +entrada2,1,'last')];
                       
aux_aceleraciones_lin       = find(a_x(:,1)<=round(entrada3*a_x(end,1)...
                              /100,1),1,'last'); 
intervalo_aceleraciones_lin = [aux_aceleraciones_lin:find(a_x(:,1)*1e-3...
                               <=a_x(aux_aceleraciones_lin ,1)*1e-3...
                               +entrada2,1,'last')];

aux_actuadores       = find(alerones_pwm(:,1)<=round(entrada3*...
                       alerones_pwm(end,1)/100,1),1,'last');             
intervalo_actuadores = [aux_actuadores:find(alerones_pwm(:,1)*1e-3<=...
                        alerones_pwm(aux_actuadores,1)*1e-3+entrada2,...
                        1,'last')];             
                    
aux_viento       = find(viento_dir(:,1)<=round(entrada3*...
                   viento_dir(end,1)/100,1),1,'last');
intervalo_viento = [aux_viento:find(viento_dir(:,1)*1e-3<=viento_dir...
                    (aux_viento,1)*1e-3+entrada2,1,'last')];                                     
                                
% GNSS:

latitud  = timeseries(latitud(intervalo_gnss,2),...
           (latitud(intervalo_gnss,1)-latitud...
           (aux_gnss,1))*1e-3);
        
longitud = timeseries(longitud(intervalo_gnss,2),...
           (longitud(intervalo_gnss,1)-longitud...
           (aux_gnss,1))*1e-3);
       
altitud  = timeseries(altitud(intervalo_gnss,2),...
           (altitud(intervalo_gnss,1)-altitud...
           (aux_gnss,1))*1e-3);
       
% Actitud:
  
alabeo  = timeseries(alabeo(intervalo_actitud,2),(alabeo...
          (intervalo_actitud,1)-alabeo(aux_actitud,1))*1e-3);
      
cabeceo = timeseries(cabeceo(intervalo_actitud,2),(cabeceo...
          (intervalo_actitud,1)-cabeceo(aux_actitud,1))*1e-3);
       
guinada = timeseries(guinada(intervalo_actitud,2),(guinada...
          (intervalo_actitud,1)-guinada(aux_actitud,1))*1e-3);       
       
% Velocidades NED:

v_norte = timeseries(v_norte(intervalo_velocidades_ned,2),...
          (v_norte(intervalo_velocidades_ned,1)-v_norte...
          (aux_velocidades_ned,1))*1e-3);

v_este  = timeseries(v_este(intervalo_velocidades_ned,2),...
          (v_este(intervalo_velocidades_ned,1)-v_este...
          (aux_velocidades_ned,1))*1e-3);

v_vert  = timeseries(v_vert(intervalo_velocidades_ned,2),...
          (v_vert(intervalo_velocidades_ned,1)-v_vert...
          (aux_velocidades_ned,1))*1e-3);
      
% Velocidades lineales:

v_x = [];
v_y = [];
v_z = [];

for k=1:size(intervalo_velocidades_ned,2)
    
    phi   = alabeo.Data(k);
    theta = cabeceo.Data(k); 
    psi   = guinada.Data(k); 
    
    % Matriz de rotacion de ejes NED a ejes cuerpo:
                                
    R_nb  = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
             sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
             sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta); ...
             cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*...
             sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)]; 
    
    v_lin = R_nb*[v_norte.Data(k);v_este.Data(k);v_vert.Data(k)];
    
    v_x = [v_x;v_lin(1)];
    v_y = [v_y;v_lin(2)];
    v_z = [v_z;v_lin(3)];
          
end

v_x = timeseries(v_x,v_norte.Time);
  
v_y = timeseries(v_y,v_este.Time);
  
v_z = timeseries(v_z,v_vert.Time);
      
% Velocidades angulares:

w_alabeo  = timeseries(w_alabeo(intervalo_velocidades_ang,2),...
            (w_alabeo(intervalo_velocidades_ang,1)-...
            w_alabeo(aux_velocidades_ang,1))*1e-3);
         
w_cabeceo = timeseries(w_cabeceo(intervalo_velocidades_ang,2),...
            (w_cabeceo(intervalo_velocidades_ang,1)-...
            w_cabeceo(aux_velocidades_ang,1))*1e-3);
        
w_guinada = timeseries(w_guinada(intervalo_velocidades_ang,2),...
            (w_guinada(intervalo_velocidades_ang,1)-...
            w_guinada(aux_velocidades_ang,1))*1e-3);
        
% Aceleraciones lineales: 

a_x = timeseries(a_x(intervalo_aceleraciones_lin,2),...
      (a_x(intervalo_aceleraciones_lin,1)-...
      a_x(aux_aceleraciones_lin,1))*1e-3);
  
a_y = timeseries(a_y(intervalo_aceleraciones_lin,2),...
      (a_y(intervalo_aceleraciones_lin,1)-...
      a_y(aux_aceleraciones_lin,1))*1e-3);
  
a_z = timeseries(a_z(intervalo_aceleraciones_lin,2),...
      (a_z(intervalo_aceleraciones_lin,1)-...
      a_z(aux_aceleraciones_lin,1))*1e-3);
       
% Actuadores:

alerones_pwm   = timeseries(alerones_pwm(intervalo_actuadores,2),...
                 (alerones_pwm(intervalo_actuadores,1)-alerones_pwm...
                 (aux_actuadores,1))*1e-3);

elevadores_pwm = timeseries(elevadores_pwm(intervalo_actuadores,2),...
                 (elevadores_pwm(intervalo_actuadores,1)-...
                 elevadores_pwm(aux_actuadores,1))*1e-3);

motor_pwm      = timeseries(motor_pwm(intervalo_actuadores,2),...
                 (motor_pwm(intervalo_actuadores,1)-...
                 motor_pwm(aux_actuadores,1))*1e-3);

% Viento

viento_mag_horz = timeseries(viento_mag_horz(intervalo_viento,2),...
                  (viento_mag_horz(intervalo_viento,1)-...
                  viento_mag_horz(aux_viento,1))*1e-3);
              
viento_mag_vert = timeseries(viento_mag_vert(intervalo_viento,2),...
                  (viento_mag_vert(intervalo_viento,1)-...
                  viento_mag_vert(aux_viento,1))*1e-3);
              
viento_dir      = timeseries(viento_dir(intervalo_viento,2),...
                  (viento_dir(intervalo_viento,1)-...
                   viento_dir(aux_viento,1))*1e-3);
    
viento_x = [];
viento_y = [];
viento_z = [];

indice = min([size(intervalo_actitud,2) size(intervalo_viento,2)]);

for k=1:size(indice,2)
    
    phi   = alabeo.Data(k);
    theta = cabeceo.Data(k); 
    psi   = guinada.Data(k); 
    
    % Matriz de rotacion de ejes NED a ejes cuerpo:
                                
    R_nb  = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
             sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
             sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta); ...
             cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*...
             sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)]; 
             
    viento_NE = R_nb*([-viento_mag_horz.Data(k)*...
                      [cos(viento_dir.Data(k))*cos(psi);...
                       cos(viento_dir.Data(k))*sin(psi)];...
                       viento_mag_vert.Data(k)]);
            
    viento_x  = [viento_x; viento_NE(1)];
    viento_y  = [viento_y; viento_NE(2)];
    viento_z  = [viento_z; viento_NE(3)];
    
    
end

viento_x = timeseries(viento_x,viento_dir.Time);                 
viento_y = timeseries(viento_y,viento_dir.Time);
viento_z = timeseries(viento_z,viento_dir.Time);
       
% Valores iniciales:

coordenadas_geodeticas_iniciales = [0 latitud.Data(1) ...
                                    longitud.Data(1) ...
                                    altitud.Data(1)];
                                                                                                       
posicion_NED_inicial = [0 0 0 0];
                 
actitud_inicial      = [0 alabeo.Data(1) cabeceo.Data(1) guinada.Data(1)]; 
                                
phi   = alabeo.Data(1);
theta = cabeceo.Data(1); 
psi   = guinada.Data(1); 
                                
R_nb  = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
        sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
        sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta); ...
        cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*...
        sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)];                               
                                
velocidades_lin_inicial    =  [0 (R_nb*[v_norte.Data(1);...
                               v_este.Data(1);v_vert.Data(1)]).'];
                                 
velocidades_ang_inicial    =  [0 w_alabeo.Data(1) ...
                               w_cabeceo.Data(1) w_guinada.Data(1)];
                         
aceleraciones_lin_inicial  =  [0 a_x.Data(1) a_y.Data(1) a_z.Data(1)];                         