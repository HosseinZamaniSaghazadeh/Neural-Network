clear
clc

%num = input('Enter the number of patterns\n');
%P = {};
%t = {};
%for jj=1:num
    
 %   P{1,jj}=input('Enter the value of pattern matrix (Must be in the form of R*1)\n');
 %   t{1,jj}=input('Enter the value of target matrix (Must be in the form of S*1)\n');
%end
P1 = [1,4]';
t1 = 0;
P2 = [1,5]';
t2 = 0;
P3 = [2,4]';
t3 = 0;
P4 = [2,5]';
t4 = 0;
P5 = [3,1]';
t5 = 1;
P6 = [3,2]';
t6 = 1;
P7 = [4,1]';
t7 = 1;
P8 = [4,2]';
t8 = 1;
P = {P1 P2 P3 P4 P5 P6 P7 P8};
s = size(P,2);
t = {t1 t2 t3 t4 t5 t6 t7 t8};
%W = input('Enter the weight matrix initial value (Must be in the form of S*R or S*1)\n');
%b = input('Enter the bias matrix inital value (Must be in the form of S*1)\n');
W = [1 1];
b = 1;
for ii=1:24
    
    while ii > size(P,2)   % To make the pattern index bounded between 1 to number of patterns
        ii=0+(ii-size(P,2));
    end
    a = hardlim(W*P{1,ii}+b);
    e = t{1,ii}-a;
    W = W + e * P{1,ii}';
    b = b + e;
    Error(1,ii)={e};
end
fprintf('The Weight Matrix Converges to\n')
disp(W)
fprintf('The Bias Matrix Converges to\n')
disp(b)

%% Adding Input Vectors Vectors to Training Sets
P1_Add = (P1+W');
t1 = 0;
P2_Add = (P2+W');
t2 = 0;
P3_Add = (P3+W');
t3 = 0;
P4_Add = (P4+W');
t4 = 0;
P5_Add = (P5+W');
t5 = 1;
P6_Add = (P6+W');
t6 = 1;
P7_Add = (P7+W');
t7 = 1;
P8_Add = (P8+W');
t8 = 1;
P_Add = {P1_Add P2_Add P3_Add P4_Add P5_Add P6_Add P7_Add P8_Add};
s = size(P_Add,2);
t = {t1 t2 t3 t4 t5 t6 t7 t8};
%W_Add = input('Enter the new trained weight matrix initial value (Must be in the form of S*R or S*1)\n');
%b_Add = input('Enter the new trainetd bias matrix inital value (Must be in the form of S*1)\n');
W_Add = [1 1];
b_Add = 1;
for ii=1:24
    
    while ii > size(P_Add,2)   % To make the pattern index bounded between 1 to number of patterns
        ii=0+(ii-size(P_Add,2));
    end
    a_Add = hardlim(W_Add*P_Add{1,ii}+b_Add);
    e_Add = t{1,ii}-a_Add;
    W_Add = W_Add + e_Add * P_Add{1,ii}';
    b_Add = b_Add + e_Add;
    Error_Add(1,ii)={e_Add};
end
fprintf('The New Trained Weight Matrix Converges to\n')
disp(W_Add)
fprintf('The New Trained Bias Matrix Converges to\n')
disp(b_Add)

%% Test Section

W_Test = W;
b_Test = b;
for ii=1:8
    
a_Test{1,ii} = hardlim(W_Test*P{1,ii}+b_Test);

end
fprintf('The Output Vector Corrsponding To Problem Inputs Is\n')
disp(a_Test)
