% Script que procesa los datos contenidos en las celdas generadas por
% interprete_datos.m. El motivo es la necesidad de homogeneizar los datos 
% provenientes de los distintos sensores de abordo, los cuales no trabajan 
% a las mismas frecuencias de refresco, con el fin de poder utilizarlos 
% para el calculo de la ley propulsiva, la cual relaciona la entrada de la 
% senal PWM del motor con la fuerza generada por el mismo.
%
% El algoritmo aplicado se basa en un proceso similar al Zero-Order Hold
% (ZOH): 
%
% 1.- Se elige la celda cuya matriz es mas larga (perteneciente al sensor 
%     con la tasa de refresco mas alta) y se unifica esta misma longitud 
%     para todas las demas celdas (dejando invariables a las de mayor 
%     longitud).
% 
% 2.- Se modifican las celdas cuyas matrices no tengan la longitud maxima 
%     mediante un proceso ZOH, rellenandolas de este modo para los nuevos
%     valores de tiempo.


%% CALCULO

% Medimos las longitudes de las matrices y dejamos invariables aquellas
% que tengan la mayor longitud. Se generan vectores en los que se
% diferencian los parametros cuya longitud de matriz es maxima de los que 
% no, caracterizados por su indice dentro de celdatos:

longitud  = [];
ind_datos = [1:size(celdatos,2)];

for k=1:ind_datos(end)
    
    longitud(k) = size(celdatos{k},1);
    
end

[longitud_max,ind_max] = max(longitud);
ind_max_repetidos      = find(longitud==longitud_max);

for k=ind_max_repetidos(1):ind_max_repetidos(end)
    
    celproces{k} = celdatos{k};
    
end

ind_no_max                    = ind_datos;
ind_no_max(ind_max_repetidos) = [];

% Se modifican las matrices de datos que no tengan una longitud maxima con 
% tal de igualarlas a las de longitud maxima. Para ello se mantienen los
% datos hasta que se produce un cambio en el valor de tiempo (columna 1 de
% matriz de cada una de las celdas):

for i=ind_no_max
                
    celproces{i}(1,:) = celdatos{i}(1,:);       
    
    if celdatos{i}(end,1)<celdatos{ind_max}(end,1)
       
        aux = 1;
        
    else
        
        aux = 0;
        
    end
    
    for j=2:longitud(i)
        
        ind_inicial = size(celproces{i},1);
        ind_final   = find(celproces{ind_max}(:,1)<=...
                      celdatos{i}(j,1),1,'last');
        
        celproces{i}(ind_inicial+1:ind_final,1) = ...
        celdatos{ind_max}(ind_inicial+1:ind_final,1);
        celproces{i}(ind_inicial+1:ind_final,2) = ...
        celproces{i}(ind_inicial,2);
        celproces{i}(ind_final,:) = celdatos{i}(j,:);
            
        if j~=longitud(i)

            if celproces{i}(ind_final,1)~=celproces{ind_max}(ind_final+1,1)

                celproces{i}(ind_final,:) = celdatos{i}(j,:);

            else

                celproces{i}(ind_final,:) = celdatos{i}(ind_final+1,:);

            end
            
        else
            
            if aux==0
                
                celproces{i}(ind_final,:) = celdatos{i}(j,:);
                
            else
                
                celproces{i}(ind_final,:) = celdatos{i}(j,:);
                
                for k=ind_final+1:longitud_max
                    
                    celproces{i}(k,1) = celdatos{ind_max}(k,1);
                    celproces{i}(k,2) = celdatos{i}(j,2);
                    
                end
                
            end
            
        end      
        
    end
    
end


%% CELPROCES

latitud         = celproces{1};
longitud        = celproces{2};
altitud         = celproces{3};
altura          = celproces{4};
v_norte         = celproces{5};
v_este          = celproces{6};
v_vert          = celproces{7};
alabeo          = celproces{8};
cabeceo         = celproces{9};
guinada         = celproces{10};
w_alabeo        = celproces{11};
w_cabeceo       = celproces{12};
w_guinada       = celproces{13};
a_x             = celproces{14};
a_y             = celproces{15};
a_z             = celproces{16};
alerones_pwm    = celproces{17};
elevadores_pwm  = celproces{18};
motor_pwm       = celproces{19};
presion_abs     = celproces{20};
presion_dif     = celproces{21};
viento_mag_horz = celproces{22};
viento_mag_vert = celproces{23};
viento_dir      = celproces{24};


%% CALCULO DE OTROS PARAMETROS

% Se anaden dos celdas nuevas (presion estatica y densidad), las 
% cuales requerian procesamiento para ser creadas:

presion_est = [presion_abs(:,1) presion_abs(:,2)+presion_dif(:,2)];

rho0 = 1.225225;
T0   = 288.15;
a    = -6.5e-3;
g    = 9.81;
R    = 287;

densidad = [presion_abs(:,1) ...
           rho0*((T0+a.*altitud(:,2))/T0).^(-(g/(a*R))-1)]; 
% 1ª columna: tiempo en ms.
% 2ª columna: calculo de densidad (ISA) en kg/m^3.

celproces{25} = presion_est;
celproces{26} = densidad;