%% Perceptron_Network_HW#2_E4.12
clear
clc

%num = input('Enter the number of patterns\n');
%P = {};
%t = {};
%for jj=1:num
    
 %   P{1,jj}=input('Enter the value of pattern matrix (Must be in the form of R*1)\n');
 %   t{1,jj}=input('Enter the value of target matrix (Must be in the form of S*1)\n');
%end
P1 = [1,1]';
t1 = [0,0]';
P2 = [1,2]';
t2 = [0,0]';
P3 = [2,1.5]';
t3 = [0,1]';
P4 = [2,0]';
t4 = [0,1]';
P5 = [-1,2]';
t5 = [1,0]';
P6 = [-2,1]';
t6 = [1,0]';
P7 = [-1,-1]';
t7 = [1,1]';
P8 = [-2,-2]';
t8 = [1,1]';
P = {P1 P2 P3 P4 P5 P6 P7 P8};
s = size(P,2);
t = {t1 t2 t3 t4 t5 t6 t7 t8};
%W = input('Enter the weight matrix initial value (Must be in the form of S*R or S*1)\n');
%b = input('Enter the bias matrix inital value (Must be in the form of S*1)\n');
W = [1 0;0 1];
b = [1 1]';
for ii=1:2000
    
    while ii > size(P,2)   % To make the pattern index bounded between 1 to number of patterns
        ii=0+(ii-size(P,2));
    end
    a = hardlim(W*P{1,ii}+b);
    e = t{1,ii}-a;
    W = W + e * P{1,ii}'
    b = b + e;
    Error(1,ii)={e};
end
fprintf('The Weight Matrix Converges to\n')
disp(W)
fprintf('The Bias Matrix Converges to\n')
disp(b)