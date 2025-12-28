# Import Libraries for the project
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Set random seed for reproducibility
np.random.seed(42)
random.seed(42)

# Configuration
START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2023, 12, 31)
NUM_TRANSACTIONS = 2000

# Business dimensions
REGIONS = ['Northeast', 'Southeast', 'Midwest', 'West']
SALES_REPS = {
    'Northeast': ['Sarah Johnson', 'Michael Chen'],
    'Southeast': ['Jennifer Martinez', 'David Lee'],
    'Midwest': ['Robert Taylor', 'Amanda White'],
    'West': ['Emily Davis', 'James Wilson']
}

PRODUCT_CATEGORIES = {
    'Electronics': ['Laptop', 'Tablet', 'Smartphone', 'Smartwatch', 'Headphones'],
    'Office Supplies': ['Printer', 'Monitor', 'Keyboard', 'Mouse', 'Desk Organizer'],
    'Furniture': ['Office Chair', 'Standing Desk', 'Filing Cabinet', 'Bookshelf', 'Conference Table']
}

# Pricing information (Unit Price, Cost Multiplier)
PRODUCT_PRICES = {
    'Laptop': (899.99, 0.70),
    'Tablet': (449.99, 0.70),
    'Smartphone': (699.99, 0.70),
    'Smartwatch': (299.99, 0.72),
    'Headphones': (149.99, 0.65),
    'Printer': (299.99, 0.73),
    'Monitor': (349.99, 0.71),
    'Keyboard': (79.99, 0.60),
    'Mouse': (39.99, 0.55),
    'Desk Organizer': (29.99, 0.50),
    'Office Chair': (449.99, 0.71),
    'Standing Desk': (799.99, 0.70),
    'Filing Cabinet': (249.99, 0.68),
    'Bookshelf': (199.99, 0.66),
    'Conference Table': (1299.99, 0.72)
}

# Regional sales patterns (multiplier by region for sales volume)
REGIONAL_MULTIPLIERS = {
    'Northeast': 1.2,  # Higher sales
    'Southeast': 0.9,  # Lower sales
    'Midwest': 1.0,  # Average sales
    'West': 1.1  # Above average sales
}

# Seasonal patterns (multiplier by month)
SEASONAL_PATTERNS = {
    1: 0.85,  # January - Post-holiday slow
    2: 0.90,  # February
    3: 1.00,  # March
    4: 1.05,  # April
    5: 1.10,  # May
    6: 1.15,  # June - Mid-year push
    7: 1.00,  # July
    8: 0.95,  # August
    9: 1.05,  # September - Back to school
    10: 1.10,  # October
    11: 1.25,  # November - Black Friday
    12: 1.30  # December - Holiday season
}


def generate_random_date(start_date, end_date):
    """Generate a random date between start_date and end_date"""
    time_delta = end_date - start_date
    random_days = random.randint(0, time_delta.days)
    return start_date + timedelta(days=random_days)


def calculate_units_sold(product, region, month):
    """Calculate realistic units sold based on product type, region, and seasonality"""
    # Base units by product category
    base_units = {
        'Electronics': random.randint(30, 120),
        'Office Supplies': random.randint(15, 200),
        'Furniture': random.randint(5, 25)
    }

    # Find category
    category = None
    for cat, products in PRODUCT_CATEGORIES.items():
        if product in products:
            category = cat
            break

    # Calculate final units with regional and seasonal adjustments
    units = base_units[category]
    units = int(units * REGIONAL_MULTIPLIERS[region] * SEASONAL_PATTERNS[month])

    return max(1, units)  # Ensure at least 1 unit


def generate_sales_data():
    """Generate the complete sales dataset"""
    print("Generating sales performance data...")

    transactions = []

    for i in range(NUM_TRANSACTIONS):
        # Random date
        date = generate_random_date(START_DATE, END_DATE)
        month = date.month

        # Random region
        region = random.choice(REGIONS)

        # Random sales rep from that region
        sales_rep = random.choice(SALES_REPS[region])

        # Random product category and product
        category = random.choice(list(PRODUCT_CATEGORIES.keys()))
        product = random.choice(PRODUCT_CATEGORIES[category])

        # Get pricing info
        unit_price, cost_multiplier = PRODUCT_PRICES[product]

        # Calculate units sold with business logic
        units_sold = calculate_units_sold(product, region, month)

        # Calculate financial metrics
        revenue = round(units_sold * unit_price, 2)
        cost = round(revenue * cost_multiplier, 2)
        profit = round(revenue - cost, 2)

        # Create transaction record
        transaction = {
            'Date': date.strftime('%Y-%m-%d'),
            'Region': region,
            'Sales_Rep': sales_rep,
            'Product_Category': category,
            'Product': product,
            'Units_Sold': units_sold,
            'Unit_Price': unit_price,
            'Revenue': revenue,
            'Cost': cost,
            'Profit': profit
        }

        transactions.append(transaction)

        # Progress indicator
        if (i + 1) % 200 == 0:
            print(f"  Generated {i + 1}/{NUM_TRANSACTIONS} transactions...")

    # Create DataFrame
    df = pd.DataFrame(transactions)

    # Sort by date
    df = df.sort_values('Date').reset_index(drop=True)

    return df


def generate_summary_statistics(df):
    """Print summary statistics about the generated data"""
    print("\n" + "=" * 60)
    print("DATASET SUMMARY")
    print("=" * 60)
    print(f"Total Transactions: {len(df):,}")
    print(f"Date Range: {df['Date'].min()} to {df['Date'].max()}")
    print(f"Total Revenue: ${df['Revenue'].sum():,.2f}")
    print(f"Total Profit: ${df['Profit'].sum():,.2f}")
    print(f"Average Profit Margin: {(df['Profit'].sum() / df['Revenue'].sum() * 100):.1f}%")

    print("\nTransactions by Region:")
    print(df['Region'].value_counts().to_string())

    print("\nRevenue by Product Category:")
    category_revenue = df.groupby('Product_Category')['Revenue'].sum().sort_values(ascending=False)
    for cat, rev in category_revenue.items():
        print(f"  {cat}: ${rev:,.2f}")

    print("\nTop 5 Products by Revenue:")
    top_products = df.groupby('Product')['Revenue'].sum().sort_values(ascending=False).head(5)
    for prod, rev in top_products.items():
        print(f"  {prod}: ${rev:,.2f}")

    print("\nTop 5 Sales Reps by Revenue:")
    top_reps = df.groupby('Sales_Rep')['Revenue'].sum().sort_values(ascending=False).head(5)
    for rep, rev in top_reps.items():
        print(f"  {rep}: ${rev:,.2f}")

    print("=" * 60)


def main():
    """Main execution function"""
    print("\n" + "=" * 60)
    print("SALES PERFORMANCE DASHBOARD - DATA GENERATOR")
    print("=" * 60 + "\n")

    # Generate data
    df = generate_sales_data()

    # Display summary
    generate_summary_statistics(df)

    # Save to CSV
    output_file = 'sales_performance_data.csv'
    df.to_csv(output_file, index=False)
    print(f"\n✓ Data saved to: {output_file}")
    print(f"✓ Ready to import into Excel!")

    # Display first few rows
    print("\nFirst 5 rows of generated data:")
    print(df.head().to_string(index=False))

    print("\n" + "=" * 60)
    print("NEXT STEPS:")
    print("=" * 60)
    print("1. Open Excel")
    print("2. Import 'sales_performance_data.csv'")
    print("3. Create PivotTables for analysis")
    print("4. Build your dashboard with charts and KPIs")
    print("5. Add slicers for interactive filtering")
    print("=" * 60 + "\n")


if __name__ == "__main__":
    main()