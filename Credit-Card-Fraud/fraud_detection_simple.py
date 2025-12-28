"""
Credit Card Fraud Detection
Simple Python Script - No Jupyter Required!

Author: Victor Torres
Run with: python fraud_detection_simple.py
"""

import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.metrics import (
    classification_report, confusion_matrix, 
    roc_auc_score, roc_curve,
    accuracy_score, precision_score, recall_score, f1_score
)
from imblearn.over_sampling import SMOTE
import warnings
warnings.filterwarnings('ignore')

# Settings
plt.style.use('seaborn-v0_8-darkgrid')
sns.set_palette("husl")
pd.set_option('display.max_columns', None)

# Create images folder if it doesn't exist
if not os.path.exists('images'):
    os.makedirs('images')
    print("✓ Created 'images' folder")

print("="*80)
print("CREDIT CARD FRAUD DETECTION - MACHINE LEARNING ANALYSIS")
print("="*80)
print("\n1. Loading libraries...")
print("✓ All libraries imported successfully!\n")

# Load data
print("2. Loading dataset...")
try:
    df = pd.read_csv('data/creditcard.csv')
    print(f"✓ Dataset loaded successfully!")
    print(f"   Shape: {df.shape}")
    print(f"   Total transactions: {len(df):,}")
except FileNotFoundError:
    print("ERROR: creditcard.csv not found in 'data/' folder!")
    print("Please download from: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud")
    exit()

# Basic exploration
print("\n3. Exploratory Data Analysis...")
print(f"   Missing values: {df.isnull().sum().sum()}")
print(f"   Legitimate transactions: {(df['Class']==0).sum():,} ({(df['Class']==0).sum()/len(df)*100:.2f}%)")
print(f"   Fraudulent transactions: {(df['Class']==1).sum():,} ({(df['Class']==1).sum()/len(df)*100:.3f}%)")

# Visualize class distribution
print("\n4. Creating visualizations...")
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

df['Class'].value_counts().plot(kind='bar', ax=axes[0], color=['#3498db', '#e74c3c'])
axes[0].set_title('Class Distribution', fontsize=14, fontweight='bold')
axes[0].set_xlabel('Class (0: Legitimate, 1: Fraud)', fontsize=12)
axes[0].set_ylabel('Count', fontsize=12)
axes[0].set_xticklabels(['Legitimate', 'Fraud'], rotation=0)

for i, v in enumerate(df['Class'].value_counts().values):
    axes[0].text(i, v + 5000, f'{v:,}', ha='center', fontweight='bold')

colors = ['#3498db', '#e74c3c']
explode = (0, 0.1)
df['Class'].value_counts().plot(kind='pie', ax=axes[1], autopct='%1.2f%%',
                                 colors=colors, explode=explode, startangle=90)
axes[1].set_title('Class Distribution (%)', fontsize=14, fontweight='bold')
axes[1].set_ylabel('')

plt.tight_layout()
plt.savefig('images/class_distribution.png', dpi=300, bbox_inches='tight')
plt.close()
print("   ✓ Saved: images/class_distribution.png")

# Amount distribution
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

df[df['Class'] == 0]['Amount'].plot(kind='hist', bins=50, ax=axes[0], 
                                     color='#3498db', alpha=0.7, label='Legitimate')
df[df['Class'] == 1]['Amount'].plot(kind='hist', bins=50, ax=axes[0], 
                                     color='#e74c3c', alpha=0.7, label='Fraud')
axes[0].set_title('Transaction Amount Distribution', fontsize=14, fontweight='bold')
axes[0].set_xlabel('Amount ($)', fontsize=12)
axes[0].legend()
axes[0].set_xlim([0, 500])

df.boxplot(column='Amount', by='Class', ax=axes[1])
axes[1].set_title('Amount by Class', fontsize=14, fontweight='bold')
axes[1].set_xlabel('Class', fontsize=12)
plt.suptitle('')

plt.tight_layout()
plt.savefig('images/amount_distribution.png', dpi=300, bbox_inches='tight')
plt.close()
print("   ✓ Saved: images/amount_distribution.png")

# Data preprocessing
print("\n5. Preprocessing data...")
X = df.drop('Class', axis=1)
y = df['Class']

scaler = StandardScaler()
X['Amount'] = scaler.fit_transform(X['Amount'].values.reshape(-1, 1))
X['Time'] = scaler.fit_transform(X['Time'].values.reshape(-1, 1))
print("   ✓ Features scaled")

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)
print(f"   ✓ Train set: {len(X_train):,} | Test set: {len(X_test):,}")

# Apply SMOTE
print("\n6. Applying SMOTE to balance classes...")
print(f"   Before: Legitimate={((y_train==0).sum()):,}, Fraud={((y_train==1).sum()):,}")

smote = SMOTE(random_state=42)
X_train_balanced, y_train_balanced = smote.fit_resample(X_train, y_train)

print(f"   After:  Legitimate={((y_train_balanced==0).sum()):,}, Fraud={((y_train_balanced==1).sum()):,}")
print("   ✓ Dataset balanced!")

# Train models
print("\n7. Training models (this may take a few minutes)...")
models = {
    'Logistic Regression': LogisticRegression(random_state=42, max_iter=1000),
    'Decision Tree': DecisionTreeClassifier(random_state=42),
    'Random Forest': RandomForestClassifier(n_estimators=100, random_state=42, n_jobs=-1),
    'Gradient Boosting': GradientBoostingClassifier(n_estimators=100, random_state=42),
}

results = []
trained_models = {}

for name, model in models.items():
    print(f"   Training {name}...", end=' ')
    
    model.fit(X_train_balanced, y_train_balanced)
    trained_models[name] = model
    
    y_pred = model.predict(X_test)
    y_pred_proba = model.predict_proba(X_test)[:, 1]
    
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    recall = recall_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)
    roc_auc = roc_auc_score(y_test, y_pred_proba)
    
    results.append({
        'Model': name,
        'Accuracy': accuracy,
        'Precision': precision,
        'Recall': recall,
        'F1-Score': f1,
        'ROC-AUC': roc_auc
    })
    
    print(f"✓ (F1: {f1:.4f})")

# Results
print("\n" + "="*80)
print("MODEL PERFORMANCE COMPARISON")
print("="*80)
results_df = pd.DataFrame(results).sort_values('F1-Score', ascending=False)
print(results_df.to_string(index=False))
print("="*80)

# Model comparison visualization
print("\n8. Creating performance visualizations...")
fig, axes = plt.subplots(2, 2, figsize=(15, 10))

metrics = ['Accuracy', 'Precision', 'Recall', 'F1-Score']

for idx, metric in enumerate(metrics):
    ax = axes[idx // 2, idx % 2]
    results_df.plot(x='Model', y=metric, kind='bar', ax=ax, color='#3498db', legend=False)
    ax.set_title(f'{metric} by Model', fontsize=14, fontweight='bold')
    ax.set_xlabel('Model', fontsize=12)
    ax.set_ylabel(metric, fontsize=12)
    ax.set_xticklabels(results_df['Model'], rotation=45, ha='right')
    ax.set_ylim([0, 1])
    
    for i, v in enumerate(results_df[metric]):
        ax.text(i, v + 0.02, f'{v:.3f}', ha='center', fontweight='bold', fontsize=9)

plt.tight_layout()
plt.savefig('images/model_comparison.png', dpi=300, bbox_inches='tight')
plt.close()
print("   ✓ Saved: images/model_comparison.png")

# Best model analysis
best_model_name = results_df.iloc[0]['Model']
best_model = trained_models[best_model_name]

print(f"\n9. Analyzing best model: {best_model_name}")

y_pred_best = best_model.predict(X_test)
cm = confusion_matrix(y_test, y_pred_best)

# Confusion matrix
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', cbar=True,
            xticklabels=['Legitimate', 'Fraud'],
            yticklabels=['Legitimate', 'Fraud'])
plt.title(f'Confusion Matrix - {best_model_name}', fontsize=14, fontweight='bold')
plt.xlabel('Predicted', fontsize=12)
plt.ylabel('Actual', fontsize=12)
plt.tight_layout()
plt.savefig('images/confusion_matrix_best.png', dpi=300, bbox_inches='tight')
plt.close()
print("   ✓ Saved: images/confusion_matrix_best.png")

# ROC curves
plt.figure(figsize=(10, 8))

for name, model in trained_models.items():
    y_pred_proba = model.predict_proba(X_test)[:, 1]
    fpr, tpr, _ = roc_curve(y_test, y_pred_proba)
    roc_auc = roc_auc_score(y_test, y_pred_proba)
    plt.plot(fpr, tpr, label=f'{name} (AUC = {roc_auc:.3f})', linewidth=2)

plt.plot([0, 1], [0, 1], 'k--', label='Random', linewidth=2)
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate', fontsize=12)
plt.ylabel('True Positive Rate', fontsize=12)
plt.title('ROC Curves - Model Comparison', fontsize=14, fontweight='bold')
plt.legend(loc='lower right')
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig('images/roc_curves.png', dpi=300, bbox_inches='tight')
plt.close()
print("   ✓ Saved: images/roc_curves.png")

# Feature importance (if Random Forest)
if 'Random Forest' in trained_models:
    rf_model = trained_models['Random Forest']
    importances = rf_model.feature_importances_
    feature_names = X_train.columns
    
    feature_imp_df = pd.DataFrame({
        'Feature': feature_names,
        'Importance': importances
    }).sort_values('Importance', ascending=False)
    
    plt.figure(figsize=(10, 8))
    top_features = feature_imp_df.head(20)
    plt.barh(range(len(top_features)), top_features['Importance'], color='#3498db')
    plt.yticks(range(len(top_features)), top_features['Feature'])
    plt.xlabel('Importance', fontsize=12)
    plt.title('Top 20 Feature Importances - Random Forest', fontsize=14, fontweight='bold')
    plt.gca().invert_yaxis()
    plt.tight_layout()
    plt.savefig('images/feature_importance.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("   ✓ Saved: images/feature_importance.png")

# Business impact
print("\n" + "="*80)
print("BUSINESS IMPACT ANALYSIS")
print("="*80)

tn, fp, fn, tp = cm.ravel()

false_positive_cost = 10
false_negative_cost = 120

cost_fp = fp * false_positive_cost
cost_fn = fn * false_negative_cost
total_cost = cost_fp + cost_fn

total_frauds = (y_test == 1).sum()
cost_without_model = total_frauds * false_negative_cost
savings = cost_without_model - total_cost

print(f"\nConfusion Matrix Breakdown:")
print(f"  True Negatives (Correct Legitimate): {tn:,}")
print(f"  False Positives (Legitimate flagged): {fp:,}")
print(f"  False Negatives (Fraud missed): {fn:,}")
print(f"  True Positives (Fraud caught): {tp:,}")

print(f"\nCost Analysis:")
print(f"  Cost of False Positives: ${cost_fp:,.2f}")
print(f"  Cost of False Negatives: ${cost_fn:,.2f}")
print(f"  Total Cost with Model: ${total_cost:,.2f}")

print(f"\nSavings:")
print(f"  Cost without Model: ${cost_without_model:,.2f}")
print(f"  Savings with Model: ${savings:,.2f}")
print(f"  ROI: {(savings/total_cost)*100:.1f}%")

print(f"\nDetection Metrics:")
print(f"  Fraud Detection Rate: {(tp/(tp+fn))*100:.1f}%")
print(f"  False Positive Rate: {(fp/(fp+tn))*100:.2f}%")

print("\n" + "="*80)
print("ANALYSIS COMPLETE!")
print("="*80)
print(f"\n✓ Best Model: {best_model_name}")
print(f"✓ F1-Score: {results_df.iloc[0]['F1-Score']:.4f}")
print(f"✓ ROC-AUC: {results_df.iloc[0]['ROC-AUC']:.4f}")
print(f"\n✓ All visualizations saved to 'images/' folder")
print("\nCheck the 'images' folder for:")
print("  - class_distribution.png")
print("  - amount_distribution.png")
print("  - model_comparison.png")
print("  - confusion_matrix_best.png")
print("  - roc_curves.png")
print("  - feature_importance.png")
print("\nThank you for using this fraud detection system!")
