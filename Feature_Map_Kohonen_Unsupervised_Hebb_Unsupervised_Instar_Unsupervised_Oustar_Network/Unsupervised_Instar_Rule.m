%% Unsupervised_Instar_Rule
clear
clc

%% Network Parameters
P0_train = [1 0 1 0 1 0];
P_train = {[0.174;0.985] [-0.174;0.985] [0.174;0.985] [-0.174;0.985] [0.174;0.985] [-0.174;0.985]};
W0 = 1;
W = [0;0];
b = -0.5;
alpha = 0.6;
%% Network Simulation
    for q = 1:6
        
        while q > size(P_train,2)
            q = 0+(q-size(P_train,2));
        end
        
        a_train(:,q) = hardlim(W'*P_train{:,q} + W0*P0_train(:,q)+b);
        W(2,1) = W(2,1) + alpha*a_train(:,q)*(P_train{:,q}(2,1)-W(2,1));
        
    end

%% The Value Of Final Weights and Biases
fprintf('The Unconditioned Weight Matrix Converges to\n')
disp(W)
fprintf('The Network Responce to Test Set is\n')
disp(a_train)