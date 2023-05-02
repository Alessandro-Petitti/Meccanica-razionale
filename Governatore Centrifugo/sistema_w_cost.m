function xdot  = sistema_w_cost(m1, m2, a, w, x, t)
g = 9.81;
xdot = zeros(2,1);
theta = x(1);
theta_p = x(2);  

xdot(1) = theta_p;
xdot(2) = (-theta_p^2*(2*m2*a*sin(theta)*cos(theta))-sin(theta)*((m1+m2)*g-m1*a*w^2*cos(theta)))/(m1*a+2*m2*a*(sin(theta))^2);



end