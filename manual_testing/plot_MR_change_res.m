% Sam Wood
% Fall2021
% PFCV
%% Plotting different metabolic rates to see influence on model
close all
clear PaO2_vals
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_diss_params.mat');

init_curve_model;
%% Parameters for Plotting
theta = [0, 5.4e4, 100];

r_factor = 200;
sig_figs = 2;
ETO2_raw = round(decimate(ETO2mmHg_Data(2,:), r_factor), sig_figs);
time = decimate(ETO2mmHg_Data(1,:), r_factor);


MRO2_vals = [4.5e-6 4.5e-7 9e-6];
lambda = 863; %[]
Pa = 760; % [mmHg]
Pw = 47; % [mmHg]
MRO2_vals = (Pa - Pw)/lambda*MRO2_vals; 
%% Plotting time delayed curve shifting
i = 1;
for MRO2 = MRO2_vals
    clear out
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/curve_optimization_model.slx', [], options);
    PaO2_vals{i} = {out.PaO2.Time, out.PaO2.Data};
    i = i + 1;
end 

figure
hold on
plot(time, ETO2_raw, '.r')
t = sprintf('Change in PaO_2 Output Given MRO_2');
title(t);
xlabel('Time [ms]');
ylabel('PaO_2 [mmHg]');
for k = 1:length(PaO2_vals)
    PaO2_time = PaO2_vals{k}{1};
    PaO2 = PaO2_vals{k}{2};
    plot(PaO2_time, PaO2)
end
l1 = sprintf('MRO_2 = %d', MRO2_vals(1));
l2 = sprintf('MRO_2 = %d', MRO2_vals(2));
l3 = sprintf('MRO_2 = %d', MRO2_vals(3));
% l4 = sprintf('MRO_2 = %d', MRO2_vals(4));

legend('ETO2', l1, l2, l3);