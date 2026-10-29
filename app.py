
import streamlit as st
import pandas as pd

from cleaning_data import load_clean_data
from customer_analysis import customer_analysis
from orders_analysis import analyze_order, monthly_orders
from delivery_analysis import analyze_delivery, delivery_status


# --------------------------------------------------
# PAGE CONFIGURATION
# --------------------------------------------------

st.set_page_config(
    page_title="Food Delivery | Analytics",
    page_icon="🚚",
    layout="wide",
    initial_sidebar_state="expanded"
)


# --------------------------------------------------
# CUSTOM STYLING — SUBTLE DOOM THEME
# --------------------------------------------------

st.markdown("""
<style>

/* Main color palette */
:root {
    --doom-green: #263D30;
    --doom-green-light: #385744;
    --doom-accent: #A8C99A;
    --doom-bg: #101713;
    --doom-card: #19221C;
    --doom-border: #303D33;
    --doom-text: #E8EEE9;
    --doom-muted: #A4B0A6;
}

/* Main application background */
.stApp {
    background: var(--doom-bg);
    color: var(--doom-text);
}

/* Content spacing */
.block-container {
    padding-top: 2rem;
    padding-bottom: 2.5rem;
    max-width: 1500px;
}

/* Sidebar */
[data-testid="stSidebar"] {
    background: linear-gradient(
        180deg,
        #18291F 0%,
        #111A14 100%
    );
    border-right: 1px solid var(--doom-border);
}

[data-testid="stSidebar"] h1,
[data-testid="stSidebar"] h2,
[data-testid="stSidebar"] h3 {
    color: var(--doom-text);
}

/* Main headings */
h1, h2, h3 {
    letter-spacing: -0.4px;
}

h1 {
    font-weight: 700;
}

h2, h3 {
    font-weight: 600;
}

/* Captions */
[data-testid="stCaptionContainer"] {
    color: var(--doom-muted);
}

/* Metric cards */
[data-testid="stMetric"] {
    background: var(--doom-card);
    border: 1px solid var(--doom-border);
    border-radius: 12px;
    padding: 18px 20px;
    min-height: 112px;
}

[data-testid="stMetricLabel"] {
    color: var(--doom-muted);
    font-size: 0.88rem;
}

[data-testid="stMetricValue"] {
    color: var(--doom-text);
    font-weight: 650;
}

/* Navigation radio buttons */
[data-testid="stSidebar"] [data-testid="stRadio"] label {
    padding-top: 5px;
    padding-bottom: 5px;
}

/* Buttons */
.stButton > button {
    border-radius: 8px;
    border: 1px solid var(--doom-border);
    transition: 0.2s ease;
}

.stButton > button:hover {
    border-color: var(--doom-accent);
    color: var(--doom-accent);
}

/* Dataframes */
[data-testid="stDataFrame"] {
    border: 1px solid var(--doom-border);
    border-radius: 10px;
    overflow: hidden;
}

/* Dividers */
hr {
    border-color: var(--doom-border);
}

/* Status badge containers */
.status-label {
    color: var(--doom-muted);
    font-size: 0.85rem;
}

/* Keep the interface responsive */
@media (max-width: 768px) {
    .block-container {
        padding-top: 1rem;
        padding-left: 1rem;
        padding-right: 1rem;
    }
}

</style>
""", unsafe_allow_html=True)


# --------------------------------------------------
# HEADER
# --------------------------------------------------

header_col, refresh_col = st.columns([5, 1])

with header_col:
    st.title("🚚 Food Delivery Analytics")
    st.caption(
        "Customer intelligence  /  Order performance  /  Delivery operations"
    )

with refresh_col:
    st.write("")
    if st.button("↻ Refresh data", use_container_width=True):
        st.rerun()

st.divider()


# --------------------------------------------------
# LOAD DATA AND CHECK CONNECTION
# --------------------------------------------------

data = None
db_connected = False
error_message = None

try:
    data = load_clean_data()

    customer = data["customers"]
    menu = data["Menu_Item"]
    restaurant = data["Restaurants"]
    order = data["Orders"]
    delivery = data["Delivery"]

    db_connected = True

except Exception as e:
    error_message = str(e)


# --------------------------------------------------
# SIDEBAR
# --------------------------------------------------

with st.sidebar:

    st.markdown("## 🛡️ FOOD DELIVERY")
    st.caption("ANALYTICS COMMAND CENTER")

    st.divider()

    st.markdown("### System status")

    if db_connected:
        st.success("Database connected")
        st.caption("Data loaded successfully")
    else:
        st.error("Database unavailable")
        st.caption(
            "Check the database service, credentials, "
            "table names, and connection settings."
        )

        with st.expander("Technical details"):
            st.code(error_message or "Unknown error")

    st.divider()

    st.markdown("### Navigation")

    page = st.radio(
        "Select a section",
        [
            "Overview",
            "Customer Analysis",
            "Order Analysis",
            "Delivery Analysis"
        ],
        label_visibility="collapsed"
    )

    st.divider()

    st.caption("FOOD DELIVERY CUSTOMER ANALYSIS")
    st.caption("Data-driven insights, clearly presented.")


# --------------------------------------------------
# STOP IF DATA CANNOT BE LOADED
# --------------------------------------------------

if not db_connected:
    st.error(
        "The dashboard could not load all required tables. "
        "Resolve the connection or data-loading issue and refresh."
    )
    st.stop()


# --------------------------------------------------
# OVERVIEW
# --------------------------------------------------

if page == "Overview":

    st.subheader("Command Center")
    st.caption("A high-level view of your food delivery business.")

    total_customers = customer["C_ID"].nunique()
    total_orders = order["Order_ID"].nunique()
    total_restaurants = restaurant["Res_ID"].nunique()
    total_revenue = order["Total_Price"].sum()

    col1, col2, col3, col4 = st.columns(4)

    col1.metric(
        "Total Customers",
        f"{total_customers:,}"
    )

    col2.metric(
        "Total Orders",
        f"{total_orders:,}"
    )

    col3.metric(
        "Restaurants",
        f"{total_restaurants:,}"
    )

    col4.metric(
        "Total Revenue",
        f"{total_revenue:,.2f}"
    )

    st.divider()

    chart_col, info_col = st.columns([3, 2])

    with chart_col:
        st.subheader("Monthly Order Trend")
        st.caption("Unique orders grouped by month.")

        monthly_data = monthly_orders(order)

        st.line_chart(
            monthly_data,
            use_container_width=True
        )

    with info_col:
        st.subheader("Data snapshot")

        snapshot_col1, snapshot_col2 = st.columns(2)

        snapshot_col1.metric(
            "Menu Items",
            f"{len(menu):,}"
        )

        snapshot_col2.metric(
            "Delivery Records",
            f"{len(delivery):,}"
        )

        st.caption(
            "Counts reflect the records currently loaded "
            "from the database."
        )

    st.divider()

    st.subheader("Recent Orders")
    st.caption("The latest records in the loaded order table.")

    st.dataframe(
        order.tail(10),
        use_container_width=True,
        hide_index=True
    )


# --------------------------------------------------
# CUSTOMER ANALYSIS
# --------------------------------------------------

elif page == "Customer Analysis":

    st.subheader("Customer Intelligence")
    st.caption("Understand who your customers are and how they are distributed.")

    customer_data = customer_analysis(customer, order)

    col1, col2, col3 = st.columns(3)

    col1.metric(
        "Total Customers",
        f"{customer_data['Total_Customers']:,}"
    )

    col2.metric(
        "Repeated Customers",
        f"{customer_data['Repeated_Customers']:,}"
    )

    col3.metric(
        "Customer Count",
        f"{customer_data['Unqiue_Customers']:,}"
    )

    st.divider()

    gender_col, city_col = st.columns(2)

    with gender_col:
        st.subheader("Customers by Gender")
        st.caption("Distribution of recorded gender categories.")

        st.bar_chart(
            customer_data["Gender_Count"],
            use_container_width=True
        )

    with city_col:
        st.subheader("Customers by City")
        st.caption("Distribution based on the city extracted from addresses.")

        st.bar_chart(
            customer_data["City_Count"],
            use_container_width=True
        )

    st.divider()

    with st.expander("View customer records"):
        st.dataframe(
            customer,
            use_container_width=True,
            hide_index=True
        )


# --------------------------------------------------
# ORDER ANALYSIS
# --------------------------------------------------

elif page == "Order Analysis":

    st.subheader("Order Intelligence")
    st.caption("Track revenue, order volume, and average order value.")

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
    st.caption("Track how order volume changes over time.")

    monthly_data = monthly_orders(order)

    st.line_chart(
        monthly_data,
        use_container_width=True
    )

    st.divider()

    with st.expander("View all order records"):
        st.dataframe(
            order,
            use_container_width=True,
            hide_index=True
        )


# --------------------------------------------------
# DELIVERY ANALYSIS
# --------------------------------------------------

elif page == "Delivery Analysis":

    st.subheader("Delivery Operations")
    st.caption("Monitor delivery duration and the distribution of delivery statuses.")

    st.metric(
        "Total Delivery Records",
        f"{len(delivery):,}"
    )

    # Calculate delivery durations.
    delivery_data = analyze_delivery(order, delivery)
    del_min = delivery_data["delivery_minutes"]

    valid_durations = del_min.dropna()

    if not valid_durations.empty:

        average_duration = valid_durations.mean()

        # Supports pandas Timedelta results and numeric minutes.
        if isinstance(average_duration, pd.Timedelta):
            average_delivery_minutes = (
                average_duration.total_seconds() / 60
            )
        else:
            average_delivery_minutes = float(average_duration)

        st.metric(
            "Average Delivery Time",
            f"{average_delivery_minutes:.1f} minutes"
        )

    else:
        st.metric(
            "Average Delivery Time",
            "N/A"
        )
        st.info(
            "No valid delivery durations are available "
            "for calculating an average."
        )

    st.divider()

    st.subheader("Delivery Status")
    st.caption("Number of delivery records in each status category.")

    status = delivery_status(delivery)

    if status is not None and not status.empty:
        st.bar_chart(
            status,
            use_container_width=True
        )
    else:
        st.info("No delivery status data is available.")

    st.divider()

    with st.expander("View delivery records"):
        st.dataframe(
            delivery,
            use_container_width=True,
            hide_index=True
        )
