clear all;

global param_D param_chi param_S0 param_a ic

param_D = 116.0;
param_chi = 1.0;
param_S0 = 1.0 * 10e4;
param_a = 2.0 * 10e2;
ic = 1.0 * 10^6;

T = 25000;
X = 2000;

m = 0;

x = linspace(0, X, X + 1);
t = linspace(0, T, T/10 + 1);

sol = pdepe(m, @pde_func, @pde_ic, @pde_bc, x, t);

% Extract the first solution component as u.  This is not necessary
% for a single equation, but makes a point about the form of the output.
u = sol(:,:,1);

figure;
hLine = imagesc(t, x, u');
set(gca, 'FontSize', 30);
xlabel('$t$', 'Interpreter', 'latex');
set(gca, 'FontSize', 30);
ylabel('$r$', 'Interpreter', 'latex');
colormap hot;
h = colorbar;
set(gca, 'FontSize', 30);
title(h, '$n$', 'FontSize', 33, 'interpreter','latex');
set(gca,'YDir','normal');
hold all;

figure;
plot(x, u(end,:))
set(gca, 'FontSize', 30);
xlabel('$r$', 'Interpreter', 'latex');
set(gca, 'FontSize', 30);
ylabel('$n$', 'Interpreter', 'latex');
% --------------------------------------------------------------------------

function [c,f,s] = pde_func(x, t, u, DuDx)
global param_D param_chi param_S0 param_a
c = 1;
f = param_D * DuDx + u * param_chi * param_S0 / ((x + param_a) * (x + param_a));
s = 0;
end

% --------------------------------------------------------------------------

function u0 = pde_ic(x)
global ic
u0 = ic;
end

% --------------------------------------------------------------------------

function [pl,ql,pr,qr] = pde_bc(xl, ul, xr, ur, t)
pl = ul;
ql = 1;
pr = ur;
qr = 1;
end


