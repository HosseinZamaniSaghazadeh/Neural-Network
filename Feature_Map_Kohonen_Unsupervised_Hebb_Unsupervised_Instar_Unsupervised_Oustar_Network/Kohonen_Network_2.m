%% Kohonen_Network
clear
clc

%% Network Parameters
for kk = 1:200
    
    P{1,kk} = [0 + (1-0)*rand(1,1);2 + (3-2)*rand(1,1)];
    
end

for jj = 1:16
    
    W(jj,1) = -1 + (1+1)*rand(1,1);
    W(jj,2) = -1 + (1+1)*rand(1,1);
    
end

alpha = 0.01;
f = 1;
%% Network Simulation
    for q = 1:8000
        
        
        while q > size(P,2)
            q = 0+(q-size(P,2));
        end
        
        for ll = 1:16
            
            n(ll,1) = norm(W(ll,1:end)'-P{:,q});
            
        end
        
        a = compet(n);
        m = find(a);
        mprime = m(1,1); % The number of lowest nonzero index of vector a
        
        W(mprime,1) = (1-alpha)*W(mprime,1) + alpha*P{:,q}(1,1);
        W(mprime,2) = (1-alpha)*W(mprime,2) + alpha*P{:,q}(2,1);
        
        for ii = 1:16
            
            W(ii,1) = W(ii,1);
            W(ii,2) = W(ii,2);
            
        end
          
        f = f+1;
        W1(:,f-1) = [W(1,1);W(1,2)];
        W2(:,f-1) = [W(2,1);W(2,2)];
        W3(:,f-1) = [W(3,1);W(3,2)];
        W4(:,f-1) = [W(4,1);W(4,2)];
        W5(:,f-1) = [W(5,1);W(5,2)];
        W6(:,f-1) = [W(6,1);W(6,2)];
        W7(:,f-1) = [W(7,1);W(7,2)];
        W8(:,f-1) = [W(8,1);W(8,2)];
        W9(:,f-1) = [W(9,1);W(9,2)];
        W10(:,f-1) = [W(10,1);W(10,2)];
        W11(:,f-1) = [W(11,1);W(11,2)];
        W12(:,f-1) = [W(12,1);W(12,2)];
        W13(:,f-1) = [W(13,1);W(13,2)];
        W14(:,f-1) = [W(14,1);W(14,2)];
        W15(:,f-1) = [W(15,1);W(15,2)];
        W16(:,f-1) = [W(16,1);W(16,2)];
        g(1,f-1)=f;
    end
    
%% Plots 
figure
subplot(2,1,1);plot(g(1,1:end),W1(1,1:end));
title('W1 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W11')
subplot(2,1,2);plot(g(1,1:end),W1(2,1:end));
xlabel('Number of Iterations')
ylabel('W12')

figure
subplot(2,1,1);plot(g(1,1:end),W2(1,1:end));
title('W2 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W21')
subplot(2,1,2);plot(g(1,1:end),W2(2,1:end));
xlabel('Number of Iterations')
ylabel('W22')

figure
subplot(2,1,1);plot(g(1,1:end),W3(1,1:end));
title('W3 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W31')
subplot(2,1,2);plot(g(1,1:end),W3(2,1:end));
xlabel('Number of Iterations')
ylabel('W32')

figure
subplot(2,1,1);plot(g(1,1:end),W4(1,1:end));
title('W4 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W41')
subplot(2,1,2);plot(g(1,1:end),W4(2,1:end));
xlabel('Number of Iterations')
ylabel('W42')

figure
subplot(2,1,1);plot(g(1,1:end),W5(1,1:end));
title('W5 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W51')
subplot(2,1,2);plot(g(1,1:end),W5(2,1:end));
xlabel('Number of Iterations')
ylabel('W52')

figure
subplot(2,1,1);plot(g(1,1:end),W6(1,1:end));
title('W6 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W61')
subplot(2,1,2);plot(g(1,1:end),W6(2,1:end));
xlabel('Number of Iterations')
ylabel('W62')

figure
subplot(2,1,1);plot(g(1,1:end),W7(1,1:end));
title('W7 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W71')
subplot(2,1,2);plot(g(1,1:end),W7(2,1:end));
xlabel('Number of Iterations')
ylabel('W72')

figure
subplot(2,1,1);plot(g(1,1:end),W8(1,1:end));
title('W8 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W81')
subplot(2,1,2);plot(g(1,1:end),W8(2,1:end));
xlabel('Number of Iterations')
ylabel('W82')

figure
subplot(2,1,1);plot(g(1,1:end),W9(1,1:end));
title('W9 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W91')
subplot(2,1,2);plot(g(1,1:end),W9(2,1:end));
xlabel('Number of Iterations')
ylabel('W92')

figure
subplot(2,1,1);plot(g(1,1:end),W10(1,1:end));
title('W10 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W101')
subplot(2,1,2);plot(g(1,1:end),W10(2,1:end));
xlabel('Number of Iterations')
ylabel('W102')

figure
subplot(2,1,1);plot(g(1,1:end),W11(1,1:end));
title('W11 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W111')
subplot(2,1,2);plot(g(1,1:end),W11(2,1:end));
xlabel('Number of Iterations')
ylabel('W112')

figure
subplot(2,1,1);plot(g(1,1:end),W12(1,1:end));
title('W12 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W121')
subplot(2,1,2);plot(g(1,1:end),W12(2,1:end));
xlabel('Number of Iterations')
ylabel('W122')

figure
subplot(2,1,1);plot(g(1,1:end),W13(1,1:end));
title('W13 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W131')
subplot(2,1,2);plot(g(1,1:end),W13(2,1:end));
xlabel('Number of Iterations')
ylabel('W132')

figure
subplot(2,1,1);plot(g(1,1:end),W14(1,1:end));
title('W14 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W141')
subplot(2,1,2);plot(g(1,1:end),W14(2,1:end));
xlabel('Number of Iterations')
ylabel('W142')

figure
subplot(2,1,1);plot(g(1,1:end),W15(1,1:end));
title('W15 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W151')
subplot(2,1,2);plot(g(1,1:end),W15(2,1:end));
xlabel('Number of Iterations')
ylabel('W152')

figure
subplot(2,1,1);plot(g(1,1:end),W16(1,1:end));
title('W16 Variation Through Training')
xlabel('Number of Iterations')
ylabel('W161')
subplot(2,1,2);plot(g(1,1:end),W16(2,1:end));
xlabel('Number of Iterations')
ylabel('W162')    