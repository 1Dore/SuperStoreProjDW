CREATE TABLE dim_product (
    sk_product INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR (255) NULL,
    product_name VARCHAR(255) NULL,
    category VARCHAR(255) NULL,
    sub_category VARCHAR(255) NULL
);

CREATE TABLE dim_country (
    sk_country INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255) NULL,
    city VARCHAR(255) NULL,
    state VARCHAR(255) NULL,
    region VARCHAR(255) NULL,
    postal_code VARCHAR(255) NULL
);

CREATE TABLE dim_customer(
    sk_customer INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(255) NULL,
    customer_name VARCHAR(255) NULL,
    segment VARCHAR(255) NULL,
    timestamp datetime
);

CREATE TABLE dim_ship_mode (
    sk_ship_mode INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ship_Mode VARCHAR(255) NULL,
    timestamp datetime
);

-- dimension fechas, se carga desde un csv
CREATE TABLE dim_date (
    date_key INT NOT NULL PRIMARY KEY,
    full_date DATE NOT NULL,
    day_of_week INT NOT NULL,
    day_num_in_mont INT NOT NULL,
    day_name VARCHAR(20) NOT NULL,
    weekday_flag VARCHAR(8) NOT NULL,
    week_num_in_year INT NOT NULL,
    week_begin_date DATE NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter int NOT NULL,
    fiscal_month INT NOT NULL,
    fiscal_quarter INT NOT NULL,
    fiscal_year INT NOT NULL,
    last_day_in_month INT NOT NULL
);

-- tabla de hechos para el data warehouse
CREATE TABLE fact_orders (
    order_id VARCHAR(255) NOT NULL,
    order_date INT NOT NULL,
    ship_date INT NOT NULL,
    sk_ship_mode INT NOT NULL,
    sk_customer INT NOT NULL,
    sk_country_code INT NOT NULL,
    sk_product INT NOT NULL,
    sales DECIMAL(18, 2) NULL,
    quantity INT NULL,
    discount DECIMAL(18, 2) NULL,
    profit DECIMAL(18, 2) NULL,
    PRIMARY KEY (order_id, order_date, sk_customer, sk_country_code,
    sk_ship_mode, sk_product),
    foreign key (order_date) references dim_date(date_key),
    foreign key (ship_date) REFERENCES dim_date(date_key),
    foreign key (sk_ship_mode) REFERENCES dim_ship_mode(sk_ship_mode),
    foreign key (sk_customer) REFERENCES dim_customer(sk_customer),
    foreign key (sk_country_code) REFERENCES dim_country(sk_country),
    foreign key (sk_product)  REFERENCES dim_product(sk_product)
);