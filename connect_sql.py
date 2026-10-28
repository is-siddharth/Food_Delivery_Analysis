import pandas as pd
from sqlalchemy import create_engine, URL

# Creating Connection String

def connect_database():
    try:
        url = URL.create(
            drivername="mysql+mysqldb",
            username="root",
            password="MySQL@123",
            host="localhost",
            database="Food_Delivery"
        )

        engine = create_engine(url)

        # Test the actual database connection
        with engine.connect() as connection:
            print("Database Connected Successfully!")

        return engine

    except Exception as e:
        print("Connection Failed:", e)
        return None


def connect_tables():
    engine = connect_database()

    if engine is None:
        return None

    try:
        with engine.connect() as connection:
            Customers = pd.read_sql_query(
                "SELECT * FROM Customer;", connection
            )
            Restaurants = pd.read_sql_query(
                "SELECT * FROM Restaurent;", connection
            )
            Menu_Items = pd.read_sql_query(
                "SELECT * FROM Menu_Items;", connection
            )
            Orders = pd.read_sql_query(
                "SELECT * FROM ORDERS;", connection
            )
            Delivery = pd.read_sql_query(
                "SELECT * FROM Delivery;", connection
            )

        # DELIVERY was not included in your earlier SQL schema.
        return Customers, Restaurants, Menu_Items, Orders, Delivery

    except Exception as e:
        print("Table could not be connected:", e)
        return None


tables = connect_tables()

if tables is not None:
    Customers, Restaurants, Menu_Items, Orders, Delivery = tables

    print("All tables loaded successfully!")
    print(Customers.head())
    print(Restaurants.head())
    print(Menu_Items.head())
    print(Orders.head())
    print(Delivery.head())