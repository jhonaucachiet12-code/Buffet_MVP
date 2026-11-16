CREATE DATABASE buffet_express;
USE buffet_express;

-- Tabla de Usuarios (Alumnos y Administradores)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('student', 'admin') NOT NULL,
    course VARCHAR(20) -- Solo para alumnos
);

-- Tabla de Categorías
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    icon VARCHAR(50)
);

-- Tabla de Productos
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabla de Pedidos (Comandas)
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    student_name VARCHAR(100) NOT NULL,
    student_course VARCHAR(20) NOT NULL,
    ticket_code VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('Pending_Payment', 'Preparing', 'Ready', 'Cancelled', 'Rejected') NOT NULL,
    payment_method ENUM('Cash', 'MercadoPago') NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabla de Detalle del Pedido
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insertar datos de prueba
INSERT INTO categories (name, icon) VALUES ('Bebidas', 'cup'), ('Snacks', 'cookie'), ('Menús', 'restaurant');
INSERT INTO products (category_id, name, description, price, is_available) VALUES 
(1, 'Agua mineral', '500 ml', 1200.00, TRUE),
(1, 'Jugo de naranja', '200 ml', 1500.00, TRUE),
(2, 'Alfajor de chocolate', '1 unidad', 1000.00, TRUE),
(2, 'Papas fritas', 'Bolsa de 40 g', 1300.00, TRUE),
(3, 'Sándwich de milanesa', '1 unidad', 3500.00, TRUE),
(3, 'Tarta de verdura', '1 porción', 3200.00, TRUE);