function x_dot = sis_non_lineare(x,t,m1,m2,l1,l2)
    
    g = 9.81;
    x_dot = zeros(4,1);
    theta1 = x(1);
    theta2 = x(2);
    omega_1 = x(3);
    omega_2 = x(4);
    %va abbassato il grado

    x_dot(1) = omega_1;

    x_dot(2) = omega_2;

    x_dot(3) = (m2*g*sin(theta2)*cos(theta1-theta2)-l2*m2*(omega_2)^2*sin(theta1-theta2)-(m1+m2)*g*sin(theta1)-(m2*l1)/(2)*sin(2*theta1-2*theta2))...
    /(l1*(m1+m2-m2*(cos(theta1-theta2))^2));

    x_dot(4) = ((m2*l2)/(2)*(omega_2)^2*sin(2*theta1-2*theta2)+(m1+m2)*g*(sin(theta2)-sin(theta1)*cos(theta1-theta2))-(m1+m2)*l1*(omega_1)^2*sin(theta1-theta2))...
        /(l2*(m2*(cos(theta1-theta2))^2-m1-m2));
    
    
end
