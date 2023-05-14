function xdot = prova_doppio_pendolo_attuato(m1,m2,l1,l2,t1,t2,t,x)
g = 9.81;
a1 = x(1);
w1 = x(2);
a2 = x(3);
w2 = x(4);
%alpha1
xdot(1) = x(2);
%omega1
%alpha2
xdot(3) = x(4);
%omega2
end

