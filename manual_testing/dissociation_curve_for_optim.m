% Sam Wood
% Fall2021
% PFCV
% Function used by dissociation_shifting_std_model for optimizing
% parameters given ETO2 and SpO2 data
function err = dissociation_curve_for_optim(PxO2, SpO2, theta)
    SxO2 = theta(3)*(PxO2.^3 + theta(1)*PxO2)./...
        (PxO2.^3 + theta(1)*PxO2 + theta(2));
    err = mean((SxO2 - SpO2).^2);
end