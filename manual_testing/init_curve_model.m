% Sam Wood
% Fall2021
% PFCV
%% Initializing variables for the Simulink model
close all
clear all
load('../utilities/data/FiO2mmHg.mat');
load('../utilities/data/EtO2mmHg.mat');
load('../utilities/data/MinV.mat');
load('../utilities/data/SpO2.mat');
load('../utilities/data/optim_diss_params.mat');

%% Input Data
r_factor = 200;
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

% O2 Parameters
tau_a = 0; %19.8; %19.8; %[s]
tau_v = 0; %33.6; %33.6; %[s]
Vl = 2.5; %[L]
Vl = Vl/1000; %[m^3]
Vt = 6; %[L]
Vt = Vt/1000; %[m^3]
SV = 0.1/1000; %[m^3]
Q = 100/60*SV; %[m^3/s] assuming 100 bpm
MRO2 = 0.0045/1000; %[m^3/s]
lambda = 863; %[]
Pa = 760; % [mmHg]
Pw = 47; % [mmHg]
MRO2 = (Pa - Pw)/lambda*MRO2;

% Initial Values
Pai = 300; % [mmHg]
Cvi = 0.2; % []

% Theta values
theta = [1e-3, 1e4, 100];

%% Running Model
% options = simset('SrcWorkspace','current');
% out = sim('../utilities/models/curve_optimization_model.slx', [], options);
% 
% % Theta values
% theta = [1e-3, 1e4, 100,];
% 
% x0 = [0, 1e5, 95, 1e3, 1e2];
% LB = [0, 1e3, 90, 0, 0];
% UB = [1, 1e7, 100, 1e4, 1e4];
% 
% optim = @(x)pure_pred(x);
% [x, err] = fmincon(optim, x0, [], [], [], [], LB, UB);
% 
% theta = x;
% save('optim_results.mat', 'theta')

%% Defining optimization function
function err = pure_pred(x)
    theta = x;
    tau_a = x(4);
    tau_v = x(5);
    
    load('../utilities/data/FiO2mmHg.mat');
    load('../utilities/data/EtO2mmHg.mat');
    load('../utilities/data/MinV.mat');
    load('../utilities/data/SpO2.mat');
    load('../utilities/data/optim_diss_params.mat');
    theta = O2_diss_vals;
    
    r_factor = 200;
    m_factor = 200;
    time = FiO2mmHg_Data(1,:);
    first = 1;
    last = length(time);
    time = decimate(time(first:last), r_factor);
    t_end = time(end);
    Ts = 0.01*r_factor;

    SpO2 = decimate(SpO2_Data(2,first:last), r_factor);

    minV = decimate(MinV_Data(2,first:last), r_factor); %[L/min]
    minV = minV/60000; % [m^3/s]
    minV = movmean(minV, m_factor);
    minV_input = [time' minV'];

    PiO2 = decimate(FiO2mmHg_Data(2,first:last), r_factor);
    PiO2_input = [time' PiO2'];

    ETO2_output = decimate(ETO2mmHg_Data(2,first:last), r_factor);
    
    % O2 Parameters
    Vl = 2.5; %[L]
    Vl = Vl/1000; %[m^3]
    Vt = 6; %[L]
    Vt = Vt/1000; %[m^3]
    SV = 0.1/1000; %[m^3]
    Q = 100/60*SV; %[m^3/s] assuming 100 bpm
    MRO2 = 0.0045/1000; %[m^3/s]
    lambda = 863; %[]
    Pa = 760; % [mmHg]
    Pw = 47; % [mmHg]
    MRO2 = (Pa - Pw)/lambda*MRO2;

    % Initial Values
    Pai = 100; % [mmHg]
    Cvi = 0.2; % []
    
    options = simset('SrcWorkspace','current');
    out = sim('../utilities/models/curve_optimization_model.slx', [], options);
    
    y_inf = out.PaO2.Data';
    y_inf = decimate(y_inf, r_factor);
    ETO2_output = decimate(ETO2_output, r_factor);
    a = length(y_inf);
    b = length(ETO2_output);
    y_inf = interp(y_inf, b);
    ETO2_output = interp(ETO2_output, a);
    err = mean((ETO2_output - y_inf).^2)
end