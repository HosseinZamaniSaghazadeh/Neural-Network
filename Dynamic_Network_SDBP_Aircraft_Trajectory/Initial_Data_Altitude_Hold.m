%% Advanced_Flight_Dynamics_Project_Phase#1_Initial_and_Constant_Datas

%% Geometry and Flight Condition Inputs   

S = 280;                          % ft^2
Ro = 0.0013;                      % lbs/ft^2
b = 46;                           % ft
c = 6.5;                          % ft
g = 32.17;                        % ft/s^2
mass = 341.9;                     % Slugs
Ixx = 15189;                      % Slug.ft^2
Ixz = 4371;                       % Slug.ft^2
Izz = 34141;                      % Slug.ft^2
Iyy = 20250;                      % Slug.ft^2
%% Thrust Coefficients

CTxu = -0.0596;
T1 = 1055.4173;                   % lbs
CTy = 0;
CTz = 0;
ClT = 0;
CmTu = 0;
CmT1 = 0;
CmTalpha = 0;
CnTbeta = 0;
%% Aerodynamic Coefficient
CDu = 0;
CD0 = 0.0270;
CDalpha = 0.131;
CDalphadot = 0;
CDq = 0;
CDdelE = 0;
CDiH = 0;
Cybeta = -0.59;
Cybetadot = 0;
Cyp = -0.19;
Cyr = 0.39;
CydelA = 0;
CydelR = 0.144;
CLu = 0.020;
CL0 = 0.201;
CLalpha = 5.48;
CLiH = 1.35;
CLalphadot = 2.5;
CLq = 8.1;
CLdelE = 0.60;
Clbeta = -0.13;
Clbetadot = 0;
Clp = -0.50;
Clr = 0.14;
CldelA = 0.156;
CldelR = 0.0106;
Cmu = 0;
Cm0 = 0.05;
Cmalpha = -1.89;
Cmalphadot = -9.1;
Cmq = -34.0;
CmdelE = -2.0;
cmiH = -4.1;
Cnbeta = 0.080;
Cnbetadot = 0;
Cnp = 0.019;
Cnr = -0.197;
CndelA = -0.0012;
CndelR = -0.0758;




%% Cpontrol Surfaces Parameters
delE =0.0077075;     %rad ; 
delA = 0;
delR = 0;
iH = 0;

%% PSD
%sigma=5*3.28084;
%L=580*3.28084;
%U0=450;
%Kgg=sqrt(3*sigma*sigma*U0/(L*pi));
%beta1=U0/(sqrt(3)*L);
%landa1=U0/L;

%% Pilot in Loop (Banck angle & Pitch angle)
Kp =1;                              % Pilot gain
taw =0.1;                             % Pilot delay
TL =0.4;                                % Lead
TI =0.2;                                % Lag
TN =0.1;                                % Pilot strength parameter
LdelA =17.1510;                           
Lp =-2.81;

%% Pilot transfer function
syms s

exp1 = expand(Kp*(2-taw*s)*(TL*s+1));
exp2 = expand((2+taw*s)*(TI*s+1)*(TN*s+1));
display(exp1)
display(exp2)
