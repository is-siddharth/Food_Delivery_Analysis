## Customer Analysis

from cleaning_data import load_clean_data

def customer_analysis(customer_df, order_df):
    total_customer = customer_df['C_ID'].nunique()
    gender_count = customer_df['C_Gender'].value_counts()
    # city_count = customer_df['C_Address']
    city = []
    for address in customer_df['C_Address']:
        city.append(address.split(',')[-1].strip())

    customer_df['C_City'] = city
    city_count = customer_df['C_City'].value_counts()

    repeated_customers = order_df['C_ID'].value_counts()
    total_repeated_customers = len(repeated_customers[repeated_customers > 1])

    #
    # total_repeated_customers = len(repeated_customers)
    unique_customers = total_customer - total_repeated_customers

    return {
        'Total_Customers' : total_customer, 
        'Gender_Count' : gender_count, 
        'City_Count' : city_count, 
        'Repeated_Customers' : total_repeated_customers,
        'Unqiue_Customers' : unique_customers
        }


customer_df = load_clean_data()['customers']
order_df = load_clean_data()['Orders']
# customer_analysis(customer_df)

print(customer_analysis(customer_df, order_df))