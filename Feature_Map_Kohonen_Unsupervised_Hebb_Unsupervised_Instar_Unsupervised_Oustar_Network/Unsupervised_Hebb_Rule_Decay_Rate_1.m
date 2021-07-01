%% Unsupervised_Hebb_Rule
clc

%% Network Parameters
P0_train = 0;
P_train = 0;
P0_test = 0;
P_test = 1;
W0 = 1;
W = 1;
b = -0.8;
alpha = 0.3;
gamma = 0.1;
a_test = hardlim(W*P_test + W0*P0_test+b);
a_train = hardlim(W*P_train + W0*P0_train+b);
q = 1;
a_test(:,q) = a_test;
a_train(:,q) = a_train;
P0_train(:,q) = P0_train;
P_train(:,q) = P_train;
P0_test(:,q) = P0_test;
P_test(:,q) = P_test;
W(:,q) = W;
iter(:,q)=q;
%% Network Simulation
if a_test ~= 0
    
    while a_test(:,q) == 1
        
        P_train(:,q+1) = P_train(:,q);
        P0_train(:,q+1) = P0_train(:,q);
        P_test(:,q+1) = P_test(:,q);
        P0_test(:,q+1) = P0_test(:,q);
        
        a_train(:,q+1) = hardlim(W(:,q)*P_train(:,q+1) + W0*P0_train(:,q+1)+b);
        W(:,q+1) = (1-gamma)*W(:,q) + alpha*a_train(:,q+1);
        a_test(:,q+1) = hardlim(W(:,q+1)*P_test(:,q+1) + W0*P0_test(:,q+1)+b);
        
        q = q+1;
        iter(:,q)=q;
        
        
    end
    
    
end

%% The Value Of Final Weights and Biases
fprintf('The Unconditioned Weight Matrix Converges to\n')
disp(W(:,q))
fprintf('The Network Responce to Test Set is\n')
disp(a_test)
fprintf('The Number of Iterations is\n')
disp(iter(:,q-1))

 %% Plots Of Networks Output
  plot(iter,W)
  title('Unsupervised Hebb Rule With Decay Rate, Weight Variation Until Network Not Responds')
  xlabel('Iterations')
  ylabel('Unconditioned Weight')