# PFCV-Lung-Tissue-Optim
Repository containing optimization scripts for two compartment lung and tissue models
## Directories
- dissociation_optimization
  - contains scripts to run various dissociation optimization processes. Utilizes the utilities/models/curve_optimization_model.slx Simulink model
- manual_testing
  - contains scripts for testing the effect of individual variables on the behavior of the dissociation optimization model
- parameter_optimization
  - contains scripts to run various general parameter optimization processes. Utilizes the utilities/models/parameter_optimization_model.slx Simulink model
- utilities
  - contains the data and models directories

## Functionality
The two compartment lung and tissue model take in experimental FiO2 and MinV for the pure prediction of PaO2 (ETO2). Nonlinear optimization can then be done using the MSE between experimental ETO2 and modeled PaO2.
