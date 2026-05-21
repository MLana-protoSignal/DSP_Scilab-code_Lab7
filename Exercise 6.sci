function [yn, yn_oneCyc] = cirConvolFFT(xn, hn, n)
    N = length(xn);
    X = fft(xn);
    H = fft(hn);
    Y = X .* H;
    yn_oneCyc = ifft(Y);
    yn = zeros(1, length(n));
    for i = 1:length(n)
        idx = pmodulo(n(i), N);
        yn(i) = yn_oneCyc(idx + 1);
    end
endfunction

function [yn, yn_oneCyc] = cirConvolDirect(xn, hn, n)
    N = length(xn);
    yn_oneCyc = zeros(1, N);
    for a = 0: (N-1)
        for b = 0:(N-1)
            idx = pmodulo(a - b, N);
            yn_oneCyc(a+1) = yn_oneCyc(a+1) + hn(b+1) .* xn(idx+1);
        end
    end 
    
    yn = zeros(1, length(n));
    for i = 1:length(n)
        idx = pmodulo(n(i), N);
        yn(i) = yn_oneCyc(idx + 1); 
    end
endfunction

n = -10:10;
len = 4;
// x(n)
xn = zeros(1, len);
xn(1) = 1; 
xn(2) = 2; 
xn(3) = 3; 
xn(4) = 4;
// h(n)
hn = zeros(1, len);
hn(1) = 1; 
hn(2) = 1;
hn(3) = 0; 
hn(4) = 0;
// Using DFT (FFT in Scilab)
[yn1, yn_oneCyc1] = cirConvolFFT(xn, hn, n);
// Compute the circular convolution directly, not using the DFT
[yn2, yn_oneCyc2] = cirConvolDirect(xn, hn, n);

//Display
//Console
printf(" 1. Using DFT (FFT in Scilab) \n One cycle of y(n): [ %d", yn_oneCyc1(1)); 
for i=2:length(yn_oneCyc1)
    printf(", %d", yn_oneCyc1(i));
end
printf(" ]\n");

printf(" 2. Compute the circular convolution directly, not using the DFT \n One cycle of y(n): [ %d", yn_oneCyc2(1)); 
for i=2:length(yn_oneCyc2)
    printf(", %d", yn_oneCyc2(i));
end
printf(" ]\n");
//Plot
clf();
subplot(2, 1, 1);
plot2d3(n, yn1);
xlabel("n"); ylabel("y(n)"); title("Using DFT (FFT in Scilab)");
subplot(2, 1, 2);
plot2d3(n, yn2);
xlabel("n"); ylabel("y(n)"); title("Compute the circular convolution directly, not using the DFT");
