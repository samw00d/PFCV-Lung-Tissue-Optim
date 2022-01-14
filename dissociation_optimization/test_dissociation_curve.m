function SxO2 = test_dissociation_curve(PaO2, theta)
%     theta(3) = 100;
    SxO2 = theta(3)*(PaO2.^3 + theta(1)*PaO2)./...
        (PaO2.^3 + theta(1)*PaO2 + theta(2));
end