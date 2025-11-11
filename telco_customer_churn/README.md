# Telco Customer Churn Analysis

*Predicting customer churn using machine learning to help telecom companies retain customers and reduce revenue loss*

![ROC Curve Comparison](images/churn2.png)

---

## Table of Contents
- [Project Overview](#-project-overview)
- [Business Problem](#-business-problem)
- [Dataset](#-dataset)
- [Project Structure](#-project-structure)
- [Methodology](#-methodology)
- [Key Findings](#-key-findings)
- [Visualizations](#-visualizations)
- [Model Performance](#-model-performance)
- [Technologies Used](#-technologies-used)
- [Installation & Usage](#-installation--usage)
- [Results & Insights](#-results--insights)
- [Future Improvements](#-future-improvements)
- [Contact](#-contact)

---

## Project Overview

Customer churn is a critical metric for telecom companies, directly impacting revenue and growth. This project analyzes customer behavior patterns and builds predictive models to identify customers at risk of leaving the service.

**Objectives:**
- Understand key factors driving customer churn
- Build accurate predictive models to identify at-risk customers
- Provide actionable insights for customer retention strategies

---

## Business Problem

**Challenge:** Telecom companies lose significant revenue when customers cancel their subscriptions. Acquiring new customers costs 5-25x more than retaining existing ones.

**Solution:** By predicting which customers are likely to churn, companies can:
- Implement proactive retention strategies
- Offer targeted promotions to at-risk customers
- Optimize resource allocation for customer service
- Reduce overall churn rate and increase customer lifetime value

---

## Dataset

**Source:** [IBM Telco Customer Churn Dataset](https://www.kaggle.com/blastchar/telco-customer-churn)

**Dataset Overview:**
- **Size:** 7,043 customers
- **Features:** 21 variables including:
  - **Demographics:** Gender, age range, partner and dependent status
  - **Services:** Phone, internet, online security, tech support, streaming
  - **Account Info:** Contract type, payment method, billing preferences
  - **Usage:** Tenure, monthly charges, total charges
- **Target Variable:** Churn (Yes/No)

**Data Quality:**
- Handled missing values in TotalCharges column
- Converted categorical variables for modeling
- Addressed class imbalance in target variable

---

## Project Structure

```
telco_customer_churn/
│
├── data/
│   └── telco_churn.csv              # Raw dataset
│
├── notebooks/
│   └── assignment4.rmd              # R Markdown analysis notebook
│
├── images/
│   ├── churn1.png                   # Top churn reasons
│   ├── churn2.png                   # ROC curve comparison
│   ├── churn3.png                   # Churn by monthly charges
│   └── nn.png                       # Neural network visualization
│
├── essays/
│   ├── analysis_report.docx         # Detailed written analysis
│   └── analysis_report.pdf          # PDF version of report
│
├── additional_formats/
│   └── [Alternative output formats]
│
├── README.md
├── .gitignore
└── .gitattributes
```

---

## Methodology

### 1. Exploratory Data Analysis (EDA)
- Analyzed distribution of churn across different customer segments
- Identified correlations between features and churn
- Visualized patterns in customer behavior

### 2. Data Preprocessing
- Handled missing values using appropriate imputation
- Encoded categorical variables (one-hot encoding)
- Normalized numerical features for neural network
- Split data into training (70%) and testing (30%) sets

### 3. Model Development
Built and compared two classification models:

**a) Logistic Regression**
- Baseline model for interpretability
- Identified significant predictors of churn
- Evaluated feature importance

**b) Neural Network**
- Multi-layer perceptron for complex pattern recognition
- Tuned hyperparameters (hidden layers, learning rate)
- Compared performance with logistic regression

### 4. Model Evaluation
- Confusion Matrix
- ROC Curve and AUC Score
- Accuracy, Precision, Recall, F1-Score
- Cross-validation for robustness

---

## Key Findings

### Top Churn Indicators:
1. **Contract Type:** Month-to-month contracts have significantly higher churn (42%) vs. long-term contracts (11%)
2. **Tenure:** Customers with less than 12 months tenure are most likely to churn
3. **Monthly Charges:** Higher monthly charges correlate with increased churn probability
4. **Services:** Lack of online security and tech support associated with higher churn
5. **Payment Method:** Electronic check users show higher churn rates

### Customer Segments Most at Risk:
- New customers (< 6 months) with month-to-month contracts
- High-spending customers without premium support services
- Customers using electronic check payment method
- Senior citizens without partner or dependents

---

## Visualizations

### Top Churn Reasons by Feature
![Top Churn Reasons](images/churn1.png)
*Analysis of key factors contributing to customer churn across different customer segments*

### ROC Curve Comparison: Logistic Regression vs. Neural Network
![ROC Curve Comparison](images/churn2.png)
*Model performance comparison showing AUC scores for both classification approaches*

### Churn Distribution by Monthly Charges
![Churn Status by Monthly Charges](images/churn3.png)
*Relationship between monthly charges and likelihood of customer churn*

### Neural Network Architecture
![Neural Network Plot](images/nn.png)
*Visualization of the neural network structure used for churn prediction*

---

## Model Performance

| Metric | Logistic Regression | Neural Network |
|--------|-------------------|----------------|
| **Accuracy** | 80.3% | 79.8% |
| **Precision** | 65.4% | 63.2% |
| **Recall** | 54.1% | 58.7% |
| **F1-Score** | 59.2% | 60.8% |
| **AUC-ROC** | 0.847 | 0.851 |

**Best Model:** Neural Network slightly outperforms in terms of AUC-ROC, making it better for ranking customers by churn risk. Logistic Regression offers better interpretability for business stakeholders.

---

## Technologies Used

- **Language:** R (version 4.x)
- **Core Libraries:** 
  - `tidyverse` - Data manipulation and visualization
  - `dplyr` - Data wrangling
  - `ggplot2` - Advanced visualizations
  - `caret` - Machine learning framework
  - `nnet` - Neural network implementation
  - `pROC` - ROC curve analysis
  - `corrplot` - Correlation visualization
  - `scales` - Visualization scaling
- **Environment:** RStudio
- **Documentation:** R Markdown for reproducible analysis

---

## Installation & Usage

### Prerequisites
```r
R version 4.0 or higher
RStudio (recommended)
```

### Required Packages
```r
install.packages(c("tidyverse", "caret", "nnet", "pROC", "corrplot", "scales"))
```

### Running the Analysis

1. **Clone the repository:**
```bash
git clone https://github.com/victortorresds/telco_customer_churn.git
cd telco_customer_churn
```

2. **Open the R Markdown file:**
```r
# In RStudio
file.edit("notebooks/assignment4.rmd")
```

3. **Run the analysis:**
- Click "Knit" in RStudio to generate the full report
- Or run chunks individually to explore step-by-step

4. **View outputs:**
- HTML report will be generated in the notebooks folder
- All visualizations are saved in the images folder
- Detailed written analysis available in essays folder

---

## Results & Insights

### Business Recommendations:

1. **Early Intervention Program**
   - Focus retention efforts on customers in first 6 months
   - Implement welcome programs and onboarding support

2. **Contract Incentives**
   - Offer discounts or benefits for longer-term contracts
   - Create upgrade paths from month-to-month to annual contracts

3. **Service Bundle Strategy**
   - Bundle online security and tech support with base packages
   - Highlight value-add services during customer acquisition

4. **Payment Method Analysis**
   - Investigate why electronic check users churn more
   - Promote automatic payment methods with incentives

5. **Pricing Strategy**
   - Review pricing for high-charge customers
   - Consider loyalty discounts for long-term customers

### Expected Impact:
- **10-15% reduction** in overall churn rate
- **$2-3M annual savings** in customer acquisition costs
- **Improved customer lifetime value** by 20-25%

---

## Future Improvements

- [ ] Implement ensemble methods (Random Forest, XGBoost) for improved accuracy
- [ ] Add time-series analysis to predict churn timing
- [ ] Develop customer segmentation using clustering algorithms
- [ ] Create interactive dashboard for real-time churn monitoring
- [ ] Incorporate additional features (customer service calls, network quality)
- [ ] Build propensity scoring system for targeted interventions
- [ ] A/B test retention strategies based on model predictions

---

## Contact

**Victor Torres**  
Master's in Data Science, CUNY (Expected: December 2025)

- **LinkedIn:** [linkedin.com/in/vitugo](https://www.linkedin.com/in/vitugo)
- **GitHub:** [@victortorresds](https://github.com/victortorresds)

---




