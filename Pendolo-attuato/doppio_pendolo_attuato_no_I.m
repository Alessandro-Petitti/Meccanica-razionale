function xdot = doppio_pendolo_attuato_no_I(m1,m2,l1,l2,t1,t2,t,Y)
g = 9.81;
xdot = [Y(2); 
    (l2*t1 - l2*t2 - l1*t2*cos(Y(3)) - g*l1*l2*m1*cos(Y(1)) - g*l1*l2*m2*cos(Y(1)) + l1*l2^2*m2*sin(Y(3))*Y(2)^2 + l1*l2^2*m2*sin(Y(3))*Y(4)^2 + g*l1*l2*m2*cos(Y(3))*cos(Y(1) + Y(3)) + l1^2*l2*m2*cos(Y(3))*sin(Y(3))*Y(2)^2 + 2*l1*l2^2*m2*sin(Y(3))*Y(2)*Y(4))/(l2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(3))^2));
    Y(4);
    -(l2^2*m2*t1 - l1^2*m2*t2 - l1^2*m1*t2 - l2^2*m2*t2 + l1*l2*m2*t1*cos(Y(3)) - 2*l1*l2*m2*t2*cos(Y(3)) + l1*l2^3*m2^2*sin(Y(3))*Y(2)^2 + l1^3*l2*m2^2*sin(Y(3))*Y(2)^2 + l1*l2^3*m2^2*sin(Y(3))*Y(4)^2 - g*l1*l2^2*m2^2*cos(Y(1)) + g*l1^2*l2*m2^2*cos(Y(1) + Y(3)) - g*l1^2*l2*m2^2*cos(Y(1))*cos(Y(3)) + g*l1^2*l2*m1*m2*cos(Y(1) + Y(3)) + g*l1*l2^2*m2^2*cos(Y(3))*cos(Y(1) + Y(3)) + 2*l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(2)^2 + l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(4)^2 + l1^3*l2*m1*m2*sin(Y(3))*Y(2)^2 - g*l1*l2^2*m1*m2*cos(Y(1)) + 2*l1*l2^3*m2^2*sin(Y(3))*Y(2)*Y(4) - g*l1^2*l2*m1*m2*cos(Y(1))*cos(Y(3)) + 2*l1^2*l2^2*m2^2*cos(Y(3))*sin(Y(3))*Y(2)*Y(4))/(l2^2*m2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(3))^2))];

end

