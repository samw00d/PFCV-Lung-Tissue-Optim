% Sam Wood
% Fall2021
% PFCV
%% File used to find the optimal dissociation curve based on ETO2 and SpO2 experimental data
clear all
close all
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/SpO2.mat');

%% Processing Data
r_factor = 200;
sig_figs = 2;
SpO2_raw = decimate(SpO2_Data(2,:), r_factor);
ETO2_raw = round(decimate(ETO2mmHg_Data(2,:), r_factor), sig_figs);

% Giving each value of ETO2 the same number of SpO2 measurements
[ETO2, j, k] = unique(ETO2_raw);
SpO2 = accumarray(k, (1:numel(k))', [], @(x)mean(SpO2_raw(x)));
% hold on;
% plot(ETO2_raw, SpO2_raw)
% plot(ETO2, SpO2)

%% Plotting Spo2 and ETO2
% plot(ETO2, SpO2)
% xlabel('ETO_2 [mmHg]');
% ylabel('SpO_2 [%]');
% title('Data Dissociation Relationship');

%% Nonlinear Optimization
% Uncomment below to re-reun optimization
% theta0 = [1 1 1]; % arbitrary starting point
% 
% optim = @(x)dissociation_curve_for_optim(ETO2', SpO2, x);
% [x, err] = fmincon(optim, theta0, [], [], [], [], [1e-3 1 1],...
%     [1e7 1e10 1e10]);
% O2_diss_vals = x;
% 
% save('../utilities/data/optim_diss_params.mat', 'O2_diss_vals')

%% Testing Dissociation Curve
load('../utilities/data/optim_diss_params.mat');
% 1e-3 stays constant
% 1e3 for left shift, 1e4 for known, 1e5 for right shift

theta1 = [1e-3, 1e5, 100];
theta = O2_diss_vals;
test_PaO2 = 0:1:700;
test_SpO2_base = test_dissociation_curve(test_PaO2, theta);
test_SpO2 = test_dissociation_curve(test_PaO2, theta1);
known_SpO2 = known_relationship(test_PaO2);

figure
hold on
plot(ETO2, SpO2)
plot(test_PaO2, test_SpO2_base);
plot(test_PaO2, test_SpO2);
plot(test_PaO2, known_SpO2);
xlabel('PaO_2 [mmHg]');
ylabel('SpO_2 [%]');
title('Test O_2 Dissociation Curve');
legend('Data', 'Optimization', 'Test', 'Known')