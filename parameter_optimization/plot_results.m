% Sam Wood
% Fall2021
% PFCV
%% Plotting results of the optimized model
close all
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_diss_params.mat');

init_curve_model
%% Plotting time delayed curve shifting
load('optim_results.mat');
tau_a = theta(4);
tau_v = theta(5);

options = simset('SrcWorkspace','current');
out = sim('../utilities/models/curve_optimization_model.slx', [], options);

figure
hold on
plot(PiO2_input(:,1), PiO2_input(:,2), '.')
plot(time, ETO2_output)
plot(out.PaO2.Time, out.PaO2.Data)
t = sprintf('Optimized PaO_2 Curve Model Output');
title(t);
xlabel('Time [ms]');
ylabel('PaO_2 [mmHg]');
legend('PiO_2 Input', 'Known ETO_2', 'Optimized Diss. Curve');