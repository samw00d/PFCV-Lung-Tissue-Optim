% Sam Wood
% Fall2021
% PFCV
%% Parameter optimization file
close all
clear all
init_param_model
%% Nonlinear Optimization
x0 = 6.1964e-4; %MRO2*(Pa - Pw)/(lambda*Vt);

LB = 6e-6;
UB = 6e-2;

optim = @(x)pure_pred(x);
[x, err] = fmincon(optim, x0, [], [], [], [], LB, UB);

MRO2 = x*lambda*Vt/(Pa - Pw)

save('../utilities/data/optim_results.mat', 'MRO2')
%% Defining optimization function
function err = pure_pred(x)
    init_param_model
    
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/parameter_optimization_model.slx', [], options);
    
    y_inf = out.PaO2.Data';
    y_inf = decimate(y_inf, r_factor);
    ETO2_output = decimate(ETO2_output, r_factor);
    a = length(y_inf);
    b = length(ETO2_output);
    y_inf = interp(y_inf, b);
    ETO2_output = interp(ETO2_output, a);
    t_start = round(length(y_inf)/5);
    err = mean((ETO2_output(t_start:end) - y_inf(t_start:end)).^2)
end