% function for calculating memristor registance return value registance and
% present state and argument voltage , pulse width and present weight
function [Rm,X] = get_memristor_registance(v,dt,x0)

% author Mrinmoy Sarkar

%%%% model parameters
a1 = 0.17;
a2 = 0.17;
b = 0.05;
vp = .16;
vn = 0.15;
Ap = 4000;
An = 4000;
xp = 0.3;
xn = 0.5;
alphap = 1;
alphan = 5;
%x0 = 0.11;
eta = 1;


%freq = 2e6; num_of_cycles = 20; amp = 5; points=40000; tspan=[0
%num_of_cycles/freq]; t = linspace(tspan(1),tspan(2),points); dt = t(2) -
%t(1); v = amp*sin(freq*2*pi*t);

%dt = 1e-6; v=[50e-3 -5 -5 -4 -4 -5 -5 -4 -4 -5 -3 50e-3 50e-3 50e-3 50e-3
%50e-3 50e-3]; t=[0:dt:16*dt];

Vxsv = x0;

V = v;
%%%%  multiplicative functions to ensure zero state variable motion at
%%%%  memristor boundaries
Wp = (xp - Vxsv)/(1 - xp) + 1;
Wn = Vxsv/(1 - xn);
%%%% Describes the device threshold
if V <= vp && V >= -vn
    Gv = 0;
elseif V > vp
    Gv = Ap * (exp(V) - exp(vp));
else
    Gv = -An * (exp(-V) - exp(vn));
end
%%%% Describes the sv motion
if eta*V >= 0 && Vxsv >= xp
    Fv = exp(-alphap * (Vxsv - xp)) * Wp;
    
elseif eta*V < 0 && Vxsv <= (1 - xn)
    Fv = exp(alphan * (Vxsv + xn - 1)) * Wn;
else
    Fv = 1;
end
%%% hyperbolic sine due to MIM structure
if V >= 0
    IVrel = a1*Vxsv*sinh(b*V);
else
    IVrel = a2* Vxsv*sinh(b*V);
end
%%%% calculation of current source's current value
Igx = eta*Fv*Gv;
Igm = IVrel;
%%%% calculation of state variable value
Vxsv = Vxsv + Igx * dt;

%return value
X = Vxsv;
Rm = V/Igm;

end