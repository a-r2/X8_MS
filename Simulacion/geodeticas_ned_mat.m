function salida = geodeticas_ned_mat(entrada)
% Funcion que transforma coordenadas geodeticas a NED.
%
% salida = geodeticas_ned_mat(entrada)
%
% Siendo:
%
% [latitud0, longitud0, altitud0, coordenadas] = entrada; 
%
% donde coordenadas es un vector formado por una sucesion de coordenadas
% geodeticas en el formato lineal [latitud, longitud, altitud].
%
% N = salida(1);
% E = salida(2);
% D = salida(3);


%% ENTRADA

latitud0  = entrada(1);
longitud0 = entrada(2);
altitud0  = entrada(3);

latitud  = [];
longitud = [];
altitud  = [];

for k=4:3:length(entrada)-2
    
    latitud   = [latitud; entrada(k)];
    longitud  = [longitud; entrada(k+1)];
    altitud   = [altitud; entrada(k+2)];
    
end


%% CALCULO

WGS84   = referenceEllipsoid('wgs84');  
[N,E,D] = geodetic2ned(latitud,longitud,altitud,latitud0,longitud0,...
          altitud0,WGS84);   
      

%% SALIDA
      
salida = reshape([N,E,D].',[],1);