from cleaning_data import load_clean_data

Orders = load_clean_data()['Orders']
print(Orders)

def analyze_order(Orders):
    revenue = Orders['Total_Price'].sum()
    total_orders = Orders['Order_ID'].nunique()
    average_order_value = Orders['Total_Price'].mean()

    return {
        'Total_Revenue': float(revenue),
        'Total_Orders': int(total_orders),
        'Average_Order_Value': round(float(average_order_value),2)
    }

# print(analyze_order(Orders))

def monthly_orders(Orders):
    Orders['months'] = Orders['Order_DateTime'].dt.to_period('M').astype(str)

    return Orders.groupby('months')['Order_ID'].nunique()

print(monthly_orders(Orders))
print(Orders.isnull().sum())
