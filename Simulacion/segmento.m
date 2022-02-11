function salida = segmento(entrada)
% Funcion que implementa el calculo de psi y altitud instantanea del
% sistema de gestion de vuelo.
%
% salida = segmento(entrada)
%
% Siendo:
%
% p_n   = entrada(1);
% p_e   = entrada(2);
% p_d   = entrada(3);
% r_n   = entrada(4);
% r_e   = entrada(5);
% r_d   = entrada(6);
% q_n   = entrada(7);
% q_e   = entrada(8);
% q_d   = entrada(9);
% psi   = entrada(10);
%
% psi_c = salida(1);
% h_c   = salida(2);


%% ENTRADA

p_n = entrada(1);
p_e = entrada(2);
p_d = entrada(3);
r_n = entrada(4);
r_e = entrada(5);
r_d = entrada(6);
q_n = entrada(7);
q_e = entrada(8);
q_d = entrada(9);
psi = entrada(10);


%% CALCULO

r = [r_n;r_e;r_d];
p = [p_n;p_e;p_d];

psi_inf = pi/4; % entre 0 y pi/2
k_ruta  = 1e-2; % suavidad del campo vectorial alrededor del segmento
psi_q = atan2(q_e,q_n); % rumbo de la senda

e_p = p-r;

n_aux = [0 -q_d q_e; q_d 0 -q_n; -q_e q_n 0]*[0;0;1];
n     = n_aux/norm(n_aux);

s       = e_p-(e_p.'*n)*n;
s_n     = s(1);
s_e     = s(2);

h_c = -r_d-sqrt(s_n^2+s_e^2)*(q_d/sqrt(q_n^2+q_e^2));

if (psi_q-psi)>pi
    
    psi_q = psi_q-2*pi;
    
elseif (psi_q-psi)<-pi
    
    psi_q = psi_q+2*pi;
    
end

e_py = -sin(psi_q)*(p_n-r_n)+cos(psi_q)*(p_e-r_e);

psi_c = psi_q-2*psi_inf*atan(k_ruta*e_py)/pi;


%% SALIDA

salida = [psi_c;h_c];