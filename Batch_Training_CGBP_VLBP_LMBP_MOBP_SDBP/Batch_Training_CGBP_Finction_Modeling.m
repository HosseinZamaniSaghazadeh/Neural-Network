%% Batch_Training_CGBP_Finction_Modeling
clear
clc

%% Main Function Plot
x = -2:0.1:2;
y = 1 + sin((pi/2).*x);
plot(x,y)
xlabel('x and P')
ylabel('sin(x)')
title('Function Approximation Batch Training CGBP Method')

%% Network 1-2-1
P = [-2:0.1:2]';
W1 = -0.5 + (0.5+0.5)*rand(2,1);
b1 = -0.5 + (0.5+0.5)*rand(2,1);
W2 = -0.5 + (0.5+0.5)*rand(1,2);
b2 = -0.5 + (0.5+0.5)*rand(1,1);
epsilon = 0.001;
tol = 0.01;

X0 = [W1(1,1);W1(2,1);b1(1,1);b1(2,1);W2(1,1);W2(1,2);b2];
X = X0;
t = (1 + sin((pi/2).*P))';
taw = 0.618;

for kk = 1:4200
    
for ii = 1:size(P,1)
    
    n1 = [X(1,1);X(2,1)] * P(ii,1) + [X(3,1);X(4,1)];
    a1 = logsig(n1);
    n2 = [X(5,1) X(6,1)] * a1 + X(7,1);
    a2 = purelin(n2);
    e(1,ii) = t(1,ii)-a2;
    Fdot2 = 1;
    s2 = -2 * Fdot2 * e(1,ii);
    Fdot1 = zeros(size(n1,1),size(n1,1));
    
    for jj = 1:2
        
        Fdot1(jj,jj) = (1-a1(jj,1)) * a1(jj,1);
        
    end
    
    s1 = Fdot1 * ([X(5,1) X(6,1)])' * s2;
    
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

if kk==1
    
    g0 = [g1_total_W(1,1);g1_total_W(2,1);g1_total_b(1,1);g1_total_b(2,1);g2_total_W(1,1);g2_total_W(1,2);g2_total_b];
    p0 = -g0;
    
    Fprimex(1,1) = Fx(1,kk);
    for jj = 1:40
        
        Xprime = X0;
        Xprime = Xprime + jj*epsilon*p0;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fprimex(1,jj+1) = e*(e)';
    end
    
    for ll = 1:(size(Fprimex,2)-2)
        
        if Fprimex(1,ll)>Fprimex(1,ll+1) && Fprimex(1,ll+2)>Fprimex(1,ll+1)
            u = ll;
            break;
        end
    end
    
    a = u*epsilon;
    b = (u+2)*epsilon;
    c = a + (1-taw)*(b-a);
    d = b - (1-taw)*(b-a);
    while (b-a)>tol
        
        Xprime = X0;
        Xprime = Xprime + c*p0;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fc = e*(e)';
        
        Xprime = X0;
        Xprime = Xprime + d*p0;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fd = e*(e)';
        
        if Fc < Fd
            
            a = a;
            b = d;
            d = c;
            c = a + (1-taw)*(b-a);
        else
            
            a = c;
            b = b;
            c = d;
            d = b - (1-taw)*(b-a);
            
        end
        
    end
    
    alpha = b;
    
    X = X0;
    X = X+alpha*p0;
    p = p0;
    g_previous = g0'*g0;
end





if kk>=2
    
    g = [g1_total_W(1,1);g1_total_W(2,1);g1_total_b(1,1);g1_total_b(2,1);g2_total_W(1,1);g2_total_W(1,2);g2_total_b];
    if kk<=7
        
        beta = (g'*g)/(g_previous);
        p = -g + beta*p;
        
    else
        p = -g;
    end
    
    Fprimex(1,1) = Fx(1,kk);
    for jj = 1:40
        
        Xprime = X;
        Xprime = Xprime + jj*epsilon*p;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fprimex(1,jj+1) = e*(e)';
    end
    
    for ll = 1:(size(Fprimex,2)-2)
        
        if Fprimex(1,ll)>Fprimex(1,ll+1) && Fprimex(1,ll+2)>Fprimex(1,ll+1)
            u = ll;
            break;
        end
    end
    
    a = u*epsilon;
    b = (u+2)*epsilon;
    c = a + (1-taw)*(b-a);
    d = b - (1-taw)*(b-a);
    while (b-a)>tol
        
        Xprime = X;
        Xprime = Xprime + c*p;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fc = e*(e)';
        
        Xprime = X;
        Xprime = Xprime + d*p;
        for ii = 1:size(P,1)
            
            n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
            a1 = logsig(n1);
            n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
            a2 = purelin(n2);
            e(1,ii) = t(1,ii)-a2;
            
        end
        
        Fd = e*(e)';
        
        if Fc < Fd
            
            a = a;
            b = d;
            d = c;
            c = a + (1-taw)*(b-a);
        else
            
            a = c;
            b = b;
            c = d;
            d = b - (1-taw)*(b-a);
            
        end
        
    end
    
    alpha = b;
    X = X + alpha*p;
    g_previous = g'*g;
end



 
end

 %% The Value Of Final Weights and Biases
fprintf('The First Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp([X(1,1);X(2,1)])
fprintf('The First Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp([X(3,1);X(4,1)])
fprintf('The Second Layer Weight Matrix Of 1-2-1 Network Converges to\n')
disp([X(5,1) X(6,1)])
fprintf('The Second Layer Bias Matrix Of 1-2-1 Network Converges to\n')
disp(X(7,1))

 %% Plots Of Networks Output
  hold on
  plot(P,A2_Prime)
  legend('Main Function','1-2-1 Network','Location','northwest')