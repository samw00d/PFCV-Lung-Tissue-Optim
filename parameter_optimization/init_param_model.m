% Sam Wood
% Fall2021
% PFCV
%% Initializing variables for the Simulink model
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_curve_results.mat');
curve = theta;
clear theta

%% Input Data
r_factor = 200;
time = FiO2mmHg_Data(1,:);
first = 1;
last = length(time);
time = decimate(time(first:last), r_factor);
t_end = time(end);
Ts = 0.01*r_factor;

SpO2 = decimate(SpO2_Data(2,first:last), r_factor);

m_factor = 200;
minV = decimate(MinV_Data(2,first:last), r_factor); %[L/min]
minV = minV/60000; % [m^3/s]
minV = movmean(minV, m_factor);
minV_input = [time' minV'];

PiO2 = decimate(FiO2mmHg_Data(2,first:last), r_factor);
PiO2_input = [time' PiO2'];

ETO2_output = decimate(ETO2mmHg_Data(2,first:last), r_factor);

% O2 Parameters
tau_a = curve(4); %[s]
tau_v = curve(5); %[s]
Vl = 2.5; %[L]
Vl = Vl/1000; %[m^3]
Vt = 6; %[L]
Vt = Vt/1000; %[m^3]
SV = 0.1/1000; %[m^3]
Q = 100/60*SV; %[m^3/s] assuming 100 bpm
MRO2 = 0.0045/1000; %[m^3/s]
lambda = 863; %[]
Pa = 760; % [mmHg]
Pw = 47; % [mmHg]
MRO2 = (Pa - Pw)/lambda*MRO2;

% Initial Values
Pai = 300; % [mmHg]
Cvi = 0.2; % []
