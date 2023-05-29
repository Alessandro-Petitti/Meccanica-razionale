clear;
clearvars;
m1 = 20;
m2 = 0.2;
l1 = 7;
l2 = 0.7;
g = 9.81;
kp=1000;
kd=1000;
a1_des = -pi/2;
a2_des= pi/2;

dt = (0:1e-3:18);

x0 =[pi/2,0,-pi/2,0];
%x0 = [pi/2,0,pi/2,0];
opts = odeset('reltol',1.e-6);

[t,x] = ode45(@(t,Y)ennesima(m1,m2,l1,l2,kp,kd,a1_des,a2_des,Y,t),dt,x0,opts);
%Calcolo delle traiettorie:
x_m1 = l1.*cos(x(:,3));
y_m1 = l1.*sin(x(:,3));
x_m2 = l1.*cos(x(:,3))+l2.*cos(x(:,3)+x(:,1));
y_m2 = l1.*sin(x(:,3))+l2.*sin(x(:,3)+x(:,1));

ymin = min(min(x(:,1),x(:,3)));
ymax = max(max(x(:,1),x(:,3)));



figure('units','pixels','position',[0 0 1920 1080])


writerObj = VideoWriter('dp_PD_config_1.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);
subplot(2,2,[1;3]);
appoggio = zeros (size(x_m1));

plot3(0,0,0,'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
hold on;
for i =1:50:length(dt)
     pause(0.001)

     subplot(2,2,[1;3]);
     %traiettoria
     plot3(x_m1(1:i),appoggio(1:i),y_m1(1:i),'b-','LineWidth',2);
     hold on;
     plot3(x_m2(1:i),appoggio(1:i),y_m1(1:i),'r-','LineWidth',2);
     %punti critici
     plot3(0,0,0,'.','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black','MarkerSize',15);
     %teste del cammino 
     plot3(x_m1(i),appoggio(i),y_m1(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',15);
     plot3(x_m2(i),appoggio(i),y_m2(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',15);
     %aste
     plot3([0; x_m1(i)], [0;appoggio(i)],[0;y_m1(i)],'color','k','LineWidth',2);
     plot3([x_m1(i); x_m2(i)], [appoggio(i);appoggio(i)],[y_m1(i); y_m2(i)], 'color','k','LineWidth',2);
     hold off;
    grid on; 
    box on; 
    grid minor;
    axis ([-2 1.3 -1 1 -8 2]);

    title ('Traiettoria','Interpreter','latex'); 
    xlabel('$x$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    zlabel('$z$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    view(180*8000/length(dt),30);

    subplot(2,2,2);
    plot(t(1:i),(kp*(a1_des-x(1:i,3))-kd*(x(1:i,4))),'Color','[0.4940 0.1840 0.5560]','LineWidth',2.5);
    xlabel("t", 'Interpreter','latex');
    ylabel("$\tau_1$",'Interpreter','latex');
    set(gca,'TickLabelInterpreter', 'latex','fontsize',26);
    grid on;
    if t(i)+2 <30;xlim([0 30]); else;xlim([t(i)-30 t(i)+2]); end
    ylim([ymin-2 ymax+2]);

    subplot(2,2,4);
    plot(t(1:i),(kp*(a2_des-x(1:i,1))-kd*(x(1:i,2))),'Color','[0.4940 0.1840 0.5560]','LineWidth',2.5);
    xlabel("t", 'Interpreter','latex');
    ylabel("$\tau_2$",'Interpreter','latex');
    set(gca,'TickLabelInterpreter', 'latex','fontsize',26);
    grid on;
    if t(i)+2<30; xlim([0 30]); else;xlim([t(i)-30 t(i)+2]); end
    if x(i,2)+1<4; ylim([-4 4]);else;ylim([x(i,2)-15 x(i,2)+15]);end




if i ==length(dt)
        subplot(2,2,[1;3])
        axis off
        grid off
        subplot(2,2,4);
        ylim([min(x(:,2)) max(x(:,2))+2']);
        xlim([0 65]);
        subplot(2,2,2);
        xlim([0 65]);
        subplot(2,2,[1;3])
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    else
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end


end

close(writerObj)


