%% Kohonen_Network
clear
clc

%% Network Parameters
P = {[-1;0] [0;1] [1/(sqrt(2));1/(sqrt(2))]};
w1 = [0;-1];
w2 = [(-2)/(sqrt(5));(-1)/(sqrt(5))];
w3 = [(-1)/(sqrt(5));(-2)/(sqrt(5))];
W = [w1';w2';w3'];
b1 = 0;
b2 = 0;
b3 = 0;
b = [b1;b2;b3];
alpha = 0.5;
k = 1;
%% Network Simulation
    for q = 1:15
        
        
        while q > size(P,2)
            q = 0+(q-size(P,2));
        end
        
        
        a = compet(W*P{:,q} + b);
        
        if a(1,1) == 1
            
           w1 = (1-alpha)*w1 + alpha*P{:,q};
           b1 = b1 - 0.2;
           w2 = w2;
           b2 = 0.9*b2;
           w3 = w3;
           b3 = 0.9*b3;
           
        end
        
        if a(2,1) == 1
           
           w1 = w1;
           b1 = 0.9*b1; 
           w2 = (1-alpha)*w2 + alpha*P{:,q};
           b2 = b2 - 0.2;
           w3 = w3;
           b3 = 0.9*b3;
           
        end
        
        if a(3,1) == 1
           
           w1 = w1;
           b1 = 0.9*b1; 
           w2 = w2;
           b2 = 0.9*b2;
           w3 = (1-alpha)*w3 + alpha*P{:,q};
           b3 = b3 - 0.2;
           
        end
        
         W = [w1';w2';w3'];
         b = [b1;b2;b3];
         A(:,k) = a;
         k = k+1;
         
         
    end

%% The Value Of Final Weights and Biases
 fprintf('The Number of Iterations is\n')
 disp(k-1)
 fprintf('The Weight Matrix Converges to\n')
 disp(W)
 fprintf('The Bias Vector Converges to\n')
 disp(b)
 fprintf('The Network Output is\n')
 disp(A)