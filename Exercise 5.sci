N = 20;
n = 0:N-1;
x = sin(2*%pi*2*n/N);

clf();
plot2d3(n, x);
plot(n, x, ".r");
title("x(n) = sin(2*pi*2*n/N), N=20");
xlabel("n");
ylabel("x(n)");
