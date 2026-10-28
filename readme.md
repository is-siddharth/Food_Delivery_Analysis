# 🚚 Food Delivery Customer Analysis

### From raw data to meaningful insights.

What does it take to turn food delivery data into actionable insights?

How do we store customer, restaurant, order, and delivery information? How do we clean inconsistent data? And how can we use it to understand customer behaviour, revenue, and delivery performance?

**Food Delivery Customer Analysis** is an end-to-end data analytics project that brings together SQL, Python, data cleaning, exploratory analysis, and an interactive Streamlit dashboard to explore these questions.

---

## 🎯 Project Overview

The project follows a simple data journey:

**MySQL → Python → Data Cleaning → Analysis → Streamlit Dashboard**

It connects a relational database to Python, transforms raw records into analysis-ready data, and presents key metrics and trends through an interactive dashboard.

## ✨ What Can We Explore?

| Analysis | Key questions answered |
|---|---|
| 👥 **Customer Analysis** | How many customers do we have? How are they distributed by gender and city? How many place repeat orders? |
| 💰 **Order Analysis** | How much revenue do orders generate? What is the average order value? How do order volumes change month by month? |
| 🛵 **Delivery Analysis** | How long do deliveries take on average? What are the different delivery statuses, and how frequently do they occur? |
| 📊 **Dashboard Overview** | What do the key business metrics tell us at a glance? |

## 🧰 Tech Stack

- **MySQL & MySQL Workbench** — Relational database design, data storage, SQL queries, joins, and aggregations.
- **Python** — Data processing and analytical logic.
- **Pandas** — Data cleaning, transformation, grouping, and analysis.
- **SQLAlchemy & MySQLclient** — Database connectivity between Python and MySQL.
- **Streamlit** — Interactive dashboard and data visualization.

## 🗂️ Project Structure

```text
food_delivery_customer_analysis/
│
├── MySQL/
│   └── Food_Delivery.sql
│
├── Dataset/
│   └── food_delivery_csv_import_pack/
│
├── Data_SQL/
│   └── Exported table data (CSV)
│
├── app.py
├── connect_sql.py
├── cleaning_data.py
├── customer_analysis.py
├── orders_analysis.py
├── delivery_analysis.py
├── requirements.txt
└── README.md
```

## 🔍 How Does the Project Work?

### 1. Store the data — MySQL

The project uses a relational database called `Food_Delivery`, organized into five tables:

- `Customer` — Customer details, gender, contact information, addresses, and sign-up dates.
- `Restaurent` — Restaurant information, cuisine, location, and ratings.
- `Menu_Items` — Food items, prices, availability, and their associated restaurants.
- `ORDERS` — Customer orders, quantities, discounts, prices, and timestamps.
- `DELIVERY` — Delivery executives, delivery timestamps, and order statuses.

Primary keys and foreign keys establish relationships between the tables, enabling connected analysis rather than isolated data exploration.

### 2. Connect the database — Python & SQLAlchemy

The `connect_sql.py` module establishes a connection to MySQL and retrieves table data into pandas DataFrames.

This allows SQL-stored records to be processed and analyzed directly in Python.

### 3. Clean the data — Pandas

Raw data is rarely ready for analysis. The `cleaning_data.py` module prepares it by:

- Removing rows containing missing values.
- Removing duplicate records.
- Trimming unnecessary whitespace from text fields.
- Standardizing customer gender and delivery status labels.
- Organizing the cleaned tables for downstream analysis.

The cleaned data is then passed to the relevant analysis modules.

### 4. Analyze the data — Python

Separate modules keep the analysis organized and reusable:

- `customer_analysis.py` — Customer counts, gender distribution, city distribution, and repeat-order behaviour.
- `orders_analysis.py` — Revenue, total orders, average order value, and monthly order trends.
- `delivery_analysis.py` — Delivery duration calculations and delivery-status counts.

### 5. Present the insights — Streamlit

The `app.py` file brings everything together in an interactive dashboard featuring:

- An overview of key metrics.
- Customer analysis charts.
- Order performance metrics and monthly trends.
- Delivery duration and status analysis.
- Sidebar navigation and database connection feedback.

The aim is to make the results accessible without requiring users to read SQL queries or Python code.

## ⚙️ Getting Started

### Prerequisites

Make sure you have:

- Python installed.
- MySQL Server and MySQL Workbench.
- Git (optional, for cloning the repository).

### Step 1 — Clone the repository

```bash
git clone <your-github-repository-url>
cd food_delivery_customer_analysis
```

### Step 2 — Create and activate a virtual environment

```bash
python -m venv .venv
```

On Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

### Step 3 — Install the dependencies

```bash
python -m pip install --upgrade pip
python -m pip install streamlit pandas sqlalchemy mysqlclient
```

### Step 4 — Set up the database

1. Open MySQL Workbench and connect to your MySQL Server.
2. Open `MySQL/Food_Delivery.sql`.
3. Execute the database schema and sample-data setup.
4. If you use the optional CSV import section near the end of the SQL script, update its machine-specific file paths and ensure local file loading is configured correctly.

### Step 5 — Configure the database connection

Configure the MySQL host, database name, username, and password for your local environment in `connect_sql.py`.

**Security note:** Never publish real database credentials in a public repository. Use environment variables or an appropriate secrets configuration.

### Step 6 — Launch the dashboard

From the project directory, run:

```bash
python -m streamlit run app.py
```

Streamlit will provide a local URL where you can explore the dashboard.

## 💡 Key Takeaway

This project demonstrates how data moves from a relational database into a Python analytics workflow and ultimately into an interactive business dashboard.

It brings together database fundamentals, data preparation, analytical thinking, and visualization in one practical application.

**Because data becomes valuable when we can turn it into decisions.**

---

*Built as a hands-on data analytics project using MySQL, Python, Pandas, SQLAlchemy, and Streamlit.*