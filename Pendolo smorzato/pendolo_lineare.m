function x_punto = pendolo_lineare(t,x,m,l)
%In questa function definiamo il vettore x_punto
g = 9.81;
x_punto = [x(2); -g/l*x(1)]; %x(2) = omega x(1) = theta
end
