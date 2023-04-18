function risultati = prova_function(x,t,m1,m2,l1,l2)
m1 = 4;
m2 = 2;
l1 = 6;
l2 = 4;
g = 9.81;
risoluzione = 1;
tf = 30 %modificare questo per cambiare la "risoluzione" del grafico.
dt = (0:risoluzione:tf);
risultati = zeros(129600,4);
%theta1 theta2 omega1 omega2
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
cont = 1;
appoggio = 0;
    for j = -pi:0.0174533:pi
        for k = -pi:0.0174533:pi
            x0 = [j,k,0,0];
            [t,x] = ode45(@(t,x)sis_non_lineare(x,t,m1,m2,l1,l2),dt,x0,opts);
            for i = 1:risoluzione:size(t)
                if (x(i,2) >= k+2*pi | x(i,2)<= k-2*pi)
                    risultati(cont,4) = cont;
                    risultati(cont,1) = j;
                    risultati(cont,2) = k;
                    risultati(cont,3) = i;
                    appoggio  = 1;
                    break
                end
            end
                if (appoggio == 0)

                    risultati(cont,4) = cont;
                    risultati(cont,1) = j;
                    risultati(cont,2) = k;
                    risultati(cont,3) = 0;
                end
             cont = cont+1;
             appoggio = 0;
         end
    
    end
    figure;
    scatter3(risultati(:,1),risultati(:,2),risultati(:,3), [],risultati(:,3),'filled'); 
    colorbar;
end




