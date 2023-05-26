import torch
import pandas as pd
from torch.utils.data import Dataset, DataLoader
from transformers import BertTokenizer, BertForSequenceClassification
from sklearn.model_selection import train_test_split
import time

def load_dataset(dataset_file):
    # Load the dataset from file
    df = pd.read_csv(dataset_file)

    texts = df['sentence'].tolist()
    labels = df['hate'].tolist()

    tokenizer = BertTokenizer.from_pretrained('sagorsarker/bangla-bert-base')

    # Tokenize and encode the text
    def preprocess_text(text):
        inputs = tokenizer.encode_plus(
            text,
            None,
            truncation=True,
            padding='max_length',
            max_length=128,
            add_special_tokens=True,
            return_attention_mask=True,
            return_tensors='pt'
        )

        input_ids = inputs['input_ids'].squeeze()
        attention_mask = inputs['attention_mask'].squeeze()

        return input_ids, attention_mask

    input_ids = []
    attention_masks = []
    for text in texts:
        ids, masks = preprocess_text(text)
        input_ids.append(ids)
        attention_masks.append(masks)

    dataset = list(zip(input_ids, attention_masks, labels))

    return dataset

    
# Define the model
model = BertForSequenceClassification.from_pretrained('sagorsarker/bangla-bert-base', num_labels=2)


batch_size = 16
learning_rate = 2e-5
num_epochs = 5



dataset = load_dataset('Bengali hate speech.csv')

train_data, test_data = train_test_split(dataset, test_size=0.2, random_state=42)


train_dataloader = DataLoader(train_data, batch_size=batch_size, shuffle=True)
test_dataloader = DataLoader(test_data, batch_size=batch_size)

# Set device
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')


# Move model to device
model = model.to(device)

# Set up the optimizer and the loss function
optimizer = torch.optim.AdamW(model.parameters(), lr=learning_rate)
criterion = torch.nn.CrossEntropyLoss()

# Training loop
start_time=time.time()
for epoch in range(num_epochs):
    model.train()
    total_loss = 0.0
    correct_predictions = 0
    total_predictions = 0

    for batch in train_dataloader:
        input_ids, attention_masks, labels = batch

        input_ids = input_ids.to(device)
        attention_masks = attention_masks.to(device)
        labels = labels.to(device)

        # Zero gradients
        optimizer.zero_grad()

        # Forward pass
        outputs = model(input_ids, attention_mask=attention_masks)
        logits = outputs.logits

        # Calculate loss
        loss = criterion(logits, labels)
        total_loss += loss.item()

        # Backward pass
        loss.backward()

        # Update parameters
        optimizer.step()

        # Calculate accuracy
        _, predicted_labels = torch.max(logits, dim=1)
        correct_predictions += torch.sum(predicted_labels == labels).item()
        total_predictions += labels.size(0)

    # Calculate accuracy and ETA
    train_loss = total_loss / len(train_dataloader)
    train_accuracy = correct_predictions / total_predictions
    eta = (num_epochs - epoch - 1) * (time.time() - start_time) / (epoch + 1)

    # Print progress updates
    print(f"Epoch {epoch+1}/{num_epochs}")
    print(f"Train Loss: {train_loss:.4f} | Train Accuracy: {train_accuracy:.4f} | ETA: {eta:.2f} seconds")