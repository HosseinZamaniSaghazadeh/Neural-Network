%% ADALINE_Network
clear
clc

%num = input('Enter the number of patterns\n');
%P = {};
%t = {};
%for jj=1:num
    
 %   P{1,jj}=input('Enter the value of pattern matrix (Must be in the form of R*1)\n');
 %   t{1,jj}=input('Enter the value of target matrix (Must be in the form of S*1)\n');
%end
P1 = [1 1]';
t1 = 1;
P2 = [-1 2]';
t2 = 1;
P3 = [0 -1]';
t3 = -1;
P4 = [-4 1]';
t4 = -1;

P = {P1 P2 P3 P4};
t = {t1 t2 t3 t4};
%W = input('Enter the weight matrix initial value (Must be in the form of S*R)\n');
%b = input('Enter the bias matrix inital value (Must be in the form of S*1)\n');
%alpha = input('Enter the learning rate\n');
W = [0 0];
b = 0;
alpha = 0.1;
for ii=1:200
    
    while ii > size(P,2)   % To make the network loops just inside the inputs for example after entering P4 the network must enter P1 again
        ii=0+(ii-size(P,2));
    end
    a = purelin(W*P{1,ii}+b);
    e = t{1,ii}-a;
    W = W + 2*alpha*e*P{1,ii}'
    b = b + 2*alpha*e
    Error(1,ii)={e};
end
fprintf('The Weight Matrix Converges to\n')
disp(W)
fprintf('The Bias Matrix Converges to\n')
disp(b)