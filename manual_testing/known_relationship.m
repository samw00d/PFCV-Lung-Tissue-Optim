% Sam Wood
% Fall2021
% PFCV
function SaO2 = known_relationship(PxO2)
    SaO2 = 100*((23400*((PxO2).^3 + 150*PxO2).^(-1)) + 1).^(-1);
end
