%% Adaptive_Filter
clear
clc


%W = input('Enter the weight matrix initial value (Must be in the form of S*R)\n');
%b = input('Enter the bias matrix inital value (Must be in the form of S*1)\n');
%alpha = input('Enter the learning rate\n');
W = [0 0];
b = 0;
alpha = 0.01;
for ii=0:6000
 
    P = [sin((ii-1)*(pi/5));sin((ii-2)*(pi/5))];
    a = purelin(W*P+b);
    e = sin(ii*(pi/5))-a;
    W = W + 2*alpha*e*P'
    %b = b + 2*alpha*e
    W11(1,ii+1) = W(1,1);
    W12(1,ii+1) = W(1,2);
end
fprintf('The Weight Matrix Converges to\n')
disp(W)
fprintf('The Bias Matrix Converges to\n')
disp(b)

%% Plots
[X0,Y0] = meshgrid(-2:0.1:2,-2:0.1:2);
Z0 = 0.5*(X0.^2 + Y0.^2) + 2*0.4045*X0.*Y0 - 2*0.4045*X0 - 2*0.1545*Y0 + 0.5;
contour(X0,Y0,Z0)
title('Original Function Contour Plot alpha=0.01')
xlabel('W(1,1)')
ylabel('W(1,2)')
hold on
plot( W11,W12)