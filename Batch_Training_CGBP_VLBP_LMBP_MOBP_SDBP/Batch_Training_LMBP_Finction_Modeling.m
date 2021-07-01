%% Batch_Training_LMBP_Finction_Modeling
clear
clc

%% Main Function Plot
x = -2:0.1:2;
y = 1 + sin((pi/2).*x);
plot(x,y)
xlabel('x and P')
ylabel('sin(x)')
title('Function Approximation Batch Training LMBP Method')

%% Network 1-2-1
P = [-2:0.1:2]';
W1 = -0.5 + (0.5+0.5)*rand(2,1);
b1 = -0.5 + (0.5+0.5)*rand(2,1);
W2 = -0.5 + (0.5+0.5)*rand(1,2);
b2 = -0.5 + (0.5+0.5)*rand(1,1);
miu = 0.01;
theta = 10;

s1 = {};
s2 = {};
A0 = {};
A1 = {};
X0 = [W1(1,1);W1(2,1);b1(1,1);b1(2,1);W2(1,1);W2(1,2);b2];
X = X0;

t = (1 + sin((pi/2).*P))';
for kk = 1:41
    
for ii = 1:size(P,1)
    
    n1 = [X(1,1);X(2,1)] * P(ii,1) + [X(3,1);X(4,1)];
    a1 = logsig(n1);
    n2 = [X(5,1) X(6,1)] * a1 + X(7,1);
    a2 = purelin(n2);
    e(1,ii) = t(1,ii)-a2;
    Fdot2 = 1;
    s2{1,ii} = -Fdot2;
    Fdot1 = zeros(size(n1,1),size(n1,1));
    
    for jj = 1:2
        
        Fdot1(jj,jj) = (1-a1(jj,1)) * a1(jj,1);
        
    end
    
    s1{1,ii} = Fdot1 * ([X(5,1) X(6,1)])' * s2{1,ii};
    
    A0{1,ii} = [P(ii,1);1;1];
    A1{1,ii} = [a1(1,1);a1(2,1);1];
    
    
    J(ii,1) = s1{1,ii}(1,1)*A0{1,ii}(1,1);
    J(ii,2) = s1{1,ii}(2,1)*A0{1,ii}(1,1);
    J(ii,3) = s1{1,ii}(1,1)*A0{1,ii}(2,1);
    J(ii,4) = s1{1,ii}(2,1)*A0{1,ii}(3,1);
    J(ii,5) = s2{1,ii}(1,1)*A1{1,ii}(1,1);
    J(ii,6) = s2{1,ii}(1,1)*A1{1,ii}(2,1);
    J(ii,7) = s2{1,ii}(1,1)*A1{1,ii}(3,1);
    
    A2_Prime(1,ii) = a2;
    
    
end
v = e';
Fx(1,kk) = e*(e)';



Xprime = X;
delXprime = -inv((J'*J + miu*eye(size(J,2))))*J'*v;
Xprime = delXprime + Xprime;

for ii = 1:size(P,1)
    
    n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
    a1 = logsig(n1);
    n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
    a2 = purelin(n2);
    eprime(1,ii) = t(1,ii)-a2;
end

Fprimex(1,kk) = eprime*(eprime)';


while Fprimex(1,kk)>Fx(1,kk)

    miu = theta*miu;
    Xprime = X;
    delXprime = -inv((J'*J + miu*eye(size(J,2))))*J'*v;
    Xprime = delXprime + Xprime;
    for ii = 1:size(P,1)
    
    n1 = [Xprime(1,1);Xprime(2,1)] * P(ii,1) + [Xprime(3,1);Xprime(4,1)];
    a1 = logsig(n1);
    n2 = [Xprime(5,1) Xprime(6,1)] * a1 + Xprime(7,1);
    a2 = purelin(n2);
    eprime(1,ii) = t(1,ii)-a2;
    end

Fprimex(1,kk) = eprime*(eprime)';
    
end

X = Xprime;
miu = miu/theta;
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