clear;
clearvars;
m1 = 4;
m2 = 2;
l1 = 6;
l2 = 4;
g = 9.81;
tf = 40;
tspan = 0:1e-3:tf;
opts = odeset('reltol',1.e-6);
%theta1 theta2 omega1 omega2
x0_1 = [pi/2,pi/4,0,0];% circa 6 gradi
x0_2 = [pi/2,pi/4+0.01,0,0];% circa 6.2 gradi

%punti critici
centro = [0,0];

[t,x_non_lin_1] = ode45(@(t,x)sis_non_lineare(x,t,m1,m2,l1,l2),tspan,x0_1,opts);
[t,x_non_lin_2] = ode45(@(t,x)sis_non_lineare(x,t,m1,m2,l1,l2),tspan,x0_2,opts);
xm11 = l1*sin(x_non_lin_1(:,3));
ym11 = -l1*cos(x_non_lin_1(:,3));
xm21 = xm11 + l2.*sin(x_non_lin_1(:,4));
ym21 = ym11 - l2.*cos(x_non_lin_1(:,4));

xm12 = l1*sin(x_non_lin_2(:,3));
ym12 = -l1*cos(x_non_lin_2(:,3));
xm22 = xm12 + l2.*sin(x_non_lin_2(:,4));
ym22 = ym12- l2.*cos(x_non_lin_2(:,4));


ymin = min(min(x_non_lin_1(:,3),x_non_lin_2(:,3)));
ymax = max(max(x_non_lin_1(:,3),x_non_lin_2(:,3)));

figure('units','pixels','position',[0 0 1920 1080])


writerObj = VideoWriter('Double_Pendolum.avi'); % Name it.
writerObj.FrameRate = 40; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);

subplot(2,2,[1;3])
plot(centro(1),centro(2),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');

for i =1:50:length(tspan)
     pause(0.001)
     subplot(2,2,[1;3])
     
     plot(xm21(1:i,1),ym21(1:i,1),'b-','LineWidth',2);
     hold on;
    
    
     plot(xm22(1:i,1),ym22(1:i,1),'r-','LineWidth',2);
     plot(centro(1),centro(2),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
     plot(xm21(i,1),ym21(i,1),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
     plot(xm22(i,1),ym22(i,1),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
     hold off;
    
    xlim([-20 20]); 
    ylim([-50 50]);
    grid on; 
    box on; 
    grid minor;
    xticklabels({});
    yticklabels({});
    title ('Piano Cartesiano','Interpreter','latex'); 
    xlabel('$x$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    view(180*8000/length(tspan),30);
    
    subplot(2,2,2)
    plot(t(1:i),x_non_lin_1(1:i,4),'b-','LineWidth',1.5);
    hold on;
    plot(t(1:i),x_non_lin_2(1:i,4),'r-','LineWidth',1.5);
    hold off
    if t(i)+2 <30;xlim([0 30]); 
     else;xlim([t(i)-30 t(i)+2]); 
    end
    ylim([ymin-5 ymax+5]);
    title ('Solution: $\theta2_a$ (Blu), $\theta2_b$ (Rosso)','Interpreter','latex');
    ylabel('$\theta_2(t)$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',2);

    subplot(2,2,4)
    plot(t(1:i),abs(x_non_lin_1(1:i,4)-x_non_lin_2(1:i,4)),'k');
    if t(i)+2<30;xlim([0 30]); else;xlim([t(i)-30  t(i)+2]); end
    xlabel('$t$','Interpreter','latex','FontSize',26,'FontWeight','bold'); ylabel('$|\theta2_b- \theta2_a|$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',2); 
    if abs(x_non_lin_1(1:i,4)-x_non_lin_2(1:i,4))<1
    title ('Differenza trascurabile','Interpreter','latex');
    elseif abs(x_non_lin_1(1:i,4)-x_non_lin_2(1:i,4))<3
    title ('Differenza visibile','Interpreter','latex');
    else
    title ('Differenza evidente','Interpreter','latex');
    end
        if i ==length(tspan)
        subplot(2,2,[1;3])
        axis off
        grid off
    for i=1:1000
        view(360*i/1000,30);
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end
    else
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end




    
end
close(writerObj)