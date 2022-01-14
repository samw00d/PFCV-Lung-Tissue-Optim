## Dissociation Optimization
# Files
- curve_optim
  - main optimization script for the dissociaiton curve model. Utilizes init_curve_model to set constant parameter values and updates the dissociaiton curve constants to optimize model performance using fmincon
- dissociation_curve
  - function that takes in oxygen partial pressure and outputs the corresponding blood oxygen concentration
- init_curve_model
  - initializes all parameters needed to run the curve optimization model
- known_relationship
  - oxygen-hemoglobin dissociation curve relationship from the literature
- plot_results
  - file to see the output of the model
- test_dissociation_curve
  - function that takes in oxygen partial pressure and outputs the corresponding blood oxygen saturation
