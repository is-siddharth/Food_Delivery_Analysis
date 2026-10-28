from cleaning_data import load_clean_data
import pandas as pd

orders=load_clean_data()['Orders']
delivery=load_clean_data()['Delivery']

print(orders,delivery)

def analyze_delivery(orders,delivery):
    df=pd.merge(orders,delivery[['Order_ID','Del_Time']],on=['Order_ID'],how="left")
    df['delivery_minutes']=df['Del_Time']-df['Order_DateTime']
    return df
    

def delivery_status(delivery):
    return delivery['Status'].value_counts()

# print(delivery_status(delivery))
    

print(analyze_delivery(orders,delivery))