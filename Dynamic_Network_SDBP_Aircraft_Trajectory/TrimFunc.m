%% Steady_State_Cruise_Flight_Trim_Condition 

function T=TrimFunc(X)
%% Geometry and Flight Condition Inputs

W = 11000;              % Weight (lbs)
S = 280;                % Refernce area (ft^2)
c = 6.5;                % MAC (ft)
b = 46;                 % Wing span (ft)
q1 = 128.2;             % Dynamic pressure (lbs/ft^2)
zt = 0;                 % Vertical distance of engines to aircraft CG
Gama1 = 0;              % Path angle
Phi1 = 0;               % Bank angle
%% Longitudinal Inputs

CD0 = 0.0270;
CDalpha = 0.131;
CDdelE = 0;             % CD delta elevator
CDiH = 0;
CL0 = 0.201;
CLalpha = 5.48;
CLdelE = 0.6;           % CL delta elevator
CLiH = 1.35;
Cm0 = 0.05;
Cmalpha = -1.89;
CmdelE = -2;            % Cm delta elevator
CmiH = -4.1;
iH = 0;
thetaT = 0;
%% Lateral-Directional Inputs

CYbeta = -0.59;
CYdelA = 0;             % CY delta aileron
CYdelR = 0.144;         % CY delta rudder
Clbeta = -0.13; 
CLdelA = 0.156;         % Cl delta aileron
CldelR = 0.0106;        % Cl delta rudder
Cnbeta = 0.08;          
CndelA = -0.0012;       % Cn delta aileron
CndelR = -0.0758;       % Cn delta rudder
FTY1 = 0;               % Lateral force due to thrust
LT1 = 0;                % Roll moment due to thrust
NT1 = 0;                % Yaw moment due to thrust
%% Main Function
%% Longitudinal Trim Equations

Alpha_Tr = X(1);        % Required attack angle for trim condition
DeE_Tr = X(2);          % Required elevator deflection for trim dondition
Thr_Tr = X(3);          % Required thrust for trim condition

T(1) = W*sin(Gama1)+q1*S*(CD0+CDalpha*Alpha_Tr+CDdelE*DeE_Tr+CDiH*iH)-Thr_Tr*cos(thetaT+Alpha_Tr);
T(2) = W*cos(Gama1)-q1*S*(CL0+CLalpha*Alpha_Tr+CLdelE*DeE_Tr+CLiH*iH)-Thr_Tr*sin(thetaT+Alpha_Tr);
T(3) = q1*S*c*(Cm0+Cmalpha*Alpha_Tr+CmdelE*DeE_Tr+CmiH*iH)-Thr_Tr*zt;
%% Lateral-Diroctiona Trim Equations

Beta_Tr = X(4);         % Required side slip angle for trim condition
DeA_Tr = X(5);          % Required aileron deflection for trim dondition
DeR_Tr = X(6);          % Required rudder deflection for trim condition

T(4) = -W*cos(Gama1)*sin(Phi1)-q1*S*(CYbeta*Beta_Tr+CYdelA*DeA_Tr+CYdelR*DeR_Tr)-FTY1;
T(5) = 0-q1*S*b*(Clbeta*Beta_Tr+CLdelA*DeA_Tr+CldelR*DeR_Tr)-LT1;
T(6) = 0-q1*S*b*(Cnbeta*Beta_Tr+CndelA*DeA_Tr+CndelR*DeR_Tr)-NT1;
end

