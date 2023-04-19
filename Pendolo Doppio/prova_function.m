function prova_function(x,t,m1,m2,l1,l2)
m1 = 4;
m2 = m1;
l1 = 6;
l2 = l1;
g = 9.81;
const = sqrt(l1/g);
risoluzione = 1;
tf = 600*const; %modificare questo per cambiare la "risoluzione" del grafico.
dt = (0:risoluzione:tf);
risultati = zeros(129600,4);
%theta1 theta2 omega1 omega2
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
cont = 1;
appoggio = 0;
tic;
    for j = -pi:0.0174533:pi
        tic
        for k = -pi:0.0174533:pi
            x0 = [j,k,0,0];
            [t,x] = ode45(@(t,x)sis_non_lineare(x,t,m1,m2,l1,l2),dt,x0,opts);
            for i = 1:risoluzione:size(t)
                if (x(i,2) >= k+2*pi | x(i,2)<= k-2*pi)
                    %risultati(cont,4) = cont;
                    risultati(cont,1) = j;
                    risultati(cont,2) = k;
                    risultati(cont,3) = i;
                    appoggio  = 1;
                    break
                end
            end
                if (appoggio == 0)

                  %  risultati(cont,4) = cont;
                    risultati(cont,1) = j;
                    risultati(cont,2) = k;
                    risultati(cont,3) = 0;
                end
             cont = cont+1;
             appoggio = 0;
        end
        toc
    end
    figura = figure;
    set(gcf,'PaperUnits','centimeters');
    set(gcf,'Position',[100,100,420,580]);

    scatter3(risultati(:,1),risultati(:,2),risultati(:,3), [],risultati(:,3),'filled'); 
    colorbar;
    colormap("turbo");
    view([360 90]);
    %save('matrice_risultati_function_mappa',"risultati");%Modifica il nome per non sovrascriverla
    %exportgraphics(figura,"grafico_mappa.eps",'Resolution',300);
    toc;
end
