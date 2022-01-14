% Sam Wood
% Fall2021
% PFCV
%% Initializing variables for the Simulink model
close all
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');

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
% minV = movmean(minV, m_factor);
% plot(time, minV);
% title('Minute Ventilation Input Data')
% xlabel('Time [ms]');
% ylabel('Minute Ventilation [m^3/s]');
% figure
minV_input = [time' minV'];

PiO2 = decimate(FiO2mmHg_Data(2,first:last), r_factor);
% plot(time, PiO2);
% title('PiO_2 Input Data')
% xlabel('Time [ms]');
% ylabel('PiO_2 [mmHg]');
PiO2_input = [time' PiO2'];

ETO2_output = decimate(ETO2mmHg_Data(2,first:last), r_factor);
% figure
% plot(time, ETO2_output);
% title('ETO_2 Output Data')
% xlabel('Time [ms]');
% ylabel('ETO_2 [mmHg]');
% figure
% hold on
% plot(time, ETO2_output);
% plot(time, PiO2);
% title('ETO_2 Output Data and PiO_2 Input Data')
% xlabel('Time [ms]');
% ylabel('Partial Pressure [mmHg]');
% legend('ETO_2', 'PiO_2')

% O2 Parameters
tau_a = 19.8; %[s]
tau_v = 33.6; %[s]
Vl = 2.5; %[L]
Vl = Vl/1000; %[m^3]
Vt = 6; %[L]
Vt = Vt/1000; %[m^3]
SV = 0.1/1000; %[m^3]
Q = 100/60*SV; %[m^3/s] assuming 100 bpm
lambda = 863; %[]
Pa = 760; % [mmHg]
Pw = 47; % [mmHg]
MRO2 = 0.0045/1000; %[1/s] in BTPS
MRO2 = (Pa - Pw)/lambda*MRO2; %[1/s] in STP

% Initial Values
Pai = 300; % [mmHg]
Cvi = 0.2; % []





