clear;
clearvars;
m1 = 4;
m2 = 8;%kg
a = 3; %m
g = 9.81;
dt = (0:1e-3:60);
x0_w_var =[pi/6, 0, 0, pi/4];
opts = odeset('reltol',1.e-6);

[t,x] = ode45(@(t,x)sistema_w_variabile(m1, m2, a, x, t),dt,x0_w_var,opts);

ymin = min(min(x(:,1),x(:,3)));
ymax = max(max(x(:,1),x(:,3)));


x_m1d = a*sin(x(:,1)).*cos(x(:,2));
y_m1d = a*sin(x(:,1)).*sin(x(:,2));
z_m1d = -a*cos(x(:,1));

x_m1s = x_m1d;
y_m1s = -y_m1d;
z_m1s = z_m1d;

x_m2 = zeros(size(x(:,1)));
y_m2 = zeros(size(x(:,1)));
z_m2 = -2*a*cos(x(:,1));

figure('units','pixels','position',[0 0 1920 1080])


writerObj = VideoWriter('governator.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);
subplot(2,2,[1;3]);

plot3(0,0,0,'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
hold on;
for i =1:50:length(dt)
     pause(0.001)

     subplot(2,2,[1;3]);
     %traiettoria
     plot3(x_m1d(1:i),y_m1d(1:i),z_m1d(1:i),'b-','LineWidth',2);
     hold on;
     plot3(x_m1s(1:i),y_m1s(1:i),z_m1s(1:i),'r-','LineWidth',2);
     plot3(x_m2(1:i),y_m2(1:i),z_m2(1:i),'c-','LineWidth',2);
     %punti critici
     plot3(0,0,0,'.','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black','MarkerSize',15);
     %teste del cammino 
     plot3(x_m1d(i),y_m1d(i),z_m1d(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',15);
     plot3(x_m1s(i),y_m1s(i),z_m1s(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',15);
     plot3(x_m2(i),y_m2(i),z_m2(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',30);
     %aste
     plot3([0; x_m1d(i)], [0;y_m1d(i)],[0;z_m1d(i)],'color','k','LineWidth',2);
     plot3([0; x_m1s(i)], [0;y_m1s(i)],[0;z_m1s(i)], 'color','k','LineWidth',2);
     plot3([x_m1d(i); x_m2(i)], [y_m1d(i); y_m2(i)],[z_m1d(i); z_m2(i)], 'color','k','LineWidth',2);
     plot3([x_m1s(i); x_m2(i)], [y_m1s(i); y_m2(i)],[z_m1s(i); z_m2(i)], 'color','k','LineWidth',2);

     hold off;
    xlim([-2 2]); 
    ylim([-2 2]);
    zlim([-6 1.5]);
    grid on; 
    box on; 
    grid minor;

    title ('Traiettoria','Interpreter','latex'); 
    xlabel('$x$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    zlabel('$z$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    view(180*8000/length(dt),30);

    subplot(2,2,2);
    plot(t(1:i),x(1:i,1),'Color','[0.4940 0.1840 0.5560]','LineWidth',2.5);
    xlabel("t", 'Interpreter','latex');
    ylabel("$\theta$",'Interpreter','latex');
    set(gca,'TickLabelInterpreter', 'latex','fontsize',26);
    grid on;
    if t(i)+2 <30;xlim([0 30]); else;xlim([t(i)-30 t(i)+2]); end
    ylim([ymin-2 ymax+2]);

    subplot(2,2,4);
    plot(t(1:i),x(1:i,2),'Color','[0.4940 0.1840 0.5560]','LineWidth',2.5);
    xlabel("t", 'Interpreter','latex');
    ylabel("$\varphi$",'Interpreter','latex');
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
    for i=1:500
        view(360*i/500,30);
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


