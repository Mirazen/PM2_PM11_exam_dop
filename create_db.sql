CREATE DATABASE book_world;

\c book_world

CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL REFERENCES Roles(role_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    full_name VARCHAR(100) NOT NULL,
    login VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    article VARCHAR(10) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER NOT NULL REFERENCES Authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES Genres(genre_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    publisher_id INTEGER NOT NULL REFERENCES Publishers(publisher_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    year INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount_price DECIMAL(10,2) DEFAULT NULL,
    is_on_sale BOOLEAN DEFAULT FALSE,
    stock INTEGER NOT NULL DEFAULT 0,
    description TEXT,
    cover_path VARCHAR(50) DEFAULT 'picture.png'
);

CREATE TABLE PickupPoints (
    pickup_point_id SERIAL PRIMARY KEY,
    address VARCHAR(200) NOT NULL
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    pickup_point_id INTEGER NOT NULL REFERENCES PickupPoints(pickup_point_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    order_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    receive_code VARCHAR(10) NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE OrderDetails (
    detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    book_id INTEGER NOT NULL REFERENCES Books(book_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    quantity INTEGER NOT NULL
);