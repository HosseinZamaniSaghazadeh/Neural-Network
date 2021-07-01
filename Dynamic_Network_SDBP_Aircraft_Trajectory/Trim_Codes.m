%% Project#1_Advanced_Flight_Dynamics_Steady_State_Cruise_Flight_Trim_Condition

clc
clear all

%% Solving Trim equations

Xg = [0;0;2000;0;0;0];
X = fsolve(@TrimFunc,Xg);
%% Display Outputs

Alpha = X(1);             % Required angle of attack for trim condition (degree)
DeltaE = X(2)*57.3;            % Required elevator deflection for trim condition (degree)
Thrust = X(3);                  % Required thrust for trim condition (lbs)
Beta = X(4)*57.3;               % Required side slip angle for trim condition (degree)
DeltaA = X(5)*57.3;             % Required aileron deflection for trim condition (degree)
DeltaR = X(6)*57.3;             % Required rudder deflection for trim condition (degree)

fprintf('*** Steady State Cruise Flight Trim Condition *** \n\n')
fprintf('%%%%%% Longitudinal Trim Parameters %%%%%% \n')
S1 = ['Required angle of attack for trim condition is ',num2str(Alpha),' degree'];
S2 = ['Required elevator deflection for trim condition is ',num2str(DeltaE),' degree'];
S3 = ['Required thrust for trim condition is ',num2str(Thrust),' lbs'];
S4 = ['Required side slip angle for trim condition is ',num2str(Beta),' degree'];
S5 = ['Required aileron deflection for trim condition is ',num2str(DeltaA),' degree'];
S6 = ['Required Required rudder deflection for trim condition is ',num2str(DeltaR),' degree'];

disp(S1)
disp(S2)
disp(S3)

fprintf('\n%%%%%% Lateral-Directional Trim Parameters %%%%%% \n')
disp(S4)
disp(S5)
disp(S6)