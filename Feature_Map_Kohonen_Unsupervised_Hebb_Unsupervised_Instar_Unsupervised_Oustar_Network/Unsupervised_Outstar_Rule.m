%% Unsupervised_Outstar_Rule
clear
clc

%% Network Parameters
P0_train = {[1;1] [-1;1] [-1;-1] [-1;1] [1;-1] [1;1]};
P_train = {[1;0;0] [0;1;0] [0;0;1] [0;1;0] [0;0;1] [1;0;0]};
W0 = eye(2);
W = [0 0 0;0 0 0];
b = [-0.5;-0.5];
alpha = 0.6;
%% Network Simulation
    for q = 1:6
        
        while q > size(P_train,2)
            q = 0+(q-size(P_train,2));
        end
        
        if q == 1 || q == 6
            
        a_train{:,q} = hardlims(W*P_train{:,q} + W0*P0_train{:,q}+b);
        W(1:end,1) = W(1:end,1) + alpha*(a_train{:,q}-W(1:end,1))*P_train{:,q}(1,1);
        
        end
        
        if q == 2 || q == 4
            
        a_train{:,q} = hardlims(W*P_train{:,q} + W0*P0_train{:,q}+b);
        W(1:end,2) = W(1:end,2) + alpha*(a_train{:,q}-W(1:end,2))*P_train{:,q}(2,1);
        
        end
        
        if q == 3 || q == 5
            
        a_train{:,q} = hardlims(W*P_train{:,q} + W0*P0_train{:,q}+b);
        W(1:end,3) = W(1:end,3) + alpha*(a_train{:,q}-W(1:end,3))*P_train{:,q}(3,1);
        
        end
    end

%% The Value Of Final Weights and Biases
fprintf('The Unconditioned Weight Matrix Converges to\n')
disp(W)
fprintf('The Network Responce to Test Set is\n')
disp(a_train)

%% Testing The Network
P0_test = [0;0];
P_test = [0;0;1];
a_test = hardlims(W*P_test + W0*P0_test+b);

if a_test == [1;1]
    fprintf('The Network Recogonize The President And Lifting Him to 4th Floor\n')
end

if a_test == [-1;1]
    fprintf('The Network Recogonize The Vise-President And Lifting Him to 3rd Floor\n')
end

if a_test == [-1;-1]
    fprintf('The Network Recogonize The Chairman And Lifting Him to 1st or 2nd Floor\n')
end