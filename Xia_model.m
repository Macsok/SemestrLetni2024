clc;
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

%   Total attenuation
%   L = L_fs + L_rts + L_md

L_fs = -10 * log10((wavelength / (4*pi*R))^2);

x = w / 2;   %assume that remote is in the middle between buildings
theta = cot(delta_h / x);
r = sqrt(delta_h*delta_h + x*x);
L_rts = -10 * log10((wavelength / 2*pi*pi*r) * ((1/theta) - (1/(2*pi + theta)))^2);

%...
screens = 10;  %diffraction screens
g = (h_tower - h_buildings) * (1 / sqrt(wavelength * d));
L_md = -10 * log10( calc_Q(screens, g, 10)^2 );

answer = L_fs + L_rts + L_md

function value = calc_I(M, q)
    value = 0;
    if q == 0
        value = 1 / (M^(2/3));

    elseif q == 1
        for n = 0:(M-1)
            value = value + (1 / ((n^(2/3)) * ((M - n)^(2/3))));
        end
        value = value * (1/(4*sqrt(pi)));

    else
        for n = 1:(M-2)
            value = value + (calc_I(n, q-1) / sqrt(M - 1 - n));
        end
        value = value * (1/(2*sqrt(pi)*M));
        value = ((M - 1)*(q - 1)/(2*M)) * calc_I(M-1, q-1) + value;
    end
end

function value = calc_Q(M, g, sub_infty)
    value = 0;
    for q = 0:sub_infty
        value = value + (1 / factorial(q)) * ( (2*g*sqrt(j*pi))^q ) * calc_I(M-1, q);
    end
    value = sqrt(M) * value;
end