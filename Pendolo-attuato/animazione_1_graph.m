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
tau1 = 0;
tau2 =  0.500;

dt = (0:1e-3:10);

%x0 =[pi/2,0,-pi/2,0];
x0 = [pi/2,0,pi/2,0];
opts = odeset('reltol',1.e-6);

[t,x] = ode45(@(t,Y)manipolatore(t,Y,l1,m1,l2,m2,tau1,tau2),dt,x0,opts);
%Calcolo delle traiettorie:
x_m1 = l1.*cos(x(:,3));
y_m1 = l1.*sin(x(:,3));
x_m2 = l1.*cos(x(:,3))+l2.*cos(x(:,3)+x(:,1));
y_m2 = l1.*sin(x(:,3))+l2.*sin(x(:,3)+x(:,1));

figure('units','pixels','position',[0 0 1920 1080])

writerObj = VideoWriter('manipolatore_config_2_tau_const.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);

plot(0,0,'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
hold on;
for i =1:50:length(dt)
     pause(0.001)

     
     %traiettoria
     plot(x_m1(1:i),y_m1(1:i),'b-','LineWidth',2);
     hold on;
     plot(x_m2(1:i),y_m2(1:i),'c-','LineWidth',2);
     %punti critici
     plot(0,0,'.','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black','MarkerSize',15);
     %teste del cammino 
     % plot(x_m1(i),y_m1(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',35);
     % plot(x_m2(i),y_m2(i),'ko','MarkerFaceColor','magenta','MarkerEdgeColor','black','MarkerSize',15);
     %aste
     plot([0; x_m1(i)],[0;y_m1(i)],'color','r','LineWidth',4);
     plot([x_m1(i); x_m2(i)], [y_m1(i); y_m2(i)], 'color','k','LineWidth',2);
     hold off;
     grid on; 
     box on; 
     grid minor;
     axis ([0 4  -8 8]);
     axis equal;

    title ('Traiettoria con $\tau_1 = 0$ e $\tau_2 = 0.5$ ','Interpreter','latex'); 
    xlabel('$x$','Interpreter','latex','FontSize',26);
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
 


end

close(writerObj)


