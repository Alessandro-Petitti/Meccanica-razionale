clear
clc
close all
n = 1:0.01:4;
xi = [0 0.1 0.25 0.4 0.55 0.7 0.85 1 1.15 1.3];
syms x;
figure;
legenda = cell(1, length(xi));
for i = 1:length(xi)
    h = 1/(sqrt((1-x^2)^2 + (2*x*xi(i))^2));
    fplot(h,[0 4], LineWidth=2);
    hold on;
    legenda{i} = ['$\zeta=$ ' num2str(xi(i))];
end
legend(legenda,'Interpreter','latex','FontSize',20);
set(gca,'TickLabelInterpreter', 'latex','fontsize',25);
title('Coefficienta di amplificazione dinamica', 'Interpreter','latex','FontSize',22);
xlabel('$n$','Interpreter','latex','FontSize',30);
ylabel('$H(\Omega)$','Interpreter','latex','FontSize',30);
%% Studio del sistema
zeta = 0;
omega_n = .1; 
Omega = .4;
F = 1;
% periodo naturale
T_n = 2*pi/omega_n;
NT = 9;
% intervallo di tempo
DT = [0,NT*T_n];%integro per un tempo che è NT volte il periodo
%%Condizioni iniziali
x0 = 0;
xp0 = 1;
%%Risolutore 
sol = ode45(@(t,y) Sistema(t,y,zeta,omega_n,F,Omega),DT,[x0,xp0]);
t = sol.x;
x = sol.y(1,:);
v = sol.y(2,:);
tplot = linspace(0,NT*T_n,1000);
FinerSol = deval(sol,tplot);
xplot = FinerSol(1,:);
vplot = FinerSol(2,:);
%figure('units','normalized','outerposition',[0 0 1 1])
plot(tplot,vplot, 'linewidth',1.5)
 

%% Equazione differenziale 
function dydt = Sistema(t,y,zeta,omega_n,F,Omega)
    dydt = [y(2)
            F*sin(Omega*t)-2*zeta*omega_n*y(2)-omega_n^2*y(1)];
    %Si suppone una forza oscillatoria vec(F) = Fsin(omega*t)
end


