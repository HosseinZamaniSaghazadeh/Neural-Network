%% Finction_Modeling_BackPropagation
clear
clc

%% Main Function Plot
x = -2:0.1:2;
y = 1 + sin((pi/2).*x);
plot(x,y)
xlabel('x and P')
ylabel('sin(x)')
title('Function Approximation With Back Propagation Method')

%% Network 1-2-1
P = [-2:0.1:2]';
W1_2N = -0.5 + (0.5+0.5)*rand(2,1);
b1_2N = -0.5 + (0.5+0.5)*rand(2,1);
W2_2N = -0.5 + (0.5+0.5)*rand(1,2);
b2_2N = -0.5 + (0.5+0.5)*rand(1,1);
alpha_2N = 0.03;
for ii = 1:21000
    
    while ii > size(P,1)   % To make the network loops just inside the inputs for example after entering P4 the network must enter P1 again
        ii = 0+(ii-size(P,1));
    end
    n1_2N = W1_2N * P(ii,1) + b1_2N;
    a1_2N = logsig(n1_2N);
    n2_2N = W2_2N * a1_2N + b2_2N;
    a2_2N = purelin(n2_2N);
    t_2N = 1 + sin((pi/2).*P(ii,1));
    e_2N = t_2N - a2_2N;
    Fdot2_2N = 1;
    s2_2N = -2 * Fdot2_2N * e_2N;
    Fdot1_2N = zeros(size(n1_2N,1),size(n1_2N,1));
    for jj = 1:2
    Fdot1_2N(jj,jj) = (1-a1_2N(jj,1)) * a1_2N(jj,1);
    end
    s1_2N = Fdot1_2N * W2_2N' * s2_2N;
    W1_2N = W1_2N - alpha_2N * s1_2N * P(ii,1)';
    b1_2N = b1_2N - alpha_2N * s1_2N;
    W2_2N = W2_2N - alpha_2N * s2_2N * a1_2N';
    b2_2N = b2_2N - alpha_2N * s2_2N;
    Error_2N(1,ii) = e_2N;
    Output_2N(1,ii) = a2_2N;
end

%% Network 1-10-1
W1_10N = -0.5 + (0.5+0.5)*rand(10,1);
b1_10N = -0.5 + (0.5+0.5)*rand(10,1);
W2_10N = -0.5 + (0.5+0.5)*rand(1,10);
b2_10N = -0.5 + (0.5+0.5)*rand(1,1);
alpha_10N = 0.03;
for ii = 1:21000
    
    while ii > size(P,1)   % To make the network loops just inside the inputs for example after entering P4 the network must enter P1 again
        ii = 0+(ii-size(P,1));
    end
    n1_10N = W1_10N * P(ii,1) + b1_10N;
    a1_10N = logsig(n1_10N);
    n2_10N = W2_10N * a1_10N + b2_10N;
    a2_10N = purelin(n2_10N);
    t_10N = 1 + sin((pi/2).*P(ii,1));
    e_10N = t_10N - a2_10N;
    Fdot2_10N = 1;
    s2_10N = -2 * Fdot2_10N * e_10N;
    Fdot1_10N = zeros(size(n1_10N,1),size(n1_10N,1));
    for jj = 1:10
    Fdot1_10N(jj,jj) = (1-a1_10N(jj,1)) * a1_10N(jj,1);
    end
    s1_10N = Fdot1_10N * W2_10N' * s2_10N;
    W1_10N = W1_10N - alpha_10N * s1_10N * P(ii,1)';
    b1_10N = b1_10N - alpha_10N * s1_10N;
    W2_10N = W2_10N - alpha_10N * s2_10N * a1_10N';
    b2_10N = b2_10N - alpha_10N * s2_10N;
    Error_10N(1,ii) = e_10N;
    Output_10N(1,ii) = a2_10N;
end

%% The Value Of Final Weights and Biases
fprintf('The First Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W1_2N)
fprintf('The First Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b1_2N)
fprintf('The Second Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W2_2N)
fprintf('The Second Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b2_2N)
fprintf('The First Layer Weight Matrix Of 1-10-1 Network Converges to\n')
disp(W1_10N)
fprintf('The First Layer Bias Matrix Of 1-10-1 Network Converges to\n')
disp(b1_10N)
fprintf('The Second Layer Weight Matrix Of 1-10-1 Network Converges to\n')
disp(W2_10N)
fprintf('The Second Layer Bias Matrix Of 1-10-1 Network Converges to\n')
disp(b2_10N)

%% Plots Of Networks Output
hold on
plot(P,Output_2N)
hold on
plot(P,Output_10N)
legend('Main Function','1-2-1 Network','1-10-1 Network','Location','northwest')