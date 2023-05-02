function xdot = sistema_w_variabile (m1, m2, a, x, t)

g = 9.81;
xdot = zeros(4,1);
theta = x(1);
phi = x(2);  
theta_p = x(3);
phi_p= x(4);

xdot(1) = theta_p;%theta 

xdot(2) = phi_p;%phi

xdot(3) = ((m1*phi_p^2-2*m2*theta_p^2)*a*sin(theta)*cos(theta)-g*(m1+m2)*sin(theta))/(m1*a+2*m2*a*(sin(theta)^2));
%theta_p

xdot(4) = -(2*cos(theta)*theta_p*phi_p)/(sin(theta));%phi_p


end