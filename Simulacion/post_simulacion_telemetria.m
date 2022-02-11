% Script que representa en distintas graficas datos de interes obtenidos 
% a lo largo de la simulacion de la telemetria.

close all

figure; 
subplot(3,1,1);
plot(posicion_geodetica.Time,posicion_geodetica.Data(:,1),...
     latitud.Time,latitud.Data,'r');
grid; title('Latitud');
xlabel('t [s]'); ylabel('\Phi [º]'); 
subplot(3,1,2);
plot(posicion_geodetica.Time,posicion_geodetica.Data(:,2),...
     longitud.Time,longitud.Data,'r'); 
grid; title('Longitud');
xlabel('t [s]'); ylabel('\Lambda [º]'); 
subplot(3,1,3);
plot(posicion_geodetica.Time,posicion_geodetica.Data(:,3),...
     altitud.Time,altitud.Data,'r'); 
grid; title('Altitud');
xlabel('t [s]'); ylabel('h [m]'); 

figure; 
subplot(3,1,1)
plot(velocidades_lineales.Time,velocidades_lineales.Data(:,1),...
     v_x.Time,v_x.Data); 
grid; title('Velocidad X (cuerpo)');
xlabel('t [s]'); ylabel('V_X [m/s]'); 
subplot(3,1,2);
plot(velocidades_lineales.Time,velocidades_lineales.Data(:,2),...
     v_y.Time,v_y.Data); 
grid; title('Velocidad Y (cuerpo)');
xlabel('t [s]'); ylabel('V_Y [m/s]'); 
subplot(3,1,3);
plot(velocidades_lineales.Time,velocidades_lineales.Data(:,3),...
     v_z.Time,v_z.Data); 
grid; title('Velocidad Z (cuerpo)');
xlabel('t [s]'); ylabel('V_Z [m/s]');

figure; 
subplot(3,1,1)
plot(aceleraciones_lineales.Time,aceleraciones_lineales.Data(:,1),...
     a_x.Time,a_x.Data); 
grid; title('Aceleracion X (cuerpo)');
xlabel('t [s]'); ylabel('A_X [m/s^2]'); 
subplot(3,1,2);
plot(aceleraciones_lineales.Time,aceleraciones_lineales.Data(:,2),...
     a_y.Time,a_y.Data); 
grid; title('Aceleracion Y (cuerpo)');
xlabel('t [s]'); ylabel('A_Y [m/s^2]'); 
subplot(3,1,3);
plot(aceleraciones_lineales.Time,aceleraciones_lineales.Data(:,3),...
     a_z.Time,a_z.Data); 
grid; title('Aceleracion Z (cuerpo)');
xlabel('t [s]'); ylabel('A_Z [m/s^2]');

figure; 
subplot(3,1,1);
plot(actitud.Time,actitud.Data(:,1),alabeo.Time,alabeo.Data*180/pi); 
grid; title('Alabeo');
xlabel('t [s]'); ylabel('\phi [º]'); 
subplot(3,1,2);
plot(actitud.Time,actitud.Data(:,2),cabeceo.Time,cabeceo.Data*180/pi); 
grid; title('Cabeceo');
xlabel('t [s]'); ylabel('\theta [º]'); 
subplot(3,1,3);
plot(actitud.Time,actitud.Data(:,3),guinada.Time,...
     mod(guinada.Data*180/pi,360)); 
grid; title('Guinada');
xlabel('t [s]'); ylabel('\psi [º]');

figure; 
subplot(3,1,1);
plot(velocidades_angulares.Time,velocidades_angulares.Data(:,1),...
     w_alabeo.Time,w_alabeo.Data); 
grid; title('Velocidad de alabeo');
xlabel('t [s]'); ylabel('\omega_\phi [º/s]'); 
subplot(3,1,2);
plot(velocidades_angulares.Time,velocidades_angulares.Data(:,2),...
     w_cabeceo.Time,w_cabeceo.Data); 
grid; title('Velocidad de cabeceo');
xlabel('t [s]'); ylabel('\omega_\theta [º/s]'); 
subplot(3,1,3);
plot(velocidades_angulares.Time,velocidades_angulares.Data(:,3),...
     w_guinada.Time,w_guinada.Data); 
grid; title('Velocidad de guinada');
xlabel('t [s]'); ylabel('\omega_\psi [º/s]');