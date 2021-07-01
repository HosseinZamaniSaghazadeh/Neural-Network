clear
clc 
%% Variables
p1 = [1;-1;-1;1;1;1;1;1;-1;-1;1;-1;-1;-1;-1;-1;-1;-1;-1;-1]; % ??? ?
p2 = [-1;1;1;1;-1;-1;-1;1;1;1;1;1;1;-1;1;-1;1;1;1;1];% ??? ???
p3 = [1;1;1;1;-1;-1;-1;1;-1;-1;-1;1;-1;-1;-1;1;1;1;1;1];% ??? ???
p = [1;-1;-1;1;1;1;1;1;-1;-1;1;-1;-1;-1;-1;-1;-1;-1;-1;-1];
w1 = [transpose(p1);transpose(p2);transpose(p3)];
R = 20;
b1 = [R;R;R];
e = 0.4;
w2 = [1 -e -e; -e 1 -e; -e -e 1];
%% Network Design
n1 = w1*p+b1;
a1 = purelin(n1);
for t = 1:1:10
    
a2 = poslin(w2*a1);
a1 = a2;

end
display(a2);
if a2(1,1)~= 0 
    disp('It is Be')
elseif a2(2,1)~= 0 
    disp('It is Gim')
elseif a2(3,1)~= 0
    disp('It is Dal')
end
