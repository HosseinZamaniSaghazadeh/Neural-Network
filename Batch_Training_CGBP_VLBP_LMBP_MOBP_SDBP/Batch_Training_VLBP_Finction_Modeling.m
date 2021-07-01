%% Batch_Training_VLBP_Finction_Modeling
clear
clc

%% Main Function Plot
x = -2:0.1:2;
y = 1 + sin((pi/2).*x);
plot(x,y)
xlabel('x and P')
ylabel('sin(x)')
title('Function Approximation Batch Training VLBP Method')

%% Network 1-2-1
P = [-2:0.1:2]';

delW10 = -0.5 + (0.5+0.5)*rand(2,1);
delb10 = -0.5 + (0.5+0.5)*rand(2,1);
delW20 = -0.5 + (0.5+0.5)*rand(1,2);
delb20 = -0.5 + (0.5+0.5)*rand(1,1);
alpha = 0.01;
gama = 0.2;
kesi = 0.05;
ro = 0.7;
eta = 1.05;
t = (1 + sin((pi/2).*P))';
W10 = delW10;
b10 = delb10;
W20 = delW20;
b20 = delb20;

delW1 = {};
delb1 = {};
delW2 = {};
delb2 = {};
W1 = {};
b1 = {};
W2 = {};
b2 = {};

delW1{1,1} = delW10;
delb1{1,1} = delb10;
delW2{1,1} = delW20;
delb2{1,1} = delb20;
W1{1,1} = delW1{1,1};
b1{1,1} = delb1{1,1};
W2{1,1} = delW2{1,1};
b2{1,1} = delb2{1,1};
g1_total_W = {};
g1_total_b = {};
g2_total_W = {};
g2_total_b = {};

for kk = 1:8200
    
for ii = 1:size(P,1)
    
    n1 = W1{1,kk} * P(ii,1) + b1{1,kk};
    a1 = logsig(n1);
    n2 = W2{1,kk} * a1 + b2{1,kk};
    a2 = purelin(n2);
    e(1,ii) = t(1,ii)-a2;
    Fdot2 = 1;
    s2 = -2 * Fdot2 * e(1,ii);
    Fdot1 = zeros(size(n1,1),size(n1,1));
    
    for jj = 1:2
        
        Fdot1(jj,jj) = (1-a1(jj,1)) * a1(jj,1);
        
    end
    
    s1 = Fdot1 * (W2{1,kk})' * s2;
    
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

g1_total_W{1,kk} = [sum(g11_W);sum(g12_W)];

g1_total_b{1,kk} = [sum(g11_b);sum(g12_b)];

g2_total_W{1,kk} = [sum(g21_W) sum(g22_W)];

g2_total_b{1,kk} = sum(g2_b);


Fx(1,kk) = e*(e)';

if kk==1
    
    delW1{1,kk+1} = gama*0 - (1-gama)*alpha*g1_total_W{1,kk};
    W1{1,kk+1} = delW1{1,kk+1}+W1{1,kk};
    
    delb1{1,kk+1} = gama*0 - (1-gama)*alpha*g1_total_b{1,kk};
    b1{1,kk+1} = delb1{1,kk+1}+b1{1,kk};
    
    delW2{1,kk+1} = gama*0 - (1-gama)*alpha*g2_total_W{1,kk};
    W2{1,kk+1} = delW2{1,kk+1}+W2{1,kk};
    
    delb2{1,kk+1} = gama*0 - (1-gama)*alpha*g2_total_b{1,kk}; 
    b2{1,kk+1} = delb2{1,kk+1}+b2{1,kk};
    
end

if kk >=2
    
    if Fx(1,kk) > (kesi+1)*Fx(1,kk-1)
        
       W1{1,kk} = W1{1,kk-1};
       delW1{1,kk} = delW1{1,kk-1};
       g1_total_W{1,kk} = g1_total_W{1,kk-1};
       
       b1{1,kk} = b1{1,kk-1};
       delb1{1,kk} = delb1{1,kk-1};
       g1_total_b{1,kk} = g1_total_b{1,kk-1};
       
       W2{1,kk} = W2{1,kk-1};
       delW2{1,kk} = delW2{1,kk-1};
       g2_total_W{1,kk} = g2_total_W{1,kk-1};
       
       b2{1,kk} = b2{1,kk-1};
       delb2{1,kk} = delb2{1,kk-1};
       g2_total_b{1,kk} = g2_total_b{1,kk-1};
       
       gama = 0;
       alpha = alpha*ro;
       
       delW1{1,kk+1} = gama*delW1{1,kk} - (1-gama)*alpha*g1_total_W{1,kk};
       W1{1,kk+1} = delW1{1,kk+1}+W1{1,kk};
    
       delb1{1,kk+1} = gama*delb1{1,kk} - (1-gama)*alpha*g1_total_b{1,kk};
       b1{1,kk+1} = delb1{1,kk+1}+b1{1,kk};
    
       delW2{1,kk+1} = gama*delW2{1,kk} - (1-gama)*alpha*g2_total_W{1,kk};
       W2{1,kk+1} = delW2{1,kk+1}+W2{1,kk};
    
       delb2{1,kk+1} = gama*delb2{1,kk} - (1-gama)*alpha*g2_total_b{1,kk}; 
       b2{1,kk+1} = delb2{1,kk+1}+b2{1,kk};
       
       
    end
    if Fx(1,kk) < Fx(1,kk-1)
        
        gama = 0.2;
        alpha = alpha*eta;
        
        delW1{1,kk+1} = gama*delW1{1,kk} - (1-gama)*alpha*g1_total_W{1,kk};
        W1{1,kk+1} = delW1{1,kk+1}+W1{1,kk};
    
        delb1{1,kk+1} = gama*delb1{1,kk} - (1-gama)*alpha*g1_total_b{1,kk};
        b1{1,kk+1} = delb1{1,kk+1}+b1{1,kk};
    
        delW2{1,kk+1} = gama*delW2{1,kk} - (1-gama)*alpha*g2_total_W{1,kk};
        W2{1,kk+1} = delW2{1,kk+1}+W2{1,kk};
    
        delb2{1,kk+1} = gama*delb2{1,kk} - (1-gama)*alpha*g2_total_b{1,kk}; 
        b2{1,kk+1} = delb2{1,kk+1}+b2{1,kk};
        
    end
    
    if Fx(1,kk)>=Fx(1,kk-1) && Fx(1,kk)<(kesi+1)*Fx(1,kk-1)
        
        gama = 0.2;
        
        delW1{1,kk+1} = gama*delW1{1,kk} - (1-gama)*alpha*g1_total_W{1,kk};
        W1{1,kk+1} = delW1{1,kk+1}+W1{1,kk};
    
        delb1{1,kk+1} = gama*delb1{1,kk} - (1-gama)*alpha*g1_total_b{1,kk};
        b1{1,kk+1} = delb1{1,kk+1}+b1{1,kk};
    
        delW2{1,kk+1} = gama*delW2{1,kk} - (1-gama)*alpha*g2_total_W{1,kk};
        W2{1,kk+1} = delW2{1,kk+1}+W2{1,kk};
    
        delb2{1,kk+1} = gama*delb2{1,kk} - (1-gama)*alpha*g2_total_b{1,kk}; 
        b2{1,kk+1} = delb2{1,kk+1}+b2{1,kk};
        
    end
    
end

end
 %% The Value Of Final Weights and Biases
fprintf('The First Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W1(1,kk))
fprintf('The First Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b1(1,kk))
fprintf('The Second Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp(W2(1,kk))
fprintf('The Second Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(b2(1,kk))

 %% Plots Of Networks Output
  hold on
  plot(P,A2_Prime)
  legend('Main Function','1-2-1 Network','Location','northwest')