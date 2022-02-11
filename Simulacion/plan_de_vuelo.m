% Plan de vuelo. Seleccion de waypoints en formato:
%
% waypoint = [latitud longitud altitud]
%
% Con el objetivo de facilitar la busqueda de coordenadas de los puntos de
% paso, ejecutar en la ventana de comandos de Matlab "webmap". En la 
% esquina superior derecha del mapa se representan las coordenadas 
% geodeticas en funcion de la posicion actual del raton.
%
% NOTA: Es recomendable seleccionar los waypoints de tal manera que la ruta
% sea lo mas sueva posible, por tanto se deberian escoger waypoints
% sucesivos de tal forma que segmentos de ruta contiguos no formen mas de
% 90 grados entre si con el fin de evitar giros abruptos. Del mismo modo,
% se sugiere la activacion del controlador de Uinf (delta_t) para recorrer
% la ruta a una velocidad constante. Por ultimo, es importante tener en 
% cuenta que el correcto seguimiento de la misma queda a expensas de la 
% actuacion del UAV.

waypoints_mat = [37.42200 -5.88350 150;
                 37.42400 -5.88875 175; 
                 37.42200 -5.89300 200; 
                 37.41400 -5.89300 200; 
                 37.41200 -5.89825 175;
                 37.41400 -5.90350 150;
                 37.41500 -5.91010 125;
                 37.41800 -5.91210 100;
                 37.42100 -5.91010 100;
                 37.42100 -5.90350 125;
                 37.41800 -5.89300 150;
                 37.41800 -5.87420 150];
         
waypoints = reshape(waypoints_mat.',[],1);