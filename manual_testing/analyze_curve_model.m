% Sam Wood
% Fall2021
% PFCV
%% File used to plot various curves after running the model
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');

%% Input Data
r_factor = 200; % make sure same as init file
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

%% Plotting
% hold on
% plot(out.PiO2.Time, out.PiO2.Data)
% plot(time, FiO2_input)
% legend('From model', 'Into model')

figure
hold on
plot(out.tout, out.PaO2.Data)
plot(time, ETO2_output);
title('PaO_2 and ETO_2 Baseline')
xlabel('Time [s]')
ylabel('Partial Pressure O_2 [mmHg]')
legend('PaO2 model', 'ETO2 exp')

% figure
% PaO2 = out.PvO2.Data;
% SaO2_est = 100*((23400*((PaO2).^3 + 150*PaO2).^(-1)) + 1).^(-1);
% hold on;
% plot(time, SpO2);
% plot(out.tout, SaO2_est);
% 
% figure;
% PaO2 = 1:1:150;
% CaO2 = dissociation_curve(PaO2);
% plot(PaO2, CaO2)

% figure
% hold on
% plot(time, SpO2)
% plot(out.tout, out.PvO2.Data)
% legend('SpO2', 'PvO2')