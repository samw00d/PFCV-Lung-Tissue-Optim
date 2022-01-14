% Sam Wood
% Fall2021
% PFCV
%% Curve optimization file
close all
clear all

x0 = [0, 1e4, 100, 15, 10];
LB = [0, 5e3, 100, 1, 1];
UB = [0, 5e5, 100, 100, 100];

optim = @(x)pure_pred(x);
[x, err] = fmincon(optim, x0, [], [], [], [], LB, UB);

theta = x;
save('../utilities/data/optim_curve_results.mat', 'theta')

%% Defining optimization function
function err = pure_pred(x)
    init_curve_model
    
    theta = x;
    tau_a = theta(4);
    tau_v = theta(5);
    
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/curve_optimization_model.slx', [], options);
    
    y_inf = out.PaO2.Data';
    y_inf = decimate(y_inf, r_factor);
    ETO2_output = decimate(ETO2_output, r_factor);
    a = length(y_inf);
    b = length(ETO2_output);
    y_inf = interp(y_inf, b);
    ETO2_output = interp(ETO2_output, a);
    t_start = 1;
    err = mean((ETO2_output(t_start:end) - y_inf(t_start:end)).^2)
end