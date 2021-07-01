clear
clc

%% Patterns
P1_0 = [-1 1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 1 -1]';
P2_1 = [-1 1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1]';
P3_2 = [1 1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1]';
P4_3 = [1 1 1 1 -1 -1 -1 -1 -1 1 -1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 1 -1 -1 -1 -1 -1 -1]';
P5_4 = [-1 -1 1 1 -1 -1 1 -1 1 -1 1 -1 -1 1 -1 1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1]';
P6_5 = [1 1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 1 -1]';
P7_6 = [-1 1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 1 -1]';
P_01 = [P1_0 P2_1];
P_01_Star = ((P_01)'*P_01)^(-1)*(P_01)';
P_012 = [P1_0 P2_1 P3_2];
P_012_Star = ((P_012)'*P_012)^(-1)*(P_012)';
P_0123 = [P1_0 P2_1 P3_2 P4_3];
P_0123_Star = ((P_0123)'*P_0123)^(-1)*(P_0123)';
P_01234 = [P1_0 P2_1 P3_2 P4_3 P5_4];
P_01234_Star = ((P_01234)'*P_01234)^(-1)*(P_01234)';
P_012345 = [P1_0 P2_1 P3_2 P4_3 P5_4 P6_5];
P_012345_Star = ((P_012345)'*P_012345)^(-1)*(P_012345)';
P_0123456 = [P1_0 P2_1 P3_2 P4_3 P5_4 P6_5 P7_6];
P_0123456_Star = ((P_0123456)'*P_0123456)^(-1)*(P_0123456)';

%% Noisy_Input
P1_0_n = P1_0; 
P2_1_n = P2_1; 
P3_2_n = P3_2; 
P4_3_n = P4_3; 
P5_4_n = P5_4; 
P6_5_n = P6_5; 
P7_6_n = P7_6; 

P7_6_n(1,1)=1;
P7_6_n(26,1)=1;
P7_6_n(30,1)=1;
P7_6_n(22,1)=1;
P7_6_n(23,1)=1;
P7_6_n(24,1)=1;
P = P7_6_n;

%% Wight Matrices
W_Hebb_01 = P_01*(P_01)';
W_Pseudo_01 = P_01*P_01_Star;
W_Hebb_012 = P_012*(P_012)';
W_Pseudo_012 = P_012*P_012_Star;
W_Hebb_0123 = P_0123*(P_0123)';
W_Pseudo_0123 = P_0123*P_0123_Star;
W_Hebb_01234 = P_01234*(P_01234)';
W_Pseudo_01234 = P_01234*P_01234_Star;
W_Hebb_012345 = P_012345*(P_012345)';
W_Pseudo_012345 = P_012345*P_012345_Star;
W_Hebb_0123456 = P_0123456*(P_0123456)';
W_Pseudo_0123456 = P_0123456*P_0123456_Star;

%% Network

a_01_Hebb = hardlims(W_Hebb_01*P);
fprintf('The a_01_Hebb is\n')
disp(a_01_Hebb)
if a_01_Hebb == P1_0
    disp('It is 0')
elseif a_01_Hebb == P2_1
    disp('It is 1')
else
    disp('The input pattern is not supported by this network')
end

a_01_Pseudo = hardlims(W_Pseudo_01*P);
fprintf('The a_01_Pseudo is\n')
disp(a_01_Pseudo)
if a_01_Pseudo == P1_0
    disp('It is 0')
elseif a_01_Pseudo == P2_1
    disp('It is 1')
else
    disp('The input pattern is not supported by this network')
end


a_012_Hebb = hardlims(W_Hebb_012*P);
fprintf('The a_012_Hebb is\n')
disp(a_012_Hebb)
if a_012_Hebb == P1_0
    disp('It is 0')
elseif a_012_Hebb == P2_1
    disp('It is 1')
elseif a_012_Hebb == P3_2
    disp('It is 2')
else
    disp('The input pattern is not supported by this network')
end

a_012_Pseudo = hardlims(W_Pseudo_012*P);
fprintf('The a_012_Pseudo is\n')
disp(a_012_Pseudo)
if a_012_Pseudo == P1_0
    disp('It is 0')
elseif a_012_Pseudo == P2_1
    disp('It is 1')
elseif a_012_Pseudo == P3_2
    disp('Is is 2')
else
    disp('The input pattern is not supported by this network')
end


a_0123_Hebb = hardlims(W_Hebb_0123*P);
fprintf('The a_0123_Hebb is\n')
disp(a_0123_Hebb)
if a_0123_Hebb == P1_0
    disp('It is 0')
elseif a_0123_Hebb == P2_1
    disp('It is 1')
elseif a_0123_Hebb == P3_2
    disp('It is 2')
elseif a_0123_Hebb == P4_3
    disp('It is 3')
else
    disp('The input pattern is not supported by this network')
end

a_0123_Pseudo = hardlims(W_Pseudo_0123*P);
fprintf('The a_0123_Pseudo is\n')
disp(a_0123_Pseudo)
if a_0123_Pseudo == P1_0
    disp('It is 0')
elseif a_0123_Pseudo == P2_1
    disp('It is 1')
elseif a_0123_Pseudo == P3_2
    disp('Is is 2')
elseif a_0123_Pseudo == P4_3
    disp('It is 3')
else
    disp('The input pattern is not supported by this network')
end


a_01234_Hebb = hardlims(W_Hebb_01234*P);
fprintf('The a_01234_Hebb is\n')
disp(a_01234_Hebb)
if a_01234_Hebb == P1_0
    disp('It is 0')
elseif a_01234_Hebb == P2_1
    disp('It is 1')
elseif a_01234_Hebb == P3_2
    disp('It is 2')
elseif a_01234_Hebb == P4_3
    disp('It is 3')
elseif a_01234_Hebb == P5_4
    disp('It is 4')
else
    disp('The input pattern is not supported by this network')
end

a_01234_Pseudo = hardlims(W_Pseudo_01234*P);
fprintf('The a_01234_Pseudo is\n')
disp(a_01234_Pseudo)
if a_01234_Pseudo == P1_0
    disp('It is 0')
elseif a_01234_Pseudo == P2_1
    disp('It is 1')
elseif a_01234_Pseudo == P3_2
    disp('Is is 2')
elseif a_01234_Pseudo == P4_3
    disp('It is 3')
elseif a_01234_Pseudo == P5_4
    disp('It is 4')
else
    disp('The input pattern is not supported by this network')
end


a_012345_Hebb = hardlims(W_Hebb_012345*P);
fprintf('The a_012345_Hebb is\n')
disp(a_012345_Hebb)
if a_012345_Hebb == P1_0
    disp('It is 0')
elseif a_012345_Hebb == P2_1
    disp('It is 1')
elseif a_012345_Hebb == P3_2
    disp('It is 2')
elseif a_012345_Hebb == P4_3
    disp('It is 3')
elseif a_012345_Hebb == P5_4
    disp('It is 4')
elseif a_012345_Hebb == P6_5
    disp('It is 5')
else
    disp('The input pattern is not supported by this network')
end

a_012345_Pseudo = hardlims(W_Pseudo_012345*P);
fprintf('The a_012345_Pseudo is\n')
disp(a_012345_Pseudo)
if a_012345_Pseudo == P1_0
    disp('It is 0')
elseif a_012345_Pseudo == P2_1
    disp('It is 1')
elseif a_012345_Pseudo == P3_2
    disp('Is is 2')
elseif a_012345_Pseudo == P4_3
    disp('It is 3')
elseif a_012345_Pseudo == P5_4
    disp('It is 4')
elseif a_012345_Pseudo == P6_5
    disp('It is 5')
else
    disp('The input pattern is not supported by this network')
end


a_0123456_Hebb = hardlims(W_Hebb_0123456*P);
fprintf('The a_0123456_Hebb is\n')
disp(a_0123456_Hebb)
if a_0123456_Hebb == P1_0
    disp('It is 0')
elseif a_0123456_Hebb == P2_1
    disp('It is 1')
elseif a_0123456_Hebb == P3_2
    disp('It is 2')
elseif a_0123456_Hebb == P4_3
    disp('It is 3')
elseif a_0123456_Hebb == P5_4
    disp('It is 4')
elseif a_0123456_Hebb == P6_5
    disp('It is 5')
elseif a_0123456_Hebb == P7_6
    disp('It is 6')
else
    disp('The input pattern is not supported by this network')
end

a_0123456_Pseudo = hardlims(W_Pseudo_0123456*P);
fprintf('The a_0123456_Pseudo is\n')
disp(a_0123456_Pseudo)
if a_0123456_Pseudo == P1_0
    disp('It is 0')
elseif a_0123456_Pseudo == P2_1
    disp('It is 1')
elseif a_0123456_Pseudo == P3_2
    disp('Is is 2')
elseif a_0123456_Pseudo == P4_3
    disp('It is 3')
elseif a_0123456_Pseudo == P5_4
    disp('It is 4')
elseif a_0123456_Pseudo == P6_5
    disp('It is 5')
elseif a_0123456_Pseudo == P7_6
    disp('It is 6')
else
    disp('The input pattern is not supported by this network')
end

%% Plots

figure
error_digit0_hebb_2pix = [0,0,0,0,0,0.9];
X = [2,3,4,5,6,7];
plot(X,error_digit0_hebb_2pix,'-o')

hold on
error_digit0_hebb_4pix = [0,0,0.1,0.1,0.6,0.9];
plot(X,error_digit0_hebb_4pix,'-o')

hold on
error_digit0_hebb_6pix = [0,0,0.5,0.7,0.7,0.8];
plot(X,error_digit0_hebb_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 0 Using Hebb Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')

figure
error_digit0_pseudo_2pix = [0,0,0,0,0,0];
plot(X,error_digit0_pseudo_2pix,'-o')

hold on
error_digit0_pseudo_4pix = [0,0,0,0,0.3,0.4];
plot(X,error_digit0_pseudo_4pix,'-o')

hold on
error_digit0_pseudo_6pix = [0,0,0.1,0.6,0.5,0.9];
plot(X,error_digit0_pseudo_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 0 Using Pseudo Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')


figure
error_digit1_hebb_2pix = [0,0,0,0,0,0];
plot(X,error_digit1_hebb_2pix,'-o')

hold on
error_digit1_hebb_4pix = [0,0,0,0.2,0.2,0.3];
plot(X,error_digit1_hebb_4pix,'-o')

hold on
error_digit1_hebb_6pix = [0,0.3,0.4,0.3,0.5,0.5];
plot(X,error_digit1_hebb_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 1 Using Hebb Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')

figure
error_digit1_pseudo_2pix = [0,0,0,0,0,0.1];
plot(X,error_digit1_pseudo_2pix,'-o')

hold on
error_digit1_pseudo_4pix = [0,0,0,0,0,0.1];
plot(X,error_digit1_pseudo_4pix,'-o')

hold on
error_digit1_pseudo_6pix = [0,0.2,0.3,0.3,0.4,0.4];
plot(X,error_digit1_pseudo_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 1 Using Pseudo Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')


figure
error_digit2_hebb_2pix = [0,0,0,0,0.1];
X1 = [3,4,5,6,7];
plot(X1,error_digit2_hebb_2pix,'-o')

hold on
error_digit2_hebb_4pix = [0,0.1,0.1,0.2,0.5];
plot(X1,error_digit2_hebb_4pix,'-o')

hold on
error_digit2_hebb_6pix = [0.2,0.3,0.3,0.5,0.7];
plot(X1,error_digit2_hebb_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 2 Using Hebb Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')

figure
error_digit2_pseudo_2pix = [0,0,0.1,0.1,0.1];
plot(X1,error_digit2_pseudo_2pix,'-o')

hold on
error_digit2_pseudo_4pix = [0,0,0.1,0.2,0.5];
plot(X1,error_digit2_pseudo_4pix,'-o')

hold on
error_digit2_pseudo_6pix = [0.1,0.2,0.3,0.4,0.7];
plot(X1,error_digit2_pseudo_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 2 Using Pseudo Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')


figure
error_digit3_hebb_2pix = [0,0,0,0.1];
X2 = [4,5,6,7];
plot(X2,error_digit3_hebb_2pix,'-o')

hold on
error_digit3_hebb_4pix = [0,0.2,0.3,0.6];
plot(X2,error_digit3_hebb_4pix,'-o')

hold on
error_digit3_hebb_6pix = [0.1,0.2,0.5,0.6];
plot(X2,error_digit3_hebb_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 3 Using Hebb Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')

figure
error_digit3_pseudo_2pix = [0,0,0,0.1];
plot(X2,error_digit3_pseudo_2pix,'-o')

hold on
error_digit3_pseudo_4pix = [0,0,0.1,0.5];
plot(X2,error_digit3_pseudo_4pix,'-o')

hold on
error_digit3_pseudo_6pix = [0,0.3,0.5,1];
plot(X2,error_digit3_pseudo_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 3 Using Pseudo Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')


figure
error_digit4_hebb_2pix = [0,0.1,0.2];
X3 = [5,6,7];
plot(X3,error_digit4_hebb_2pix,'-o')

hold on
error_digit4_hebb_4pix = [0.1,0,0.2];
plot(X3,error_digit4_hebb_4pix,'-o')

hold on
error_digit4_hebb_6pix = [0.4,0.5,0.5];
plot(X3,error_digit4_hebb_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 4 Using Hebb Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')

figure
error_digit4_pseudo_2pix = [0,0,0.1];
plot(X3,error_digit4_pseudo_2pix,'-o')

hold on
error_digit4_pseudo_4pix = [0,0,0.1];
plot(X3,error_digit4_pseudo_4pix,'-o')

hold on
error_digit4_pseudo_6pix = [0.1,0.5,0.7];
plot(X3,error_digit4_pseudo_6pix,'-o')

title('Error VS Number of Digits Stored For Digit Number 4 Using Pseudo Rule')
legend('2 Pixels','4 Pixels','6 Pixels','Location','northwest')
xlabel('Number of Stored Digits')
ylabel('Error Percentage')