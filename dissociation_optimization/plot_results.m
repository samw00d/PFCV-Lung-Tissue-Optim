close all
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');

init_curve_model
%% Plotting time delayed curve shifting
load('../utilities/data/optim_curve_results.mat');
tau_a = theta(4);
tau_v = theta(5);
theta = [0, 5.4e4, 100];

options = simset('SrcWorkspace','current');
out = sim('../utilities/models/curve_optimization_model.slx', [], options);

figure
hold on
plot(PiO2_input(:,1), PiO2_input(:,2), '.')
plot(time, ETO2_output, '.r')
plot(out.PaO2.Time, out.PaO2.Data)
t = sprintf('Optimized PaO_2 Curve Model Output');
title(t);
xlabel('Time [ms]');
ylabel('PaO_2 [mmHg]');
legend('PiO_2 Input', 'Known ETO_2', 'Optimized Diss. Curve');