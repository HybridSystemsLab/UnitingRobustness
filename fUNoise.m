function xdot = fUNoise(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: fU.m
%--------------------------------------------------------------------------
% Project: Uniting Nesterov's accelerated gradient descent globally with
% heavy ball locally.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 09/29/2020 1:07:00
   
% The global variables
global lambda gamma M zeta sigma randomsInterp randomsIndex rho

% state
z1 = x(1);
z2 = x(2);
q = x(3);
tau = x(4);

if(randomsIndex < length(randomsInterp))
    rho = sigma*randomsInterp(randomsIndex);
else
    randomsIndex = 1;
    rho = sigma*randomsInterp(randomsIndex);
end

randomsIndex = randomsIndex + 1;

if (q == 0) 
    u = - lambda*z2 - gamma*(GradientL(z1) + rho); 
elseif (q == 1)
    dBar = 3/(2*(tau + 2));
    betaBar = (tau - 1)/(tau + 2);
    u = - 2*dBar*z2 - (zeta^2/(M))*(GradientL(z1 + betaBar*z2) + rho); 
end

xdot = [z2;u;0;q]; 
end