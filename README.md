# Data Science Portfolio

**Victor Torres**  
*Master's in Data Science, CUNY (December 2025)*

Welcome to my data science portfolio! This repository showcases a diverse collection of end-to-end projects demonstrating proficiency in machine learning, econometrics, causal inference, statistical analysis, data visualization, and business intelligence.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/vitugo)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/victortorresds)
[![Capstone](https://img.shields.io/badge/Capstone-Tariff_Analysis-red)](https://github.com/victortorresds/Tariff-Analysis)

---

## About Me

I'm a Master's student in Data Science at CUNY, passionate about transforming data into actionable insights that drive business decisions and social impact. With a unique background spanning software development, trucking industry operations, and data science, I combine technical expertise with real-world business understanding.

**Background:**
- **Master's in Data Science** - CUNY (Graduating December 2025)
- **Industry Experience** - 2 years as trucking owner-operator
- **Google Data Analytics Certification** - Coursera
- **Full Stack Development** - IBM Certification
- **Technical Skills:** Python, R, SQL, Java, C#

**What Drives Me:**
I'm fascinated by uncovering meaningful patterns in data that can improve business outcomes and contribute to social good. Whether it's analyzing trade policy impacts, predicting customer churn, or optimizing manufacturing processes, I approach each problem with rigor, curiosity, and a commitment to measurable impact.

---

## Master's Capstone Project

### [Impact of US Tariffs on Transportation Equipment Imports](https://github.com/victortorresds/Tariff-Analysis)

**Econometric Analysis | Causal Inference | December 2025**

My Master's capstone applies rigorous **difference-in-differences methodology** to evaluate the causal impact of US tariffs on Chinese transportation equipment imports, combining 2 years of trucking industry experience with advanced econometric techniques.

**Research Highlights:**
- 📊 **Major Economic Impact:** -$10B/month (-25%) decline in Chinese imports
- 📈 **Trade Diversion:** Mexico imports +30%, Canada +10%
- 🚚 **Distributional Effects:** Border states gained $68K/year per trucker, West Coast ports lost 15% freight
- 📉 **Equipment Costs:** Trucks +22%, Parts +28%
- 🔬 **Rigorous Validation:** Parallel pre-trends, multiple control groups, 5 model specifications (R² = 0.847-0.891)

**Methodology:**
- **Natural Experiment Design** with difference-in-differences
- **Treatment Group:** China (received tariffs)
- **Control Groups:** Mexico, Canada, Brazil (no tariffs on transportation equipment)
- **Data:** 524 observations (131 months × 4 countries)
- **Sources:** Federal Reserve Economic Data (FRED), US Census Bureau

**Deliverables:**
- [55-page Research Paper](https://github.com/victortorresds/Tariff-Analysis/blob/main/final_paper/final_paper.pdf)
- [Defense Presentation](https://github.com/victortorresds/Tariff-Analysis/blob/main/presentation/presentation.pdf)
- [Reproducible Analysis Code](https://github.com/victortorresds/Tariff-Analysis/tree/main/code)
- [20+ Publication-Quality Visualizations](https://github.com/victortorresds/Tariff-Analysis/tree/main/figures)

**Why This Matters:**
This research demonstrates my ability to:
- Apply rigorous causal inference methods (gold standard in economics)
- Combine domain expertise with technical analysis
- Communicate complex findings to diverse audiences
- Build reproducible, well-documented research workflows

**[Read Full Research →](https://github.com/victortorresds/Tariff-Analysis)** | **[View Code →](https://github.com/victortorresds/Tariff-Analysis/tree/main/code)**

---

## Technical Skills

### Programming Languages
![Python](https://img.shields.io/badge/Python-Expert-blue?logo=python)
![R](https://img.shields.io/badge/R-Expert-blue?logo=r)
![SQL](https://img.shields.io/badge/SQL-Proficient-green?logo=postgresql)
![Java](https://img.shields.io/badge/Java-Proficient-green?logo=java)
![C#](https://img.shields.io/badge/C%23-Proficient-green?logo=csharp)

### Data Science & ML
- **Python Libraries:** Pandas, NumPy, Scikit-Learn, TensorFlow, Matplotlib, Seaborn, Plotly
- **R Packages:** Tidyverse, ggplot2, caret, randomForest, arules, fpp3, forecast
- **Machine Learning:** Classification, Regression, Time Series, Clustering, Association Rules
- **Econometrics:** Causal Inference, Difference-in-Differences, Panel Data, Natural Experiments
- **Deep Learning:** Neural Networks, CNNs (introductory)

### Frameworks & Tools
- **Development:** Spring, Django, .NET
- **Visualization:** Tableau, Power BI, ggplot2, Seaborn, Plotly
- **Data Handling:** Jupyter, RStudio, Quarto, VS Code, Excel
- **Version Control:** Git, GitHub
- **Databases:** PostgreSQL, MySQL, SQLite

### Analytics Techniques
- Predictive Modeling
- Causal Inference & Policy Evaluation
- Time Series Forecasting
- Statistical Hypothesis Testing
- A/B Testing
- Feature Engineering
- Model Selection & Validation
- Data Wrangling & Cleaning
- Exploratory Data Analysis (EDA)

---

## Portfolio Projects

### [ABC Beverage pH Prediction](./ABC_Beverage)
**Predictive modeling for manufacturing quality control**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-R%20|%20Machine%20Learning-blue)

Developed predictive models to forecast beverage pH levels in manufacturing, enabling real-time quality control and regulatory compliance.

**Key Achievements:**
- Compared 10 different models (Linear & Non-linear)
- Random Forest achieved **RMSE: 0.61, R²: 0.64** (best performance)
- Identified **Manufacturing Flow** as primary pH driver (54.42 importance score)
- Projected **$700K+ annual savings** through batch rejection reduction

**Technical Highlights:**
- MICE imputation for missing data (8-30 variables)
- Feature engineering with square root transformations
- Cross-validation and hyperparameter tuning
- Feature importance analysis for process optimization

**Business Impact:** Real-time pH prediction system reducing batch rejections by 50% and testing costs by $150K-200K annually.

**[Explore Project →](./ABC_Beverage)**

---

### [Time Series Forecasting: Financial & Energy Applications](./ATM-Power-Forecasting)
**Dual forecasting analysis of ATM cash demand and residential power consumption**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-R%20|%20Time%20Series-blue)

Applied advanced time series techniques to predict ATM cash withdrawals and residential electricity demand, optimizing resource allocation for financial and energy sectors.

**Key Achievements:**
- **Part A:** Forecasted daily cash for 4 ATM machines (May 2010)
- **Part B:** Predicted monthly residential power consumption (2014)
- Tested ARIMA, ETS, NAIVE, SNAIVE, MEAN, RW models
- ETS model achieved **MAPE: 3.2%** for power forecasting

**Technical Highlights:**
- STL decomposition for seasonality analysis
- Box-Cox transformation for variance stabilization
- Multiple model comparison with RMSE, MAE, MAPE
- Weekly and seasonal pattern identification

**Business Impact:** Optimized cash replenishment schedules saving $40K-60K per ATM annually; improved power generation planning reducing costs by $500K-1M.

**[Explore Project →](./ATM-Power-Forecasting)**

---

### [Market Basket Analysis: Grocery Purchase Patterns](./MB_Analysis)
**Association rule mining and network analysis for retail optimization**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-R%20|%20Data%20Mining-blue)

Analyzed 10,000 grocery transactions to uncover product associations and shopping patterns, providing data-driven recommendations for store layout and promotional strategies.

**Key Achievements:**
- Mined **15 high-confidence association rules** (Lift: 2.0-3.0)
- Identified **whole milk** and **other vegetables** as anchor products
- Discovered **25 natural product communities** using Louvain clustering
- **Ready soups** identified as unexpected bridge product (high betweenness centrality)

**Technical Highlights:**
- Apriori algorithm for association rules
- Network analysis with degree and betweenness centrality
- Community detection for product clustering
- Multiple visualization approaches (igraph, visNetwork)

**Business Impact:** Data-driven store layout optimization projected to increase basket size by 12-18% and improve cross-selling by 15-20%.

**[Explore Project →](./MB_Analysis)**

---

### [Telco Customer Churn Analysis](./telco_customer_churn)
**Machine learning classification to predict customer attrition**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-R%20|%20Classification-blue)

Built classification models to identify customers at risk of churning, enabling proactive retention strategies for telecom companies.

**Key Achievements:**
- Compared Logistic Regression vs. Neural Network models
- Neural Network: **AUC-ROC: 0.851, Accuracy: 79.8%**
- Identified **contract type** and **tenure** as top churn predictors
- Month-to-month contracts show **42% churn** vs. 11% for long-term

**Technical Highlights:**
- Exploratory data analysis on 7,043 customers
- Feature engineering and encoding
- ROC curve analysis and threshold optimization
- Model comparison and selection

**Business Impact:** Targeted retention campaigns projected to reduce churn by 10-15%, saving $2-3M annually in acquisition costs.

**[Explore Project →](./telco_customer_churn)**

---

### [Gun Control Effectiveness Analysis](./Gun_Control_Analysis)
**Statistical analysis of gun law strictness vs. mortality rates**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-R%20|%20Statistical%20Analysis-blue)

Investigated the relationship between state gun law strictness and firearm mortality rates using CDC data and web-scraped gun law grades.

**Key Achievements:**
- **Strong negative correlation (r = -0.67)** between law strictness and mortality
- States with **A-grade laws** have **3-5x lower** mortality than F-grade states
- Web scraped gun law data from Giffords Law Center
- Accessed CDC mortality data via API

**Technical Highlights:**
- Web scraping with `rvest`
- API data retrieval with `httr`
- Linear regression and correlation analysis
- Data visualization with state-by-state comparisons

**Policy Implications:** Data supports evidence-based gun legislation as effective public health intervention; each 1-point increase in law strictness associated with 4.2 fewer deaths per 100K.

**[Explore Project →](./Gun_Control_Analysis)**

---

### [Food Security and Poverty in the United States](./FS_Analysis)
**Large-scale analysis of child food insecurity across America**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tech](https://img.shields.io/badge/Tech-Python%20|%20Social%20Impact-blue)

Analyzed 126,832 individuals from CPS Food Security Supplement data to examine child food insecurity patterns and correlation with poverty levels.

**Key Achievements:**
- Processed **126,832 records** with **508 variables**
- Found **strong negative correlation** between income and food insecurity
- Identified geographic clustering (Southern states higher insecurity)
- Created compelling "elevator pitch" visualizations for policymakers

**Technical Highlights:**
- Large-scale data processing with Pandas
- Geographic analysis with GeoPandas
- Statistical correlation analysis
- Data storytelling for policy advocacy

**Social Impact:** Findings inform policy recommendations for SNAP expansion, school nutrition programs, and state-targeted interventions to address food insecurity affecting millions of children.

**[Explore Project →](./FS_Analysis)**

---

## Project Summary Matrix

| Project | Domain | Techniques | Key Metric | Business Value |
|---------|--------|------------|------------|----------------|
| **Tariff Analysis** | **Trade Policy** | **DiD, Econometrics** | **-$10B/month** | **Policy insights** |
| **ABC Beverage pH** | Manufacturing | Regression, Random Forest | R² = 0.64 | $700K+ savings |
| **Time Series Forecasting** | Finance, Energy | ARIMA, ETS | MAPE = 3.2% | $500K-1M savings |
| **Market Basket Analysis** | Retail | Association Rules, Networks | 15 Rules, Lift 2-3 | 12-18% basket ↑ |
| **Telco Churn** | Telecom | Classification, Neural Nets | AUC = 0.85 | $2-3M savings |
| **Gun Control** | Public Policy | Statistical Analysis | r = -0.67 | Policy insights |
| **Food Security** | Social Impact | Large Data, Geographic | 126K records | Policy recommendations |

---

## What Makes This Portfolio Stand Out

### Diversity of Methods
- **Causal Inference:** Difference-in-Differences, natural experiments (Capstone)
- **Supervised Learning:** Classification (Logistic, Neural Networks) and Regression (Linear, Random Forest, SVM)
- **Unsupervised Learning:** Clustering (Louvain), Association Rules (Apriori)
- **Time Series:** ARIMA, ETS, STL Decomposition, Forecasting
- **Data Engineering:** Missing data imputation (MICE), feature engineering, web scraping

### Diversity of Applications
- **7 different domains:** Trade Policy, Manufacturing, Finance, Energy, Retail, Telecom, Public Health/Policy
- **Real-world problems:** Each project addresses actual business or social challenges
- **Measurable impact:** Quantified business value and ROI for each project

### Academic + Industry Rigor
- **Master's-level research** with peer-reviewed methodology
- **Industry experience** informing data science applications
- **Business acumen** translating technical findings to strategic recommendations

### Technical Breadth
- **Multiple programming languages:** R and Python with equal proficiency
- **Statistical foundations:** From descriptive to causal inference
- **Communication skills:** Academic papers, technical reports, executive summaries

### Data Science Lifecycle
- **Data Collection:** APIs, web scraping, databases, government sources
- **Data Cleaning:** Missing values, outliers, transformations
- **EDA:** Visualization, statistical summaries, pattern discovery
- **Modeling:** Algorithm selection, training, validation, comparison
- **Deployment:** Predictions, monitoring recommendations, business integration
- **Communication:** Documentation, presentations, stakeholder reporting

---

## Highlighted Skills by Project

### Programming & Tools
| Skill | Projects |
|-------|----------|
| **R** | Tariff Analysis, ABC Beverage, Time Series, Market Basket, Telco Churn, Gun Control |
| **Python** | Food Security Analysis |
| **SQL** | Data extraction and manipulation across projects |
| **Web Scraping** | Gun Control Analysis (`rvest`, `httr`) |
| **API Integration** | Gun Control (CDC API), Tariff Analysis (FRED API) |

### Advanced Methods
| Method | Projects |
|--------|----------|
| **Difference-in-Differences** | Tariff Analysis (Capstone) |
| **Random Forest** | ABC Beverage (Winner: R²=0.64) |
| **Neural Networks** | Telco Churn (AUC=0.85) |
| **ARIMA/ETS** | Time Series Forecasting (MAPE=3.2%) |
| **Econometrics** | Tariff Analysis (causal inference) |
| **Apriori** | Market Basket Analysis (15 rules) |

### Statistical Methods
| Method | Projects |
|--------|----------|
| **Causal Inference** | Tariff Analysis (natural experiment) |
| **Linear Regression** | Gun Control, ABC Beverage |
| **Correlation Analysis** | Food Security, Gun Control |
| **Time Series Decomposition** | Time Series Forecasting (STL), Tariff Analysis |
| **MICE Imputation** | ABC Beverage (handling 8.2% missing data) |
| **Cross-Validation** | ABC Beverage (10-fold CV) |

### Data Visualization
| Tool/Package | Projects |
|--------------|----------|
| **ggplot2** | All R projects |
| **Plotly** | Market Basket, Time Series (interactive) |
| **Matplotlib/Seaborn** | Food Security |
| **igraph** | Market Basket (network viz) |
| **GeoPandas** | Food Security (geographic mapping) |
| **Quarto** | Tariff Analysis (academic publishing) |

---

## Key Accomplishments

### Academic Excellence
- Master's in Data Science (Dec 2025)
- Bachelors in Information Technology SNHU
- Master's Capstone: Econometric analysis with difference-in-differences
- Google Data Analytics Certification
- IBM Full Stack Development Certification
- Comprehensive project portfolio spanning multiple domains and methods

### Technical Achievements
- Deployed 7 end-to-end data science projects
- Applied rigorous causal inference methodology (Master's standard)
- Compared 50+ machine learning models across projects
- Processed datasets ranging from 2,571 to 126,832 records
- Achieved measurable business impact in every project

### Business Impact
- **$3M+ in projected annual value** across all projects
- **Quantified ROI** for each analysis (425% for ABC Beverage)
- **Actionable recommendations** implemented or implementable
- **Data-driven decision making** enabled in multiple industries
- **Policy insights** informing trade and public health decisions

### Research Contribution
- **55-page Master's thesis** on tariff policy impacts
- **20+ publication-quality visualizations** in capstone
- **Rigorous methodology** validated across multiple robustness checks
- **Public presentation** defending research findings

---

## Education

**Master of Science in Data Science**  
City University of New York (CUNY)  
*Expected Graduation December 2025*

**Capstone Project:**  
"Impact of US Tariffs on Chinese Transportation Equipment Imports: A Difference-in-Differences Analysis"

**Relevant Coursework:**
- DATA 698: Master's Capstone (Econometrics, Causal Inference)
- DATA 624: Predictive Analytics
- DATA 608: Knowledge and Visual Analytics  
- DATA 621: Business Analytics and Data Mining
- Statistical Methods
- Machine Learning
- Data Visualization

**Certifications:**
- Google Data Analytics Professional Certificate (Coursera)
- IBM Full Stack Software Developer Professional Certificate

---

## Let's Connect!

I'm actively seeking **Data Science** and **Data Analyst** opportunities where I can apply my analytical skills to solve real-world problems and drive business value.

**Contact Information:**
- 📧 **Email:** vitugo.torres@gmail.com
- 💼 **LinkedIn:** [linkedin.com/in/vitugo](https://www.linkedin.com/in/vitugo)
- 💻 **GitHub:** [@victortorresds](https://github.com/victortorresds)
- 🎓 **Capstone:** [Tariff Analysis Research](https://github.com/victortorresds/Tariff-Analysis)
- 📁 **Portfolio:** You're here!

**What I'm Looking For:**
- Data Science roles in tech, finance, trade/supply chain, healthcare, or social impact
- Opportunities involving causal inference, policy analysis, or econometrics
- Positions requiring rigorous statistical analysis and business insights
- Collaborative teams that value data-driven decision making
- Companies committed to continuous learning and innovation

**Open to:**
- Full-time positions (available from December 2025)
- Internships or contract work
- Research collaborations
- Coffee chats about data science, econometrics, and trade policy

---

## Current Focus

**Learning:**
- Deep Learning and Neural Networks (TensorFlow, PyTorch)
- Natural Language Processing (NLP)
- Cloud platforms (AWS, GCP) for ML deployment
- Advanced causal inference methods (Synthetic Control, RDD)

**Building:**
- Credit Card Fraud Detection project (Python, Scikit-learn)
- Economic Indicators Dashboard (Tableau)
- Additional econometric analyses

**Exploring:**
- Real-time data streaming and analytics
- MLOps and model monitoring
- A/B testing frameworks
- Bayesian inference methods

---

## GitHub Stats

![Victor's GitHub Stats](https://github-readme-stats.vercel.app/api?username=victortorresds&show_icons=true&theme=default)

---

## Repository Structure

```
DataScience/
│
├── ABC_Beverage/                    # pH Prediction project
├── ATM-Power-Forecasting/           # Time series forecasting
├── MB_Analysis/                     # Market Basket Analysis
├── telco_customer_churn/            # Customer churn prediction
├── Gun_Control_Analysis/            # Gun law effectiveness study
├── FS_Analysis/                     # Food security analysis
│
├── DataScience-Portfolio-Structure/ # Project templates
│   ├── PROJECT-TEMPLATE/            # Standard project structure
│   └── SETUP_GUIDE.md              # Portfolio setup instructions
│
└── README.md                        # This file!
```

**Separate Repository:**
- **[Tariff-Analysis](https://github.com/victortorresds/Tariff-Analysis)** - Master's Capstone (standalone)

---

## Philosophy

> "Data science is not just about algorithms and models—it's about asking the right questions, applying rigorous methodology, telling compelling stories with data, and creating actionable insights that drive real-world impact."

I approach every project with:
- **Rigor:** Are my methods sound, validated, and reproducible?
- **Curiosity:** What patterns exist in this data?
- **Impact:** How will this analysis create value?
- **Communication:** Can stakeholders understand and act on my findings?
- **Ethics:** Am I using data responsibly and considering societal implications?

---

## Collaboration

I'm always interested in collaborating on:
- **Data for Good** projects with social impact
- **Economic policy** analysis and evaluation
- **Trade and supply chain** analytics
- **Open source** data science tools and libraries
- **Research projects** in causal inference or econometrics

Feel free to reach out if you have an interesting problem to solve!

---

## Acknowledgments

- **CUNY Faculty:** For excellent instruction and guidance throughout my Master's program
- **Capstone Advisor:** Professor George Hagstrom for guidance on econometric methodology
- **Fellow Trucking Professionals:** Who inspired the capstone research through shared industry experiences
- **Open Source Community:** For amazing tools like R, Python, and countless packages
- **Data Providers:** Federal Reserve, US Census Bureau, CDC, and other public data sources

---

<div align="center">

### Ready to Solve Data Problems Together?

**Let's connect and discuss how data science can drive your business forward!**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Let's_Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/vitugo)
[![GitHub](https://img.shields.io/badge/GitHub-Follow_Me-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/victortorresds)
[![Capstone](https://img.shields.io/badge/Capstone-Read_Research-red?style=for-the-badge&logo=github&logoColor=white)](https://github.com/victortorresds/Tariff-Analysis)

---

*Last Updated: December 2025*

</div>
