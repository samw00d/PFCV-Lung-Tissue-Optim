% Sam Wood
% Fall2021
% PFCV
function CxO2 = dissociation_curve(PxO2, theta1, theta2, theta3)
    SxO2 = theta3*(PxO2.^3 + theta1*PxO2)./...
        (PxO2.^3 + theta1*PxO2 + theta2);
    CxO2 = (1.34*16*SxO2 + 0.0031*PxO2)/100;
end