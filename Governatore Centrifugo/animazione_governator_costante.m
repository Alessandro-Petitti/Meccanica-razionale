clear;
clearvars;
w_value = [0.5, 3, 6, 9,15];
m1 = 4;
m2 = 8;
a = 3; 
dt = (0:1e-2:60);
x0 =[pi/6,0];
opts = odeset('reltol',1.e-6);

figure('units','pixels','position',[0 0 1920 1080])

writerObj = VideoWriter('governator_w_cost.avi'); 
writerObj.FrameRate = 20; 
writerObj.Quality = 100;
open(writerObj);


for j =1:length(w_value)
     pause(0.001)
     plot3(0,0,0,'o','MarkerFaceColor','[0, 0.5, 0]','MarkerEdgeColor','black');
     hold on;
    [x_m1d,y_m1d,z_m1d,x_m1s,y_m1s, z_m1s,x_m2,y_m2,z_m2,ymin,ymax] = calcolatrice(w_value(j));

    for i = 1:50:(length(dt))

     %traiettoria
     plot3(x_m1d(1:i),y_m1d(1:i),z_m1d(1:i),'b-','LineWidth',2);
     hold on;
     plot3(x_m1s(1:i),y_m1s(1:i),z_m1s(1:i),'b-','LineWidth',2);
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
    axis square;
    grid on; 
    box on; 
    %grid minor;
    tit =['$\omega_0$ = ', num2str(w_value(j))];

    title ('Traiettoria con ',tit,'Interpreter','latex','FontSize',100); 

    xlabel('$x$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    ylabel('$y$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    zlabel('$z$','Interpreter','latex','FontSize',26,'FontWeight','bold');
    set(gca,'FontSize',18,'LineWidth',1.5);
    view(180*8000/length(dt),30);
    %lgd = legend(strcat('w = ',num2str(w_value(j))),'Location','north',"FontSize",30);
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end
    if j == length(w_value)
        axis off
        grid off
    else
        drawnow;
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end
    


    
    clf;
end

close(writerObj)

%%
function [x_m1d,y_m1d,z_m1d,x_m1s,y_m1s, z_m1s,x_m2,y_m2,z_m2,ymin,ymax] = calcolatrice (w)
m1 = 4;
m2 = 8;%kg
a = 3; %m

dt = (0:1e-3:60);
x0 =[pi/6,0];
opts = odeset('reltol',1.e-6);
    [t,x] = ode45(@(t,x)sistema_w_cost(m1, m2, a, w, x, t),dt,x0,opts);
    x_m1d = a*sin(x(:,1)).*cos(x(:,2));
    y_m1d = a*sin(x(:,1)).*sin(x(:,2));
    z_m1d = -a*cos(x(:,1));
    

    x_m1s = x_m1d;
    y_m1s = -y_m1d;
    z_m1s = z_m1d;
    
    x_m2 = zeros(size(x(:,1)));
    y_m2 = zeros(size(x(:,1)));
    z_m2 = -2*a*cos(x(:,1));
    

    ymin = min(min(x(:,1),x(:,2)));
    ymax = max(max(x(:,1),x(:,2)));
end