# Gun Control Effectiveness Analysis in the United States

*Investigating the relationship between firearm legislation strictness and mortality rates using CDC data and web-scraped gun law ratings*

![Firearm Mortality Heatmap](images/gun_control.png)

---

## Table of Contents
- [Project Overview](#-project-overview)
- [Research Question](#-research-question)
- [Data Sources](#-data-sources)
- [Project Structure](#-project-structure)
- [Methodology](#-methodology)
- [Key Findings](#-key-findings)
- [Visualizations](#-visualizations)
- [Statistical Analysis](#-statistical-analysis)
- [Technologies Used](#-technologies-used)
- [Installation & Usage](#-installation--usage)
- [Policy Implications](#-policy-implications)
- [Limitations](#-limitations)
- [Future Improvements](#-future-improvements)
- [Contact](#-contact)

---

## Project Overview

Gun violence is a critical public health issue in the United States. This project examines the effectiveness of state-level firearm control laws by analyzing the correlation between gun law strictness and firearm mortality rates across all 50 states.

**Project Goals:**
- Quantify the relationship between gun law strictness and firearm deaths
- Identify states with effective gun control policies
- Provide data-driven insights for public health policy discussions
- Practice web scraping, API consumption, and statistical analysis in R

---

## Research Question

**Do stricter firearm control laws correlate with lower firearm mortality rates?**

This analysis tests the hypothesis that states with more comprehensive gun control legislation experience fewer gun-related deaths per capita.

---

## Data Sources

### 1. CDC Firearm Mortality Data (2023)
- **Source:** Centers for Disease Control and Prevention (CDC)
- **Collection Method:** Accessed via CDC Open API
- **Metrics:** Age-adjusted firearm mortality rates per 100,000 population
- **Coverage:** All 50 U.S. states
- **Links:**
  - 🔗 [CDC Mortality Data Portal](https://www.cdc.gov/nchs/pressroom/sosmap/firearm_mortality/firearm.htm)
  - 🔗 [CDC Open API Documentation](https://open.cdc.gov/apis.html)

### 2. State Gun Law Grades
- **Source:** Giffords Law Center to Prevent Gun Violence Scorecard
- **Collection Method:** Web scraping using `rvest` package
- **Metrics:** Letter grades (A through F) evaluating gun law strength
- **Grading Criteria:** Based on 50+ gun safety policies including:
  - Background check requirements
  - Assault weapon regulations
  - Concealed carry permits
  - Red flag laws
  - Waiting periods

### Data Processing
- Converted letter grades to 5-point Likert scale:
  - **A (5 points):** Most strict gun laws 🟢
  - **B (4 points):** Moderately strict laws 🟡
  - **C (3 points):** Moderate laws 🟠
  - **D (2 points):** Lax laws 🔴
  - **F (1 point):** Most lax gun laws ⚫

---

## Project Structure

```
Gun_Control_Analysis/
│
├── notebooks/
│   └── gun_control_analysis.rmd    # R Markdown analysis notebook
│
├── images/
│   ├── gun_control.png             # Firearm mortality heatmap
│   └── gun_control_1.png           # Scatter plot with regression
│
├── additional_formats/
│   ├── analysis_report.html        # HTML output
│   └── analysis_report.pdf         # PDF output
│
├── README.md
├── .gitignore
└── .gitattributes
```

**Note:** No local data files needed - all data is fetched programmatically via API and web scraping.

---

## Methodology

### 1. Data Collection

**Step 1: CDC API Data Retrieval**
```r
# Fetch 2023 firearm mortality data from CDC API
library(httr)
library(jsonlite)

cdc_data <- GET("https://data.cdc.gov/resource/...")
mortality_df <- fromJSON(content(cdc_data, "text"))
```

**Step 2: Web Scraping Gun Law Grades**
```r
# Scrape gun law scorecard
library(rvest)

url <- "https://giffords.org/lawcenter/resources/scorecard/"
gun_laws <- read_html(url) %>%
  html_table() %>%
  extract2(1)
```

### 2. Data Cleaning & Transformation
- Filtered for 2023 data only
- Standardized state names across datasets
- Converted letter grades to numeric scale (1-5)
- Handled missing values and outliers
- Merged datasets by state abbreviation

### 3. Exploratory Data Analysis
- Summary statistics for mortality rates and gun law scores
- Distribution analysis of both variables
- Correlation analysis between strictness and mortality

### 4. Visualization
- **Heatmap:** Geographic distribution of firearm mortality
- **Scatter plot:** Relationship between law strictness and death rates
- **Linear regression:** Trend line showing correlation

### 5. Statistical Testing
- Pearson correlation coefficient
- Linear regression model
- Hypothesis testing (p-value < 0.05 for significance)

---

## Key Findings

### Main Conclusion:
** Yes, stricter firearm control laws are significantly associated with lower firearm mortality rates.**

### Quantitative Results:
- **Correlation coefficient:** -0.67 (strong negative correlation)
- **R-squared:** 0.45 (gun law strictness explains ~45% of mortality variance)
- **Statistical significance:** p < 0.001 (highly significant relationship)

### State Comparisons:

**States with Strictest Laws & Lowest Mortality:**
1. **California** (Grade A) - 8.5 deaths per 100k
2. **New Jersey** (Grade A) - 5.2 deaths per 100k
3. **Connecticut** (Grade A-) - 6.0 deaths per 100k
4. **Massachusetts** (Grade A-) - 3.4 deaths per 100k
5. **New York** (Grade A-) - 5.4 deaths per 100k

**States with Weakest Laws & Highest Mortality:**
1. **Mississippi** (Grade F) - 28.6 deaths per 100k
2. **Louisiana** (Grade F) - 26.3 deaths per 100k
3. **Wyoming** (Grade F) - 25.9 deaths per 100k
4. **Alabama** (Grade F) - 23.6 deaths per 100k
5. **Missouri** (Grade F) - 23.1 deaths per 100k

### Key Insights:
- States with **A grades** have mortality rates **3-5x lower** than F-graded states
- The top 10 safest states all have gun law grades of B or higher
- 9 of the 10 states with highest mortality rates have F grades
- Geographic clustering: Northeastern states tend to have stricter laws and lower mortality

---

## Visualizations

### Firearm Mortality Rate by State (2023)
![Firearm Mortality Heatmap](images/gun_control.png)
*Choropleth map showing age-adjusted firearm mortality rates. Darker colors indicate higher death rates. Clear pattern emerges with Southern and Mountain West states showing highest mortality.*

### Gun Law Strictness vs. Mortality Rate (Linear Regression)
![Gun Law vs Mortality Scatter](images/gun_control_1.png)
*Scatter plot demonstrating negative correlation between gun law strictness (1=lax, 5=strict) and firearm deaths per 100,000. Regression line shows significant downward trend with R² = 0.45.*

---

## 📈 Statistical Analysis

### Linear Regression Model
```
Firearm Mortality = β₀ + β₁(Gun Law Score) + ε

Results:
- Intercept (β₀): 26.3 deaths per 100k
- Slope (β₁): -4.2 (each point increase in law strictness associated with 4.2 fewer deaths)
- R²: 0.45
- p-value: < 0.001
```

### Interpretation:
- For every **1-point increase** in gun law strictness score, there is an associated **4.2 decrease** in firearm deaths per 100,000 residents
- This relationship is **statistically significant** (p < 0.001)
- Gun law strictness accounts for **45% of the variation** in state mortality rates
- Other factors (socioeconomic conditions, urban density, cultural attitudes) explain remaining variance

---

## Technologies Used

- **Language:** R (version 4.x)
- **Core Libraries:**
  - `tidyverse` - Data manipulation and visualization
  - `ggplot2` - Advanced data visualizations
  - `dplyr` - Data wrangling
  - `rvest` - Web scraping
  - `httr` - HTTP requests for API access
  - `jsonlite` - JSON parsing
  - `plotly` - Interactive visualizations
  - `openintro` - Statistical datasets and functions
- **Environment:** RStudio
- **Documentation:** R Markdown for reproducible research

---

## Installation & Usage

### Prerequisites
```r
R version 4.0 or higher
RStudio (recommended)
Internet connection (for API access and web scraping)
```

### Required Packages
```r
install.packages(c(
  "tidyverse",
  "rvest",
  "httr",
  "jsonlite",
  "plotly",
  "openintro"
))
```

### Running the Analysis

1. **Clone the repository:**
```bash
git clone https://github.com/victortorresds/Gun_Control_Analysis.git
cd Gun_Control_Analysis
```

2. **Open the R Markdown file:**
```r
# In RStudio
file.edit("notebooks/gun_control_analysis.rmd")
```

3. **Run the analysis:**
- Click "Knit" in RStudio to generate the full report
- The script will automatically:
  - Fetch data from CDC API
  - Scrape gun law grades from Giffords website
  - Perform analysis and generate visualizations
  - Create HTML and PDF reports

4. **View outputs:**
- HTML report: `additional_formats/analysis_report.html`
- PDF report: `additional_formats/analysis_report.pdf`
- Visualizations: `images/` folder

---

## Policy Implications

### For Policymakers:
1. **Evidence-Based Legislation:** Data supports comprehensive gun control as effective public health intervention
2. **Model State Programs:** States like Massachusetts (3.4 deaths/100k) provide templates for effective legislation
3. **Multi-Policy Approach:** Most effective states implement comprehensive packages, not single policies

### Recommended Policy Areas (Based on Top-Performing States):
- Universal background checks including private sales
- Permit requirements for firearm purchases
- Extreme risk protection orders (red flag laws)
- Assault weapon restrictions
- Mandatory waiting periods
- Safe storage requirements

### Public Health Perspective:
- Gun violence prevention is a **data-driven public health issue**
- States treating it as such show measurably better outcomes
- Policy interventions can save thousands of lives annually

---

## Limitations

### Methodological Constraints:
1. **Correlation vs. Causation:** Analysis shows association, not definitive causation
2. **Confounding Variables:** Socioeconomic factors, population density, cultural attitudes not controlled for
3. **Single Year Data:** 2023 snapshot doesn't capture long-term trends or policy lag effects
4. **Grade Simplification:** Collapsing complex legislation into letter grades loses nuance
5. **Aggregate Data:** State-level analysis masks county and city variations

### Data Limitations:
- CDC data excludes non-fatal injuries
- Gun law grades are advocacy organization ratings, not neutral academic scoring
- Some states changed laws during 2023, creating measurement challenges

### Future Analysis Needs:
- Multi-year trend analysis
- Control for confounding socioeconomic variables
- Examination of specific policy components
- County-level granular analysis

---

## Future Improvements

- [ ] Add time-series analysis (5-10 year trends)
- [ ] Include socioeconomic control variables (poverty rate, education, urbanization)
- [ ] Break down gun law scores by specific policy types
- [ ] Add county-level analysis for within-state variation
- [ ] Include gun ownership rates as additional variable
- [ ] Separate analysis for suicide vs. homicide deaths
- [ ] Interactive Shiny dashboard for real-time exploration
- [ ] Compare U.S. states to international gun policy models
- [ ] Predictive modeling: forecast mortality under policy changes

---

## Contact

**Victor Torres**  
Master's in Data Science, CUNY (Expected: December 2025)

- **LinkedIn:** [linkedin.com/in/vitugo](https://www.linkedin.com/in/vitugo)
- **GitHub:** [@victortorresds](https://github.com/victortorresds)
- **Portfolio:** [github.com/victortorresds](https://github.com/victortorresds)

---

## References & Citations

- Centers for Disease Control and Prevention. (2023). *Firearm Mortality by State*. https://www.cdc.gov/nchs/pressroom/sosmap/firearm_mortality/firearm.htm
- Giffords Law Center to Prevent Gun Violence. (2023). *Annual Gun Law Scorecard*. https://giffords.org/lawcenter/resources/scorecard/

---

