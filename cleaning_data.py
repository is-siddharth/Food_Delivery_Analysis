import pandas as pd
from connect_sql import connect_tables


def load_data():
    tables = connect_tables()
    tablenames = ["customers", "Menu_Item", "Restaurants", "Orders", "Delivery"]
    i = 0
    for table in tables: 
        i = 0
        table.to_csv(f"Data_SQL/{tablenames[i]}.csv")
        i += 1

    data = {}

    i = 0
    for table in tablenames:
        data[table] = tables[i]
        i += 1
    return data



def clean_data(df = pd.DataFrame()):
    null_values = df.isnull().sum()
    # print(null_values)
    df.dropna(inplace = True)
    df.drop_duplicates(inplace = True)

    for col in df.select_dtypes(include = 'object').columns:
        df[col] = df[col].str.strip()
    
    if 'C_Gender' in df.columns:
        df['C_Gender'] = (
        df['C_Gender']
        .str.strip()
        .str.lower()
        .replace({
            'female': 'Female',
            'FEMALE': 'Female',
            'male': 'Male',
            'MALE': 'Male'
        })
    )

    elif 'Status' in df.columns:
        df['Status'] = (
            df['Status']
            .str.strip()
            .str.lower()
            .replace({
                'delivered': 'Delivered',
                'in transit': 'In Transit',
                'delayed': 'Delayed',
                'cancelled': 'Cancelled',
                'failed': 'Failed'
             })
            )
    return df

    



def load_clean_data():
    data = load_data()
    clean_df = {}
    for table_name, table_data in data.items():
        clean_df[table_name] = clean_data(table_data)
    return clean_df

# data = load_clean_data()
# print(data['Delivery']['Status'].value_counts())

# load_clean_data()