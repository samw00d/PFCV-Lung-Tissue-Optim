% Sam Wood
% Fall2021
% PFCV
%% Plotting different lung volumes to see influence on model
close all
clear PaO2_vals
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_diss_params.mat');

init_curve_model
%% Parameters for Plotting
theta = [0, 1e4, 100];

r_factor = 200;
sig_figs = 2;
ETO2_raw = round(decimate(ETO2mmHg_Data(2,:), r_factor), sig_figs);
time = decimate(ETO2mmHg_Data(1,:), r_factor);


Vl_vals = [2.5e-3 1e-3 2.5e-4 1e-4 5e-2];
%% Plotting time delayed curve shifting
i = 1;
for Vl = Vl_vals
    clear out
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/curve_optimization_model.slx', [], options);
    PaO2_vals{i} = {out.PaO2.Time, out.PaO2.Data};
    i = i + 1;
end 

figure
hold on
plot(time, ETO2_raw)
t = sprintf('Change in PaO_2 Output Given Vl');
title(t);
xlabel('Time [ms]');
ylabel('PaO_2 [mmHg]');
for k = 1:length(PaO2_vals)
    PaO2_time = PaO2_vals{k}{1};
    PaO2 = PaO2_vals{k}{2};
    plot(PaO2_time, PaO2)
end
l1 = sprintf('Vl = %d', Vl_vals(1));
l2 = sprintf('Vl = %d', Vl_vals(2));
l3 = sprintf('Vl = %d', Vl_vals(3));
l4 = sprintf('Vl = %d', Vl_vals(4));
l5 = sprintf('Vl = %d', Vl_vals(5));
legend('ETO2', l1, l2, l3, l4, l5);