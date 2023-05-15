function x_dot = sistema(Y,t,m1,m2,l1,l2,tau1,tau2)
    
    g = 9.81;
    x_dot = zeros(4,1);
    %va abbassato il grado
    xdot =[Y(2); (l2*tau1 - l2*tau2 - l1*tau2*cos(Y(3)) - g*l1*l2*m1*cos(Y(1)) - g*l1*l2*m2*cos(Y(1)) + l1*l2^2*m2*sin(Y(3))*Y(2)^2 + l1*l2^2*m2*sin(Y(3))*Y(4)^2 + g*l1*l2*m2*cos(Y(3))*cos(Y(1) + Y(3)) + l1^2*l2*m2*cos(Y(3))*sin(Y(3))*Y(2)^2 + 2*l1*l2^2*m2*sin(Y(3))*Y(2)*Y(4))/(l2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(3))^2)); Y(4); -(l2^2*m2*tau1 - l1^2*m2*tau2 - l1^2*m1*tau2 - l2^2*m2*tau2 + l1*l2*m2*tau1*cos(Y(3)) - 2*l1*l2*m2*tau2*cos(Y(3)) + l1*l2^3*m2^2*sin(Y(3))*Y(2)^2 + l1^3*l2*m2^2*sin(Y(3))*Y(2)^2 + l1*l2^3*m2^2*sin(Y(3))*Y(4)^2 - g*l1*l2^2*m2^2*cos(Y(1)) + g*l1^2*l2*m2^2*cos(Y(1) + Y(3)) - g*l1^2*l2*m2^2*cos(Y(1))*cos(Y(3)) + g*l1^2*l2*m1*m2*cos(Y(1) + Y(3)) + g*l1*l2^2*m2^2*cos(Y(3))*cos(Y(1) + Y(3)) + 2*l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(2)^2 + l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(4)^2 + l1^3*l2*m1*m2*sin(Y(3))*Y(2)^2 - g*l1*l2^2*m1*m2*cos(Y(1)) + 2*l1*l2^3*m2^2*sin(Y(3))*Y(2)*Y(4) - g*l1^2*l2*m1*m2*cos(Y(1))*cos(Y(3)) + 2*l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(2)*Y(4))/(l2^2*m2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(3))^2))];
    
end

