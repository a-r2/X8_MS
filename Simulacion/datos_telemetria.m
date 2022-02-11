function celdatos = datos_telemetria(vuelo)
% Funcion que carga, interpreta y acondiciona para su posterior 
% procesamiento los datos de telemetria de un vuelo concreto del UAV. 
%
% celdatos = datos_telemetria(vuelo)
%
% La entrada de la funcion ("vuelo") se define como un numero entre 1 y 5
% correspondiente a cada uno de los cinco vuelos llevados a cabo por el
% UAV.
%
% La salida de la funcion ("celdatos") es una estructura de celdas que
% almacena todos los datos de cada sensor como matrices en cada una de sus 
% celdas en formato "[tiempo dato]", donde "tiempo" es el instante de 
% tiempo en el cual el sensor realizo la medida con respecto al tiempo de 
% referencia, esto es, el encendido de la camara de a bordo justo antes del 
% despegue, y "dato" es la medida del sensor en dicho instante de tiempo.
%
% Ejemplo: celdatos = datos_telemetria(3)


%% CARGA DE DATOS, TIEMPO DE REFERENCIA INICIAL Y DEPURACION

% Se cargan los datos de telemetria y se establece el tiempo de referencia
% inicial (instante en el que la camara comienza a grabar) con "datenum".
% La fecha es un dia antes que la marcada en los archivos .tlog cargados. 

switch vuelo 
    
    case 1
      
        load 2014-06-27_10-38-46.tlog.mat
        tiempo_0_video = datenum('26-Jun-2014 10:44:56');
        ind_aux = [1114 3154 732 725 732 723 3 0];
           
    case 2
        
        load 2014-07-08_10-46-15.tlog.mat
        tiempo_0_video = datenum('07-Jul-2014 10:53:30');
        ind_aux = [2621 7423 1761 1710 1759 1704 0 3];
        
    case 3
        
        load 2014-07-08_12-02-59.tlog.mat
        tiempo_0_video = datenum('07-Jul-2014 12:06:19');
        ind_aux = [1032 2919 699 672 700 675 0 1];
    
    case 4
        
        load 2014-07-30_11-33-34.tlog.mat
        tiempo_0_video = datenum('29-Jul-2014 12:48:05'); 
        ind_aux = [3223 9125 2108 2111 2111 2095 3 0];
        
    case 5
        
        load 2014-07-30_13-34-12.tlog.mat
        tiempo_0_video = datenum('29-Jul-2014 13:43:21'); 
        ind_aux = [4087 11599 2673 2678 2678 2660 2 0];

end

% NOTA: Si se detectan errores de sincronismo, modificar el instante 
% inicial de grabacion. De este modo se actualizaran todas las marcas de 
% tiempo de los parametros de telemetria.
  

%% INFORMACION SOBRE LOS DATOS REGISTRADOS

% Cada parametro que recibe la estacion de tierra (mediante el protocolo
% MAVLink, ver "https://pixhawk.ethz.ch/mavlink/") se guarda en una matriz 
% de dos columnas y tantas filas como medidas obtenidas de dicho parametro.
% La primera columna de dichas matrices se corresponde siempre con la fecha
% y hora de la estacion de tierra a la que llego el dato. Esta fecha puede
% reconstruirse con "datestr", teniendo en cuenta que la maxima precision 
% del tiempo generado mediante este comando es de un segundo. 
%
% Para obtener con mayor precision el momento en que se grabo cada dato, 
% existen matrices que permiten relacionar la hora en la que llego cada
% dato con los milisegundos transcurridos desde el arranque de Ardupilot.
% Esto implica que en la practica se puede conocer el instante en el que se
% graba cada medida con una precision de milisegundos. Teniendo en cuenta 
% que cada sensor trabaja a una frecuencia de muestreo distinta, se tienen 
% cuatro matrices de este tipo:
%
%   - time_boot_ms_mavlink_global_position_int_t: para las medidas del GPS.
%   - time_boot_ms_mavlink_attitude_t: para las medidas de actitud.
%   - time_usec_mavlink_raw_imu_t: para las medidas de aceleracion.
%   - time_boot_ms_mavlink_rc_channels_raw_t: para las medidas de los
%     canales PWM de los mandos de vuelo.
%   - time_boot_ms_mavlink_scaled_pressure_t: para las medidas
%     barometricas.


%% REFERENCIA DE TIEMPOS

% Para cada tipo de medida, se busca el valor de tiempo en la columna 1
% asignado al instante del inicio del video y se crea una variable con
% dicho instante en ms, convirtiendola en la referencia temporal 0:

ind_t_gps 	 = find(time_boot_ms_mavlink_global_position_int_t(:,1)>=...
               tiempo_0_video,1);
tiempo_0_gps = time_boot_ms_mavlink_global_position_int_t(ind_t_gps,2);

ind_t_act    = find(time_boot_ms_mavlink_attitude_t(:,1)>=...
               tiempo_0_video,1);
tiempo_0_act = time_boot_ms_mavlink_attitude_t(ind_t_act,2);

ind_t_acel    = find(time_usec_mavlink_raw_imu_t(:,1)>=tiempo_0_video,1);
tiempo_0_acel = time_usec_mavlink_raw_imu_t(ind_t_acel,2);

ind_t_pwm    = find(time_boot_ms_mavlink_rc_channels_raw_t(:,1)>=...
               tiempo_0_video,1);
tiempo_0_pwm = time_boot_ms_mavlink_rc_channels_raw_t(ind_t_pwm,2);

ind_t_pres    = find(time_boot_ms_mavlink_scaled_pressure_t(:,1)...
                >=tiempo_0_video,1);
tiempo_0_pres = time_boot_ms_mavlink_scaled_pressure_t(ind_t_pres,2);
                 
ind_t_vnt    = find(time_boot_ms_mavlink_system_time_t(:,1)...
               >=tiempo_0_video,1);    
tiempo_0_vnt = time_boot_ms_mavlink_system_time_t(ind_t_vnt,2);

% Variables de tiempo en ms para todas las medidas. Se crean los vectores 
% de tiempo en ms para cada tipo de medicion y se elimina la parte previa
% al inicio del video, es decir, anterior al despegue:

tiempo_gps = time_boot_ms_mavlink_global_position_int_t(:,2)-tiempo_0_gps;
gps_0_ms   = find(tiempo_gps>=0,1); 
tiempo_gps = tiempo_gps(gps_0_ms:end);

tiempo_act = time_boot_ms_mavlink_attitude_t(:,2)-tiempo_0_act;
act_0_ms   = find(tiempo_act>=0,1); 
tiempo_act = tiempo_act(act_0_ms:end);

tiempo_acel = (time_usec_mavlink_raw_imu_t(:,2)-tiempo_0_acel)/1000;
acel_0_ms   = find(tiempo_acel>=0,1); 
tiempo_acel = tiempo_acel(acel_0_ms:end);

tiempo_pwm = time_boot_ms_mavlink_rc_channels_raw_t(:,2)-tiempo_0_pwm;
pwm_0_ms   = find(tiempo_pwm>=0,1);
tiempo_pwm = tiempo_pwm(pwm_0_ms:end);

tiempo_pres = time_boot_ms_mavlink_scaled_pressure_t(:,2)-tiempo_0_pres;
pres_0_ms   = find(tiempo_pres>=0,1);
tiempo_pres = tiempo_pres(pres_0_ms:end);

tiempo_vnt  = time_boot_ms_mavlink_system_time_t(:,2)-tiempo_0_vnt;
viento_0_ms = find(tiempo_vnt>=0,1);
tiempo_vnt  = tiempo_vnt(viento_0_ms:end);


%% EQUIVALENCIA HORA ESTACION EN TIERRA

% En base a esta referencia de tiempos, para cada parametro registrado, se
% va a construir una matriz que contiene tantas filas como numero de
% medidas de ese parametro, la cual tiene dos columnas que representan:
%
%   - Columna 1: tiempo en milisengudos desde la referencia temporal.
%   - Columna 2: valor del parametro medido (se especifican las unidades 
%                en cada caso).

tiempo_0_gs = datestr(time_boot_ms_mavlink_global_position_int_t(1,1));

 
%% DATOS REGISTRADOS POR LA TELEMETRIA

% COORDENADAS GEOGRAFICAS:

latitud = [tiempo_gps ...
          lat_mavlink_global_position_int_t(gps_0_ms:end,2)/1e7];     
latitud = latitud(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de latitud en grados.

longitud = [tiempo_gps ...
           lon_mavlink_global_position_int_t(gps_0_ms:end,2)/1e7];   
longitud = longitud(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de longitud en grados.

altitud = [tiempo_gps ...
          alt_mavlink_global_position_int_t(gps_0_ms:end,2)/1000];
altitud = altitud(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de altitud (sobre el elipsoide WGS84) en metros.

altura = [tiempo_gps ...
         relative_alt_mavlink_global_position_int_t(gps_0_ms:end,2)/1000];
altura = altura(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de altura (sobre el suelo) en metros.

% VELOCIDADES RESPECTO A TIERRA EN EJES NED:

v_norte = [tiempo_gps ...
          vx_mavlink_global_position_int_t(gps_0_ms:end,2)/100];
v_norte = v_norte(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente de velocidad norte en m/s.

v_este = [tiempo_gps ...
         vy_mavlink_global_position_int_t(gps_0_ms:end,2)/100];
v_este = v_este(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente de velocidad este en m/s.

v_vert = [tiempo_gps ...
         -vz_mavlink_global_position_int_t(gps_0_ms:end,2)/100];
v_vert = v_vert(1:ind_aux(1),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente de velocidad vertical en m/s.

% ANGULOS DE EULER:

alabeo = [tiempo_act ...
         roll_mavlink_attitude_t(act_0_ms:end,2)];   
alabeo = alabeo(1:ind_aux(2),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de angulo de alabeo en radianes.

cabeceo = [tiempo_act ...
          pitch_mavlink_attitude_t(act_0_ms:end,2)];  
cabeceo = cabeceo(1:ind_aux(2),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de angulo de cabeceo en radianes.

guinada = [tiempo_act ...
          yaw_mavlink_attitude_t(act_0_ms:end,2)];  
guinada = guinada(1:ind_aux(2),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de angulo de guinada en radianes.

% VELOCIDADES ANGULARES EN EJES CUERPO:

w_alabeo = [tiempo_act ...
           rollspeed_mavlink_attitude_t(act_0_ms:end,2)];
w_alabeo = w_alabeo(1:ind_aux(2),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de velocidad angular de alabeo en radianes/s.

w_cabeceo = [tiempo_act ...
            pitchspeed_mavlink_attitude_t(act_0_ms:end,2)]; 
w_cabeceo = w_cabeceo(1:ind_aux(2),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de velocidad angular de cabeceo en radianes/s.

w_guinada = [tiempo_act ...
            yawspeed_mavlink_attitude_t(act_0_ms:end,2)];    
w_guinada = w_guinada(1:ind_aux(2),:); 
% 1ª columna: tiempo en ms.
% 2ª columna: medida de velocidad angular de guinada en radianes/s.

% ACELERACIONES EN EJES CUERPO:

% Existe un error en las medidas de aceleracion del cuarto vuelo el cual
% queda solucionado con el siguiente codigo:

if vuelo == 4

    ind_error = 1258; 
    error_t   = 4.2944462e+06; %cantidad desplazada en el tiempo
    
else
    
    ind_error = 1;
    error_t   = 0;

end

a_x = [tiempo_acel(1:ind_error) ...
      9.81e-3*xacc_mavlink_raw_imu_t(acel_0_ms:acel_0_ms+ind_error-1,2);
      tiempo_acel(ind_error+1:end)+error_t ...
      9.81e-3*xacc_mavlink_raw_imu_t(acel_0_ms+ind_error:end,2)];
a_x = a_x(1:ind_aux(3),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente X de la aceleracion en m/s^2.

a_y = [tiempo_acel(1:ind_error) ...
      9.81e-3*yacc_mavlink_raw_imu_t(acel_0_ms:acel_0_ms+ind_error-1,2); 
      tiempo_acel(ind_error+1:end)+error_t ...
      9.81e-3*yacc_mavlink_raw_imu_t(acel_0_ms+ind_error:end,2)];  
a_y = a_y(1:ind_aux(3),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente Y de la aceleracion en m/s^2.

a_z = [tiempo_acel(1:ind_error) ...
      -(9.81e-3*zacc_mavlink_raw_imu_t(acel_0_ms:acel_0_ms+ind_error-1,2)); 
      tiempo_acel(ind_error+1:end)+error_t ...
      -(9.81e-3*zacc_mavlink_raw_imu_t(acel_0_ms+ind_error:end,2))]; 
a_z = a_z(1:ind_aux(3),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente Z de la aceleracion en m/s^2.

% SENALES PWM DE LOS ACTUADORES:

alerones_pwm = [tiempo_pwm ...
               chan1_raw_mavlink_rc_channels_raw_t(pwm_0_ms:end,2)];
alerones_pwm = alerones_pwm(1:ind_aux(4),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de senal del canal 1 (alerones) del PWM en us.

elevadores_pwm = [tiempo_pwm ...
                 chan2_raw_mavlink_rc_channels_raw_t(pwm_0_ms:end,2)];
elevadores_pwm = elevadores_pwm(1:ind_aux(4),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de senal del canal 2 (elevadores) del PWM en us.

motor_pwm = [tiempo_pwm ...
            chan3_raw_mavlink_rc_channels_raw_t(pwm_0_ms:end,2)];
motor_pwm = motor_pwm(1:ind_aux(4),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de senal del canal 3 (motor) del PWM en us.

% MEDIDAS BAROMETRICAS:

presion_abs = [tiempo_pres ...
              press_abs_mavlink_scaled_pressure_t(pres_0_ms:end,2)*100];
presion_abs = presion_abs(1:ind_aux(5),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de presion absoluta en pascales.

presion_dif = [tiempo_pres ...
              press_diff_mavlink_scaled_pressure_t(pres_0_ms:end,2)*100];
presion_dif = presion_dif(1:ind_aux(5),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de presion diferencial en pascales.

% MEDIDAS DE VIENTO

viento_mag_horz = [tiempo_vnt(1:end-ind_aux(7)) ...
                  speed_mavlink_wind_t(viento_0_ms:end-ind_aux(8),2)];
viento_mag_horz = viento_mag_horz(1:ind_aux(6),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente horizontal de viento en m/s.

viento_mag_vert = [tiempo_vnt(1:end-ind_aux(7)) ...
                  -speed_z_mavlink_wind_t(viento_0_ms:end-ind_aux(8),2)];
viento_mag_vert = viento_mag_vert(1:ind_aux(6),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de la componente vertical de viento en m/s.

viento_dir = [tiempo_vnt(1:end-ind_aux(7)) ...
             mod(direction_mavlink_wind_t(viento_0_ms:end-ind_aux(8),2)...
             .*(pi/180)+pi,2*pi)];
viento_dir = viento_dir(1:ind_aux(6),:);
% 1ª columna: tiempo en ms.
% 2ª columna: medida de direccion de viento en radianes.

%% CELDATOS

celdatos{1}  = latitud;
celdatos{2}  = longitud;
celdatos{3}  = altitud;
celdatos{4}  = altura;
celdatos{5}  = v_norte;
celdatos{6}  = v_este;
celdatos{7}  = v_vert;
celdatos{8}  = alabeo;
celdatos{9}  = cabeceo;
celdatos{10} = guinada;
celdatos{11} = w_alabeo;
celdatos{12} = w_cabeceo;
celdatos{13} = w_guinada;
celdatos{14} = a_x;
celdatos{15} = a_y;
celdatos{16} = a_z;
celdatos{17} = alerones_pwm;
celdatos{18} = elevadores_pwm;
celdatos{19} = motor_pwm;
celdatos{20} = presion_abs;
celdatos{21} = presion_dif;
celdatos{22} = viento_mag_horz;
celdatos{23} = viento_mag_vert;
celdatos{24} = viento_dir;