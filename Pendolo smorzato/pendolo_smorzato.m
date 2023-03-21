function x_dot = pendolo_smorzato (m,l,b,x,t)
%definiamo la costante g
g = 9.81;

x_dot = [x(2);(-b/(m*l^2))*x(2)-(g/l)*sin(x(1))];
% x(2) = omega, x(1) = theta
end