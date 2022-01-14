% Sam Wood
% Fall2021
% PFCV
% Script for saving and visualizing specific data fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
%Loading in Data from .mat
load('DATA_03192021.mat'); % third experiment data file (can be replaced)

% If the above file is changed, check the indices below to confirm they
% correspond with the correct variable
data = DATA_03192021.Y;
time = DATA_03192021.X(1).Data;
ETCO2 = data(11).Data;
ETNO2 = data(12).Data;
ETO2 = data(13).Data;
FiCO2 = data(14).Data;
FiNO2 = data(15).Data;
FiO2 = data(16).Data;
SpO2 = data(19).Data;
SpO2_nellcore = data(109).Data;
RespRate = data(17).Data;
minV = 15*data(64).Data;
AVS_TidV = data(10).Data;
BPM = data(18).Data; % this is AVS, pulse oximeter is 18

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Taking samples from defined snippets in time
start = 1; %first 200s garbage
finish = length(time);
ETCO2_Data(1,:) = time(start:finish);
ETCO2_Data(2,:) = ETCO2(start:finish);
ETNO2_Data(1,:) = time(start:finish);
ETNO2_Data(2,:) = ETNO2(start:finish);
ETO2_Data(1,:) = time(start:finish);
ETO2_Data(2,:) = ETO2(start:finish);
SpO2_Data(1,:) = time(start:finish);
SpO2_Data(2,:) = SpO2(start:finish);
SpO2_Data_N(1,:) = time(start:finish);
SpO2_Data_N(2,:) = SpO2_nellcore(start:finish);
FiCO2_Data(1,:) = time(start:finish);
FiCO2_Data(2,:) = FiCO2(start:finish);
FiNO2_Data(1,:) = time(start:finish);
FiNO2_Data(2,:) = FiNO2(start:finish);
FiO2_Data(1,:) = time(start:finish);
FiO2_Data(2,:) = FiO2(start:finish);
AVS_TidV_Data(1,:) = time(start:finish);
AVS_TidV_Data(2,:) = AVS_TidV(start:finish);
Resp_Data(1,:) = time(start:finish);
Resp_Data(2,:) = RespRate(start:finish);
MinV_Data(1,:) = time(start:finish);
MinV_Data(2,:) = minV(start:finish);
BPM_Data(1,:) = time(start:finish);
BPM_Data(2,:) = BPM(start:finish);

figure
hold on
plot(100*SpO2_Data_N(2,:))
plot(SpO2_Data(2,:))
legend('Nellcore', 'Other')
figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data smoothing
for i = 1:length(SpO2_Data)
    if(SpO2_Data(2,i) > 100)
        SpO2_Data(2,i) = 100;
    end
end
SpO2_Data(2,:) = movmean(SpO2_Data(2,:), 5000);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Getting tidal volume

% V_Data(1,:) = time(start:finish);
% V_Data(2,:) = MinV_Data(2,:).*Resp_Data(2,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Converting to mmHg from percent                           %
Pa = 760;
Pw = 47;
ETCO2mmHg_Data(1,:) = ETCO2_Data(1,:);
ETCO2mmHg_Data(2,:) = (Pa - Pw)/100*ETCO2_Data(2,:);
ETNO2mmHg_Data(1,:) = ETNO2_Data(1,:);
ETNO2mmHg_Data(2,:) = (Pa - Pw)/100*ETNO2_Data(2,:);
ETO2mmHg_Data(1,:) = ETO2_Data(1,:);
ETO2mmHg_Data(2,:) = (Pa - Pw)/100*ETO2_Data(2,:);
FiCO2mmHg_Data(1,:) = FiCO2_Data(1,:);
FiCO2mmHg_Data(2,:) = (Pa - Pw)/100*FiCO2_Data(2,:);
FiNO2mmHg_Data(1,:) = FiNO2_Data(1,:);
FiNO2mmHg_Data(2,:) = (Pa - Pw)/100*FiNO2_Data(2,:);
FiO2mmHg_Data(1,:) = FiO2_Data(1,:);
FiO2mmHg_Data(2,:) = (Pa - Pw)/100*FiO2_Data(2,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting ETO2 and SpO2 data against time on seperate plots%
% plot(ETO2_Data(1,:), ETO2_Data(2,:));
% xlabel('time');
% ylabel('ETO2');
% figure;
% plot(SpO2_Data(1,:), SpO2_Data(2,:));
% xlabel('time');
% ylabel('SpO2');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on;
%Plotting ETO2 vs. SpO2 to see relationship
% plot(ETO2_Data(2,:), SpO2_Data(2,:));
% xlabel('ETO2')
% ylabel('SpO2')

%% Raw Data
% plot(ETCO2_Data(2,:), FiCO2_Data(2,:));
% xlabel('ETCO2')
% ylabel('FiCO2')

% plot(ETO2_Data(2,:), FiO2_Data(2,:));
% xlabel('ETO2')
% ylabel('FiO2')

% plot(ETCO2_Data(1,:), ETCO2_Data(2,:));
% xlabel('time')
% ylabel('ETCO2')
% figure;

% plot(AVS_TidV_Data(1,:), AVS_TidV_Data(2,:));
% xlabel('time')
% ylabel('AVS Tidal Volume')
% figure;
% 
% plot(ETO2_Data(1,:), ETO2_Data(2,:));
% xlabel('time')
% ylabel('ETO2')
% figure;
% 
% plot(FiO2_Data(1,:), FiO2_Data(2,:));
% xlabel('time')
% ylabel('FiO2')
% figure

plot(FiO2_Data(2,:), ETO2_Data(2,:));
xlabel('FiO2')
ylabel('ETO2')
figure

% plot(FiCO2_Data(1,:), FiCO2_Data(2,:));
% xlabel('time')
% ylabel('FiCO2')
% 
% plot(SpO2_Data(1,:), SpO2_Data(2,:));
% xlabel('time')
% ylabel('SpO2')
% figure;

% figure;
% plot(Resp_Data(1,:), Resp_Data(2,:));
% xlabel('time')
% ylabel('Respiratory Rate')
% figure;
% 
% plot(MinV_Data(1,:), MinV_Data(2,:));
% xlabel('time')
% ylabel('Minute Ventilation')
% figure;

% plot(V_Data(1,:), V_Data(2,:));
% xlabel('time')
% ylabel('Volume')
% figure;

%% mmHg
% plot(ETCO2mmHg_Data(1,:), ETCO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('ETCO2')
% % figure;
% hold on;
% 
% plot(FiCO2mmHg_Data(1,:), FiCO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('FiCO2')
% figure;

% plot(ETCO2mmHg_Data(2,:), FiCO2mmHg_Data(2,:));
% xlabel('ETCO2')
% ylabel('FiCO2')
% figure;

% plot(FiCO2mmHg_Data(1,:), ETCO2mmHg_Data(2,:) - FiCO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('ETCO2-FiCO2')
% hold on;
% figure;

% plot(ETNO2mmHg_Data(1,:), ETNO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('ETNO2')
% figure;

% plot(FiNO2mmHg_Data(1,:), FiNO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('FiNO2')
% figure;
% 
% plot(ETNO2mmHg_Data(2,:), FiNO2mmHg_Data(2,:));
% xlabel('ETNO2')
% ylabel('FiNO2')
% figure;

% plot(FiNO2mmHg_Data(1,:), ETNO2mmHg_Data(2,:) - FiNO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('ETNO2-FiNO2')
% figure;

% plot(FiO2mmHg_Data(1,:), FiO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('FiO2')
% figure;

% plot(ETO2mmHg_Data(1,:), ETO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('ETO2')
% figure;

% plot(ETO2mmHg_Data(2,:), FiO2mmHg_Data(2,:));
% xlabel('ETO2')
% ylabel('FiO2')
% figure;

% plot(FiO2mmHg_Data(1,:), FiO2mmHg_Data(2,:) - ETO2mmHg_Data(2,:));
% xlabel('time')
% ylabel('FiO2-ETO2')

% plot(FiO2mmHg_Data(2,:) - ETO2mmHg_Data(2,:), ETCO2mmHg_Data(2,:) - FiCO2mmHg_Data(2,:));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Saving SpO2 and ETO2 data in .mat files

save("SpO2.mat", "SpO2_Data");
% save("ETO2.mat", "ETO2_Data");
% save("FiO2.mat", "FiO2_Data");
% save("ETCO2.mat", "ETCO2_Data");
% save("FiCO2.mat", "FiCO2_Data");
% save("Resp.mat", "Resp_Data");
save("MinV.mat", "MinV_Data");
% save("BPM.mat", "BPM_Data");
save("ETO2mmHg.mat", "ETO2mmHg_Data");
save("FiO2mmHg.mat", "FiO2mmHg_Data");
% save("ETCO2mmHg.mat", "ETCO2mmHg_Data");
% save("FiCO2mmHg.mat", "FiCO2mmHg_Data");

% save("Volume.mat", "V_Data");


%% Notes
