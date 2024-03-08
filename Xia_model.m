%   exemplary data

%heights and widths in meters
R = 800;
d = 20;
w = 10;
h_buildings = 12;
h_tower = 15;
h_remote = 1.5;
f = 1800;   %frequency in MHz

%----------------

wavelength = 299792458 / f * 1000;
delta_h = h_buildings - h_remote;   %distance between remote and roofs
x = w / 2;   %assume that remote is in the middle between buildings

%   Total attenuation
%   L = L_fs + L_rts + L_md

L_fs = -10 * log10((wavelength / (4*pi*R))^2);

theta = cot(delta_h / x);
r = sqrt(delta_h*delta_h + x*x);
L_rts = -10 * log10((wavelength / 2*pi*pi*r) * ((1/theta) - (1/(2*pi + theta)))^2);

%...
L_md = 0;

ans = L_fs + L_rts