% Script que calcula el punto de equilibrio del UAV.

close all, clear all

options           = optimset('TolFun',1e-16,'TolX',1e-16,'TolCon',1e-16,...
                    'MaxIter',Inf,'MaxFunEvals',Inf);
x0                = [15 0 1 0 0 0 0.01 0.1 0 0 0 1];
lb                = [0 0 0 0 0 0 -pi/2 -pi/2 0 944 1056 1100];
ub                = [30 0 2 0 0 0 pi/2 pi/2 0 2100 2100 2100];
estado_equilibrio = fsolve(@eom,x0,options);
salida_eom        = eom(estado_equilibrio)

U_equilibrio       = estado_equilibrio(1);
V_equilibrio       = estado_equilibrio(2);
W_equilibrio       = estado_equilibrio(3);
P_equilibrio       = estado_equilibrio(4);
Q_equilibrio       = estado_equilibrio(5);
R_equilibrio       = estado_equilibrio(6);
phi_equilibrio     = estado_equilibrio(7);
theta_equilibrio   = estado_equilibrio(8);
psi_equilibrio     = estado_equilibrio(9);
delta_a_equilibrio = estado_equilibrio(10);
delta_e_equilibrio = estado_equilibrio(11);
delta_t_equilibrio = estado_equilibrio(12);