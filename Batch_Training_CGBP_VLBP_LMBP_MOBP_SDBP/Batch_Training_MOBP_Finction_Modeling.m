%% Batch_Training_MOBP_Finction_Modeling
clear
clc

%% Main Function Plot
x = -2:0.1:2;
y = 1 + sin((pi/2).*x);
plot(x,y)
xlabel('x and P')
ylabel('sin(x)')
title('Function Approximation Batch Training MOBP Method')

%% Network 1-2-1
P = [-2:0.1:2]';
delW1 = -0.5 + (0.5+0.5)*rand(2,1);
delb1 = -0.5 + (0.5+0.5)*rand(2,1);
delW2 = -0.5 + (0.5+0.5)*rand(1,2);
delb2 = -0.5 + (0.5+0.5)*rand(1,1);
alpha = 0.05;
gama = 0.9;
t = (1 + sin((pi/2).*P))';
W1 = delW1;
b1 = delb1;
W2 = delW2;
b2 = delb2;
for kk = 1:20250
    
for ii = 1:size(P,1)
    
    n1 = W1 * P(ii,1) + b1;
    a1 = logsig(n1);
    n2 = W2 * a1 + b2;
    a2 = purelin(n2);
    e(1,ii) = t(1,ii)-a2;
    Fdot2 = 1;
    s2 = -2 * Fdot2 * e(1,ii);
    Fdot1 = zeros(size(n1,1),size(n1,1));
    
    for jj = 1:2
        
        Fdot1(jj,jj) = (1-a1(jj,1)) * a1(jj,1);
        
    end
    
    s1 = Fdot1 * W2' * s2;
    
    g1_W = s1*(P(ii,1))';
    g11_W(1,ii) = g1_W(1,1);
    g12_W(1,ii) = g1_W(2,1);
    g1_b = s1;
    g11_b(1,ii) = g1_b(1,1);
    g12_b(1,ii) = g1_b(2,1);
    
    g2_W = s2*(a1)';
    g21_W(ii,1) = g2_W(1,1);
    g22_W(ii,1) = g2_W(1,2);
    g2_b(1,ii) = s2;
    
    A2_Prime(1,ii) = a2;
    
end

g1_total_W = [sum(g11_W);sum(g12_W)];
g1_total_b = [sum(g11_b);sum(g12_b)];

g2_total_W = [sum(g21_W) sum(g22_W)];
g2_total_b = sum(g2_b);


Fx(1,kk) = e*(e)';

delW1 = gama*delW1 - (1-gama)*alpha*g1_total_W;
W1 = delW1+W1;
delb1 = gama*delb1 - (1-gama)*alpha*g1_total_b;
b1 = delb1+b1;
delW2 = gama*delW2 - (1-gama)*alpha*g2_total_W;
W2 = delW2+W2;
delb2 = gama*delb2 - (1-gama)*alpha*g2_total_b; 
b2 = delb2+b2;

end

 %% The Value Of Final Weights and Biases
fprintf('The First Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W1)
fprintf('The First Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b1)
fprintf('The Second Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W2)
fprintf('The Second Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b2)

 %% Plots Of Networks Output
  hold on
  plot(P,A2_Prime)
  legend('Main Function','1-2-1 Network','Location','northwest')