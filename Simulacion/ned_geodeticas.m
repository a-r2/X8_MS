function salida = ned_geodeticas(entrada)
% Funcion que transforma coordenadas NED a geodeticas.
% 
% salida = ned_geodeticas(entrada)
%
% Siendo:
%
% latitud0  = entrada(1);
% longitud0 = entrada(2);
% altitud0  = entrada(3);
% X         = entrada(4);
% Y         = entrada(5);
% Z         = entrada(6);
%
% longitud  = salida(1);
% latitud   = salida(2);
% altitud   = salida(3);


%% ENTRADA

latitud0  = entrada(1);
longitud0 = entrada(2);
altitud0  = entrada(3);
X         = entrada(4);
Y         = entrada(5);
Z         = entrada(6);


%% CALCULO

WGS84 = referenceEllipsoid('wgs84');
[latitud,longitud,altitud] = ned2geodetic(X,Y,Z,latitud0,longitud0,...
                             altitud0,WGS84);
          
salida = [longitud;latitud;altitud];