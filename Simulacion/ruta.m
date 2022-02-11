function salida = ruta(entrada)
% Funcion que implementa la ruta a seguir por el sistema de gestion de
% vuelo.
%
% salida = ruta(entrada)
%
% Siendo:
%
% disparo_reinicio = entrada(1);
% p_reinicio       = entrada(2:4);
% p_ned            = entrada(5:7);
% tramo            = entrada(8);
% waypoints_ned    = entrada(9:end);
%
% r1               = salida(1);
% q1               = salida(2);
% tramo            = salida(3);
%
% donde r1 es el vector unitario que marca la posicion del UAV respecto al
% origen de coordenadas NED y q1 es el vector unitario que une el ultimo
% waypoint con el siguiente.


%% ENTRADA

disparo_reinicio = entrada(1);
p_reinicio       = entrada(2:4);
p_ned            = entrada(5:7);
tramo            = entrada(8);
waypoints_ned    = entrada(9:end);


%% CALCULO

k             = 3*tramo;
waypoints_num = size(waypoints_ned,1)/3;

if disparo_reinicio==1 || tramo==0

    tramo = 0;
    r1    = p_reinicio;
    r2    = waypoints_ned(1:3); 

elseif disparo_reinicio==2

    r1 = p_reinicio;
    r2 = waypoints_ned(k-2:k);
    r3 = waypoints_ned(k+1:k+3);

else

    if k==3

        r1 = p_reinicio;
        r2 = waypoints_ned(k-2:k);
        r3 = waypoints_ned(k+1:k+3);

    else

        r1 = waypoints_ned(k-5:k-3);
        r2 = waypoints_ned(k-2:k);

        if tramo<waypoints_num

            r3 = waypoints_ned(k+1:k+3);

        end

    end

end

q1  = (r2-r1)/norm(r2-r1);

if tramo<waypoints_num
    
    if tramo==0
        
        q2 = q1;
        
    else
        
        q2 = (r3-r2)/norm(r3-r2);

    end

    n  = (q1+q2)/norm(q1+q2);
    
    if (p_ned-r2).'*n>=0
        
        tramo  = tramo+1;
        q1 = q2;  

    end
    
end


%% SALIDA

salida = [r1;q1;tramo];