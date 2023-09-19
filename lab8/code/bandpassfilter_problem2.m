function Hd = bandpassfilter_problem2
%BANDPASSFILTER_PROBLEM2 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 11-Apr-2023 19:35:31

% Equiripple Bandpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 10000;  % Sampling Frequency

Fstop1 = 80;              % First Stopband Frequency
Fpass1 = 150;             % First Passband Frequency
Fpass2 = 900;             % Second Passband Frequency
Fstop2 = 970;             % Second Stopband Frequency
Dstop1 = 0.001;           % First Stopband Attenuation
Dpass  = 0.057501127785;  % Passband Ripple
Dstop2 = 0.001;          % Second Stopband Attenuation
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]