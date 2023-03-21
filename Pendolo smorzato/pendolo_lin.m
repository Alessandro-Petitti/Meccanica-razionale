function xdot = pendolo_lin (t,x,L)
    %Pendolo linearizzato, la t non viene usata, la massa non compare
    g = 9.81;
    L = 1;
    xdot = [x(2); -g/L*x(1)];
    %xdot_non_linear = [x(2); -(b/m*l^2)*x(2)-g/L*sin(x(1))];

    
    %xdot ha due componenti: [theta_dot; omega_dot] = [omega;-g/L*theta]
    %dunque x(1) è theta, x(2) è omega