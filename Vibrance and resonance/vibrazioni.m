% STUDIO DELLA RISONANZA
clear
clc
close all
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
xlabel('$n$','Interpreter','latex','FontSize',20);
ylabel('$H(\Omega)$','Interpreter','latex','FontSize',20);
%% Studio del sistema
zeta = 0.01;
omega_n = .6; 
Omega = .59;
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
figure;
plot(tplot,xplot, 'linewidth',1.5)
title('Spostamento', 'Interpreter','latex','FontSize',22);
xlabel('t [s]','Interpreter','latex','FontSize',20);
ylabel('$x\left(t\right)$ [m]','Interpreter','latex','FontSize',20);
 %% Studio del fattore di trasmissione delle forze
 syms n;
 figure;
 for i = 1:length(xi)
    tr = sqrt(1+(2*xi(i)*n)^2)/(sqrt((1-n^2)^2 + (2*n*xi(i))^2));
    fplot(tr,[0 4], LineWidth=1.4);
    hold on;
    legenda{i} = ['$\zeta=$ ' num2str(xi(i))];
 end
legend(legenda,'Interpreter','latex','FontSize',20);
set(gca,'TickLabelInterpreter', 'latex','fontsize',25);
title('Fattore di trasmissione delle forze', 'Interpreter','latex','FontSize',22);
xlabel('$n$','Interpreter','latex','FontSize',20);
ylabel('$(TR)_F$','Interpreter','latex','FontSize',20);

%% Animazione risonanza
syms l
%Prendiamo ora un sistema e animiamo la risonanza:
zeta = 0.01;
omega_n = .6; 
Omega = .59;
F = 1;
%%Condizioni iniziali
x0 = 0;
xp0 = 1;
T_n = 2*pi/omega_n;
NT = 9;
tf =100;
tspan =  0:1e-1:tf;
[t,x]= ode45(@(t,y) Sistema(t,y,zeta,omega_n,F,Omega),tspan,[x0,xp0]);
forza_eccitante = F.*sin(Omega.*t);
figure('units','pixels','position',[0 0 1920 1080])
writerObj = VideoWriter('Resonance.avi'); % Name it.
writerObj.FrameRate = 80; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);
xa = 0; ya = -60; xb = 0; yb = 0; ne = 40; a = 400; ro = 0.01;k=1;
g = 3;
for i =1:20:length(tspan)
    subplot(1,2,1)
    pause(0.001) 
    plot(t(1:i),x(1:i,1),'k', 'linewidth',2);
    hold on;
    plot(t(1:i),forza_eccitante(1:i),'r','LineWidth',1.5);
    if (g == 3)
        ylim([-15 15]);
        if(t(i)>20)
            g =1;
        end
    end
    if (t(i) > 20 && g == 1)
        ylim([-30 30]);
        if(t(i)>40)
             g = 0;
        end
    elseif (t(i) >40 && g == 0)
        ylim([-65 65]);
        g = 2;
    end
    if t(i)+2 <30;xlim([0 30]); else;xlim([t(i)-30 t(i)+2]); end
    grid on
    hold off;
    subplot(1,2,2);
    if i == 1
        [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro); 
        plot(xs,ys,'LineWidth',2);
    end
    if i>1
        yb = x(i,1)+60;
        [xs,ys]=spring(xa,ya,xb,yb); 
        plot(xs,ys,'LineWidth',2);
    end
    hold on;
    plot(0,x(i)+60,'ko','MarkerFaceColor','black','MarkerEdgeColor','black','MarkerSize',15);
    grid on;
    xlim ([-4 4]);
    ylim([0 120]);
    hold off;
    drawnow;
    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);
end
close(writerObj)
%% Equazione differenziale 
function dydt = Sistema(t,y,zeta,omega_n,F,Omega)
    dydt = [y(2)
            F*sin(Omega*t)-2*zeta*omega_n*y(2)-omega_n^2*y(1)];
    %Si suppone una forza oscillatoria vec(F) = Fsin(omega*t)
end


