clear; clc; close
global sigma rho beta


rho = 28;
sigma = 10;
beta = 8/3;


tf = 60;


eta = sqrt(beta*(rho-1));


% critical points   
yc1 = [0;0;0];
yc2 = [eta;eta;rho-1];
yc3 = [-eta;-eta;rho-1];


% initial conditions 
y01 = [0; 1; 0];
y02 = [0; 1.001; 0];


% Integrate forever, or until the stop button is toggled.
   
tspan = 0:1e-3:tf;
opts = odeset('reltol',1.e-6);
[t,X1]=ode45(@lorenz, tspan, y01, opts);
[t,X2]=ode45(@lorenz, tspan, y02, opts);


ymin = min(min(X2(:,1),X1(:,1)));
ymax = max(max(X2(:,1),X1(:,1)));


figure('units','pixels','position',[0 0 1920 1080])


writerObj = VideoWriter('Lorenz.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);
subplot(2,2,[1;3])


plot3(yc1(1),yc1(2),yc1(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
hold on;
plot3(yc2(1),yc2(2),yc2(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
plot3(yc3(1),yc3(2),yc3(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');


for i =1:50:length(tspan)
     pause(0.001)

    subplot(2,2,[1;3])
    
    plot3(X1(1:i,1),X1(1:i,2),X1(1:i,3),'b-','LineWidth',2);
    hold on;
    plot3(X2(1:i,1),X2(1:i,2),X2(1:i,3),'r-','LineWidth',2)
    plot3(yc1(1),yc1(2),yc1(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
    plot3(yc2(1),yc2(2),yc2(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
    plot3(yc3(1),yc3(2),yc3(3),'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
    plot3(X1(i,1),X1(i,2),X1(i,3),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
    plot3(X2(i,1),X2(i,2),X2(i,3),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
    hold off;
    xlim([-20 20]); 
    ylim([-50 50]);
    zlim([0 50]);
    grid on; 
    box on; 
    grid minor;
    xticklabels({});
    yticklabels({});
    zticklabels({});
    title ('Phase Space: Trajectories','Interpreter','latex'); 
    xlabel('$x$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    zlabel('$z$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    view(180*8000/length(tspan),30);
    
    
    subplot(2,2,2)
    
    plot(t(1:i),X1(1:i,1),'b-','LineWidth',1.5);hold on;plot(t(1:i),X2(1:i,1),'r-','LineWidth',1.5);
    plot(t(1:100:length(t)),yc1(1)*ones((length(t)-1)/100 +1),'g--',t(1:100:length(t)),yc2(1)*ones((length(t)-1)/100 +1),'g--',t(1:100:length(t)),yc3(1)*ones((length(t)-1)/100 +1),'g--')
    plot(t(i),X1(i,1),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
    plot(t(i),X2(i,1),'ko','MarkerFaceColor','black','MarkerEdgeColor','black')
    hold off
    if t(i)+2 <30;xlim([0 30]); else;xlim([t(i)-30 t(i)+2]); end
    ylim([ymin-5 ymax+5]);
    title ('Solution: $x_1$ (Blue), $x_2$ (Red)','Interpreter','latex');
    ylabel('$x(t)$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',2);
    
    
    subplot(2,2,4)
    
    plot(t(1:i),abs(X1(1:i,1)-X2(1:i,1)),'k');
    if t(i)+2<30;xlim([0 30]); else;xlim([t(i)-30  t(i)+2]); end
    xlabel('$t$','Interpreter','latex','FontSize',26,'FontWeight','bold'); ylabel('$|x_2 -x_1|$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',2); 
    if t(i)<20
    title ('Negligible difference','Interpreter','latex');
    elseif t(i)<25
    title ('Noticeable difference','Interpreter','latex');
    else
    title ('Obvious difference','Interpreter','latex');
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
%% Functions 


function ydot = lorenz(t,y)
global sigma rho beta
%LORENZ  Equation of the Lorenz chaotic attractor.
%   ydot = lorenz(t,y).


ydot(1) = sigma *(y(2) -y(1));
ydot(2) = y(1)*(rho -y(3)) -y(2);
ydot(3) = y(1)*y(2) -beta*y(3);


ydot =[ydot(1);ydot(2);ydot(3)];
end

