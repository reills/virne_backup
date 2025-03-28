import re
import matplotlib.pyplot as plt

# Example log string; you can also read this from a file.
log_text = """
Epoch 1/1000 → Actor Loss: 3.6224 | Actor Acc: 0.5570 | Critic Loss: 0.0119 | Val Actor Loss: 2.9704 | Val Critic Loss: 0.0083 | Val Acc: 0.7902 | Time: 150.63s
Checkpoint saved at epoch 1 (new best val loss: 2.9787).
Epoch 2/1000 → Actor Loss: 2.2234 | Actor Acc: 0.9155 | Critic Loss: 0.0079 | Val Actor Loss: 1.5366 | Val Critic Loss: 0.0080 | Val Acc: 0.9859 | Time: 150.84s
Checkpoint saved at epoch 2 (new best val loss: 1.5445).
Epoch 3/1000 → Actor Loss: 1.1670 | Actor Acc: 0.9867 | Critic Loss: 0.0076 | Val Actor Loss: 0.7744 | Val Critic Loss: 0.0081 | Val Acc: 0.9859 | Time: 150.86s
Checkpoint saved at epoch 3 (new best val loss: 0.7825).
Epoch 4/1000 → Actor Loss: 0.5844 | Actor Acc: 0.9869 | Critic Loss: 0.0074 | Val Actor Loss: 0.3734 | Val Critic Loss: 0.0089 | Val Acc: 0.9859 | Time: 150.87s
Checkpoint saved at epoch 4 (new best val loss: 0.3822).
Epoch 5/1000 → Actor Loss: 0.2954 | Actor Acc: 0.9868 | Critic Loss: 0.0073 | Val Actor Loss: 0.2065 | Val Critic Loss: 0.0087 | Val Acc: 0.9858 | Time: 151.58s
Checkpoint saved at epoch 5 (new best val loss: 0.2152).
Epoch 6/1000 → Actor Loss: 0.1810 | Actor Acc: 0.9869 | Critic Loss: 0.0071 | Val Actor Loss: 0.1432 | Val Critic Loss: 0.0079 | Val Acc: 0.9859 | Time: 150.85s
Checkpoint saved at epoch 6 (new best val loss: 0.1511).
Epoch 7/1000 → Actor Loss: 0.1323 | Actor Acc: 0.9869 | Critic Loss: 0.0070 | Val Actor Loss: 0.1162 | Val Critic Loss: 0.0074 | Val Acc: 0.9858 | Time: 150.86s
Checkpoint saved at epoch 7 (new best val loss: 0.1235).
Epoch 8/1000 → Actor Loss: 0.1087 | Actor Acc: 0.9869 | Critic Loss: 0.0070 | Val Actor Loss: 0.0995 | Val Critic Loss: 0.0075 | Val Acc: 0.9859 | Time: 150.85s
Checkpoint saved at epoch 8 (new best val loss: 0.1070).
Epoch 9/1000 → Actor Loss: 0.0942 | Actor Acc: 0.9870 | Critic Loss: 0.0069 | Val Actor Loss: 0.0928 | Val Critic Loss: 0.0074 | Val Acc: 0.9859 | Time: 150.87s
Checkpoint saved at epoch 9 (new best val loss: 0.1002).
Epoch 10/1000 → Actor Loss: 0.0855 | Actor Acc: 0.9869 | Critic Loss: 0.0069 | Val Actor Loss: 0.0846 | Val Critic Loss: 0.0074 | Val Acc: 0.9861 | Time: 150.88s
Checkpoint saved at epoch 10 (new best val loss: 0.0921).
Epoch 11/1000 → Actor Loss: 0.0796 | Actor Acc: 0.9870 | Critic Loss: 0.0068 | Val Actor Loss: 0.0806 | Val Critic Loss: 0.0073 | Val Acc: 0.9859 | Time: 150.87s
Checkpoint saved at epoch 11 (new best val loss: 0.0880).
Epoch 12/1000 → Actor Loss: 0.0753 | Actor Acc: 0.9871 | Critic Loss: 0.0068 | Val Actor Loss: 0.0782 | Val Critic Loss: 0.0077 | Val Acc: 0.9858 | Time: 150.88s
Checkpoint saved at epoch 12 (new best val loss: 0.0859).
Epoch 13/1000 → Actor Loss: 0.0729 | Actor Acc: 0.9870 | Critic Loss: 0.0067 | Val Actor Loss: 0.0763 | Val Critic Loss: 0.0079 | Val Acc: 0.9862 | Time: 150.86s
Checkpoint saved at epoch 13 (new best val loss: 0.0842).
Epoch 14/1000 → Actor Loss: 0.0706 | Actor Acc: 0.9869 | Critic Loss: 0.0067 | Val Actor Loss: 0.0755 | Val Critic Loss: 0.0070 | Val Acc: 0.9858 | Time: 150.86s
Checkpoint saved at epoch 14 (new best val loss: 0.0825).
Epoch 15/1000 → Actor Loss: 0.0690 | Actor Acc: 0.9869 | Critic Loss: 0.0066 | Val Actor Loss: 0.0750 | Val Critic Loss: 0.0078 | Val Acc: 0.9856 | Time: 150.84s
Epochs without improvement: 1/50
Epoch 16/1000 → Actor Loss: 0.0674 | Actor Acc: 0.9870 | Critic Loss: 0.0066 | Val Actor Loss: 0.0735 | Val Critic Loss: 0.0070 | Val Acc: 0.9859 | Time: 150.85s
Checkpoint saved at epoch 16 (new best val loss: 0.0805).
Epoch 17/1000 → Actor Loss: 0.0664 | Actor Acc: 0.9870 | Critic Loss: 0.0066 | Val Actor Loss: 0.0731 | Val Critic Loss: 0.0071 | Val Acc: 0.9856 | Time: 151.88s
Epochs without improvement: 1/50
Epoch 18/1000 → Actor Loss: 0.0652 | Actor Acc: 0.9870 | Critic Loss: 0.0066 | Val Actor Loss: 0.0720 | Val Critic Loss: 0.0081 | Val Acc: 0.9858 | Time: 150.86s
Epochs without improvement: 2/50
Epoch 19/1000 → Actor Loss: 0.0644 | Actor Acc: 0.9870 | Critic Loss: 0.0066 | Val Actor Loss: 0.0733 | Val Critic Loss: 0.0070 | Val Acc: 0.9858 | Time: 150.86s
Epochs without improvement: 3/50
Epoch 20/1000 → Actor Loss: 0.0638 | Actor Acc: 0.9872 | Critic Loss: 0.0065 | Val Actor Loss: 0.0719 | Val Critic Loss: 0.0073 | Val Acc: 0.9859 | Time: 150.86s
Checkpoint saved at epoch 20 (new best val loss: 0.0792).
Epoch 21/1000 → Actor Loss: 0.0630 | Actor Acc: 0.9872 | Critic Loss: 0.0065 | Val Actor Loss: 0.0706 | Val Critic Loss: 0.0071 | Val Acc: 0.9859 | Time: 150.86s
Checkpoint saved at epoch 21 (new best val loss: 0.0777).
Epoch 22/1000 → Actor Loss: 0.0620 | Actor Acc: 0.9873 | Critic Loss: 0.0065 | Val Actor Loss: 0.0728 | Val Critic Loss: 0.0069 | Val Acc: 0.9859 | Time: 150.88s
Epochs without improvement: 1/50
Epoch 23/1000 → Actor Loss: 0.0614 | Actor Acc: 0.9874 | Critic Loss: 0.0064 | Val Actor Loss: 0.0707 | Val Critic Loss: 0.0068 | Val Acc: 0.9859 | Time: 150.86s
Epochs without improvement: 2/50
Epoch 24/1000 → Actor Loss: 0.0610 | Actor Acc: 0.9874 | Critic Loss: 0.0064 | Val Actor Loss: 0.0712 | Val Critic Loss: 0.0069 | Val Acc: 0.9858 | Time: 150.89s
Epochs without improvement: 3/50
Epoch 25/1000 → Actor Loss: 0.0606 | Actor Acc: 0.9874 | Critic Loss: 0.0063 | Val Actor Loss: 0.0731 | Val Critic Loss: 0.0067 | Val Acc: 0.9856 | Time: 150.87s
Epochs without improvement: 4/50
Epoch 26/1000 → Actor Loss: 0.0607 | Actor Acc: 0.9874 | Critic Loss: 0.0063 | Val Actor Loss: 0.0714 | Val Critic Loss: 0.0069 | Val Acc: 0.9859 | Time: 151.62s
Epochs without improvement: 5/50
Epoch 27/1000 → Actor Loss: 0.0597 | Actor Acc: 0.9874 | Critic Loss: 0.0063 | Val Actor Loss: 0.0720 | Val Critic Loss: 0.0067 | Val Acc: 0.9859 | Time: 150.87s
Epochs without improvement: 6/50
Epoch 28/1000 → Actor Loss: 0.0593 | Actor Acc: 0.9874 | Critic Loss: 0.0062 | Val Actor Loss: 0.0697 | Val Critic Loss: 0.0066 | Val Acc: 0.9861 | Time: 150.87s
Checkpoint saved at epoch 28 (new best val loss: 0.0763).
Epoch 29/1000 → Actor Loss: 0.0590 | Actor Acc: 0.9875 | Critic Loss: 0.0062 | Val Actor Loss: 0.0715 | Val Critic Loss: 0.0068 | Val Acc: 0.9858 | Time: 150.86s
Epochs without improvement: 1/50
Epoch 30/1000 → Actor Loss: 0.0589 | Actor Acc: 0.9875 | Critic Loss: 0.0062 | Val Actor Loss: 0.0715 | Val Critic Loss: 0.0067 | Val Acc: 0.9856 | Time: 150.83s
Epochs without improvement: 2/50
Epoch 31/1000 → Actor Loss: 0.0577 | Actor Acc: 0.9878 | Critic Loss: 0.0061 | Val Actor Loss: 0.0717 | Val Critic Loss: 0.0067 | Val Acc: 0.9859 | Time: 150.80s
Epochs without improvement: 3/50
Epoch 32/1000 → Actor Loss: 0.0576 | Actor Acc: 0.9879 | Critic Loss: 0.0061 | Val Actor Loss: 0.0720 | Val Critic Loss: 0.0065 | Val Acc: 0.9858 | Time: 150.77s
Epochs without improvement: 4/50
Epoch 33/1000 → Actor Loss: 0.0577 | Actor Acc: 0.9879 | Critic Loss: 0.0061 | Val Actor Loss: 0.0745 | Val Critic Loss: 0.0066 | Val Acc: 0.9856 | Time: 150.76s
Epochs without improvement: 5/50
Epoch 34/1000 → Actor Loss: 0.0573 | Actor Acc: 0.9878 | Critic Loss: 0.0060 | Val Actor Loss: 0.0725 | Val Critic Loss: 0.0065 | Val Acc: 0.9861 | Time: 150.77s
Epochs without improvement: 6/50
Epoch 35/1000 → Actor Loss: 0.0569 | Actor Acc: 0.9879 | Critic Loss: 0.0060 | Val Actor Loss: 0.0746 | Val Critic Loss: 0.0064 | Val Acc: 0.9856 | Time: 150.76s
Epochs without improvement: 7/50
Epoch 36/1000 → Actor Loss: 0.0564 | Actor Acc: 0.9877 | Critic Loss: 0.0059 | Val Actor Loss: 0.0721 | Val Critic Loss: 0.0066 | Val Acc: 0.9861 | Time: 150.75s
Epochs without improvement: 8/50
Epoch 37/1000 → Actor Loss: 0.0563 | Actor Acc: 0.9883 | Critic Loss: 0.0059 | Val Actor Loss: 0.0740 | Val Critic Loss: 0.0064 | Val Acc: 0.9862 | Time: 151.53s
Epochs without improvement: 9/50
Epoch 38/1000 → Actor Loss: 0.0562 | Actor Acc: 0.9879 | Critic Loss: 0.0059 | Val Actor Loss: 0.0715 | Val Critic Loss: 0.0063 | Val Acc: 0.9858 | Time: 150.75s
Epochs without improvement: 10/50
Epoch 39/1000 → Actor Loss: 0.0557 | Actor Acc: 0.9879 | Critic Loss: 0.0059 | Val Actor Loss: 0.0755 | Val Critic Loss: 0.0063 | Val Acc: 0.9858 | Time: 150.74s
Epochs without improvement: 11/50
Epoch 40/1000 → Actor Loss: 0.0549 | Actor Acc: 0.9882 | Critic Loss: 0.0059 | Val Actor Loss: 0.0745 | Val Critic Loss: 0.0064 | Val Acc: 0.9858 | Time: 150.74s
Epochs without improvement: 12/50
Epoch 41/1000 → Actor Loss: 0.0551 | Actor Acc: 0.9882 | Critic Loss: 0.0059 | Val Actor Loss: 0.0777 | Val Critic Loss: 0.0074 | Val Acc: 0.9858 | Time: 150.75s
Epochs without improvement: 13/50
Epoch 42/1000 → Actor Loss: 0.0539 | Actor Acc: 0.9884 | Critic Loss: 0.0059 | Val Actor Loss: 0.0754 | Val Critic Loss: 0.0064 | Val Acc: 0.9858 | Time: 150.76s
Epochs without improvement: 14/50
Epoch 43/1000 → Actor Loss: 0.0538 | Actor Acc: 0.9885 | Critic Loss: 0.0058 | Val Actor Loss: 0.0744 | Val Critic Loss: 0.0065 | Val Acc: 0.9859 | Time: 150.64s
Epochs without improvement: 15/50
Epoch 44/1000 → Actor Loss: 0.0535 | Actor Acc: 0.9885 | Critic Loss: 0.0058 | Val Actor Loss: 0.0743 | Val Critic Loss: 0.0063 | Val Acc: 0.9858 | Time: 150.60s
Epochs without improvement: 16/50
Epoch 45/1000 → Actor Loss: 0.0503 | Actor Acc: 0.9889 | Critic Loss: 0.0057 | Val Actor Loss: 0.0771 | Val Critic Loss: 0.0061 | Val Acc: 0.9856 | Time: 150.49s
Epochs without improvement: 17/50
Epoch 46/1000 → Actor Loss: 0.0500 | Actor Acc: 0.9889 | Critic Loss: 0.0057 | Val Actor Loss: 0.0730 | Val Critic Loss: 0.0061 | Val Acc: 0.9862 | Time: 150.46s
Epochs without improvement: 18/50
Epoch 47/1000 → Actor Loss: 0.0497 | Actor Acc: 0.9892 | Critic Loss: 0.0057 | Val Actor Loss: 0.0741 | Val Critic Loss: 0.0061 | Val Acc: 0.9862 | Time: 150.44s
Epochs without improvement: 19/50
Epoch 48/1000 → Actor Loss: 0.0490 | Actor Acc: 0.9893 | Critic Loss: 0.0057 | Val Actor Loss: 0.0735 | Val Critic Loss: 0.0061 | Val Acc: 0.9859 | Time: 150.45s
Epochs without improvement: 20/50
Epoch 49/1000 → Actor Loss: 0.0487 | Actor Acc: 0.9894 | Critic Loss: 0.0056 | Val Actor Loss: 0.0750 | Val Critic Loss: 0.0061 | Val Acc: 0.9865 | Time: 150.44s
Epochs without improvement: 21/50
Epoch 50/1000 → Actor Loss: 0.0479 | Actor Acc: 0.9894 | Critic Loss: 0.0056 | Val Actor Loss: 0.0762 | Val Critic Loss: 0.0061 | Val Acc: 0.9863 | Time: 150.45s
Epochs without improvement: 22/50
Epoch 51/1000 → Actor Loss: 0.0476 | Actor Acc: 0.9897 | Critic Loss: 0.0056 | Val Actor Loss: 0.0742 | Val Critic Loss: 0.0061 | Val Acc: 0.9866 | Time: 150.45s
Epochs without improvement: 23/50
Epoch 52/1000 → Actor Loss: 0.0462 | Actor Acc: 0.9901 | Critic Loss: 0.0056 | Val Actor Loss: 0.0732 | Val Critic Loss: 0.0060 | Val Acc: 0.9861 | Time: 150.41s
Epochs without improvement: 24/50
Epoch 53/1000 → Actor Loss: 0.0458 | Actor Acc: 0.9901 | Critic Loss: 0.0056 | Val Actor Loss: 0.0742 | Val Critic Loss: 0.0060 | Val Acc: 0.9866 | Time: 150.41s
Epochs without improvement: 25/50
Epoch 54/1000 → Actor Loss: 0.0457 | Actor Acc: 0.9900 | Critic Loss: 0.0056 | Val Actor Loss: 0.0721 | Val Critic Loss: 0.0061 | Val Acc: 0.9865 | Time: 150.39s
Epochs without improvement: 26/50
Epoch 55/1000 → Actor Loss: 0.0445 | Actor Acc: 0.9903 | Critic Loss: 0.0056 | Val Actor Loss: 0.0712 | Val Critic Loss: 0.0060 | Val Acc: 0.9869 | Time: 150.37s
Epochs without improvement: 27/50
"""

# Prepare lists to store data
epochs = []
train_total_losses = []   # Actor Loss + Critic Loss
val_total_losses = []     # Val Actor Loss + Val Critic Loss

# Define a regex pattern to capture the key metrics from each epoch line
pattern = re.compile(
    r"Epoch (\d+)/\d+ → Actor Loss: ([\d\.]+) \| .*?Critic Loss: ([\d\.]+) \| Val Actor Loss: ([\d\.]+) \| Val Critic Loss: ([\d\.]+)"
)

# Parse the log
for line in log_text.splitlines():
    match = pattern.search(line)
    if match:
        epoch = int(match.group(1))
        actor_loss = float(match.group(2))
        critic_loss = float(match.group(3))
        val_actor_loss = float(match.group(4))
        val_critic_loss = float(match.group(5))
        train_total = actor_loss + critic_loss
        val_total = val_actor_loss + val_critic_loss
        epochs.append(epoch)
        train_total_losses.append(train_total)
        val_total_losses.append(val_total)

# Save parsed metrics to a text file (optional)
with open("training_metrics.txt", "w") as f:
    f.write("Epoch\tTrain_Total_Loss\tVal_Total_Loss\n")
    for e, t_loss, v_loss in zip(epochs, train_total_losses, val_total_losses):
        f.write(f"{e}\t{t_loss:.4f}\t{v_loss:.4f}\n")

# Create a plot
plt.figure(figsize=(8, 6))
plt.plot(epochs, train_total_losses, marker="o", label="Training Total Loss")
plt.plot(epochs, val_total_losses, marker="s", label="Validation Total Loss")
plt.xlabel("Epoch")
plt.ylabel("Total Loss")
plt.title("Training vs. Validation Total Loss")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("training_vs_validation_loss.png")
plt.show()
