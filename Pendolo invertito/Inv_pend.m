function x_dot = Inv_pend(x,t,m,M,l,F)

    %definiamo la costante g
    g = 9.81;
    x_dot = zeros(4,1);
    theta= x(1);theta_p = x(2); pos = x(3); pos_p= x(4);
    %theta_p = psi; pos_p = xi
    x_dot(1) = theta_p;
    x_dot(2) = (F*cos(theta)+g*(M+m)*sin(theta)-m*l*theta_p*sin(theta)*cos(theta))/l*(M+m-m*cos(theta));
    x_dot(3) = pos_p;
    x_dot(4) = (F+m*g*cos(theta)*sin(theta)-m*l*pos^2*sin(theta))/(M+m-m*cos(theta)*cos(theta));

end