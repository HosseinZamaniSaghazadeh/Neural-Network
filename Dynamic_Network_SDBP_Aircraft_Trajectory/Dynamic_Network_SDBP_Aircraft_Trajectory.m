%% Dynamic_Network_SDBP_Aircraft_Trajectory
clear
clc

%% Simulation Parameters
filename1 = 'XInertia.xlsx'; 
XInertia = xlsread(filename1); % Simulation results for X Inertia
i=1;
for n = 1:1000:size(XInertia,1)
   
    XInertiap(i,1) = XInertia(n,1);
    i=i+1;
end
XInertiap = XInertiap./10000;

filename2 = 'YInertia.xlsx';
YInertia = xlsread(filename2); % Simulation results for Y Inertia
i=1;
for n = 1:1000:size(YInertia,1)
   
    YInertiap(i,1) = YInertia(n,1);
    i=i+1;
end
YInertiap = YInertiap./10000;

filename3 = 'ZInertia.xlsx'; 
ZInertia = xlsread(filename3); % Simulation results for Z Inertia
i=1;
for n = 1:1000:size(ZInertia,1)
   
    ZInertiap(i,1) = ZInertia(n,1);
    i=i+1;
end
ZInertiap = ZInertiap./10000;


filename4 = 'XdotInertia.xlsx';
XdotInertia = xlsread(filename4); % Simulation results for X velocity
i=1;
for n = 1:1000:size(XdotInertia,1)
   
    XdotInertiap(i,1) = XdotInertia(n,1);
    i=i+1;
end
XdotInertiap = XdotInertiap./100;

filename5 = 'YdotInertia.xlsx';
YdotInertia = xlsread(filename5); % Simulation results for Y velocity
i=1;
for n = 1:1000:size(YdotInertia,1)
   
    YdotInertiap(i,1) = YdotInertia(n,1);
    i=i+1;
end
YotInertiap = YdotInertiap./10000;

filename6 = 'ZdotInertia.xlsx';
ZdotInertia = xlsread(filename6); % Simulation results for Z velocity
i=1;
for n = 1:1000:size(ZdotInertia,1)
   
    ZdotInertiap(i,1) = ZdotInertia(n,1);
    i=i+1;
end
ZdotInertiap = ZdotInertiap./10;

for ff = 1:1:215
    
Time(ff,1) = ff;

end

LW12 = -1 + (1+1)*rand(10,1); %10*1
C1LW12 = LW12(:,1); % To generate vector model of matrix LW12
LW21 = -1 + (1+1)*rand(1,10); %1*10
C1LW21 = LW21(:,1); C2LW21 = LW21(:,2); C3LW21 = LW21(:,3); C4LW21 = LW21(:,4); C5LW21 = LW21(:,5); C6LW21 = LW21(:,6); C7LW21 = LW21(:,7); C8LW21 = LW21(:,8); C9LW21 = LW21(:,9); C10LW21 = LW21(:,10); % To generate vector model of matrix LW21
b1 = -1 + (1+1)*rand(10,1);
b2 = -1 + (1+1)*rand(1,1);
Xz = [C1LW12;b1;C1LW21;C2LW21;C3LW21;C4LW21;C5LW21;C6LW21;C7LW21;C8LW21;C9LW21;C10LW21;b2]; %;C5LW21;C6LW21;C7LW21;C8LW21;C9LW21;C10LW21
alpha = 0.01;

%% Training 1-10-1 Network X
for ii = 1:1:200
    
targetx(:,ii) = (XInertiap(ii+1,1)-XInertiap(ii,1))/10;

end
ttargetx = targetx';

Xx = [C1LW12;b1;C1LW21;C2LW21;C3LW21;C4LW21;C5LW21;C6LW21;C7LW21;C8LW21;C9LW21;C10LW21;b2];


for kk = 1:2000
    
    gtotalx = zeros(31,1);
    a20x = XInertiap(215,1)-XInertiap(1,1);
for ii = 1:150
    
    if ii == 1
        
        n1x = Xx(1:10,1)*a20x + Xx(11:20,1);
        a1x(:,1) = logsig(n1x);
        n2x = [Xx(21,1) Xx(22,1) Xx(23,1) Xx(24,1) Xx(25,1) Xx(26,1) Xx(27,1) Xx(28,1) Xx(29,1) Xx(30,1)]*a1x(:,1) + Xx(31,1);
        a2x(:,1) = purelin(n2x);
        ex(:,1) = targetx(1,1)-(a2x(:,1)-a20x)/10;
        
        Fdot2x = eye(size(n2x,1));
%         for jj = 1:1
%             
%             Fdot2(jj,jj) = (1-(a2(jj,1)))*(a2(jj,1));
%             
%         end
        S22x = Fdot2x;
        
        Fdot1x = zeros(size(n1x,1),size(n1x,1));
        for jj = 1:10
            
            Fdot1x(jj,jj) = (1-(a1x(jj,1)))*(a1x(jj,1));
            
        end
        S21x = S22x*[Xx(21,1) Xx(22,1) Xx(23,1) Xx(24,1) Xx(25,1) Xx(26,1) Xx(27,1) Xx(28,1) Xx(29,1) Xx(30,1)]*Fdot1x;
        
        a2eLW12x = kron((XInertiap(1,1))',S21x);
        a2eb1x = S21x;
        a2eLW21x = kron((a1x(:,1))',S22x);
        a2eb2x = S22x;
        a2eXx = [a2eLW12x a2eb1x a2eLW21x a2eb2x];
        a2Xx(1,:) = a2eXx;
        gx = (a2Xx(1,:))'*(-2*ex(:,1));
        gtotal1x = gx;
    end
        
    if ii>=2
        
    n1x = Xx(1:10,1)*(ZInertiap(215,1)-a2x(:,ii-1)) + Xx(11:20,1);
    a1x(:,ii) = logsig(n1x);
    n2x = [Xx(21,1) Xx(22,1) Xx(23,1) Xx(24,1) Xx(25,1) Xx(26,1) Xx(27,1) Xx(28,1) Xx(29,1) Xx(30,1)]*a1x(:,ii) + Xx(31,1);
    a2x(:,ii) = purelin(n2x);
    ex(:,ii) = targetx(:,ii)-(a2x(:,ii)-a2x(ii-1))/10;
    
    Fdot2x = eye(size(n2x,1));
%      for jj = 1:1
%              
%           Fdot2(jj,jj) = (1-(a2(jj,ii)))*(a2(jj,ii));
%              
%      end
    S22x = Fdot2x;
        
    Fdot1x = zeros(size(n1x,1),size(n1x,1));
    for jj = 1:10
            
         Fdot1x(jj,jj) = (1-(a1x(jj,ii)))*(a1x(jj,ii));
            
    end
    S21x = S22x*[Xx(21,1) Xx(22,1) Xx(23,1) Xx(24,1) Xx(25,1) Xx(26,1) Xx(27,1) Xx(28,1) Xx(29,1) Xx(30,1)]*Fdot1x;
        
    a2eLW12x = kron((a2x(:,ii-1))',S21x);
    a2eb1x = S21x;
    a2eLW21x = kron((a1x(:,ii))',S22x);
    a2eb2x = S22x;
    a2eXx = [a2eLW12x a2eb1x a2eLW21x a2eb2x];
    a2Xx(ii,:) = a2eXx + S21x*Xx(1:10,1)*a2Xx(ii-1,:);
    gx = (a2Xx(ii,:))'*(-2*ex(:,ii));
    gtotalx = gtotalx + gx;
        
    end
    
end
 gtotalx = gtotalx + gtotal1x;
 Xx = Xx - alpha*gtotalx;
 
 aprimex(:,1) = (a2x(:,1)-a20x)/10;
 for ii = 2:1:150
    
 aprimex(:,ii) = (a2x(:,ii)-a2x(ii-1))/10;

 end
 atprimex = aprimex';
 
end

%% Training 1-10-1 Network Xdot
for ii = 1:1:200
    
targetxdot(:,ii) = (XdotInertiap(ii+1,1)-XdotInertiap(ii,1))/10;

end
ttargetxdot = targetxdot';

Xxdot = [C1LW12;b1;C1LW21;C2LW21;C3LW21;C4LW21;C5LW21;C6LW21;C7LW21;C8LW21;C9LW21;C10LW21;b2];


for kk = 1:2000
    
    gtotalxdot = zeros(31,1);
    a20xdot = XdotInertiap(215,1)-XdotInertiap(1,1);
for ii = 1:150
    
    if ii == 1
        
        n1xdot = Xxdot(1:10,1)*a20xdot + Xxdot(11:20,1);
        a1xdot(:,1) = logsig(n1xdot);
        n2xdot = [Xxdot(21,1) Xxdot(22,1) Xxdot(23,1) Xxdot(24,1) Xxdot(25,1) Xxdot(26,1) Xxdot(27,1) Xxdot(28,1) Xxdot(29,1) Xxdot(30,1)]*a1xdot(:,1) + Xxdot(31,1);
        a2xdot(:,1) = purelin(n2xdot);
        exdot(:,1) = targetxdot(1,1)-(a2xdot(:,1)-a20xdot)/10;
        
        Fdot2xdot = eye(size(n2xdot,1));
%         for jj = 1:1
%             
%             Fdot2(jj,jj) = (1-(a2(jj,1)))*(a2(jj,1));
%             
%         end
        S22xdot = Fdot2xdot;
        
        Fdot1xdot = zeros(size(n1xdot,1),size(n1xdot,1));
        for jj = 1:10
            
            Fdot1xdot(jj,jj) = (1-(a1xdot(jj,1)))*(a1xdot(jj,1));
            
        end
        S21xdot = S22xdot*[Xxdot(21,1) Xxdot(22,1) Xxdot(23,1) Xxdot(24,1) Xxdot(25,1) Xxdot(26,1) Xxdot(27,1) Xxdot(28,1) Xxdot(29,1) Xxdot(30,1)]*Fdot1xdot;
        
        a2eLW12xdot = kron((XdotInertiap(1,1))',S21xdot);
        a2eb1xdot = S21xdot;
        a2eLW21xdot = kron((a1xdot(:,1))',S22xdot);
        a2eb2xdot = S22xdot;
        a2eXxdot = [a2eLW12xdot a2eb1xdot a2eLW21xdot a2eb2xdot];
        a2Xxdot(1,:) = a2eXxdot; 
        gxdot = (a2Xxdot(1,:))'*(-2*exdot(:,1));
        gtotal1xdot = gxdot;
    end
        
    if ii>=2
        
    n1xdot = Xxdot(1:10,1)*(ZInertiap(215,1)-a2xdot(:,ii-1)) + Xxdot(11:20,1);
    a1xdot(:,ii) = logsig(n1xdot);
    n2xdot = [Xxdot(21,1) Xxdot(22,1) Xxdot(23,1) Xxdot(24,1) Xxdot(25,1) Xxdot(26,1) Xxdot(27,1) Xxdot(28,1) Xxdot(29,1) Xxdot(30,1)]*a1xdot(:,ii) + Xxdot(31,1);
    a2xdot(:,ii) = purelin(n2xdot);
    exdot(:,ii) = targetxdot(:,ii)-(a2xdot(:,ii)-a2xdot(ii-1))/10;
    
    Fdot2xdot = eye(size(n2xdot,1));
%      for jj = 1:1
%              
%           Fdot2(jj,jj) = (1-(a2(jj,ii)))*(a2(jj,ii));
%              
%      end
    S22xdot = Fdot2xdot;
        
    Fdot1xdot = zeros(size(n1xdot,1),size(n1xdot,1));
    for jj = 1:10
            
         Fdot1xdot(jj,jj) = (1-(a1xdot(jj,ii)))*(a1xdot(jj,ii));
            
    end
    S21xdot = S22xdot*[Xxdot(21,1) Xxdot(22,1) Xxdot(23,1) Xxdot(24,1) Xxdot(25,1) Xxdot(26,1) Xxdot(27,1) Xxdot(28,1) Xxdot(29,1) Xxdot(30,1)]*Fdot1xdot;
        
    a2eLW12xdot = kron((a2xdot(:,ii-1))',S21xdot);
    a2eb1xdot = S21xdot;
    a2eLW21xdot = kron((a1xdot(:,ii))',S22xdot);
    a2eb2xdot = S22xdot;
    a2eXxdot = [a2eLW12xdot a2eb1xdot a2eLW21xdot a2eb2xdot];
    a2Xxdot(ii,:) = a2eXxdot + S21xdot*Xxdot(1:10,1)*a2Xxdot(ii-1,:);
    gxdot = (a2Xxdot(ii,:))'*(-2*exdot(:,ii));
    gtotalxdot = gtotalxdot + gxdot;
        
    end
    
end
 gtotalxdot = gtotalxdot + gtotal1xdot;
 Xxdot = Xxdot - alpha*gtotalxdot;
 
 aprimexdot(:,1) = (a2xdot(:,1)-a20xdot)/10;
 for ii = 2:1:150
    
 aprimexdot(:,ii) = (a2xdot(:,ii)-a2xdot(ii-1))/10;

 end
 atprimexdot = aprimexdot';
 
end

%% Training 1-10-1 Network Z
for ii = 1:1:200
    
targetz(:,ii) = (ZInertiap(ii+1,1)-ZInertiap(ii,1))/10;

end
ttargetz = targetz';

for kk = 1:2000
    
    gtotalz = zeros(31,1);
    a20z = ZInertiap(215,1)-ZInertiap(1,1);
for ii = 1:150
    
    if ii == 1
        
        n1z = Xz(1:10,1)*a20z + Xz(11:20,1);
        a1z(:,1) = logsig(n1z);
        n2z = [Xz(21,1) Xz(22,1) Xz(23,1) Xz(24,1) Xz(25,1) Xz(26,1) Xz(27,1) Xz(28,1) Xz(29,1) Xz(30,1)]*a1z(:,1) + Xz(31,1);
        a2z(:,1) = purelin(n2z);
        ez(:,1) = targetz(1,1)-(a2z(:,1)-a20z)/10;
        
        Fdot2z = eye(size(n2z,1));
%         for jj = 1:1
%             
%             Fdot2(jj,jj) = (1-(a2(jj,1)))*(a2(jj,1));
%             
%         end
        S22z = Fdot2z;
        
        Fdot1z = zeros(size(n1z,1),size(n1z,1));
        for jj = 1:10
            
            Fdot1z(jj,jj) = (1-(a1z(jj,1)))*(a1z(jj,1));
            
        end
        S21z = S22z*[Xz(21,1) Xz(22,1) Xz(23,1) Xz(24,1) Xz(25,1) Xz(26,1) Xz(27,1) Xz(28,1) Xz(29,1) Xz(30,1)]*Fdot1z;
        
        a2eLW12z = kron((ZInertiap(1,1))',S21z);
        a2eb1z = S21z;
        a2eLW21z = kron((a1z(:,1))',S22z);
        a2eb2z = S22z;
        a2eXz = [a2eLW12z a2eb1z a2eLW21z a2eb2z];
        a2Xz(1,:) = a2eXz;
        gz = (a2Xz(1,:))'*(-2*ez(:,1));
        gtotal1z = gz;
    end
        
    if ii>=2
        
    n1z = Xz(1:10,1)*(ZInertiap(215,1)-a2z(:,ii-1)) + Xz(11:20,1);
    a1z(:,ii) = logsig(n1z);
    n2z = [Xz(21,1) Xz(22,1) Xz(23,1) Xz(24,1) Xz(25,1) Xz(26,1) Xz(27,1) Xz(28,1) Xz(29,1) Xz(30,1)]*a1z(:,ii) + Xz(31,1);
    a2z(:,ii) = purelin(n2z);
    ez(:,ii) = targetz(:,ii)-(a2z(:,ii)-a2z(ii-1))/10;
    
    Fdot2z = eye(size(n2z,1));
%      for jj = 1:1
%              
%           Fdot2(jj,jj) = (1-(a2(jj,ii)))*(a2(jj,ii));
%              
%      end
    S22z = Fdot2z;
        
    Fdot1z = zeros(size(n1z,1),size(n1z,1));
    for jj = 1:10
            
         Fdot1z(jj,jj) = (1-(a1z(jj,ii)))*(a1z(jj,ii));
            
    end
    S21z = S22z*[Xz(21,1) Xz(22,1) Xz(23,1) Xz(24,1) Xz(25,1) Xz(26,1) Xz(27,1) Xz(28,1) Xz(29,1) Xz(30,1)]*Fdot1z;
        
    a2eLW12z = kron((a2z(:,ii-1))',S21z);
    a2eb1z = S21z;
    a2eLW21z = kron((a1z(:,ii))',S22z);
    a2eb2z = S22z;
    a2eXz = [a2eLW12z a2eb1z a2eLW21z a2eb2z];
    a2Xz(ii,:) = a2eXz + S21z*Xz(1:10,1)*a2Xz(ii-1,:);
    gz = (a2Xz(ii,:))'*(-2*ez(:,ii));
    gtotalz = gtotalz + gz;
        
    end
    
end
 gtotalz = gtotalz + gtotal1z;
 Xz = Xz - alpha*gtotalz;
 
 aprimez(:,1) = (a2z(:,1)-a20z)/10;
 for ii = 2:1:150
    
 aprimez(:,ii) = (a2z(:,ii)-a2z(ii-1))/10;

 end
 atprimez = aprimez';
end

%% Training 1-10-1 Network Zdot
for ii = 1:1:200
    
targetzdot(:,ii) = (ZdotInertiap(ii+1,1)-ZdotInertiap(ii,1))/10;

end
ttargetzdot = targetzdot';

Xzdot = [C1LW12;b1;C1LW21;C2LW21;C3LW21;C4LW21;C5LW21;C6LW21;C7LW21;C8LW21;C9LW21;C10LW21;b2];


for kk = 1:2000
    
    gtotalzdot = zeros(31,1);
    a20zdot = ZdotInertiap(215,1)-ZdotInertiap(1,1);
for ii = 1:150
    
    if ii == 1
        
        n1zdot = Xzdot(1:10,1)*a20zdot + Xzdot(11:20,1);
        a1zdot(:,1) = logsig(n1zdot);
        n2zdot = [Xzdot(21,1) Xzdot(22,1) Xzdot(23,1) Xzdot(24,1) Xzdot(25,1) Xzdot(26,1) Xzdot(27,1) Xzdot(28,1) Xzdot(29,1) Xzdot(30,1)]*a1zdot(:,1) + Xzdot(31,1);
        a2zdot(:,1) = purelin(n2zdot);
        ezdot(:,1) = targetzdot(1,1)-(a2zdot(:,1)-a20zdot)/10;
        
        Fdot2zdot = eye(size(n2zdot,1));
%         for jj = 1:1
%             
%             Fdot2(jj,jj) = (1-(a2(jj,1)))*(a2(jj,1));
%             
%         end
        S22zdot = Fdot2zdot;
        
        Fdot1zdot = zeros(size(n1zdot,1),size(n1zdot,1));
        for jj = 1:10
            
            Fdot1zdot(jj,jj) = (1-(a1zdot(jj,1)))*(a1zdot(jj,1));
            
        end
        S21zdot = S22zdot*[Xzdot(21,1) Xzdot(22,1) Xzdot(23,1) Xzdot(24,1) Xzdot(25,1) Xzdot(26,1) Xzdot(27,1) Xzdot(28,1) Xzdot(29,1) Xzdot(30,1)]*Fdot1zdot;
        
        a2eLW12zdot = kron((ZdotInertiap(1,1))',S21zdot);
        a2eb1zdot = S21zdot;
        a2eLW21zdot = kron((a1zdot(:,1))',S22zdot);
        a2eb2zdot = S22zdot;
        a2eXzdot = [a2eLW12zdot a2eb1zdot a2eLW21zdot a2eb2zdot];
        a2Xzdot(1,:) = a2eXzdot;
        gzdot = (a2Xzdot(1,:))'*(-2*ezdot(:,1));
        gtotal1zdot = gzdot;
    end
        
    if ii>=2
        
    n1zdot = Xzdot(1:10,1)*(ZInertiap(215,1)-a2zdot(:,ii-1)) + Xzdot(11:20,1);
    a1zdot(:,ii) = logsig(n1zdot);
    n2zdot = [Xzdot(21,1) Xzdot(22,1) Xzdot(23,1) Xzdot(24,1) Xzdot(25,1) Xzdot(26,1) Xzdot(27,1) Xzdot(28,1) Xzdot(29,1) Xzdot(30,1)]*a1zdot(:,ii) + Xzdot(31,1);
    a2zdot(:,ii) = purelin(n2zdot);
    ezdot(:,ii) = targetzdot(:,ii)-(a2zdot(:,ii)-a2zdot(ii-1))/10;
    
    Fdot2zdot = eye(size(n2zdot,1));
%      for jj = 1:1
%              
%           Fdot2(jj,jj) = (1-(a2(jj,ii)))*(a2(jj,ii));
%              
%      end
    S22zdot = Fdot2zdot;
        
    Fdot1zdot = zeros(size(n1zdot,1),size(n1zdot,1));
    for jj = 1:10
            
         Fdot1zdot(jj,jj) = (1-(a1zdot(jj,ii)))*(a1zdot(jj,ii));
            
    end
    S21zdot = S22zdot*[Xzdot(21,1) Xzdot(22,1) Xzdot(23,1) Xzdot(24,1) Xzdot(25,1) Xzdot(26,1) Xzdot(27,1) Xzdot(28,1) Xzdot(29,1) Xzdot(30,1)]*Fdot1zdot;
        
    a2eLW12zdot = kron((a2zdot(:,ii-1))',S21zdot);
    a2eb1zdot = S21zdot;
    a2eLW21zdot = kron((a1zdot(:,ii))',S22zdot);
    a2eb2zdot = S22zdot;
    a2eXzdot = [a2eLW12zdot a2eb1zdot a2eLW21zdot a2eb2zdot];
    a2Xzdot(ii,:) = a2eXzdot + S21zdot*Xzdot(1:10,1)*a2Xzdot(ii-1,:);
    gzdot = (a2Xzdot(ii,:))'*(-2*ezdot(:,ii));
    gtotalzdot = gtotalzdot + gzdot;
        
    end
    
end
 gtotalzdot = gtotalzdot + gtotal1zdot;
 Xzdot = Xzdot - alpha*gtotalzdot;
 
 aprimezdot(:,1) = (a2zdot(:,1)-a20zdot)/10;
 for ii = 2:1:150
    
 aprimezdot(:,ii) = (a2zdot(:,ii)-a2zdot(ii-1))/10;

 end
 atprimezdot = aprimezdot';
 
end

%% Plots
figure;
subplot(4,1,1);plot(Time(1:150,1),ttargetx(1:150,1),'g',Time(1:150,1),atprimex(1:150,1),'r')
xlabel('Time (s)')
ylabel('X (ft)')
title('X Variation Due To Time')
legend('Delta X Simulation','Delta X Network Output')

subplot(4,1,2);plot(Time(1:150,1),ttargetxdot(1:150,1),'g',Time(1:150,1),atprimexdot(1:150,1),'r')
xlabel('Time (s)')
ylabel('Xdot (ft/s)')
title('Xdot Variation Due To Time')
legend('Delta Xdot Simulation','Delta Xdot Network Output')

subplot(4,1,3);plot(Time(1:150,1),ttargetz(1:150,1),'g',Time(1:150,1),atprimez(1:150,1),'r')
xlabel('Time (s)')
ylabel('Z (ft)')
title('Z Variation Due To Time')
legend('Delta Z Simulation','Delta Z Network Output')

subplot(4,1,4);plot(Time(1:150,1),ttargetzdot(1:150,1),'g',Time(1:150,1),atprimezdot(1:150,1),'r')
xlabel('Time (s)')
ylabel('Zdot (ft/s)')
title('Zdot Variation Due To Time')
legend('Delta Zdot Simulation','Delta Zdot Network Output')