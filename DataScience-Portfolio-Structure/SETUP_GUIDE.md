# 🚀 DataScience Portfolio Setup Guide

This guide will help you set up and organize your DataScience portfolio repository on GitHub.

## 📋 Initial Setup

### 1. Initialize Git Repository (if not already done)

```bash
cd C:\GitHub\DataScience
git init
git add .
git commit -m "Initial commit: DataScience portfolio structure"
```

### 2. Create GitHub Repository

1. Go to https://github.com/new
2. Name it `DataScience` (or your preferred name)
3. **Do NOT** initialize with README (we already have one)
4. Click "Create repository"

### 3. Connect Local to GitHub

```bash
git remote add origin https://github.com/victortorresds/DataScience.git
git branch -M main
git push -u origin main
```

## 📁 Adding a New Project

### Option 1: Copy the Template

```bash
# Navigate to your DataScience folder
cd C:\GitHub\DataScience

# Copy the template and rename
cp -r PROJECT-TEMPLATE your-project-name

# Navigate to your new project
cd your-project-name
```

### Option 2: Create From Scratch

Follow the structure in `PROJECT-TEMPLATE/` and customize as needed.

## ✏️ Customizing Your Project README

For each project, update the following sections in the README.md:

1. **Title and Description** - Clear, descriptive name
2. **Overview** - Problem statement and objectives
3. **Dataset** - Source, size, and key features
4. **Technologies Used** - Update with actual libraries used
5. **Key Findings** - Your main insights (add these after analysis)
6. **Results** - Model performance, visualizations
7. **Installation** - Update with any special dependencies

## 📸 Adding Visualizations

1. Save your plots in the `visualizations/` folder
2. Reference them in your README:
   ```markdown
   ![Chart Title](visualizations/chart.png)
   ```
3. Make sure to commit and push the images!

## 🔄 Git Workflow for Projects

```bash
# Check status
git status

# Stage changes
git add .

# Commit with meaningful message
git commit -m "Add data exploration notebook for [project-name]"

# Push to GitHub
git push origin main
```

## 📝 Best Practices

### Commit Messages
- ✅ "Add initial EDA for customer churn analysis"
- ✅ "Update visualization with correlation heatmap"
- ✅ "Complete feature engineering and model training"
- ❌ "update"
- ❌ "changes"

### File Organization
- Keep raw data in `data/raw/` (never modify)
- Save processed data in `data/processed/`
- Number your notebooks sequentially (01_, 02_, 03_)
- Use descriptive file names

### Documentation
- Update README as you progress
- Comment your code
- Explain your thought process in notebooks
- Include visualizations in the README

## 🎯 Portfolio Checklist

For each project, make sure you have:

- [ ] Clear README with problem statement
- [ ] Clean, well-commented code
- [ ] At least 2-3 visualizations
- [ ] Results/findings section
- [ ] requirements.txt with all dependencies
- [ ] Properly structured folders
- [ ] No sensitive data or API keys
- [ ] .gitignore to exclude large files

## 🔗 Linking Projects

In your main DataScience README.md, add links to each project:

```markdown
### 1. [Customer Churn Analysis](./customer-churn-analysis)
**Status:** ✅ Completed
**Tech Stack:** Python, Pandas, Scikit-Learn
**Description:** Predictive model to identify at-risk customers
**Key Insights:** Achieved 85% accuracy in churn prediction
```

## 📊 Profile README Tips

Update your GitHub profile README (victortorresds) with:
- Pin your DataScience repository
- Link to specific projects
- Update project statuses
- Add recent accomplishments

## 🆘 Troubleshooting

**Large files won't commit?**
- Add them to .gitignore
- Use Git LFS for large datasets if needed

**Want to exclude sensitive data?**
- Add to .gitignore before first commit
- Use environment variables for API keys

**Project structure feels too complex?**
- Start simple, add folders as needed
- Not every project needs every folder

## 📞 Next Steps

1. Copy this structure to your `C:\GitHub\DataScience` folder
2. Initialize git and push to GitHub
3. Start migrating your existing projects
4. Create new projects using the template
5. Update your profile README with project links

---

Good luck with your portfolio! 🎉
