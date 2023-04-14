function x_dot = sis_lineare(t,x,m,l)
    g = 9.81;
    x_dot = zeros(4,1);
    theta1 = x(1);
    theta2 = x(2);
    omega_1 = x(3);
    omega_2 = x(4);

    x_dot(1) = omega_1;

    x_dot(2) = omega_2;
    %Il sistema va disacoppiato.
    x_dot(3) = ;
    
    x_dot(4) = ;

end