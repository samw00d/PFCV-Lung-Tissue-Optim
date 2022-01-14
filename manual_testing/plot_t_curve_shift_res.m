% Sam Wood
% Fall2021
% PFCV
%% Plotting combinations of time delays and dissociation curve shapes to see influence on model
close all
clear PaO2_vals
%% Loading in Data
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_curve_results.mat');

init_curve_model
%% Parameters for Plotting
theta_opt = O2_diss_vals;

r_factor = 200;
sig_figs = 2;
SpO2_raw = decimate(SpO2_Data(2,:), r_factor);
ETO2_raw = round(decimate(ETO2mmHg_Data(2,:), r_factor), sig_figs);
time = decimate(ETO2mmHg_Data(1,:), r_factor);

% Giving each value of ETO2 the same number of SpO2 measurements
[ETO2, j, k] = unique(ETO2_raw);
SpO2 = accumarray(k, (1:numel(k))', [], @(x)mean(SpO2_raw(x)));

theta_vals = [0, 5e4, 100;
              0, 5e3, 100;
              0, 5e5, 100;
              0, 5e6, 100];
%% Plotting curve shifting
hold on
test_PaO2 = 0:1:700;
test_SpO2_base = test_dissociation_curve(test_PaO2, theta_opt);
known_SpO2 = known_relationship(test_PaO2);
plot(ETO2, SpO2, '.')
plot(test_PaO2, test_SpO2_base, '.');
plot(test_PaO2, known_SpO2, '.');
    
for theta = theta_vals'
    test_SpO2 = test_dissociation_curve(test_PaO2, theta);
    % Dissociation Curve
    plot(test_PaO2, test_SpO2);
    xlabel('PaO_2 [mmHg]');
    ylabel('SpO_2 [%]');
    title('O_2 Dissociation Curve');
end
legend('Data', 'Optimization', 'Known', 'Near Optimal', 'Small left shift',  'Small right shift', 'Big right shift')
          
tau_vals = [1 10 20 30 40 1e3];

%% Plotting time delayed curve shifting
for tau_a = tau_vals
    tau_v = tau_a;
    clear PaO2_vals i
    i = 1;
    for theta = theta_vals'
        clear out
        options = simset('SrcWorkspace','current');
        out = sim('../utilities/models/curve_optimization_model.slx', [], options);
        PaO2_vals{i} = {out.PaO2.Time, out.PaO2.Data};
        i = i + 1;
    end
    
    figure
    hold on
    plot(PiO2_input(:,1), PiO2_input(:,2), '.')
    plot(time, ETO2_raw)
    t = sprintf('Change in PaO_2 Output Given Different Curves for tau_a = %d = tau_v', tau_a);
    title(t);
    xlabel('Time [ms]');
    ylabel('PaO_2 [mmHg]');
    for k = 1:length(PaO2_vals)
        PaO2_time = PaO2_vals{k}{1};
        PaO2 = PaO2_vals{k}{2};
        plot(PaO2_time, PaO2)
    end 
    legend('PiO2', 'ETO2', 'Near Optimal', 'Small left shift',  'Small right shift', 'Big right shift')
end   