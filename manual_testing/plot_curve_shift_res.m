% Sam Wood
% Fall2021
% PFCV
%% Plotting different curve shapes to see influence on model
close all
clear PaO2_vals
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_diss_params.mat');

%% Parameters for Plotting
theta_opt = O2_diss_vals;

r_factor = 200;
sig_figs = 2;
SpO2_raw = decimate(SpO2_Data(2,:), r_factor);
ETO2_raw = round(decimate(ETO2mmHg_Data(2,:), r_factor), sig_figs);

% Giving each value of ETO2 the same number of SpO2 measurements
[ETO2, j, k] = unique(ETO2_raw);
SpO2 = accumarray(k, (1:numel(k))', [], @(x)mean(SpO2_raw(x)));

theta_vals = [0, 1e2, 100;
              0, 1e3, 100;
              0, 1e4, 100;
              0, 1e5, 100];
          
tau_vals = [0 1e2 1e3 1e4 1e5];

%% Plotting curve shifting
i = 1;
for theta = theta_vals'
    clear out
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/curve_optimization_model.slx', [], options);
    
    tau_a = 1e4;
    
%     test_PaO2 = 0:1:700;
%     test_SpO2_base = test_dissociation_curve(test_PaO2, theta_opt);
%     test_SpO2 = test_dissociation_curve(test_PaO2, theta);
%     known_SpO2 = known_relationship(test_PaO2);
%     
%     % Dissociation Curve
%     figure;
%     subplot(2, 1, 1)
%     hold on
%     plot(ETO2, SpO2)
%     plot(test_PaO2, test_SpO2_base);
%     plot(test_PaO2, test_SpO2);
%     plot(test_PaO2, known_SpO2);
%     xlabel('PaO_2 [mmHg]');
%     ylabel('SpO_2 [%]');
%     title('O_2 Dissociation Curve');
%     legend('Data', 'Optimization', 'Test', 'Known')
%     
%     % Model Output
%     subplot(2, 1, 2)
%     hold on
%     plot(out.tout, out.PaO2.Data)
%     plot(time, ETO2_output);
%     title('PaO_2 and ETO_2')
%     xlabel('Time [ms]')
%     ylabel('Partial Pressure O_2 [mmHg]')
%     legend('PaO2 model', 'ETO2 exp')
    
    PaO2_vals(i, :) = out.PaO2.Data;
    i = i + 1;
end

% tau_vals = [1e4 1e5];
% 
% %% Plotting tau changes shifting
% i = 1;
% for tau_a = tau_vals
%     clear out
%     options = simset('SrcWorkspace','current');
%     out = sim('../utilities/models/curve_optimization_model.slx', [], options);
%     PaO2_vals(i, :) = out.PaO2.Data;
%     i = i + 1;
% end

figure
hold on
plot(ETO2_raw)
title('Change in PaO_2 Output Given Different Curves');
xlabel('Time [ms]');
ylabel('PaO_2 [mmHg]');
legend('ETO2')
for PaO2 = PaO2_vals'
    plot(PaO2)
end   
    