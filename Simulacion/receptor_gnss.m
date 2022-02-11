% Script a ejecutar en una segunda instancia de Matlab. Su objetivo es
% representar la localizacion del UAV y de la ruta sobre un mapa. Para ello
% recibe datos de la instancia principal, la cual debera ejecutar el
% simulador.
%
% NOTA: para reiniciar el script, presionar CTRL+C y luego ejecutar en la
% ventana de comandos "delete(GNSS)".

plan_de_vuelo;
         
waypoints_num = size(waypoints_mat,1);

waypoint_icono = fullfile(pwd,'waypoint.ico');
wmmarker(waypoints_mat(1,1),waypoints_mat(1,2),'Icon',waypoint_icono,...
'FeatureName',sprintf('Waypoint %d',1),'Description',...
sprintf('%d metros',waypoints_mat(1,3)),'Autofit',true);

for k=2:waypoints_num
    
    waypoint_icono = fullfile(pwd,'waypoint.ico');
    wmmarker(waypoints_mat(k,1),waypoints_mat(k,2),'Icon',...
    waypoint_icono,'FeatureName',sprintf('Waypoint %d',k),...
    'Description',sprintf('%d metros',waypoints_mat(k,3)),'Autofit',true);

    wmline([waypoints_mat(k-1,1) waypoints_mat(k,1)],...
    [waypoints_mat(k-1,2) waypoints_mat(k,2)],'Color','green',...
    'FeatureName',sprintf('Segmento %d',k-1),'Description',...
    sprintf('Waypoint %d a %d ',k-1,k),'Autofit',true);
    
end

GNSS       = udp('localhost', 'RemotePort', 3334, 'LocalPort', 3333);
fopen(GNSS);
GNSS.ReadAsyncMode = 'continuous';

datos = [];

while 1
    
    if GNSS.BytesAvailable>0
        
    datos = [datos; fread(GNSS,[4 1],'double').'];
    
    latitud  = datos(end,1);
    longitud = datos(end,2);
    psi      = datos(end,3);
    tiempo   = datos(end,4);

    if size(datos,1)>1
        
        wmremove;    
        
    end
    
    if psi>174.125 && psi<=354.125
        
      if psi>264.125
            
        if psi>309.125
               
          if psi>331.625
              
            if psi>342.875

              uav_icono = fullfile(pwd,'uav_348_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;

            else 
                
              uav_icono = fullfile(pwd,'uav_337_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
                
            end
                
          else
               
            if psi>320.375

              uav_icono = fullfile(pwd,'uav_326_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
            else
                
              uav_icono = fullfile(pwd,'uav_315.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
            
            end
               
          end
            
        else
           
          if psi>286.625
                
            if psi>297.875

              uav_icono = fullfile(pwd,'uav_303_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue; 
            
            else

              uav_icono = fullfile(pwd,'uav_292_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
            
            end

          else

            if psi>275.375

              uav_icono = fullfile(pwd,'uav_281_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;

            else
                
              uav_icono = fullfile(pwd,'uav_270.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
                
            end
                
          end
            
        end
        
      else
          
        if psi>219.125
            
          if psi>241.625
            
            if psi>252.875
             
              uav_icono = fullfile(pwd,'uav_258_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_247_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
            
            if psi>230.375
             
              uav_icono = fullfile(pwd,'uav_236_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_225.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          end
          
        else
            
          if psi>196.625
              
            if psi>207.875
                    
              uav_icono = fullfile(pwd,'uav_213_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_202_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
              
            if psi>185.375
                    
              uav_icono = fullfile(pwd,'uav_191_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_180.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end  
            
          end
          
        end
        
      end
      
    else
        
      if psi>84.125
          
        if psi>129.125
            
          if psi>151.625
                
            if psi>354.125
                 
              uav_icono = fullfile(pwd,'uav_0.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            elseif psi>162.875
                
              uav_icono = fullfile(pwd,'uav_168_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_157_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
              
            if psi>140.375
                
              uav_icono = fullfile(pwd,'uav_146_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_135.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          end
          
        else
            
          if psi>106.625
              
            if psi>117.875
                
              uav_icono = fullfile(pwd,'uav_123_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_112_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
              
            if psi>95.375
                
              uav_icono = fullfile(pwd,'uav_101_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_90.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          end
          
        end
        
      else
          
        if psi>39.125
         
          if psi>61.625
              
            if psi>72.875
                
              uav_icono = fullfile(pwd,'uav_78_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_67_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
              
            if psi>50.375
                
              uav_icono = fullfile(pwd,'uav_56_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_45.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          end
          
        else
            
          if psi>16.625
              
            if psi>27.875
                
              uav_icono = fullfile(pwd,'uav_33_75.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_22_5.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          else
              
            if psi>5.375
                
              uav_icono = fullfile(pwd,'uav_11_25.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            else
                
              uav_icono = fullfile(pwd,'uav_0.ico');
              wmmarker(latitud,longitud,'Icon',uav_icono,'Autofit',true);
              continue;
              
            end
            
          end
          
        end
        
      end
      
    end
    
    end
    
end