from flask import Flask, render_template, request, redirect, session, url_for
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Connect to the database
def connect_to_database():
    try:
        connection = mysql.connector.connect(host="localhost", user="root", password="root", database="mallmart")
        if connection.is_connected():
            print("Connected to the database")
            return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")

# Verify admin credentials
def verify_admin(username, password):
    return username == 'root' and password == 'root'

# Verify customer credentials
def verify_customer(email, customer_id):
    connection = connect_to_database()
    cursor = connection.cursor()
    query = "SELECT * FROM customer WHERE email = %s AND customer_id = %s"
    cursor.execute(query, (email, customer_id))
    result = cursor.fetchone()
    cursor.close()
    connection.close()
    return result is not None

# Main route
@app.route('/')
def home(): 
    # Fetch product data using raw SQL query
    return render_template('home.html')

@app.route('/about/')
def about():
    return render_template('about.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        login_type = request.form['login_type']
        session['login_type'] = login_type
        if login_type == 'admin':
            return redirect(url_for('admin_login'))
        elif login_type == 'customer':
            return redirect(url_for('customer_login'))
    return render_template('index.html')

# Admin login route
@app.route('/login/admin/', methods=['GET', 'POST'])
def admin_login():
    session.clear()  # Clear session to ask for username and password every time
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if verify_admin(username, password):
            session['user_type'] = 'admin'
            return redirect(url_for('admin_dashboard'))
        else:
            return render_template('admin_login.html', error='Invalid credentials')
    return render_template('admin_login.html', error=None)

# Customer login route
@app.route('/login/customer/', methods=['GET', 'POST'])
def customer_login():
    if request.method == 'POST':
        email = request.form['email']
        customer_id = request.form['customer_id']
        if verify_customer(email, customer_id):
            session['user_type'] = 'customer'
            session['customer_id'] = customer_id
            return redirect(url_for('view_products'))
        else:
            return render_template('customer_login.html', error='Invalid credentials')
    return render_template('customer_login.html', error=None)

# Admin Dashboard
@app.route('/admin/dashboard/')
def admin_dashboard():
    if session.get('user_type') == 'admin':
        return render_template('admin_dashboard.html')
    else:
        return redirect(url_for('index'))
    
@app.route('/admin/analyze_inventory/')
def analyze_inventory():
    connection = connect_to_database()
    cursor = connection.cursor()
    query = "SELECT w.warehouse_id, w.name AS warehouse_name, w.state, w.phone, v.vendor_id, p.product_id, p.name AS product_name, p.price FROM warehouse w JOIN vendor v ON w.vendor_id = v.vendor_id JOIN product p ON v.vendor_id = p.vendor_id;"
    cursor.execute(query)
    inventory_data = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('analyze_inventory.html', inventory_data=inventory_data)

@app.route('/admin/analyze_customers/')
def analyze_customers():
    connection = connect_to_database()
    cursor = connection.cursor()
    query = "SELECT * FROM customer"
    cursor.execute(query)
    customer_data = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('analyze_customers.html', customer_data=customer_data)
    

# Add a new route to handle viewing products
@app.route('/view_products/')
def view_products():
    connection = connect_to_database()
    cursor = connection.cursor()
    #query = "SELECT product_id, name, price FROM product"
    query = "SELECT * FROM product"
    cursor.execute(query)
    product_data = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('view_products.html', product_data=product_data)

# Add a new route to handle viewing the cart
@app.route('/view_cart/')
def view_cart():
    if 'user_type' in session and session['user_type'] == 'customer':
        customer_id = session['customer_id']
        connection = connect_to_database()
        cursor = connection.cursor()
        query = "SELECT p.product_id, p.name, p.price, c.quantity FROM cart c JOIN product p ON c.product_id = p.product_id WHERE c.customer_id = %s"
        cursor.execute(query, (customer_id,))
        cart_data = cursor.fetchall()
        cursor.close()
        connection.close()
        return render_template('view_cart.html', cart_data=cart_data)
    else:
        return redirect(url_for('index'))
    
# Add a new route to handle adding products to the cart
@app.route('/add_to_cart/<int:product_id>', methods=['POST'])
def add_to_cart(product_id):
    if 'user_type' in session and session['user_type'] == 'customer':
        customer_id = session['customer_id']
        quantity = request.form.get('quantity')
        connection = connect_to_database()
        cursor = connection.cursor()

        # Check if the product is already in the cart
        cart_query = "SELECT * FROM cart WHERE customer_id = %s AND product_id = %s"
        cursor.execute(cart_query, (customer_id, product_id))
        existing_item = cursor.fetchone()

        if existing_item:
            # If the product is already in the cart, update the quantity
            new_quantity = existing_item[2] + int(quantity)
            update_query = "UPDATE cart SET quantity = %s WHERE customer_id = %s AND product_id = %s"
            cursor.execute(update_query, (new_quantity, customer_id, product_id))
        else:
            # If the product is not in the cart, insert a new entry
            insert_query = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (%s, %s, %s)"
            cursor.execute(insert_query, (customer_id, product_id, quantity))

        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('view_products'))
    else:
        return redirect(url_for('index'))
    
@app.route('/remove_from_cart', methods=['POST'])
def remove_from_cart():
    if session.get('user_type') == 'customer':
        customer_id = session.get('customer_id')
        if 'product_id' in request.form:
            product_id = request.form['product_id']
            connection = connect_to_database()
            cursor = connection.cursor()
            query = "DELETE FROM cart WHERE customer_id = %s AND product_id = %s"
            cursor.execute(query, (customer_id, product_id))
            connection.commit()
            cursor.close()
            connection.close()
            return redirect(url_for('view_cart'))
    return redirect(url_for('index'))

def place_order(connection, customer_id, product_id, quantity):
    try:
        cursor = connection.cursor()
        insert_order_query = "INSERT INTO `order` (customer_id, product_id, quantity) VALUES (%s, %s, %s);"
        order_data = (customer_id, product_id, quantity)
        cursor.execute(insert_order_query, order_data)

        # Delete entry from cart table
        delete_cart_query = "DELETE FROM cart WHERE customer_id = %s AND product_id = %s"
        cursor.execute(delete_cart_query, (customer_id, product_id))

        connection.commit()
        print("Order placed successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()

# Route to place order
@app.route('/place_order/', methods=['POST'])
def place_order_route():
    if request.method == 'POST':
        customer_id = session.get('customer_id')
        connection = connect_to_database()
        cursor = connection.cursor()
        select_cart_query = "SELECT customer_id, product_id, quantity FROM cart WHERE customer_id = %s"
        cursor.execute(select_cart_query, (customer_id,))
        cart_items = cursor.fetchall()
        cursor.close()
        for item in cart_items:
            place_order(connection, item[0], item[1], item[2])
        return "Order placed successfully!"

    return render_template('place_order.html')

# Route to view coupons
@app.route('/view_coupons/')
def view_coupons():
    try:
        # Connect to the database
        connection = connect_to_database()
        cursor = connection.cursor()

        # Query coupons from the database
        cursor.execute("SELECT name FROM coupons")
        coupon_names = [row[0] for row in cursor.fetchall()]

        # Close cursor and connection
        cursor.close()
        connection.close()

        # Create a list of tuples with coupon name and status 'Expired'
        coupon_data = [(name, 'Expired') for name in coupon_names]

        return render_template('view_coupons.html', coupon_data=coupon_data)
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return "An error occurred while retrieving coupons."

# Logout route
@app.route('/logout', methods=['GET', 'POST'])
def logout():
    if request.method == 'POST' or request.method == 'GET':
        session.pop('user_type', None)
        session.pop('customer_id', None)
        return redirect(url_for('login'))
    else:
        return "Method Not Allowed", 405

if __name__ == '__main__':
    app.run(debug=True)
