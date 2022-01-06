%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: HybridNessterovHBF.m
%--------------------------------------------------------------------------
% Project: Uniting Nesterov's accelerated gradient descent globally with
% heavy ball locally. Nonstrongly convex version.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 09/29/2020 1:07:00

clear all

set(0,'defaultTextInterpreter','tex');

% global variables
global delta M gamma lambda c_0 c_10 r tauMin tauMax tauMed c zeta cTilde_0 cTilde_10 d_0 d_10 alpha sigma randomsInterp randomsIndex rho

%%%%%%%%%%%%%%%%%%%%%
%% setting parameters
%%%%%%%%%%%%%%%%%%%%%
setMinima();

% Nesterov constants
M = 2;
zeta = 2;
rho = 0;

% Heavy Ball constants
gamma = 2/3; % 
lambda = 200; % 40

% Uniting parameters for \mathcal{U}_0 and \mathcal{T}_{1,0}:
c_0 = 7000;  
c_10 = 6820;  

alpha = 1;

% eps_0 has to be bigger than eps_10
eps_0 = 10;
eps_10 = 5;

cTilde_0 = eps_0*alpha
cTilde_10 = eps_10*alpha
d_0 = c_0 - gamma*((cTilde_0^2)/alpha)
d_10 = c_10 - (cTilde_10/alpha)^2 - (1/(M*zeta^2))*((cTilde_10^2)/alpha)

tauMin = (1+sqrt(7))/2;
c = 0.5;
deltaMed = 3300; % 
r = 51; 

%%%%%%%%%%%%%%%%%%%%%
%% Initializing
%%%%%%%%%%%%%%%%%%%%%

% initial conditions
z1_0 = 50; 
z2_0 = 0;
z2_00 = 50;
q_0 = 1;
tau_0 = 0;
tauPN_0 = tauMin; 

tauMed = sqrt(((r^2)/(2*c) + (tauMin^2)*CalculateL(z1_0))/deltaMed) + tauMin
tauMax = tauMed + 1;

% Assign initial conditions to vector
x0 = [z1_0;z2_0;q_0;tau_0];
x00 = [z1_0;z2_00;tauPN_0];
x000 = [z1_0;z2_0;q_0];

% simulation horizon
TSPAN=[0 2000]; % 500
TSPAN1=[0 20];
JSPAN = [0 10];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the nominal system with first tuning of c_10 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tNom1,jNom1,xNom1] = HyEQsolver(@fU,@gU,@CU,@DU,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lNom1 = CalculateLVec(xNom1,tNom1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the nominal system with second tuning of c_10 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c_10 = 6819.68;  
d_10 = c_10 - (cTilde_10/alpha)^2 - (zeta^2/(M))*((cTilde_10^2)/alpha)

[tNom2,jNom2,xNom2] = HyEQsolver(@fU,@gU,@CU,@DU,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lNom2 = CalculateLVec(xNom2,tNom2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the nominal system with third tuning of c_10 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c_10 = 6819.676;  
d_10 = c_10 - (cTilde_10/alpha)^2 - (zeta^2/(M))*((cTilde_10^2)/alpha)

[tNom3,jNom3,xNom3] = HyEQsolver(@fU,@gU,@CU,@DU,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lNom3 = CalculateLVec(xNom3,tNom3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the nominal system with same c_10 as noisy solutions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c_10 = 6819.67593;  
d_10 = c_10 - (cTilde_10/alpha)^2 - (zeta^2/(M))*((cTilde_10^2)/alpha)

[tNom,jNom,xNom] = HyEQsolver(@fU,@gU,@CU,@DU,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lNom = CalculateLVec(xNom,tNom);

% Group together the nominal solutions, for plotting:
minarc = min([length(xNom1),length(xNom2),length(xNom3),length(xNom)]);
tNomA = [tNom(1:minarc),tNom3(1:minarc),tNom2(1:minarc),tNom1(1:minarc)];
jNomA = [jNom(1:minarc),jNom3(1:minarc),jNom2(1:minarc),jNom1(1:minarc)];
xNomA = [xNom(1:minarc,1),xNom3(1:minarc,1),xNom2(1:minarc,1),xNom1(1:minarc,1)];
xNomB = [xNom(1:minarc,2),xNom3(1:minarc,2),xNom2(1:minarc,2),xNom1(1:minarc,2)];
lNomA = [lNom(1:minarc).',lNom3(1:minarc).',lNom2(1:minarc).',lNom1(1:minarc).'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the perturbed system: sigma = 0.1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nomLen = 50*length(xNom); % 100*length(xNom);
sample = 0.01; % 0.01
   
randoms = randn(1,nomLen);
randInd = 1:nomLen;
randomsInterpIndex = 1:sample:nomLen;
randomsInterp = interp1(randInd,randoms,randomsInterpIndex);
randomsIndex = 1;
sigma = 0.1; %0.025

[ta,ja,xa] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lA = CalculateLVec(xa,ta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% simulate the perturbed system: sigma = 0.5 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randomsIndex = 1;
sigma = 0.5; % 0.05

[tb,jb,xb] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lB = CalculateLVec(xb,tb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the perturbed system: sigma = 1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randomsIndex = 1;
sigma = 1; % 0.075

[tc,jc,xc] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');
 
lC = CalculateLVec(xc,tc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the perturbed system: sigma = 0.01 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randomsIndex = 1;
sigma = 0.01; 

[td,jd,xd] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lD = CalculateLVec(xd,td);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the perturbed system: sigma = 0.05 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randomsIndex = 1;
sigma = 0.05; 
 
[te,je,xe] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lE = CalculateLVec(xe,te);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the perturbed system: sigma = 0.25 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randomsIndex = 1;
sigma = 0.25; 

[tf,jf,xf] = HyEQsolver(@fUNoise,@gU,@CUNoise,@DUNoise,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

lF = CalculateLVec(xf,tf);