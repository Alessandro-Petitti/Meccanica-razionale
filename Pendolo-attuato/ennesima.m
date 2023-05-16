function dxdt = ennesima(m1,m2,l1,l2,kp,kd,a1_des,a2_des,Y,t)
g = 9.81;


dxdt= [Y(2); -(l2^2*m2*(kp*(a1_des-Y(3))-kd*(Y(4))) - l1^2*m2*(kp*(a2_des-Y(1))-kd*(Y(2))) - l1^2*m1*(kp*(a2_des-Y(1))-kd*(Y(2))) - l2^2*m2*(kp*(a2_des-Y(1))-kd*(Y(2))) + l1*l2*m2*(kp*(a1_des-Y(3))-kd*(Y(4)))*cos(Y(1)) - 2*l1*l2*m2*(kp*(a2_des-Y(1))-kd*(Y(2)))*cos(Y(1)) + l1*l2^3*m2^2*sin(Y(1))*Y(2)^2 + l1*l2^3*m2^2*sin(Y(1))*Y(4)^2 + l1^3*l2*m2^2*sin(Y(1))*Y(4)^2 - g*l1*l2^2*m2^2*cos(Y(3)) + g*l1^2*l2*m2^2*cos(Y(1) + Y(3)) - g*l1^2*l2*m2^2*cos(Y(1))*cos(Y(3)) + g*l1^2*l2*m1*m2*cos(Y(1) + Y(3)) + g*l1*l2^2*m2^2*cos(Y(1))*cos(Y(1) + Y(3)) + l1^2*l2^2*m2^2*cos(Y(1))*sin(Y(1))*Y(2)^2 + 2*l1^2*l2^2*m2^2*cos(Y(1))*sin(Y(1))*Y(4)^2 + l1^3*l2*m1*m2*sin(Y(1))*Y(4)^2 - g*l1*l2^2*m1*m2*cos(Y(3)) + 2*l1*l2^3*m2^2*sin(Y(1))*Y(2)*Y(4) - g*l1^2*l2*m1*m2*cos(Y(1))*cos(Y(3)) + 2*l1^2*l2^2*m2^2*cos(Y(1))*sin(Y(1))*Y(2)*Y(4))/(l2^2*m2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(1))^2)); Y(4); (l2*(kp*(a1_des-Y(3))-kd*(Y(4))) - l2*(kp*(a2_des-Y(1))-kd*(Y(2))) - l1*(kp*(a2_des-Y(1))-kd*(Y(2)))*cos(Y(1)) - g*l1*l2*m1*cos(Y(3)) - g*l1*l2*m2*cos(Y(3)) + l1*l2^2*m2*sin(Y(1))*Y(2)^2 + l1*l2^2*m2*sin(Y(1))*Y(4)^2 + g*l1*l2*m2*cos(Y(1))*cos(Y(1) + Y(3)) + l1^2*l2*m2*cos(Y(1))*sin(Y(1))*Y(4)^2 + 2*l1*l2^2*m2*sin(Y(1))*Y(2)*Y(4))/(l2*(l1^2*m1 + l1^2*m2 - l1^2*m2*cos(Y(1))^2))];

end