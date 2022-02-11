% Script que representa los datos de telemetria procesados o no procesados, 
% en diversas graficas y correspondientes a un vuelo determinado.

close all, clear all

flag1 = 0;

while flag1==0

    texto1   = ['Pulse un numero entre 1 y 5 para analizar la ' ...
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

flag2 = 0;

while flag2==0

    texto2   = ['Pulse 0 para visualizar los datos no procesados o 1 ' ...
                'para visualizar los datos procesados. A ' ...
                'continuacion, presione la tecla ENTER.\n'];
    entrada2 = input(texto2);
    
    if entrada2<0 || entrada2>1
    
        error2 = ['Debe pulsar la tecla 0 o 1. Por favor, intentelo ' ...
                  'de nuevo.'];
        disp(error2);
        
    else
        
        flag2 = 1;
         
    end
    
end

celdatos = datos_telemetria(entrada1);

if entrada2==1
    
    procesador_datos;
    
    figure; 
    subplot(2,2,1);
    plot(celproces{1}(:,1)*1e-3,celproces{1}(:,2)); 
    grid; title('Latitud');
    xlabel('t [s]'); ylabel('\Phi [º]'); 
    subplot(2,2,2);
    plot(celproces{2}(:,1)*1e-3,celproces{2}(:,2)); 
    grid; title('Longitud');
    xlabel('t [s]'); ylabel('\Lambda [º]'); 
    subplot(2,2,3);
    plot(celproces{3}(:,1)*1e-3,celproces{3}(:,2)); 
    grid; title('Altitud');
    xlabel('t [s]'); ylabel('h [m]'); 
    subplot(2,2,4);
    plot(celproces{4}(:,1)*1e-3,celproces{4}(:,2)); 
    grid; title('Altura');
    xlabel('t [s]'); ylabel('H [m]');
    
    figure; 
    subplot(3,1,1);
    plot(celproces{5}(:,1)*1e-3,celproces{5}(:,2)); 
    grid; title('V_G_P_S norte');
    xlabel('t [s]'); ylabel('V_N [m/s]'); 
    subplot(3,1,2);
    plot(celproces{6}(:,1)*1e-3,celproces{6}(:,2)); 
    grid; title('V_G_P_S este');
    xlabel('t [s]'); ylabel('V_E [m/s]'); 
    subplot(3,1,3);
    plot(celproces{7}(:,1)*1e-3,celproces{7}(:,2)); 
    grid; title('V_G_P_S vertical');
    xlabel('t [s]'); ylabel('V_D [m/s]'); 

    figure; 
    subplot(2,3,1);
    plot(celproces{8}(:,1)*1e-3,rem(celproces{8}(:,2).*(180/pi),180)); 
    grid; title('Alabeo');
    xlabel('t [s]'); ylabel('\phi [º]'); 
    subplot(2,3,2);
    plot(celproces{9}(:,1)*1e-3,rem(celproces{9}(:,2).*(180/pi),90)); 
    grid; title('Cabeceo');
    xlabel('t [s]'); ylabel('\theta [º]'); 
    subplot(2,3,3);
    plot(celproces{10}(:,1)*1e-3,mod(celproces{10}(:,2).*(180/pi),360)); 
    grid; title('Guinada');
    xlabel('t [s]'); ylabel('\psi [º]');
    subplot(2,3,4);
    plot(celproces{11}(:,1)*1e-3,celproces{11}(:,2).*(180/pi)); 
    grid; title('Velocidad de alabeo');
    xlabel('t [s]'); ylabel('\omega_\phi [º/s]'); 
    subplot(2,3,5);
    plot(celproces{12}(:,1)*1e-3,celproces{12}(:,2).*(180/pi)); 
    grid; title('Velocidad de cabeceo');
    xlabel('t [s]'); ylabel('\omega_\theta [º/s]'); 
    subplot(2,3,6);
    plot(celproces{13}(:,1)*1e-3,celproces{13}(:,2).*(180/pi)); 
    grid; title('Velocidad de guinada');
    xlabel('t [s]'); ylabel('\omega_\psi [º/s]');
    
    figure; 
    subplot(3,1,1);
    plot(celproces{14}(:,1)*1e-3,celproces{14}(:,2)); 
    grid; title('Aceleracion X');
    xlabel('t [s]'); ylabel('A_X [m/s^2]'); 
    subplot(3,1,2);
    plot(celproces{15}(:,1)*1e-3,celproces{15}(:,2)); 
    grid; title('Aceleracion Y');
    xlabel('t [s]'); ylabel('A_Y [m/s^2]'); 
    subplot(3,1,3);
    plot(celproces{16}(:,1)*1e-3,celproces{16}(:,2)); 
    grid; title('Aceleracion Z');
    xlabel('t [s]'); ylabel('A_Z [m/s^2]'); 
    
    figure; 
    subplot(3,1,1);
    plot(celproces{17}(:,1)*1e-3,celproces{17}(:,2)); 
    grid; title('Alerones');
    xlabel('t [s]'); ylabel('Canal 1 PWM (alerones) [\mus]'); 
    subplot(3,1,2);
    plot(celproces{18}(:,1)*1e-3,celproces{18}(:,2)); 
    grid; title('Elevadores');
    xlabel('t [s]'); ylabel('Canal 2 PWM (elevadores) [\mus]'); 
    subplot(3,1,3);
    plot(celproces{19}(:,1)*1e-3,celproces{19}(:,2)); 
    grid; title('Motor');
    xlabel('t [s]'); ylabel('Canal 3 PWM (motor) [\mus]');
    
    figure;
    subplot(2,2,1);
    plot(celproces{20}(:,1)*1e-3,celproces{20}(:,2)); 
    grid; title('Presion absoluta');
    xlabel('t [s]'); ylabel('P [Pa]');
    subplot(2,2,2)
    plot(celproces{25}(:,1)*1e-3,celproces{25}(:,2)); 
    grid; title('Presion estatica');
    xlabel('t [s]'); ylabel('P_e_s_t [Pa]');
    subplot(2,2,3);
    plot(celproces{21}(:,1)*1e-3,celproces{21}(:,2)); 
    grid; title('Presion diferencial');
    xlabel('t [s]'); ylabel('P [Pa]');
    subplot(2,2,4);
    plot(celproces{26}(:,1)*1e-3,celproces{26}(:,2)); 
    grid; title('Densidad');
    xlabel('t [s]'); ylabel('\rho [kg/m^3]');
    
    figure;
    subplot(3,1,1);
    plot(celproces{22}(:,1)*1e-3,celproces{22}(:,2)); 
    grid; title('Magnitud de la componente de viento horizontal (NED)');
    xlabel('t [s]'); ylabel('V_H_ _v_i_e_n_t_o [m/s]');
    subplot(3,1,2);
    plot(celproces{23}(:,1)*1e-3,celproces{23}(:,2)); 
    grid; title('Magnitud de la componente de viento vertical (NED)');
    xlabel('t [s]'); ylabel('V_D_ _v_i_e_n_t_o [m/s]');
    subplot(3,1,3);
    plot(celproces{24}(:,1)*1e-3,celproces{24}(:,2).*(180/pi)); 
    grid; title('Direccion del viento (NED)');
    xlabel('t [s]'); ylabel('\Psi_v_i_e_n_t_o [º]');
    
    v_tierra_b = [];
    v_viento_b = [];
    v_aero_b   = [];
    
    for k=1:longitud_max
    
        phi = alabeo(k,2); theta = cabeceo(k,2); psi = guinada(k,2);

        % Matriz de rotacion de ejes NED a ejes cuerpo:
        
        R_nb = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta); ...
               sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*...
               sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*...
               cos(theta); cos(phi)*sin(theta)*cos(psi)+sin(phi)*...
               sin(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi) ...
               cos(phi)*cos(theta)];

        v_tierra_b = [v_tierra_b; norm(R_nb*[v_norte(k,2); v_este(k,2); ...
                     v_vert(k,2)])];

        w_total = sqrt(viento_mag_horz(k,2)^2+viento_mag_vert(k,2)^2);
        w_norte = -w_total*cos(viento_dir(k,2));
        w_este  = -w_total*sin(viento_dir(k,2));
        w_vert  = viento_mag_vert(k,2);

        v_viento_b = [v_viento_b; norm(R_nb*[w_norte;w_este;w_vert])];

        v_aero_b = [v_aero_b; v_tierra_b(k)-v_viento_b(k)];

    end
    
    figure;
    subplot(3,1,1);
    plot(v_norte(:,1)*1e-3,v_tierra_b); 
    grid; title('V_U_A_V respecto a tierra (cuerpo)');
    xlabel('t [s]'); ylabel('V_t_i_e_r_r_a [m/s]');
    subplot(3,1,2);
    plot(celproces{22}(:,1)*1e-3,v_viento_b); 
    grid; title('V_v_i_e_n_t_o respecto a tierra (cuerpo)');
    xlabel('t [s]'); ylabel('V_v_i_e_n_t_o [m/s]');
    subplot(3,1,3);
    plot(celproces{22}(:,1)*1e-3,v_aero_b); 
    grid; title('V aerodinamica (cuerpo)');
    xlabel('t [s]'); ylabel('V_a_e_r_o [m/s]');
    
elseif entrada2==0
   
    figure; 
    subplot(2,2,1);
    plot(celdatos{1}(:,1)*1e-3,celdatos{1}(:,2)); 
    grid; title('Latitud');
    xlabel('t [s]'); ylabel('\Phi [º]'); 
    subplot(2,2,2);
    plot(celdatos{2}(:,1)*1e-3,celdatos{2}(:,2)); 
    grid; title('Longitud');
    xlabel('t [s]'); ylabel('\Lambda [º]'); 
    subplot(2,2,3);
    plot(celdatos{3}(:,1)*1e-3,celdatos{3}(:,2)); 
    grid; title('Altitud');
    xlabel('t [s]'); ylabel('h [m]'); 
    subplot(2,2,4);
    plot(celdatos{4}(:,1)*1e-3,celdatos{4}(:,2)); 
    grid; title('Altura');
    xlabel('t [s]'); ylabel('H [m]');
    
    figure; 
    subplot(3,1,1);
    plot(celdatos{5}(:,1)*1e-3,celdatos{5}(:,2)); 
    grid; title('V_G_P_S norte');
    xlabel('t [s]'); ylabel('V_N [m/s]'); 
    subplot(3,1,2);
    plot(celdatos{6}(:,1)*1e-3,celdatos{6}(:,2)); 
    grid; title('V_G_P_S este');
    xlabel('t [s]'); ylabel('V_E [m/s]'); 
    subplot(3,1,3);
    plot(celdatos{7}(:,1)*1e-3,celdatos{7}(:,2)); 
    grid; title('V_G_P_S vertical');
    xlabel('t [s]'); ylabel('V_D [m/s]'); 
    
    figure; 
    subplot(2,3,1);
    plot(celdatos{8}(:,1)*1e-3,rem(celdatos{8}(:,2).*(180/pi),180)); 
    grid; title('Alabeo');
    xlabel('t [s]'); ylabel('\phi [º]'); 
    subplot(2,3,2);
    plot(celdatos{9}(:,1)*1e-3,rem(celdatos{9}(:,2).*(180/pi),90)); 
    grid; title('Cabeceo');
    xlabel('t [s]'); ylabel('\theta [º]'); 
    subplot(2,3,3);
    plot(celdatos{10}(:,1)*1e-3,mod(celdatos{10}(:,2).*(180/pi),360)); 
    grid; title('Guinada');
    xlabel('t [s]'); ylabel('\psi [º]');
    subplot(2,3,4);
    plot(celdatos{11}(:,1)*1e-3,celdatos{11}(:,2).*(180/pi)); 
    grid; title('Velocidad de alabeo');
    xlabel('t [s]'); ylabel('\omega_\phi [º/s]'); 
    subplot(2,3,5);
    plot(celdatos{12}(:,1)*1e-3,celdatos{12}(:,2).*(180/pi)); 
    grid; title('Velocidad de cabeceo');
    xlabel('t [s]'); ylabel('\omega_\theta [º/s]'); 
    subplot(2,3,6);
    plot(celdatos{13}(:,1)*1e-3,celdatos{13}(:,2).*(180/pi)); 
    grid; title('Velocidad de guinada');
    xlabel('t [s]'); ylabel('\omega_\psi [º/s]');
    
    figure; 
    subplot(3,1,1);
    plot(celdatos{14}(:,1)*1e-3,celdatos{14}(:,2)); 
    grid; title('Aceleracion X');
    xlabel('t [s]'); ylabel('a_X [m/s^2]'); 
    subplot(3,1,2);
    plot(celdatos{15}(:,1)*1e-3,celdatos{15}(:,2)); 
    grid; title('Aceleracion Y');
    xlabel('t [s]'); ylabel('a_Y [m/s^2]'); 
    subplot(3,1,3);
    plot(celdatos{16}(:,1)*1e-3,celdatos{16}(:,2)); 
    grid; title('Aceleracion Z');
    xlabel('t [s]'); ylabel('a_Z [m/s^2]'); 
    
    figure; 
    subplot(3,1,1);
    plot(celdatos{17}(:,1)*1e-3,celdatos{17}(:,2)); 
    grid; title('Alerones');
    xlabel('t [s]'); ylabel('Canal 1 PWM (alerones) [\mus]'); 
    subplot(3,1,2);
    plot(celdatos{18}(:,1)*1e-3,celdatos{18}(:,2)); 
    grid; title('Elevadores');
    xlabel('t [s]'); ylabel('Canal 2 PWM (elevadores) [\mus]'); 
    subplot(3,1,3);
    plot(celdatos{19}(:,1)*1e-3,celdatos{19}(:,2)); 
    grid; title('Motor');
    xlabel('t [s]'); ylabel('Canal 3 PWM (motor) [\mus]');
    
    figure;
    subplot(2,1,1);
    plot(celdatos{20}(:,1)*1e-3,celdatos{20}(:,2)); 
    grid; title('Presion absoluta');
    xlabel('t [s]'); ylabel('P_a_b_s [Pa]');
    subplot(2,1,2);
    plot(celdatos{21}(:,1)*1e-3,celdatos{21}(:,2)); 
    grid; title('Presion diferencial');
    xlabel('t [s]'); ylabel('P_e_s_t-P_a_b_s [Pa]');
    
    figure;
    subplot(3,1,1);
    plot(celdatos{22}(:,1)*1e-3,celdatos{22}(:,2)); 
    grid; title('Magnitud de la componente de viento horizontal (NED)');
    xlabel('t [s]'); ylabel('V_H_ _v_i_e_n_t_o [m/s]');
    subplot(3,1,2);
    plot(celdatos{23}(:,1)*1e-3,celdatos{23}(:,2)); 
    grid; title('Magnitud de la componente de viento vertical (NED)');
    xlabel('t [s]'); ylabel('V_D_ _v_i_e_n_t_o [m/s]');
    subplot(3,1,3);
    plot(celdatos{24}(:,1)*1e-3,celdatos{24}(:,2).*(180/pi)); 
    grid; title('Direccion del viento (NED)');
    xlabel('t [s]'); ylabel('\Psi_v_i_e_n_t_o [º]');
    
end