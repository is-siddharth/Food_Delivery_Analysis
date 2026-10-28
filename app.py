
import streamlit as st
from cleaning_data import load_clean_data
from customer_analysis import customer_analysis
from orders_analysis import analyze_order, monthly_orders
from delivery_analysis import analyze_delivery, delivery_status
# from connect_sql import connect_database


# Page configuration
st.set_page_config(
    page_title="Food Delivery Analysis",
    page_icon="🚚",
    layout="wide"
)


# Minimal styling
st.markdown("""
    <style>
        .block-container {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
    </style>
""", unsafe_allow_html=True)


# App title
st.title("🚚 Food Delivery Analysis")
st.caption("Customer insights, order performance and delivery overview")

st.divider()


# Load data and check database status
try:
    data = load_clean_data()

    customer = data['customers']
    menu = data['Menu_Item']
    restaurant = data['Restaurants']
    order = data['Orders']
    delivery = data['Delivery']

    db_connected = True

except Exception as e:
    db_connected = False
    error_message = str(e)


# Sidebar
with st.sidebar:
    st.title("Food Delivery")
    st.caption("Analytics Dashboard")

    st.divider()

    st.subheader("Database Status")

    if db_connected:
        st.success("Connected")
    else:
        st.error("Not connected")
        st.caption(error_message)

    st.divider()

    page = st.radio(
        "Navigation",
        [
            "Overview",
            "Customer Analysis",
            "Order Analysis",
            "Delivery Analysis"
        ]
    )

    st.divider()
    st.caption("Food Delivery Customer Analysis")


# Stop if data could not be loaded
if not db_connected:
    st.error(
        "Unable to load project data. "
        "Check your database connection and table names."
    )
    st.stop()


# Overview
if page == "Overview":

    st.subheader("Dashboard Overview")
    st.caption("A quick summary of your food delivery data.")

    total_customers = customer['C_ID'].nunique()
    total_orders = order['Order_ID'].nunique()
    total_restaurants = restaurant['Res_ID'].nunique()
    total_revenue = order['Total_Price'].sum()

    col1, col2, col3, col4 = st.columns(4)

    col1.metric("Total Customers", f"{total_customers:,}")
    col2.metric("Total Orders", f"{total_orders:,}")
    col3.metric("Restaurants", f"{total_restaurants:,}")
    col4.metric("Total Revenue", f"{total_revenue:,.2f}")

    st.divider()

    st.subheader("Monthly Orders")
    st.line_chart(monthly_orders(order))

    st.subheader("Recent Orders")
    st.dataframe(order.tail(10), use_container_width=True)


# Customer Analysis
elif page == "Customer Analysis":

    st.subheader("Customer Analysis")
    customer_data = customer_analysis(customer, order)

    col1, col2, col3 = st.columns(3)

    col1.metric(
        "Total Customers",
        customer_data['Total_Customers']
    )

    col2.metric(
        "Repeated Customers",
        customer_data['Repeated_Customers']
    )

    col3.metric(
        "Customers Counted",
        customer_data['Unqiue_Customers']
    )

    st.divider()

    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Customers by Gender")
        st.bar_chart(customer_data['Gender_Count'])

    with col2:
        st.subheader("Customers by City")
        st.bar_chart(customer_data['City_Count'])


# Order Analysis
elif page == "Order Analysis":

    st.subheader("Order Analysis")
    order_data = analyze_order(order)

    col1, col2, col3 = st.columns(3)

    col1.metric(
        "Total Revenue",
        f"{order_data['Total_Revenue']:,.2f}"
    )

    col2.metric(
        "Total Orders",
        f"{order_data['Total_Orders']:,}"
    )

    col3.metric(
        "Average Order Value",
        f"{order_data['Average_Order_Value']:,.2f}"
    )

    st.divider()

    st.subheader("Monthly Order Trend")
    st.line_chart(monthly_orders(order))

    st.subheader("Order Records")
    st.dataframe(order, use_container_width=True)


# Delivery Analysis
elif page == "Delivery Analysis":

    st.subheader("Delivery Analysis")

    st.metric("Total Delivery Records", f"{len(delivery):,}")

    st.divider()

    st.subheader("Delivery Records")

    del_min = analyze_delivery(order, delivery)['delivery_minutes']
    average_delivery_minutes = del_min.mean().total_seconds() / 60

    # del_min = analyze_delivery(order, delivery)['delivery_minutes']
    # average_delivery_minutes = del_min.mean().total_seconds() / 60

    # st.header("Average Delivery Time")
    # st.metric("Average Delivery Time", f"{average_delivery_minutes:.1f} minutes")

    st.header("Average Delivery Time")
    st.metric("Average Delivery Time", f"{average_delivery_minutes:.1f} minutes")
    # st.subheader("Average Delivery Time", f"{average_delivery_minutes:.1f} minutes")


    st.subheader("Delivery Status")
    status = delivery_status(delivery)
    # st.write("Delivery columns:", delivery.columns.tolist())
    st.bar_chart(status)

    st.dataframe(delivery, use_container_width=True)
