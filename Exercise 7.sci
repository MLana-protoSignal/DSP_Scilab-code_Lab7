function y = fft_conv(x1, x2)
    N1 = length(x1);
    N2 = length(x2);
    N = N1 + N2 - 1;
    
    // Bổ sung số 0 để độ dài bằng N (Zero-padding)
    X1 = fft([x1, zeros(1, N - N1)]);
    X2 = fft([x2, zeros(1, N - N2)]);
    
    // Nhân trong miền tần số và biến đổi ngược
    y = real(ifft(X1 .* X2));
endfunction

// x1(n)
x1 = zeros(1, 5);
x1(1) = 1; 
x1(2) = 2; 
x1(3) = 0; 
x1(4) = 3;
x1(5) = 1
x1_n = 0:length(x1)-1;
// x2(n)
x2 = zeros(1, 4);
x2(1) = 1; 
x2(2) = 0;
x2(3) = 1; 
x2(4) = 1;
x2_n = 0:length(x2)-1;
// Using DFT (FFT in Scilab)
yn =  fft_conv(x1, x2);
n_y = 0:length(yn)-1;
//Plot
clf();
subplot(3,1,1)
plot2d3(x1_n, x1);
xlabel("n"); 
ylabel("x1(n)"); 
title("x1(n)");
subplot(3,1,2)
plot2d3(x2_n, x2);
xlabel("n"); 
ylabel("x2(n)"); 
title("x2(n)");
subplot(3,1,3)
plot2d3(n_y, yn);
xlabel("n"); 
ylabel("y(n)"); 
title("y(n) = x1(n)*x2(n)");
