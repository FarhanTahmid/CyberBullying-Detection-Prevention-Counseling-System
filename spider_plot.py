import matplotlib.pyplot as plt
import numpy as np

# Four models
model_names = ['Decision Tree', 'Logistic Regression', 'Naive Bayes', 'Random Forest Classifier']

# Model performance metrics (F1 Score, accuracy, test loss)
model_metrics = [
    [0.963, 0.964, 0.93], # Model 1
    [0.910, 0.908, 0.927], # Model 2
    [0.809, 0.767, 0.98], # Model 3
    [0.82, 0.7306, 1.01] # Model 4
]

# Calculate angle for each model metric
angles = np.linspace(0, 2 * np.pi, len(model_metrics[0])+1)[:-1]

# Plot polar grid (circle grid around center point)
fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
ax.set_title('Model Performance Metrics for English Hate Texts', va='bottom')
ax.xaxis.set_tick_params(pad=20)
ax.yaxis.grid(True)

# Plot model performance metrics as polar line plot
for idx, (model_name, metrics) in enumerate(zip(model_names, model_metrics)):
    ax.plot(angles, metrics, label=model_name)
    ax.fill(angles, metrics, 'b', alpha=0.1)

# Set tick labels
tick_labels = ['F1 Score', 'Accuracy', 'Recall']
ax.set_xticklabels(tick_labels)

# Set radial tick labels
radial_ticks = np.linspace(0, 1, 5)
ax.set_yticklabels([str(round(x, 3)) for x in radial_ticks])

# Set legend
plt.legend(loc='upper right', bbox_to_anchor=(0.1, 0.1))

# Show plot
plt.show()